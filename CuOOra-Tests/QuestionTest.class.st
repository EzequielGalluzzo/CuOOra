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
	
	a1:= Answer new.
	a1 initialize .
	a2:= Answer new.
	a2 initialize .
	a3:= Answer new.
	a3 initialize .
	
	q1 addAnswer: a1.
	q2 addAnswer: a3.
]

{ #category : #running }
QuestionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
super setUp.
self makeQuestionsForAnswerTesting .

]

{ #category : #tests }
QuestionTest >> testAddAnswer [
	self setUp;
	assert: ( q1 allAnswers includes: a1);
	deny: ( q1 allAnswers includes: a3)
]

{ #category : #tests }
QuestionTest >> testDeleteAnswers [
	self setUp;
	assert: ( q1 allAnswers includes: a1).
	q1 deleteAnswers.
	self deny: ( q1 allAnswers includes: a1)
]
