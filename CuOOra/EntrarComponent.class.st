Class {
	#name : #EntrarComponent,
	#superclass : #AutorizarComponent,
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
EntrarComponent >> accept [
	(user := self model userWithName: userName protectedBy: password)
		ifNotNil: [ self entrarCon: user ].
	userName := nil.
	password := nil.
]

{ #category : #rendering }
EntrarComponent >> formulario: aCanvas [
	aCanvas heading: 'Login'.
	aCanvas horizontalRule.
	aCanvas
		paragraph: [ aCanvas label: 'Usuario: '.
			aCanvas textInput on: #userName of: self ].
	aCanvas
		paragraph: [ aCanvas label: 'Contrasena: '.
			aCanvas passwordInput on: #password of: self ]
]
