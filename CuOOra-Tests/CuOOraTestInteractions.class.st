Class {
	#name : #CuOOraTestInteractions,
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
CuOOraTestInteractions >> makeDislikes [
	user1 dislikePost: question1.
	 user2 dislikePost: question1
]

{ #category : #setUps }
CuOOraTestInteractions >> makeLikes [
	"twolikes for q1"

	user1 likePost: question1.
	user2 likePost: question1
]

{ #category : #setUps }
CuOOraTestInteractions >> makeQuestions [
	question1 := Question new.
	question2 := Question new.
	question3 := Question new
]

{ #category : #setUps }
CuOOraTestInteractions >> makeUsers [
	"Add any changes to posts constuctor here"

	user1 := User new.	"WithUsername: 'Elio' andPassword: '123'"
	user2 := User new.	"WithUsername: 'Marco' andPassword: 'abc'"
	user3 := User new	"WithUsername: 'Pablo' andPassword: '900'"
]

{ #category : #running }
CuOOraTestInteractions >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	cuoora := CuOOraSystem new.
	"genera 3 usuarios"
	self makeUsers.
	"agrega 3 preguntas"
	self makeQuestions.
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
CuOOraTestInteractions >> testGetPostInteractions [
	self assertEmpty: (cuoora getPostInteractions: question1).
	self makeLikes.
	self denyEmpty: (cuoora getPostInteractions: question1).
	self assert: (cuoora getPostInteractions: question1) size equals: 2.
]

{ #category : #tests }
CuOOraTestInteractions >> testGetUserPoints [
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
