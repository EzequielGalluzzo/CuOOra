Class {
	#name : #CuOOraSystemTest,
	#superclass : #TestCase,
	#instVars : [
		'u1',
		'u2',
		'u3',
		't1',
		't2',
		'q1',
		'q2',
		'q3',
		'cuoora',
		'a1'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
CuOOraSystemTest >> makeInterestsForUser [
	cuoora addTopic: t1 forUser: u1.
	cuoora addTopic: {t1 . t2} forUser: u2.
]

{ #category : #setUps }
CuOOraSystemTest >> makeQuestionsAndAddToUsers [
	q1 := Question new.
	q2 := Question new.
	q3 := Question new.
	
	u1 addQuestion: q1.
	u2 addQuestion: q2.
	u3 addQuestion: q3.	
		
	u2 likePost: q1.
	u3 likePost: q1.

	u3 dislikePost: q2.
	u1 dislikePost: q2.
	
	u2 addAnswerTo: q3 withText: 'a1'.
	u2 addAnswerTo: q1 withText: 'a3'.
	
	u3 addAnswerTo: q1 withText: 'a2'.
	

]

{ #category : #setUps }
CuOOraSystemTest >> makeTopics [
	t1 := Topic newWith: 'Python' desc: 'about Python language'.
	t2 := Topic newWith: 'Java' desc: 'about Java language'.
]

{ #category : #setUps }
CuOOraSystemTest >> makeUsers [
	"Add any changes to posts constuctor here"

	u1 := User new.	
	u2 := User new.
	u3 := User new.
	u1 follow: u2.
	u3 follow: u2
]

{ #category : #running }
CuOOraSystemTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	cuoora := CuOOraSystem new.
	self makeTopics;
	makeUsers ;
	makeInterestsForUser ;
	makeQuestionsAndAddToUsers .
	cuoora
		addTopic: t1;
		addTopic: t2;
		addUser: u1;
		addUser: u2;
		addUser: u3

]

{ #category : #tests }
CuOOraSystemTest >> testAddTopic [
	| tempT |
	tempT:= Topic new.
	self deny: (cuoora getAllTopics includes: tempT).
	cuoora addTopic: tempT.
	self assert: (cuoora getAllTopics includes: tempT).


]

{ #category : #tests }
CuOOraSystemTest >> testAddTopicForUser [
	| tempCont |
	tempCont := u1 getInterests size.
	cuoora addTopic: t1 forUser: u1.
	self assert: (u1 getInterests size)equals: (tempCont + 1)
]

{ #category : #tests }
CuOOraSystemTest >> testAddUserPass [
	self		
		deny: (cuoora userWithName: 'testUser' protectedBy: 'test') isNotNil.
	cuoora addUser: 'testUser' pass: 'test'.
	self
		assert: (cuoora userWithName: 'testUser' protectedBy: 'test') isNotNil
]

{ #category : #tests }
CuOOraSystemTest >> testDeleteQuestion [
	cuoora deleteQuestion: q2.
	self assert: (cuoora getAllQuestions size)equals: 2

]

{ #category : #tests }
CuOOraSystemTest >> testGetAllQuestions [
	self 
	assert: (cuoora getAllQuestions size) equals: 3
]

{ #category : #tests }
CuOOraSystemTest >> testGetUserForPost [
	self assert: (cuoora getUserForPost: q1)equals: u1 ;
	deny: (cuoora getUserForQuestion: q1)equals:  u3;
	deny: (cuoora getUserForPost: q1)equals: u3;
	assert: (cuoora getUserForQuestion: q2)equals: u2
]

{ #category : #tests }
CuOOraSystemTest >> testGetUserPointsNew [
	self
		assert: (cuoora getUserPointsNew: u1)equals: 20;
		deny: (cuoora getUserPointsNew: u2)equals: 600.
]

{ #category : #tests }
CuOOraSystemTest >> testNewTopicDescription [
	| tempCant|
	tempCant := cuoora getAllTopics size.
	cuoora newTopic: 'prueba' description: 'prueba'.
	self assert: (cuoora getAllTopics size )equals: (tempCant+1)
]

{ #category : #tests }
CuOOraSystemTest >> testTopicsForQuestion [
	self 
	assert: ((cuoora topicsForQuestion: q1) size) equals: 0.
	t1 addQuestion: q1.
	self assert: ((cuoora topicsForQuestion: q1) size) equals: 1.
]

{ #category : #tests }
CuOOraSystemTest >> testUserWithNameProtectedBy [
	self		
		deny: (cuoora userWithName: 'testUser' protectedBy: 'test') isNotNil.
	cuoora addUser: 'testUser' pass: 'test'.
	self
		assert: (cuoora userWithName: 'testUser' protectedBy: 'test') isNotNil
]
