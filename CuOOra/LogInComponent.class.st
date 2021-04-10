Class {
	#name : #LogInComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password'
	],
	#category : #'CuOOra-UI'
}

{ #category : #callbacks }
LogInComponent >> accept [
	(self model userWithName: userName protectedBy: password)
		ifNotNil: [ :it | self procedeWith: it ]
		ifNil:[
	userName := nil.
	password := nil]
]

{ #category : #callbacks }
LogInComponent >> cancel [
	self call: CuOOraHomeComponent new
]

{ #category : #model }
LogInComponent >> model [
	^ CuOOraSystem soleInstance
]

{ #category : #accessing }
LogInComponent >> password [
	^ password
]

{ #category : #accessing }
LogInComponent >> password: anObject [
	password := anObject
]

{ #category : #callbacks }
LogInComponent >> procedeWith: aUser [
	self session user: aUser.
	self call: UserHomeComponent new
]

{ #category : #rendering }
LogInComponent >> renderContentOn: aCanvas [
	aCanvas
		form: "agregue aCanvas form:[]"
		 [ aCanvas
				paragraph: [ aCanvas label: 'Ingrese su nombre de usuario:'.
					aCanvas textInput on: #userName of: self ].	"agregue on: #userName of: self"
			aCanvas
				paragraph: [ aCanvas label: 'Ingrese su contraseña:'.
					aCanvas passwordInput on: #password of: self ].	"agregue on: #password of: self"
			aCanvas anchor
				callback: [ self accept ];
				with: [ aCanvas button: 'Aceptar' ].
			aCanvas space.
			aCanvas anchor
				callback: [ self cancel ];
				with: [ aCanvas button: 'Cancelar' ] ]
]

{ #category : #accessing }
LogInComponent >> userName [
	^ userName
]

{ #category : #accessing }
LogInComponent >> userName: anObject [
	userName := anObject
]
