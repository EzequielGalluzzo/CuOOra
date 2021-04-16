Class {
	#name : #CuOOraSystemTestInteractions,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'question1',
		'question2',
		'cuoora',
		'answer1',
		'question3'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
CuOOraSystemTestInteractions >> makeDislikes [
	user1 dislikePost: question1.
	 user2 dislikePost: question1
]

{ #category : #setUps }
CuOOraSystemTestInteractions >> makeLikes [

	user1 likePost: question1.
	user2 likePost: question1
]

{ #category : #setUps }
CuOOraSystemTestInteractions >> makeQuestionsAndAddToUsers [
	question1 := Question new.
	question2 := Question new.
	question3 := Question new
]

{ #category : #setUps }
CuOOraSystemTestInteractions >> makeUsers [

	user1 := User new.	
	user2 := User new.	
	user3 := User new	
]

{ #category : #running }
CuOOraSystemTestInteractions >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	cuoora := CuOOraSystem new.
	"genera 3 usuarios"
	self makeUsers.
	"agrega 3 preguntas"
	self makeQuestionsAndAddToUsers.
	user3
		addQuestion: question1;
		addQuestion: question2.
	"40 points"
	user2 addQuestion: question3.
	cuoora
		addUser: user1;
		addUser: user2;
		addUser: user3
]

{ #category : #tests }
CuOOraSystemTestInteractions >> testGetPostInteractions [
	self assertEmpty: (cuoora getPostInteractions: question1).
	self makeLikes.
	self denyEmpty: (cuoora getPostInteractions: question1).
	self assert: (cuoora getPostInteractions: question1) size equals: 2.


]

{ #category : #tests }
CuOOraSystemTestInteractions >> testGetUserPoints [
	| user |
	self makeLikes.
	self assert: (cuoora getUserPoints: user3) equals: 42.	"20 * 2 questions + 2 likes"
	self makeDislikes.
	self assert: (cuoora getUserPoints: user3) equals: 38.	"20 * 2 questions - 2 dislikes"
	user := User new.
	cuoora addUser: user.
	user likePost: question1.
	self assert: (cuoora getUserPoints: user3) equals: 39	"20 * 2 questions - 2 dislikes"

]
