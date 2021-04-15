Class {
	#name : #CuOOraSystemTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'topic1',
		'topic2',
		'topic3',
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
CuOOraSystemTest >> makeAnswers [
	user2 addAnswerTo: question1 withText: 'blah blah'.
		user1 addAnswerTo: question1 withText: 'something'
]

{ #category : #setUps }
CuOOraSystemTest >> makeInterestsForUser [
	cuoora addTopic: topic1 forUser: user1.
	cuoora addTopic: topic2 forUser: user2
]

{ #category : #setUps }
CuOOraSystemTest >> makeQuestions [
	question1 := Question newWithName: '' topics: topic1 andContent: ''.
	question2 := Question
		newWithName: ''
		topics: topic2
		andContent: ''.
	question3 := Question newWithName: '' topics: topic1 andContent: ''
]

{ #category : #setUps }
CuOOraSystemTest >> makeTopics [
	topic1 := Topic new.	"With: 'Python' desc: 'about Python language'"
	topic2 := Topic new.	"With: 'Java' desc: 'about Java language'"
	topic3 := Topic new.	"With: 'Rust' desc: 'about Rustn language'"
]

{ #category : #setUps }
CuOOraSystemTest >> makeUsers [
	"Add any changes to posts constuctor here"

	user1 := User new.	"WithUsername: 'Elio' andPassword: '123'"
	user2 := User new.	"WithUsername: 'Marco' andPassword: 'abc'"
]

{ #category : #running }
CuOOraSystemTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	cuoora := CuOOraSystem new.
	self makeTopics.
	cuoora
		addTopic: topic1;
		addTopic: topic2;
		addTopic: topic3.
		self makeUsers.
	self makeQuestions.
	user1
		addQuestion: question1;
		addQuestion: question2.
	user2 addQuestion: question3.
	cuoora
		addUser: user1;
		addUser: user2.
]

{ #category : #tests }
CuOOraSystemTest >> testDeleteQuestion [
	self makeAnswers.
	self assert: (cuoora deleteQuestion: question1)
]

{ #category : #tests }
CuOOraSystemTest >> testGetAllQuestions [
]

{ #category : #tests }
CuOOraSystemTest >> testGetAnswers [
	self assertEmpty: (cuoora getAnswers: question1).
	user2 addAnswerTo: question1 withText: 'Python is interpreted'.
	self denyEmpty: (cuoora getAnswers: question1).

]

{ #category : #tests }
CuOOraSystemTest >> testQuestionsForTopic [
	self denyEmpty: (cuoora questionsForTopic: topic1).
	self assertCollection:  (cuoora questionsForTopic: topic1) hasSameElements: { question1. question3 }
]

{ #category : #tests }
CuOOraSystemTest >> testRelevantQuestionsForUser [
	cuoora addTopic: topic1 forUser: user1.
	self
		assertCollection: (cuoora relevantQuestionsForUser: user1)
		hasSameElements:
			{question1.
			question3} asSet
]
