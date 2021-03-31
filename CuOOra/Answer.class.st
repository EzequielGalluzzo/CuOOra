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
	#name : #Answer,
	#superclass : #Post,
	#instVars : [
		'text',
		'question'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
Answer class >> newFor: aQuestion withText: aText [ 
	^ self new initializeFor: aQuestion and: aText
]

{ #category : #initialization }
Answer >> initialize [ 
	super initialize.
]

{ #category : #initialization }
Answer >> initializeFor: aQuestion and: aText [
	text := aText
]

{ #category : #accessing }
Answer >> question [
	^ question
]

{ #category : #accessing }
Answer >> text [
	^ text
]
