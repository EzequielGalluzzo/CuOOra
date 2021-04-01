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
		'interests',
		'interactions',
		'timeAndDate',
		'username',
		'password',
		'answers',
		'questions',
		'follows'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
User class >> newWithUsername: aUsername andPassword: aPassword [
	^ self new initializeWith: aUsername and: aPassword.
]

{ #category : #adding }
User >> addAnswerTo: aQuestion withText: aText [
	| a |
	a := Answer newWithText: aText.
	aQuestion addAnswer: a.
	answers add: a.
	^ a
]

{ #category : #adding }
User >> addInterest: aTopic [
	interests  add: aTopic
]

{ #category : #adding }
User >> addQuestion: aQuestion [ 
	questions add: aQuestion
]

{ #category : #adding }
User >> addQuestionForTopic: aTopicOrMore name: aName description: aDescription [
	| q |
	q := Question
		newWithName: aName
		topics: aTopicOrMore
		andContent: aDescription.
	questions add: q.
	^ q
]

{ #category : #boolean }
User >> askedQuestion: aQuestion [
 ^ questions includes:  aQuestion 
]

{ #category : #action }
User >> deleteQuestion: aQuestion [
	(self askedQuestion: aQuestion)
		ifTrue: [ questions remove: aQuestion ]
		ifFalse: [ ^ false ]
]

{ #category : #action }
User >> dislikePost: aPost [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfPost: aPost ]
		ifNone: [ Dislike newFor: aPost ].
	interaction isDislike
		ifFalse: [ interactions remove: interaction ].
	interactions add: interaction
]

{ #category : #action }
User >> follow: aUser [
	follows
		detect: [ :user | user isFollower: aUser ]
		ifNone: [ follows add: aUser ]
]

{ #category : #accessing }
User >> followsUsers [
	^ follows
]

{ #category : #accessing }
User >> getAllAnswers [
	^ answers
]

{ #category : #accessing }
User >> getInteractions [
	^ interactions
]

{ #category : #accessing }
User >> getInterests [
	^ interests
]

{ #category : #action }
User >> getPointsFromUser [
	| userPoints repliedToOthers |
	userPoints := 0.
	userPoints := userPoints + questions size * 20.
	repliedToOthers := self getRepliesToOtherUsers.
	userPoints := userPoints + repliedToOthers size * 50.
	^ userPoints
]

{ #category : #accessing }
User >> getQuestions [ 
	^ questions
]

{ #category : #action }
User >> getRepliesToOtherUsers [
	"get all answers where the answer is not in my question's answers"

	^ questions
		collect: [ :q | q allAnswers ]
		thenReject: [ :a | answers includes: a ].
		

	"obsolete method as answers no longer know their questions:
	| repliedTo repliedToSelf |
	repliedTo := answers collect: [ :answ | answ question ]. 
	repliedToSelf := repliedTo intersection: questions.
	^ answers copyWithoutAll: repliedToSelf"
]

{ #category : #initialization }
User >> initialize [
	"solo se puede tener una interaccion para cada posteo, un Set evita repeticiones"

	timeAndDate := Date today.
	answers := OrderedCollection new.
	questions := OrderedCollection new.
	"interactions is obsolete - delete this variable"
	interactions := Set new
]

{ #category : #initialization }
User >> initializeWith: aUsername and: aPassword [
	username:= aUsername.
	password := aPassword.
]

{ #category : #boolean }
User >> isFollower: aUser [
	^ follows includes: aUser
]

{ #category : #action }
User >> likePost: aPost [
	| interaction |
	interaction := interactions
		detect: [ :inter | inter isOfPost: aPost ]
		ifNone: [ Like newFor: aPost ].
	interaction isLike
		ifFalse: [ interactions remove: interaction ].
	interactions add: interaction
]
