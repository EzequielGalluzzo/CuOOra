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
	#name : #Question,
	#superclass : #Post,
	#instVars : [
		'name',
		'content',
		'topics',
		'answers'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
Question class >> newWithName: aName topics: aCollectionOfTopics andContent: someContent [
	^ (self new) initializeWith: aName topics: aCollectionOfTopics and: someContent.
]

{ #category : #adding }
Question >> addAnswer: anAnswer [
	answers add: anAnswer 
]

{ #category : #obsolete }
Question >> allAnswers [
^ answers
]

{ #category : #deleting }
Question >> deleteAnswers [ 
 answers removeAll.
]

{ #category : #initialization }
Question >> initialize [
	super initialize.
	answers := OrderedCollection new.
	topics := Set new.
]

{ #category : #initialization }
Question >> initializeWith: aName topics: aCollectionOfTopics and: someContent [.
	super initialize.
	name:= aName.
	topics addAll: aCollectionOfTopics.
	content := someContent 
]
