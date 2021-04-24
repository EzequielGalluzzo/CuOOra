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
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
User class >> newWithUsername: aUsername andPassword: aPassword [
	^ self new initializeWith: aUsername and: aPassword.
]

{ #category : #'instance creation' }
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

{ #category : #'instance creation' }
User >> addQuestionForTopic: aTopicOrMore name: aName description: aDescription [
	| q |
	q := Question
		newWithName: aName
		topics: aTopicOrMore
		andContent: aDescription.
	questions add: q.
	^ q
]

{ #category : #'evaluating-private' }
User >> askedQuestion: aQuestion [
 ^ questions includes:  aQuestion 
]

{ #category : #deleting }
User >> deleteAnswer: anAnswer [
	(answers includes: anAnswer)
		ifTrue: [ answers remove: anAnswer.  ^ true ]
		ifFalse: [ ^false  ]
]

{ #category : #deleting }
User >> deleteQuestion: aQuestion [
	(self askedQuestion: aQuestion)
		ifTrue: [ questions remove: aQuestion. ^true ]
		ifFalse: [ ^ false ]
]

{ #category : #action }
User >> dislikePost: aPost [
	| i interaction |
	interaction := Dislike newFor: aPost.
	i := interactions
		detect: [ :inter | inter isOfPost: aPost ] ifNone:[ nil ].
	i ifNotNil:[ interactions remove: i ].
	interactions add: interaction
]

{ #category : #action }
User >> follow: aUser [
 (aUser = self)
 ifFalse: [
	follows
		detect: [ :user | user isFollower: aUser ]
		ifNone: [ follows add: aUser ]]
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

{ #category : #collection }
User >> getMyReplies [
	| temp temp1 temp2 |
	temp := (questions collect: [ :q | q allAnswers ]) flattened asSet.
	temp1 := (answers asSet) intersection: temp.
	temp2 := (answers asSet) difference: temp.
	^ temp2
]

{ #category : #numeric }
User >> getPointsFromUser [
	| userPoints temp |
	userPoints := 0.
	userPoints := userPoints + (questions size * 20).
	temp := self getMyReplies.
	userPoints := userPoints + (temp size * 50).
	^ userPoints
]

{ #category : #accessing }
User >> getQuestions [
 ^ questions 
]

{ #category : #'private-helpers' }
User >> hasName: aName hasPassword: aPassword [
^ username = aName & (password = aPassword )
]

{ #category : #'evaluating-private' }
User >> hasPost: aPost [
	^ ((questions includes: aPost) or: (answers includes: aPost))
]

{ #category : #initialization }
User >> initialize [
	"solo se puede tener una interaccion para cada posteo, un Set evita repeticiones"

	timeAndDate := DateAndTime today.
	answers := OrderedCollection new.
	questions := OrderedCollection new.
	follows := Set new.
	interests := Set new.
	interactions := Set new
]

{ #category : #initialization }
User >> initializeWith: aUsername and: aPassword [
	username:= aUsername.
	password := aPassword.
]

{ #category : #'evaluating-private' }
User >> isFollower: aUser [
	^ follows includes: aUser
]

{ #category : #action }
User >> likePost: aPost [
	| i like |
	i := interactions
		detect: [ :inter | inter isOfPost: aPost ]
		ifNone: [nil].
	i ifNotNil:[ interactions remove: i ].
	like:= Like newFor: aPost.
	interactions add: like
]

{ #category : #accessing }
User >> name [
	^ username
]

{ #category : #collection }
User >> relevantQuestions [

	| relevantQuestions followed |
	relevantQuestions := self getInterests collect: [ :t | t relatedQuestions ].
	followed := follows collect: [ :u | u getQuestions ].
   relevantQuestions addAll: followed.
	^ relevantQuestions flattened asSet
]

{ #category : #deleting }
User >> removeInterest: aTopic [
	interests remove: aTopic ifAbsent: [ false ]
]
