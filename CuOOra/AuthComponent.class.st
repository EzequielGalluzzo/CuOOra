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
	password:		<Object>
	user:		<Object>
	userName:		<Object>


    Implementation Points
"
Class {
	#name : #AuthComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password',
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
AuthComponent >> accept [
	self subclassResponsibility 
]

{ #category : #visiting }
AuthComponent >> cancel [
	user := nil.
	self answer.
	
]

{ #category : #visiting }
AuthComponent >> entrarCon: aUser [
	self session login: user.
	self call: MyHomePageComponent new
]

{ #category : #rendering }
AuthComponent >> formulario: aCanvas [
	self subclassResponsibility 
]

{ #category : #accessing }
AuthComponent >> model [ 
	^ CuOOraSystem  soleInstance 
]

{ #category : #rendering }
AuthComponent >> mostrarBotones: aCanvas [
		aCanvas submitButton
		callback: [ self accept ];
		with: 'Guardar'.
	aCanvas space.
	aCanvas submitButton
		callback: [ self cancel ];
		with: 'Cancelar'
]

{ #category : #accessing }
AuthComponent >> password [
	^ password
]

{ #category : #accessing }
AuthComponent >> password: anObject [
	password := anObject
]

{ #category : #rendering }
AuthComponent >> renderContentOn: aCanvas [
		aCanvas
		form: [ self formulario: aCanvas.
			self mostrarBotones: aCanvas ]
]

{ #category : #accessing }
AuthComponent >> user [
	^ user
]

{ #category : #accessing }
AuthComponent >> user: anObject [
	user := anObject
]

{ #category : #accessing }
AuthComponent >> userName [
	^ userName
]

{ #category : #accessing }
AuthComponent >> userName: anObject [
	userName := anObject
]
