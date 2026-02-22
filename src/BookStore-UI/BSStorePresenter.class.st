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
		'totalLabel'
	],
	#category : 'BookStore-UI',
	#package : 'BookStore-UI'
}

{ #category : 'actions' }
BSStorePresenter >> actionAddBook [
	| newBook |
	
	newBook := BSBook new 
		title: titleInput text;
		author: authorInput text;
		price: priceInput text asInteger.
		
	inventory addBook: newBook.
	
	self updateUI.
	
	titleInput text: ''.
	authorInput text: ''.
	priceInput text: ''.
]

{ #category : 'initialization' }
BSStorePresenter >> actionRemoveBook [
	| selectedBook |
	
	"1. Get the book the user clicked on"
	selectedBook := bookList selection selectedItem.
	
	"2. If they actually selected something, remove it and update!"
	selectedBook ifNotNil: [ 
		inventory removeBook: selectedBook.
		self updateUI.
	].
]

{ #category : 'initialization' }
BSStorePresenter >> connectPresenters [
	bookList display: [ :book | book title , ' by ' , book author , ' ($' , book price asString , ')' ].
	
	addButton action: [ self actionAddBook ].
	removeButton action: [ self actionRemoveBook ].
]

{ #category : 'layout' }
BSStorePresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: bookList;
		add: (SpBoxLayout newLeftToRight
			add: titleInput;
			add: authorInput;
			add: priceInput;
			add: addButton expand: false;
			yourself) expand: false;
		add: (SpBoxLayout newLeftToRight
			add: removeButton expand: false;
			add: totalLabel;
			yourself) expand: false;
		yourself
]

{ #category : 'initialization' }
BSStorePresenter >> initialize [
	super initialize.
	inventory := BSInventory new.
]

{ #category : 'initialization' }
BSStorePresenter >> initializePresenters [
	bookList := self newList.
	
	titleInput := self newTextInput placeholder: 'Title'.
	authorInput := self newTextInput placeholder: 'Author'.
	priceInput := self newTextInput placeholder: 'Price'.
	
	addButton := self newButton label: 'Add Book'.
	
	removeButton := self newButton label: 'Remove Selected'.
	totalLabel := self newLabel label: 'Total Value: $0'.
]

{ #category : 'initialization' }
BSStorePresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'My Pharo BookStore';
		initialExtent: 600@400.
]

{ #category : 'initialization' }
BSStorePresenter >> updateUI [
	"Refresh the list of books"
	bookList items: inventory books.
	
	"Update the total price label dynamically"
	totalLabel label: 'Total Value: $', inventory totalPrice asString.
]
