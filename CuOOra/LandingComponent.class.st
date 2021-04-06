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

{ #category : #visiting }
LandingComponent >> registrar [
	self call: RegUserComponent new.

]

{ #category : #rendering }
LandingComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'Bienvenido a CuOOra: Tu red social de preguntas'.
	aCanvas horizontalRule.
	self session user
		ifNil: [ aCanvas
				paragraph:
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
