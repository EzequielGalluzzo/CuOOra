"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
 
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	users:		<Object>


    Implementation Points
"
Class {
	#name : #ListUsersComponent,
	#superclass : #WAComponent,
	#instVars : [
		'users'
	],
	#category : #'CuOOra-UI'
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
	aCanvas
		form: [ aCanvas button
				callback: [ self back ];
				with: [ aCanvas label: 'volver' ] ].
				aCanvas horizontalRule.
	aCanvas heading: 'Lista de Usuarios'.
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ users
				do: [ :each | 
					aCanvas
						listItem: [ aCanvas paragraph: 'Username: ' , each name.
							aCanvas
								paragraph: 'password length: ' , each password size asString ] ] ].
	aCanvas horizontalRule.

]

{ #category : #accessing }
ListUsersComponent >> users: someUsers [ 	
users := someUsers
]
