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

{ #category : #protocol }
ListUsersComponent >> back [
	self answer
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
							aCanvas
								paragraph: 'password length: ' , each password size asString ] ] ].
	aCanvas horizontalRule.
	aCanvas form: [ 
		aCanvas button callback:[ self back ]; with:[ aCanvas label: 'volver' ]]
]

{ #category : #accessing }
ListUsersComponent >> users: someUsers [ 	
users := someUsers
]
