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
		'timeAndDateOfCreation',
		'interactions'
	],
	#category : #CuOOra
}

{ #category : #action }
Post >> dislikeFrom: aUser [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfUser: aUser ]
		ifNone: [ interaction := Dislike newFor: aUser.
			interactions add: interaction.
			^ self ].
	interaction dislike
]

{ #category : #action }
Post >> dislikePost: aUser [
| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfUser: aUser ]
		ifFound: [ interaction dislike ]
		ifNone: [ interaction := Dislike newFor: aUser.
			[ interactions add: interaction ] ].
]

{ #category : #'math functions' }
Post >> getInteractionPoints [
	| totalLikes totalDislikes |
	totalLikes := interactions
		inject: 0
		into: [ :sum :each | sum + each isLike asBit ].
	totalDislikes := interactions
		inject: 0
		into: [ :sum :each | sum + each isDislike asBit ].
	^ totalLikes + (totalDislikes * -1)
]

{ #category : #initialization }
Post >> initialize [
	timeAndDateOfCreation := Date today.
	interactions := Set new.
]

{ #category : #action }
Post >> likeFrom: aUser [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfUser: aUser ]
		ifNone: [ interaction := Like newFor: aUser.
			interactions add: interaction.
			^ self ].
	interaction like
]

{ #category : #action }
Post >> likePost: aUser [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfUser: aUser ]
		ifFound: [ interaction like ]
		ifNone: [ interaction := Like newFor: aUser.
			[ interactions add: interaction ] ]
]
