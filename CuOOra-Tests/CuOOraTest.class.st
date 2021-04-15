Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'topic1',
		'topic2',
		'topic3',
		'topicCollection',
		'question1',
		'question2',
		'question3',
		'question4',
		'cuoora',
		'answer1'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
CuOOraTest >> makeAnswers [
	user2 addAnswerTo: question1 withText: 'blah blah'.
		user1 addAnswerTo: question1 withText: 'something'
]

{ #category : #setUps }
CuOOraTest >> makeInteractions [
	"three likes for q1"
	user1 likePost: question1.
	user2 likePost: question1.
	user3 likePost: question1.
	user3 likePost: question1.
	"two likes q2"
	user1 likePost: question2.
	user2 likePost: question2.
	"one like one dislike q2"
	user1 dislikePost: question3.
	user1 likePost: question3.
	user3 dislikePost: question3.
	user3 dislikePost: question3.
	"three dislikes for q4"
	user3 dislikePost: question4.
	user1 dislikePost: question4.
	user2 dislikePost: question4
]

{ #category : #setUps }
CuOOraTest >> makeInterestsForUser [
	cuoora addTopic: topic1 forUser: user1.
	cuoora addTopic: topicCollection forUser: user3.
]

{ #category : #setUps }
CuOOraTest >> makeQuestions [
	question1 := Question new.
	question2 := Question new.	
	question3 := Question new
]

{ #category : #setUps }
CuOOraTest >> makeTopics [
	topic1 := Topic new "With: 'Python' desc: 'about Python language'".
	topic2 := Topic new "With: 'Java' desc: 'about Java language'".
	topic3 := Topic new "With: 'Rust' desc: 'about Rustn language'".
	topicCollection := OrderedCollection new.
	topicCollection
		add: topic1;
		add: topic2
]

{ #category : #setUps }
CuOOraTest >> makeUsers [
	"Add any changes to posts constuctor here"

	user1 := User new "WithUsername: 'Elio' andPassword: '123'".
	user2 := User new "WithUsername: 'Marco' andPassword: 'abc'".
	user3 := User new "WithUsername: 'Pablo' andPassword: '900'"
]

{ #category : #running }
CuOOraTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
		cuoora := CuOOraSystem new.
	"genera 3 usuarios"
	self makeUsers.
	"agrega 3 preguntas".
	self makeQuestions.
		user1
		addQuestion: question1;
		addQuestion: question2.
	user2 addQuestion: question3.
	cuoora
		addUser: user1;
		addUser: user2;
		addUser: user3.
]

{ #category : #tests }
CuOOraTest >> testDeleteQuestion [
	self makeAnswers.
	self assert: (cuoora deleteQuestion: question1).

]

{ #category : #tests }
CuOOraTest >> testGetAnswers [
	self assertEmpty: (cuoora getAnswers: question1).
	user2 addAnswerTo: question1 withText: 'Python is interpreted'.
	self denyEmpty: (cuoora getAnswers: question1).

]

{ #category : #tests }
CuOOraTest >> testGetUserPoints [
	self makeInteractions.
	self assert: (cuoora getUserPoints: user1) equals: 62.
	self assert: (cuoora getUserPoints: user2) equals: 22.
	self assert: (cuoora getUserPoints: user3) equals: 2
]

{ #category : #tests }
CuOOraTest >> testQuestionsForTopic [
	self denyEmpty: (cuoora questionsForTopic: topic1).
	self assertCollection:  (cuoora questionsForTopic: topic1) hasSameElements: { question1. question3 }
]

{ #category : #tests }
CuOOraTest >> testRelevantQuestionsForUser [
	cuoora addTopic: topic1 forUser: user1.
	self
		assertCollection: (cuoora relevantQuestionsForUser: user1)
		hasSameElements:
			{question1.
			question3} asSet
]
