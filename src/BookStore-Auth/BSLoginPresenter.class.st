Class {
	#name : 'BSLoginPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'usernameInput',
		'passwordInput',
		'loginButton'
	],
	#category : 'BookStore-Auth',
	#package : 'BookStore-Auth'
}

{ #category : 'initialization' }
BSLoginPresenter >> connectPresenters [
    loginButton action: [ 
        (usernameInput text = 'admin' and: [ passwordInput text = 'admin123' ])
            ifTrue: [ 
                self delete.
                BSStorePresenter new open ]
            ifFalse: [ 
                (usernameInput text = 'guest' and: [ passwordInput text = 'guest123' ])
                    ifTrue: [ 
                        self delete.
                        BSStorePresenter new 
                            disableManagement; 
                            open ]
                    ifFalse: [ 
                        UIManager default alert: 'Invalid username or password! Please try again.' ] ]
    ].
]

{ #category : 'layout' }
BSLoginPresenter >> defaultLayout [
    ^ SpBoxLayout newTopToBottom
        spacing: 10;
        add: usernameInput;
        add: passwordInput;
        add: loginButton expand: false;
        yourself
]

{ #category : 'initialization' }
BSLoginPresenter >> initializePresenters [
    usernameInput := self newTextInput placeholder: 'Username'.
    
    passwordInput := self newTextInput 
        placeholder: 'Password';
        bePassword. 
        
    loginButton := self newButton label: 'Login'.
]
