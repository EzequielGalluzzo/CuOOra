Class {
	#name : #QuestionTest,
	#superclass : #TestCase,
	#instVars : [
		'question1',
		'question2',
		'answer1',
		'answer2',
		'answer3'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
QuestionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
super setUp.

]

{ #category : #tests }
QuestionTest >> testAddAnswer [
]

{ #category : #tests }
QuestionTest >> testDeleteAnswers [
]
