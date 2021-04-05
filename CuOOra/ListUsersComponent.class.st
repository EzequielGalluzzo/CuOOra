Class {
	#name : #ListUsersComponent,
	#superclass : #WAComponent,
	#instVars : [
		'users'
	],
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #accessing }
ListUsersComponent class >> users: users [ 
	^ self new
	users: users; yourself
]

{ #category : #rendering }
ListUsersComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'Users in System'.
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ users
				do: [ :each | 
					aCanvas
						listItem: [ aCanvas paragraph: 'Username: ' , each name.
							aCanvas paragraph: 'password length: ' , each password size asString ] ] ]
]

{ #category : #accessing }
ListUsersComponent >> users: someUsers [ 	
users := someUsers
]
