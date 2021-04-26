Class {
	#name : #QuestionTest,
	#superclass : #TestCase,
	#instVars : [
		'q1',
		'q2',
		'a1',
		'a2',
		'a3'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
QuestionTest >> makeQuestionsForAnswerTesting [
	q1 := Question new.
	q1 initialize.
	q2 := Question new.
	q2 initialize.
	a1 := Answer new.
	a2 := Answer new.
	a3 := Answer new.
	a1 likes: 2.
	a1 dislikes: 3.
	a2 likes: 2.
	a2 dislikes: 0.
	q1 addAnswer: a1.
	q1 addAnswer: a2.
	q2 addAnswer: a3
]

{ #category : #running }
QuestionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
super setUp.
self makeQuestionsForAnswerTesting .

]

{ #category : #tests }
QuestionTest >> testAddAnswer [
	self 
	assert: ( q1 allAnswers includes: a1);
	deny: ( q1 allAnswers includes: a3)
]

{ #category : #tests }
QuestionTest >> testDeleteAnswers [
	self assert: (q1 allAnswers includesAll: {a1. a2}).
	q1 deleteAnswers.
	self
		deny:
			(q1 allAnswers
				includesAll:
					{a1.
					a2})
]

{ #category : #tests }
QuestionTest >> testgetOrderedAnswers [
	self
		assert: (q1 getOrderedAnswers at: 1) equals: a2;
		assert: (q1 getOrderedAnswers at: 2) equals: a1.
		
]
