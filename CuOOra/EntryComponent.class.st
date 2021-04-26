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
	mensaje:		<Object>


    Implementation Points
"
Class {
	#name : #EntryComponent,
	#superclass : #AuthComponent,
	#instVars : [
		'mensaje'
	],
	#category : #'CuOOra-UI'
}

{ #category : #factory }
EntryComponent class >> conMensaje: unString [
	^ self new conMensaje: unString 
]

{ #category : #visiting }
EntryComponent >> accept [
	(user := self model userWithName: userName protectedBy: password)
		ifNotNil: [ self entrarCon: user ]
		ifNil: [ userName := nil.
			password := nil.
			mensaje:= 'el usuario no existe' ]
]

{ #category : #initialization }
EntryComponent >> conMensaje: unString [
mensaje := unString
	
]

{ #category : #rendering }
EntryComponent >> formulario: aCanvas [
	aCanvas heading: 'Login'.
	aCanvas small: mensaje.
	aCanvas horizontalRule.
	aCanvas
		paragraph: [ aCanvas label: 'Usuario: '.
			aCanvas textInput on: #userName of: self ].
	aCanvas
		paragraph: [ aCanvas label: 'Contrasena: '.
			aCanvas passwordInput on: #password of: self ].
]

{ #category : #initialization }
EntryComponent >> initialize [
super initialize.
	mensaje := ''
]
