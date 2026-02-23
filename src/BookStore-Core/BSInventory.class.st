Class {
	#name : 'BSInventory',
	#superclass : 'Object',
	#instVars : [
		'books'
	],
	#category : 'BookStore-Core',
	#package : 'BookStore-Core'
}

{ #category : 'adding' }
BSInventory >> addBook: aBook [
	books add: aBook.
]

{ #category : 'accessing' }
BSInventory >> books [
	^ books
]

{ #category : 'testing' }
BSInventory >> includesTitle: aString [
	^ books anySatisfy: [ :eachBook | eachBook title asLowercase = aString asLowercase ]
]

{ #category : 'initialization' }
BSInventory >> initialize [
	super initialize.
	books := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
BSInventory >> loadFromFile [
    | fileReference loadedBooks |
    fileReference := 'bookstore.ston' asFileReference.
    
    fileReference exists ifTrue: [ 
        fileReference readStreamDo: [ :stream | 
            loadedBooks := STON fromStream: stream ].
        books := loadedBooks.
    ] ifFalse: [ 
        books := OrderedCollection new.
    ]
]

{ #category : 'removing' }
BSInventory >> reduceStock: aBook [
	aBook quantity: (aBook quantity - 1).
	
	(aBook quantity <= 0) ifTrue: [ 
		self removeBook: aBook.
	]
]

{ #category : 'removing' }
BSInventory >> removeBook: aBook [
	books remove: aBook ifAbsent: [ ].
]

{ #category : 'as yet unclassified' }
BSInventory >> saveToFile [
    | fileReference |
    fileReference := 'bookstore.ston' asFileReference.
    
    fileReference writeStreamDo: [ :stream | 
        STON put: books onStreamPretty: stream ]
]

{ #category : 'accessing' }
BSInventory >> totalPrice [
	^ books sumNumbers: [ :eachBook | eachBook price ]
]
