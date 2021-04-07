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


    Implementation Points
"
Class {
	#name : #RegUserComponent,
	#superclass : #AutorizarComponent,
	#category : #'CuOOra-UI'
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
