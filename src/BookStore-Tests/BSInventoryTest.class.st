Class {
	#name : 'BSInventoryTest',
	#superclass : 'TestCase',
	#category : 'BookStore-Tests',
	#package : 'BookStore-Tests'
}

{ #category : 'tests' }
BSInventoryTest >> testRemoveBook [
	| store book |
	store := BSInventory new.
	book := BSBook new title: '1984' author: 'George Orwell' price: 15.
	
	store addBook: book.
	self assert: store books size equals: 1.
	
	store removeBook: book.
	self assert: store books isEmpty.
]

{ #category : 'tests' }
BSInventoryTest >> testTotalPrice [
	| store book1 book2 |
	
	store := BSInventory new.
	book1 := BSBook new title: 'Book 1' author: 'Author 1' price: 10.
	book2 := BSBook new title: 'Book 2' author: 'Author 2' price: 20.
	
	store addBook: book1.
	store addBook: book2.
	
	self assert: store totalPrice equals: 30.
]
