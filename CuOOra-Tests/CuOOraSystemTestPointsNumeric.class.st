Class {
	#name : #CuOOraSystemTestPointsNumeric,
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
CuOOraSystemTestPointsNumeric >> makeDislikes [
	user1 dislikePost: question1.
	 user2 dislikePost: question1
]

{ #category : #setUps }
CuOOraSystemTestPointsNumeric >> makeLikes [

	user1 likePost: question1.
	user2 likePost: question1
]

{ #category : #setUps }
CuOOraSystemTestPointsNumeric >> makeQuestionsAndAddToUsers [
	question1 := Question new.
	question2 := Question new.
	question3 := Question new.
		user3
		addQuestion: question1;
		addQuestion: question2.
	user2 addQuestion: question3.
]

{ #category : #setUps }
CuOOraSystemTestPointsNumeric >> makeUsers [

	user1 := User new.	
	user2 := User new.	
	user3 := User new	
]

{ #category : #running }
CuOOraSystemTestPointsNumeric >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	cuoora := CuOOraSystem new.
	self makeUsers.
	self makeQuestionsAndAddToUsers.
	cuoora
		addUser: user1;
		addUser: user2;
		addUser: user3
]

{ #category : #tests }
CuOOraSystemTestPointsNumeric >> testGetUserPoints [
	| user |
	self makeLikes.
	self assert: (cuoora getUserPoints: user3) equals: 42.	"20 * 2 questions + 2 likes"
	self makeDislikes.
	self assert: (cuoora getUserPoints: user3) equals: 38.	"20 * 2 questions - 2 dislikes"
	user := User new.
	cuoora addUser: user.
	user likePost: question1.
	self assert: (cuoora getUserPoints: user3) equals: 39.	"20 * 2 questions - 2 dislikes + 1 like"
	user1 addAnswerTo: question2 withText: 'first post'.
	self assert: (cuoora getUserPoints: user1) equals: 50.	"tiene una respuesta = 50"
	user1 dislikePost: question2.
	self assert: (cuoora getUserPoints: user3) equals: 38.	"un nuevo dislike a su post"
	user3 addAnswerTo: question2 withText: 'reply my own post'.
	self assert: (cuoora getUserPoints: user3) equals: 38.	"respuestas a propias preguntas no suman"
]
