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
	post:		<Object>
	reaction:		<Object>
	timeAndDate:		<Object>


    Implementation Points
"
Class {
	#name : #Interaction,
	#superclass : #Object,
	#instVars : [
		'post',
		'timeAndDate',
		'reaction'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Interaction class >> newFor: aPost [
	^ self new initializeForPost: aPost
]

{ #category : #action }
Interaction >> dislike [
    (reaction isLike)
	ifTrue: [ reaction := Dislike newFor: post ].
	^ reaction.
]

{ #category : #obsolete }
Interaction >> dislike: aPost [
    ((self isOfPost: aPost) and: reaction isLike)
	ifTrue: [ reaction := Dislike newFor: aPost ].
	^ reaction.
]

{ #category : #initialization }
Interaction >> initializeForPost: aPost [
	post:= aPost.
	timeAndDate := Date today.
	reaction := self.

]

{ #category : #testing }
Interaction >> isDislike [
	^ self subclassResponsibility 
]

{ #category : #testing }
Interaction >> isLike [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
Interaction >> isOfPost: aPost [
	^ (aPost == post)

]

{ #category : #action }
Interaction >> like [
    (reaction isDislike)
	ifTrue: [ reaction := Like newFor: post ].
	^ reaction.
]

{ #category : #obsolete }
Interaction >> like: aPost [
	((self isOfPost: aPost) and: reaction isDislike)
	ifTrue: [ reaction := Like newFor: aPost ].
	^ reaction.
]
