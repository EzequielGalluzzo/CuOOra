Class {
	#name : #TopicTest,
	#superclass : #TestCase,
	#instVars : [
		'topic1',
		'topic2',
		'question1',
		'question2',
		'question3'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
TopicTest >> makeQuestions [
	question1 := Question
		newWithName: 'Q1'
		topics: topic2
		andContent: 'How are Java and Python different?'.
	question2 := Question
		newWithName: 'Q2'
		topics: topic2
		andContent: 'What are some uses for Rust?'.
	question3 := Question
		newWithName: 'Q3'
		topics: topic2
		andContent: 'What is a lambda function in Python?'.
	
]

{ #category : #setUps }
TopicTest >> makeTopics [
	topic1 := Topic newWith: 'Python' desc: 'about Python language'.
	topic2 := Topic newWith: 'Java' desc: 'about Java language'.
]

{ #category : #running }
TopicTest >> setUp [
super setUp.
	"Hooks that subclasses may override to define the fixture of test."
	self makeTopics.
	self makeQuestions.
	
 
]

{ #category : #tests }
TopicTest >> testRelatedQuestions [
	| col | 
	self assertEmpty: topic1 relatedQuestions.
	self denyEmpty: topic2 relatedQuestions.

	col:= Set new.
	col add: question1; add: question2; add: question3.
	self assertCollection: topic2 relatedQuestions equals: col.

]
