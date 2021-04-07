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
	#name : #AutorizarComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password',
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
AutorizarComponent >> accept [
	self subclassResponsibility 
]

{ #category : #visiting }
AutorizarComponent >> cancel [
	user := nil.
	self answer.
	
]

{ #category : #visiting }
AutorizarComponent >> entrarCon: aUser [
	self session login: user.
	self session topics: self model getAllTopics.
	self call: MyHomePageComponent new
]

{ #category : #rendering }
AutorizarComponent >> formulario: aCanvas [
	self subclassResponsibility 
]

{ #category : #accessing }
AutorizarComponent >> model [ 
	^ CuOOraSystem  soleInstance 
]

{ #category : #rendering }
AutorizarComponent >> mostrarBotones: aCanvas [
		aCanvas submitButton
		callback: [ self accept ];
		with: 'Guardar'.
	aCanvas space.
	aCanvas submitButton
		callback: [ self cancel ];
		with: 'Cancelar'
]

{ #category : #accessing }
AutorizarComponent >> password [
	^ password
]

{ #category : #accessing }
AutorizarComponent >> password: anObject [
	password := anObject
]

{ #category : #rendering }
AutorizarComponent >> renderContentOn: aCanvas [
		aCanvas
		form: [ self formulario: aCanvas.
			self mostrarBotones: aCanvas ]
]

{ #category : #accessing }
AutorizarComponent >> user [
	^ user
]

{ #category : #accessing }
AutorizarComponent >> user: anObject [
	user := anObject
]

{ #category : #accessing }
AutorizarComponent >> userName [
	^ userName
]

{ #category : #accessing }
AutorizarComponent >> userName: anObject [
	userName := anObject
]
