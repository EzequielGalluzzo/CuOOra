Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'topicCollection',
		'question1',
		'topic3',
		'question2',
		'topic1',
		'question3',
		'topic2',
		'question4',
		'cuoora'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #adding }
UserTest >> addQuestionsToUsers [
	user1
		addQuestion: question1;
		addQuestion: question2;
		addQuestion: question3.
	user2 addQuestion: question4.
]

{ #category : #setUps }
UserTest >> makeInteractions [
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
UserTest >> makeInterestsForUser [
	cuoora addTopic: topic1 forUser: user1.
	cuoora addTopic: topicCollection forUser: user3.
]

{ #category : #setUps }
UserTest >> makeQuestions [
	question1 := Question
		new"WithName: 'Q1'
		topics: topicCollection
		andContent: 'How are Java and Python different?'".
	question2 := Question
		new"WithName: 'Q2'
		topics: topic3
		andContent: 'What are some uses for Rust?'".
	question3 := Question
		new"WithName: 'Q3'
		topics: topic1
		andContent: 'What is a lambda function in Python?'".
	question4 := Question
		new"WithName: 'Q4'
		topics: topic2
		andContent: 'Can I work with memory in Java?'".

]

{ #category : #setUps }
UserTest >> makeTopics [
	topic1 := Topic newWith: 'Python' desc: 'about Python language'.
	topic2 := Topic newWith: 'Java' desc: 'about Java language'.
	topic3 := Topic newWith: 'Rust' desc: 'about Rust language'.
	topicCollection := OrderedCollection new.
	topicCollection
		add: topic1;
		add: topic2
]

{ #category : #setUps }
UserTest >> makeUsers [
	"Add any changes to posts constuctor here"

	user1 := User new" WithUsername: 'Elio' andPassword: '123'".
	user2 := User new "WithUsername: 'Marco' andPassword: 'abc'".
	user3 := User new "WithUsername: 'Pablo' andPassword: '900'"
]

{ #category : #running }
UserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	cuoora := CuOOraSystem new.
	"	self makeTopics."
	self makeUsers.
	self makeQuestions.
		cuoora
		addUser: user1;
		addUser: user2;
		addUser: user3.
]

{ #category : #tests }
UserTest >> testDeleteQuestion [
	self
		assert: (user1 deleteQuestion: question1). self
		deny: (user3 deleteQuestion: question3)
]

{ #category : #tests }
UserTest >> testDislikePost [
	| a |
	a := user1 addAnswerTo: question1 withText: 'something or other'.
	user1 dislikePost: a.
	self assert: (cuoora getPostInteractions: a) size equals: 1
]

{ #category : #tests }
UserTest >> testFollow [
	| f |
	user1 follow: user2.
	f := user1 followsUsers.
	self denyEmpty: f.
	self assertCollection: f equals: {user2} asSet.
	
]

{ #category : #tests }
UserTest >> testGetPointsFromUser [
	| a |
	self addQuestionsToUsers.
	self assert: user1 getPointsFromUser equals: 60.
	self assert: user2 getPointsFromUser equals: 20.
	self assert: user3 getPointsFromUser equals: 0.
	a := user1 addAnswerTo: question1 withText: 'something or other'.
	self assert: user1 getPointsFromUser equals: 60.
]

{ #category : #tests }
UserTest >> testGetRepliesToOtherUsers [
]

{ #category : #tests }
UserTest >> testLikePost [
		| a |
	a := user1 addAnswerTo: question1 withText: 'something or other'.
	user1 likePost: a.
	self assert: (cuoora getPostInteractions: a) size equals: 1
]
