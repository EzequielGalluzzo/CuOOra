Class {
	#name : #LandingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password',
		'user'
	],
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #visiting }
LandingComponent >> accept [
	user:= self model addUser: userName pass: password.
	self answer.
]

{ #category : #visiting }
LandingComponent >> cancel [
	user := nil.
	self answer.
	
]

{ #category : #visiting }
LandingComponent >> listUsers: someUsers [
	self call: (ListUsersComponent users: someUsers)
]

{ #category : #accessing }
LandingComponent >> model [ 
	^ CuOOraSystem  soleInstance 
]

{ #category : #accessing }
LandingComponent >> password [
	^ password
]

{ #category : #accessing }
LandingComponent >> password: anObject [
	password := anObject
]

{ #category : #rendering }
LandingComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'Bienvenido a CuOOra: Tu red social de preguntas'.
	aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Usuario: '.
					aCanvas textInput on: #userName of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Contrasena: '.
					aCanvas passwordInput on: #password of: self ].
			aCanvas button
				callback: [ self accept ];
				with: 'Guardar'.
			aCanvas space.
			aCanvas button
				callback: [ self cancel ];
				with: 'Cancelar' ].
	aCanvas horizontalRule.
	aCanvas form: [
	aCanvas button
		callback: [ self listUsers: self model getUsers ];
		with: [ aCanvas label: 'List Users' ]]
]

{ #category : #accessing }
LandingComponent >> userName [
	^ userName
]

{ #category : #accessing }
LandingComponent >> userName: anObject [
	userName := anObject
]
