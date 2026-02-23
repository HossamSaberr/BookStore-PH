Class {
	#name : 'BSStorePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'inventory',
		'bookList',
		'titleInput',
		'authorInput',
		'priceInput',
		'addButton',
		'removeButton',
		'buyButton',
		'addCopyButton',
		'removeCopyButton',
		'cart',
		'cartList',
		'cartTotalLabel',
		'checkoutButton'
	],
	#category : 'BookStore-UI',
	#package : 'BookStore-UI'
}

{ #category : 'actions' }
BSStorePresenter >> actionAddBook [
	| newBook |
	
	(titleInput text isEmpty or: [ authorInput text isEmpty or: [ priceInput text isEmpty ] ])
		ifTrue: [ 
			UIManager default alert: 'Please fill in all fields!'.
			^ self ].
			
	(inventory includesTitle: titleInput text)
		ifTrue: [ 
			UIManager default alert: 'A book with this title is already in the inventory!'.
			^ self ].
	
	newBook := BSBook new 
        title: titleInput text;
        author: authorInput text;
        price: priceInput text asInteger;
        quantity: 5.
		
	inventory addBook: newBook.
	self updateUI.
	
	titleInput text: ''.
	authorInput text: ''.
	priceInput text: ''.
]

{ #category : 'actions' }
BSStorePresenter >> actionBuyBook [
	| selectedBook |
	selectedBook := bookList selection selectedItem.
	
	selectedBook ifNotNil: [ 
		inventory reduceStock: selectedBook.
		self updateUI.
		UIManager default inform: 'Purchase successful!' 
	] ifNil: [ 
		UIManager default alert: 'Please select a book first!' 
	].
]

{ #category : 'initialization' }
BSStorePresenter >> actionRemoveBook [
	| selectedBook |
	
	selectedBook := bookList selection selectedItem.
	
	selectedBook ifNotNil: [ 
		inventory removeBook: selectedBook.
		self updateUI.
	].
]

{ #category : 'initialization' }
BSStorePresenter >> connectPresenters [
	bookList display: [ :book | 
    book title, ' by ', book author, ' - $', book price asString, ' (Stock: ', book quantity asString, ')' ].
	
	addButton action: [ self actionAddBook ].
	addCopyButton action: [ 
    bookList selectedItem ifNotNil: [ :selectedBook |
        | input amount |
        input := UIManager default 
            request: 'How many copies of "', selectedBook title, '" would you like to add?' 
            initialAnswer: '1'.
        
        input ifNotNil: [ 
            amount := input asInteger.
            
            amount ifNotNil: [ 
                selectedBook quantity: (selectedBook quantity + amount).
                self updateUI 
            ] 
        ]
    ] 
].
	removeCopyButton action: [ 
    bookList selectedItem ifNotNil: [ :selectedBook |
        | input amount |
        input := UIManager default 
            request: 'How many copies of "', selectedBook title, '" would you like to remove?' 
            initialAnswer: '1'.
        
        input ifNotNil: [ 
            amount := input asInteger.
            amount ifNotNil: [ 
                amount <= selectedBook quantity 
                    ifTrue: [ 
                        selectedBook quantity: (selectedBook quantity - amount).
                        self updateUI ]
                    ifFalse: [ 
                        UIManager default alert: 'Error: Cannot remove more copies than currently in stock!' ]
            ] 
        ]
    ] 
].
	removeButton action: [ self actionRemoveBook ].
	buyButton label: 'Add to Cart'.
		buyButton action: [ 
    		bookList selectedItem ifNotNil: [ :selectedBook |
        
        	| cartItem |
        	cartItem := cart detect: [ :item | item book = selectedBook ] ifNone: [ nil ].
        
        	cartItem 
            ifNotNil: [ cartItem quantity: cartItem quantity + 1 ]
            ifNil: [ cart add: (BSCartItem new book: selectedBook; quantity: 1) ].
            
        self updateCartUI.
    ]
].
checkoutButton action: [ 
    cart ifNotEmpty: [ 
        | canProcess |
        canProcess := cart allSatisfy: [ :item | item book quantity >= item quantity ].
        
        canProcess ifTrue: [ 
            cart do: [ :item | item book quantity: (item book quantity - item quantity) ].
            
            cart removeAll.
            self updateUI.  
            self updateCartUI. 
            UIManager default inform: 'Purchase successful! Thank you for shopping.'
        ] ifFalse: [ 
            UIManager default alert: 'Error: One or more items in your cart exceed available stock!'
        ]
    ] ifEmpty: [ 
        UIManager default alert: 'Your cart is empty!'
    ]
].
]

{ #category : 'layout' }
BSStorePresenter >> defaultLayout [
    ^ SpBoxLayout newTopToBottom
        spacing: 5;
        add: (SpPanedLayout newLeftToRight
            positionOfSlider: 60 percent;
            add: bookList;   
            add: (SpBoxLayout newTopToBottom 
                spacing: 5;
                add: 'Your Cart' expand: false;
                add: cartList; 
                add: cartTotalLabel expand: false;
					 add: checkoutButton expand: false;
                yourself);    
            yourself);
        add: (SpBoxLayout newLeftToRight
            spacing: 5;
            add: titleInput;
            add: authorInput;
            add: priceInput;
            yourself) expand: false;
        add: (SpBoxLayout newLeftToRight
            spacing: 5;
            add: addButton;
            add: addCopyButton;
            add: removeCopyButton;
            add: removeButton;
            add: buyButton;
            yourself) expand: false;
        yourself
]

{ #category : 'actions' }
BSStorePresenter >> disableManagement [
	addButton hide.
	removeButton hide.
	titleInput hide.
	authorInput hide.
	priceInput hide.
	addCopyButton hide.
	removeCopyButton hide.
	buyButton show. 
	self updateUI.
]

{ #category : 'actions' }
BSStorePresenter >> enableManagement [
	addButton show.
	removeButton show.
	titleInput show.
	authorInput show.
	priceInput show.
	addCopyButton show.
	removeCopyButton show.
	buyButton hide.
]

{ #category : 'initialization' }
BSStorePresenter >> initialize [
    super initialize.
    inventory := Smalltalk at: #SharedInventory.
	 cart := OrderedCollection new.
    self updateUI. 
]

{ #category : 'initialization' }
BSStorePresenter >> initializePresenters [
	bookList := self newList.
	
	titleInput := self newTextInput placeholder: 'Title'.
	authorInput := self newTextInput placeholder: 'Author'.
	priceInput := self newTextInput placeholder: 'Price'.
	
	addButton := self newButton label: 'Add Book'.
	buyButton := self newButton label: 'Buy Selected Book'.
	
	removeButton := self newButton label: 'Remove Selected'.
	addCopyButton := self newButton.
   addCopyButton label: 'Add Copies...'.
	removeCopyButton := self newButton.
	removeCopyButton label: 'Remove Copies...'.
	buyButton := self newButton 
		label: 'Buy Selected Book';
		icon: (self iconNamed: #cart).
	buyButton hide.
	cartList := self newTable.
	cartList 
    	addColumn: (SpStringTableColumn title: 'Book' evaluated: [ :item | item book title ]);
    	addColumn: (SpStringTableColumn title: 'Qty' evaluated: [ :item | item quantity asString ]);
    	addColumn: (SpStringTableColumn title: 'Subtotal' evaluated: [ :item | item totalPrice asString ]).

	cartTotalLabel := self newLabel.
	cartTotalLabel label: 'Total: $0'.
	checkoutButton := self newButton.
	checkoutButton label: 'Checkout'.
]

{ #category : 'initialization' }
BSStorePresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'My Pharo BookStore';
		initialExtent: 600@400.
]

{ #category : 'as yet unclassified' }
BSStorePresenter >> updateCartUI [
    | total |
    cartList items: cart.
    
    total := cart inject: 0 into: [ :sum :item | sum + item totalPrice ].
    cartTotalLabel label: 'Total: $', total asString.
]

{ #category : 'initialization' }
BSStorePresenter >> updateUI [
	bookList items: inventory books.
	
	inventory ifNotNil: [ 
    bookList items: inventory books.
].
]
