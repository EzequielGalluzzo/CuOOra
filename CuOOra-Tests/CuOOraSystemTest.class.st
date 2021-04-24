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
CuOOraSystemTest >> testAnswerRelated [
	| newQ answ1 answ2 sorted |
	newQ := Question new.
	answ1 := Answer newMockWith: Date today and: '12:00' asTime.
	answ2 := Answer newMockWith: Date today and: '12:01' asTime.
	newQ addAnswer: answ1.
	newQ addAnswer: answ2.
	sorted:= cuoora getOrderedAnswers: newQ.
	self assert: sorted first equals: answ2.
	self assert: sorted second equals: answ1
]

{ #category : #tests }
CuOOraSystemTest >> testGetOrderedAnswers [
	| newQ answ1 answ2 sorted |
	newQ := Question new.
	answ1 := Answer newMockWith: Date today and: '12:00' asTime.
	answ2 := Answer newMockWith: Date today and: '12:01' asTime.
	newQ addAnswer: answ1.
	newQ addAnswer: answ2.
	sorted:= cuoora getOrderedAnswers: newQ.
	self assert: sorted first equals: answ2.
	self assert: sorted second equals: answ1
]

{ #category : #tests }
CuOOraSystemTest >> testPostRelated [
	self 
	assert: ((cuoora getInteractionPoints: (cuoora getPostInteractions: q1)) = (cuoora getPostBalance: q1)).
	"El assert previo chequea los siguientes mensajes: getInteractionPoints:, getPostInteractions:, getPostBalance:, getNumberOfLikes:, getNumberOfDislikes:, dado que estan embebidos unos en otros, y si estos no funcionan, no andaria el assert"
	self assert: ((cuoora getUserForPost: q1) = u1 );
	deny: ((cuoora getUserForQuestion: q1) = u3);
	deny: ((cuoora getUserForPost: q1) = u3);
	assert: ((cuoora getUserForQuestion: q2) = u2)
]

{ #category : #tests }
CuOOraSystemTest >> testQuestionsRelated [
	self 
	assert: (cuoora getAllQuestions size = 3).
	cuoora deleteQuestion: q2.
	self assert: (cuoora getAllQuestions size = 2);
	assert: ((cuoora topicsForQuestion: q1) size = 0).
	t1 addQuestion: q1.
	self assert: ((cuoora topicsForQuestion: q1)size = 1)
]

{ #category : #tests }
CuOOraSystemTest >> testTopicRelated [
	| tempT tempCant|
	tempT:= Topic new.
	self deny: (cuoora getAllTopics includes: tempT).
	cuoora addTopic: tempT.
	self assert: (cuoora getAllTopics includes: tempT).
	tempCant := cuoora getAllTopics size.
	cuoora newTopic: 'prueba' description: 'prueba'.
	self assert: (cuoora getAllTopics size = (tempCant+1))
]

{ #category : #tests }
CuOOraSystemTest >> testUserRelated [
	| tempCont |
	self
		
		deny: (cuoora userWithName: 'testUser' protectedBy: 'test') isNotNil.
	cuoora addUser: 'testUser' pass: 'test'.
	self
		assert: (cuoora userWithName: 'testUser' protectedBy: 'test') isNotNil;
		"assert: (cuoora relevantQuestionsForUser: u3) size = 1; "
		assert: (cuoora relevantQuestionsForUser: u2) size = 0;
		assert: (cuoora getUserPoints: u1) = 22;
		deny: (cuoora getUserPoints: u2) = 600.
	tempCont := u1 getInterests size.
	cuoora addTopic: t1 forUser: u1.
	self assert: u1 getInterests size = (tempCont + 1)
]
