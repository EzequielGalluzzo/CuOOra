Class {
	#name : #RegisterComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password'
	],
	#category : #'CuOOra-UI'
}

{ #category : #callbacks }
RegisterComponent >> accept [
	| aUser |
	aUser := User userName: userName password: password.
	self model addUser: aUser.
	self call: CuOOraHomeComponent new
]

{ #category : #callbacks }
RegisterComponent >> cancel [
	self answer.
]

{ #category : #model }
RegisterComponent >> model [
	^ CuOOraSystem soleInstance
]

{ #category : #accessing }
RegisterComponent >> password [
	^ password
]

{ #category : #accessing }
RegisterComponent >> password: anObject [
	password := anObject
]

{ #category : #rendering }
RegisterComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Ingrese el nombre de usuario que desea:'.
					aCanvas textInput on: #userName of: self ].	"agregue on: #userName of: self"
			aCanvas
				paragraph: [ aCanvas label: 'Ingrese la contraseña:'.
					aCanvas passwordInput on: #password of: self ]."agregue on: #password of: self"
			aCanvas button
				callback: [ self accept ];
				with: [ aCanvas label: 'Aceptar' ].
			aCanvas space.
			aCanvas button
				callback: [ self cancel ];
				with: [ aCanvas label: 'Cancelar' ] ]
]

{ #category : #accessing }
RegisterComponent >> userName [
	^ userName
]

{ #category : #accessing }
RegisterComponent >> userName: anObject [
	userName := anObject
]
