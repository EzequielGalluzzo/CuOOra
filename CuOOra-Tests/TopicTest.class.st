Class {
	#name : #TopicTest,
	#superclass : #TestCase,
	#instVars : [
		't1',
		't2',
		'q1',
		'q2',
		'q3'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
TopicTest >> makeQuestionsAndAddToUsers [
	q1 := Question
		newWithName: 'Q1'
		topics: t1
		andContent: 'How are Java and Python different?'.
	q2 := Question
		newWithName: 'Q2'
		topics: t2
		andContent: 'What are some uses for Rust?'.
	q3 := Question
		newWithName: 'Q3'
		topics: {t1 . t2}
		andContent: 'What is a lambda function in Python?'.
	
]

{ #category : #setUps }
TopicTest >> makeTopics [
	t1 := Topic newWith: 'Python' desc: 'about Python language'.
	t2 := Topic newWith: 'Java' desc: 'about Java language'.
]

{ #category : #running }
TopicTest >> setUp [
super setUp.
	"Hooks that subclasses may override to define the fixture of test."
	self makeTopics.
	self makeQuestionsAndAddToUsers.
	
 
]

{ #category : #tests }
TopicTest >> testAddQuestion [
	| tempQ |
	tempQ := Question new.
	self deny: (t1 hasRelatedQuestion: tempQ).
	t1 addQuestion: tempQ .
	self assert: (t1 hasRelatedQuestion: tempQ).
]

{ #category : #tests }
TopicTest >> testHasRelatedQuestion [
	self 
	assert: (t1 hasRelatedQuestion: q1);
	deny: (t1 hasRelatedQuestion: q2);
	assert: (t2 hasRelatedQuestion: q2)
]

{ #category : #tests }
TopicTest >> testRelatedQuestions [
	self 
	assert: (t1 relatedQuestions includes: q1);
	deny: (t1 relatedQuestions includes: q2);
	assert: (t2 relatedQuestions includes: q2);
	assert: (t2 relatedQuestions includes: q3);
	deny: (t2 relatedQuestions includes: q1)
]
