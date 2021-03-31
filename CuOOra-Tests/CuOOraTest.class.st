Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'user2',
		'user3',
		'topic1',
		'topic2',
		'topic3'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
CuOOraTest >> makeQuestions [
]

{ #category : #setUps }
CuOOraTest >> makeTopics [
	
]

{ #category : #setUps }
CuOOraTest >> makeUsers [
	"Add any changes to posts constuctor here"

	user1 := User newWithUsername: 'Elio' andPassword: '123'.
	user2 := User newWithUsername: 'Marco' andPassword: 'abc'.
	user3 := User newWithUsername: 'Pablo' andPassword: '900'
]

{ #category : #running }
CuOOraTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super initialize.
	self makeUsers.
	self makeQuestions.
	self makeTopics.
]

{ #category : #tests }
CuOOraTest >> testGetAnswers [
]

{ #category : #tests }
CuOOraTest >> testGetUserPoints [

]
