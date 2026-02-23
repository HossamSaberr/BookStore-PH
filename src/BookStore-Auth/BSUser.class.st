Class {
	#name : 'BSUser',
	#superclass : 'Object',
	#instVars : [
		'username',
		'password',
		'isAdmin'
	],
	#category : 'BookStore-Auth',
	#package : 'BookStore-Auth'
}

{ #category : 'accessing' }
BSUser >> isAdmin [
    ^ isAdmin
]

{ #category : 'accessing' }
BSUser >> username: aName password: aPassword isAdmin: aBoolean [
    username := aName.
    password := aPassword.
    isAdmin := aBoolean.
]
