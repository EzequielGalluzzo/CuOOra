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
	password:		<Object>
	user:		<Object>
	userName:		<Object>


    Implementation Points
"
Class {
	#name : #LandingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password',
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
LandingComponent >> irACasa [
	self call: MyHomePageComponent new.
]

{ #category : #visiting }
LandingComponent >> listUsers: someUsers [
	self call: (ListUsersComponent users: someUsers)
]

{ #category : #'private protocol' }
LandingComponent >> login [ 	
self call: EntrarComponent new.
]

{ #category : #accessing }
LandingComponent >> model [
	^ CuOOraSystem soleInstance
]

{ #category : #rendering }
LandingComponent >> mostrarOpcionesdeEntrar: aCanvas [
aCanvas
				paragraph:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: [ aCanvas label: 'registrarte' ].
					aCanvas button
						callback: [ self login ];
						with: [ aCanvas label: 'entrar' ] ]
]

{ #category : #visiting }
LandingComponent >> registrar [
	self call: RegUserComponent new.

]

{ #category : #rendering }
LandingComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'Bienvenido a CuOOra: Tu red social de preguntas'.
	aCanvas horizontalRule.
	self session user
		ifNil: [ aCanvas paragraph:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: [ aCanvas label: 'registrarte' ].
					aCanvas button
						callback: [ self login ];
						with: [ aCanvas label: 'entrar' ] ] ]
		ifNotNil: [ aCanvas paragraph: 'Hola, bienvenido ' , self session user name.
			aCanvas
				form: [ aCanvas button
						callback: [ self irACasa ];
						with: [ aCanvas label: 'Home' ] ] ].
	aCanvas horizontalRule.

	aCanvas
		form: [ aCanvas button
				callback: [ self listUsers: self model getUsers ];
				with: [ aCanvas label: 'Listar Usuarios' ] ].
	aCanvas horizontalRule
]
