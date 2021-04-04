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
	self call: CuOOraHomeComponent new
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
		paragraph: [ aCanvas label: 'Ingrese el nombre de usuario que desea:'.
			aCanvas textInput ].
	aCanvas
		paragraph: [ aCanvas label: 'Ingrese la contraseña:'.
			aCanvas textInput ].
	aCanvas anchor
		callback: [ self accept ];
		with: [ aCanvas button: 'Aceptar' ].
	aCanvas space.
	aCanvas anchor
		callback: [ self cancel ];
		with: [ aCanvas button: 'Cancelar' ]
]

{ #category : #accessing }
RegisterComponent >> userName [
	^ userName
]

{ #category : #accessing }
RegisterComponent >> userName: anObject [
	userName := anObject
]
