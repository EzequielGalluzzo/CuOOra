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
	preguntas:		<Object>


    Implementation Points
"
Class {
	#name : #Topic,
	#superclass : #Object,
	#instVars : [
		'questions',
		'name',
		'description'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
Topic class >> newWith: aName desc: aDescription [
	^ self new initializeWith: aName and: aDescription 
]

{ #category : #adding }
Topic >> addQuestion: aQuestion [
	questions add: aQuestion 
]

{ #category : #initialization }
Topic >> initialize [ 
	questions := Set new.
]

{ #category : #initialization }
Topic >> initializeWith: aName and: aDescription [ 
	name:= aName.
	description := aDescription. 
]

{ #category : #accessing }
Topic >> relatedQuestions [ 
	^ questions 
]
