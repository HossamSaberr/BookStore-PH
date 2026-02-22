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

{ #category : 'initialization' }
BSInventory >> initialize [
	super initialize.
	books := OrderedCollection new.
]

{ #category : 'removing' }
BSInventory >> removeBook: aBook [
	books remove: aBook ifAbsent: [ ].
]

{ #category : 'accessing' }
BSInventory >> totalPrice [
	^ books sumNumbers: [ :eachBook | eachBook price ]
]
