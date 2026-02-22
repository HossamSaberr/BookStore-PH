Class {
	#name : 'BSBook',
	#superclass : 'Object',
	#instVars : [
		'title',
		'author',
		'price'
	],
	#category : 'BookStore-Core',
	#package : 'BookStore-Core'
}

{ #category : 'accessing' }
BSBook >> author [

	^ author
]

{ #category : 'accessing' }
BSBook >> author: anObject [

	author := anObject
]

{ #category : 'accessing' }
BSBook >> price [

	^ price
]

{ #category : 'accessing' }
BSBook >> price: anObject [

	price := anObject
]

{ #category : 'accessing' }
BSBook >> title [

	^ title
]

{ #category : 'accessing' }
BSBook >> title: anObject [

	title := anObject
]

{ #category : 'accessing' }
BSBook >> title: aTitle author: anAuthor price: aPrice [
	title := aTitle.
	author := anAuthor.
	price := aPrice.
]
