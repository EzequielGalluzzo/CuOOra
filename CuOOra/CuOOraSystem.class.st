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
	topics:		<Object>
	users:		<Object>


    Implementation Points
"
Class {
	#name : #CuOOraSystem,
	#superclass : #Object,
	#instVars : [
		'topics',
		'users'
	],
	#category : #CuOOra
}

{ #category : #action }
CuOOraSystem >> deleteQuestion: aQuestion [ 
|user |
	aQuestion deleteAnswers.
	user := users detect: [ :u | u askedQuestion: aQuestion ].
	user deleteQuestion: aQuestion.
]

{ #category : #accessing }
CuOOraSystem >> getAnswers: aQuestion [
	| aCol aColSorted |
	"given a question, I  need to ask the question for it's answers"
	aCol := aQuestion myAnswers.
	"then I need to sort all answers in relation to interaction points for each answer,
	from most points to least"
	aColSorted := aCol
		sort: [ :a :b | 
			(self getInteractionPoints: (self getPostInteractions: a))
				> (self getInteractionPoints: (self getPostInteractions: b)) ].
	^ aColSorted
]

{ #category : #'math functions' }
CuOOraSystem >> getInteractionPoints: aCollectionOfInteractions [
	| totalLikes totalDislikes |
	totalLikes := aCollectionOfInteractions
		inject: 0
		into: [ :sum :each | sum + each isLike asBit ].
	totalDislikes := aCollectionOfInteractions
		inject: 0
		into: [ :sum :each | sum + each isDislike asBit ].
	^ totalLikes + (totalDislikes * -1)
]

{ #category : #accessing }
CuOOraSystem >> getPostInteractions: aPost [
	| intCol| 
	"for this post, I need to collect all users interactions,
	and then find all interactions with a post which equals aPost"
	intCol := users flatCollect: [ :u | u myInteractions  ].
	^ intCol select: [:i | i hasPost: aPost  ].
	
]

{ #category : #numeric }
CuOOraSystem >> getUserPoints: aUser [
	| total posts interactions |
	total := 0.
	total sum: aUser getPointsFromUser.
	posts := aUser myQuestions.
	posts addAll: aUser myAnswers.
	"now from all users to get the posts from all of their interactions,
	if the posts of those interactions correspond to the user posts collected above, sum
	points of the interactions"
	interactions := users
		collect: [ :u | u myInteractions ]
		thenSelect: [ :i | posts do: [ :p | i hasPost: p ] ] flattened.
	^ self getInteractionPoints: interactions
]

{ #category : #accessing }
CuOOraSystem >> questionsForTopic: aTopic [
	^ aTopic relatedQuestions 
]

{ #category : #refactoring }
CuOOraSystem >> relevantQuestionsForUser: aUser [
	| questions follows q|
	"first we collect all of the questions from all of the topics relevant to the user"
	questions := aUser getInterests
		flatCollect: [ :t | t getRelevantQuestions ].
	"then we need to get all their followers and for each one get their questions"
	follows:= aUser followsUsers.
	q := follows flatCollect: [ :u | u getQuestions ].
	questions addAll:q.
	^ questions.
]
