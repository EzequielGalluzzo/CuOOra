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
	#name : #User,
	#superclass : #Object,
	#instVars : [
		'interactions',
		'timeAndDate',
		'username',
		'password',
		'answers',
		'questions'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
User class >> newWithUsername: aUsername andPassword: aPassword [
	^ self new initializeWith: aUsername and: aPassword.
]

{ #category : #action }
User >> dislikePost: aPost [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfPost: aPost ]
	ifFound: [ interaction dislike ]
		ifNone: [ interaction := Dislike newFor: aPost.
			[ interactions add: interaction ] ]
]

{ #category : #initialization }
User >> initialize [  
"solo se puede tener una interaccion para cada posteo, un Set evita repeticiones"

timeAndDate:= Date today.
answers := OrderedCollection new.
questions := OrderedCollection new.
interactions:= Set new.
]

{ #category : #initialization }
User >> initializeWith: aUsername and: aPassword [
	username:= aUsername.
	password := aPassword.
]

{ #category : #action }
User >> likePost: aPost [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfPost: aPost ]
		ifFound: [ interaction like ]
		ifNone: [ interaction := Like newFor: aPost.
			[ interactions add: interaction ] ]
]
