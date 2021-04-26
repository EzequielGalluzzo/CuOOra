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
	fechaHoraDeCreacion:		<Object>
	interacciones:		<Object>


    Implementation Points
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'time',
		'date',
		'likes',
		'dislikes'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'private - testing' }
Post class >> newMockWith: aDate and: aTime [
   ^ self new  initializeWithDate: aDate and: aTime; yourself
]

{ #category : #accessing }
Post >> date [
	^ date asString , ' ' , time print24
]

{ #category : #action }
Post >> dislikePost: aUser [
	| like dislike |
	like := likes detect: [ :l | l isOfUser: aUser ] ifNone: [ nil ].
	like ifNotNil: [ likes remove: like ].
	dislike := dislikes
		detect: [ :l | l isOfUser: aUser ]
		ifNone: [ nil ].
	dislike ifNil: [ dislikes add: (Dislike newFor: aUser) ]
]

{ #category : #numeric }
Post >> getNumberOfDislikes [
	^ dislikes size 
]

{ #category : #numeric }
Post >> getNumberOfLikes [
	^ likes size
]

{ #category : #numeric }
Post >> getPoints [
	^ likes size - dislikes size
]

{ #category : #initialization }
Post >> initialize [
	time := Time now.
	date := Date today.
	likes := OrderedCollection new.
	dislikes := OrderedCollection new
]

{ #category : #initialization }
Post >> initializeWithDate: aDate and: aTime [
	date := aDate.
	time := aTime
]

{ #category : #action }
Post >> likePost: aUser [
	| like dislike |
	dislike := dislikes
		detect: [ :d | d isOfUser: aUser ]
		ifNone: [ nil ].
	dislike ifNotNil: [ dislikes remove: dislike ].
	
	like := likes detect: [ :l | l isOfUser: aUser ] ifNone: [ nil ].
	like ifNil: [ likes add: (Like newFor: aUser) ]
]

{ #category : #accessing }
Post >> postTimeDate [
	^ (date + time )asDateAndTime 
]
