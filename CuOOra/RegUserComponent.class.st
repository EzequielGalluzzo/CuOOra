Class {
	#name : #RegUserComponent,
	#superclass : #AutorizarComponent,
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #visiting }
RegUserComponent >> accept [
	user := self model addUser: userName pass: password.
	self entrarCon: user
]

{ #category : #rendering }
RegUserComponent >> formulario: aCanvas [
	aCanvas heading: 'Registrese'.
	aCanvas horizontalRule.
	aCanvas
		paragraph: [ aCanvas label: 'Agregar Su Nombre de Usuario Preferido: '.
			aCanvas textInput on: #userName of: self ].
	aCanvas
		paragraph: [ aCanvas label: 'Elija su Contrasena: '.
			aCanvas passwordInput on: #password of: self ]
]
