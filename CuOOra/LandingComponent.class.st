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

{ #category : #rendering }
LandingComponent >> formularioLogin: aCanvas [
	aCanvas
		paragraph: [ aCanvas label: 'Usuario: '.
			aCanvas textInput on: #userName of: self ].
	aCanvas
		paragraph: [ aCanvas label: 'Contrasena: '.
			aCanvas passwordInput on: #password of: self ].

]

{ #category : #visiting }
LandingComponent >> listUsers: someUsers [
	self call: (ListUsersComponent users: someUsers)
]

{ #category : #accessing }
LandingComponent >> model [ 
	^ CuOOraSystem  soleInstance 
]

{ #category : #rendering }
LandingComponent >> mostrarBotones: aCanvas [
		aCanvas submitButton
		callback: [ self accept ];
		with: 'Guardar'.
	aCanvas space.
	aCanvas submitButton
		callback: [ self cancel ];
		with: 'Cancelar'
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
	aCanvas form: [ self formularioLogin: aCanvas.
						self mostrarBotones: aCanvas ].
	aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas button
				callback: [ self listUsers: self model getUsers ];
				with: [ aCanvas label: 'List Users' ] ]
]

{ #category : #accessing }
LandingComponent >> userName [
	^ userName
]

{ #category : #accessing }
LandingComponent >> userName: anObject [
	userName := anObject
]
