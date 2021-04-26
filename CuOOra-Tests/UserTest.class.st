Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#instVars : [
		'u1',
		'u2',
		'u3',
		'topics',
		'q1',
		'q2',
		'q3',
		't1',
		't2',
		'cuoora'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
UserTest >> makeAnswersFromUsers [
	u2 addAnswerTo: q1 withText: 'text' .
	u2 addAnswerTo: q3 withText: 'text' .
	
	u3 addAnswerTo: q1 withText: 'text' .
	 
]

{ #category : #setUps }
UserTest >> makeInterestsForUser [
	cuoora addTopic: t1 forUser: u1.
	cuoora addTopic: topics forUser: u2.
]

{ #category : #setUps }
UserTest >> makeQuestionsAndAddToUsers [
	q1 := Question new.
	q2 := Question new.
	q3 := Question new.
	
	u1 addQuestion: q1.
	u2 addQuestion: q2.
	u3 addQuestion: q3.	
		
	q1 likePost: u2.
	q1 likePost: u3.

	q2 dislikePost: u3.
	q2 dislikePost: u1.
	
	u2 addAnswerTo: q3 withText: 'a1'.
	u2 addAnswerTo: q1 withText: 'a3'.
	
	u3 addAnswerTo: q1 withText: 'a2'.
	

]

{ #category : #setUps }
UserTest >> makeQuestionsForUsers [
	u1 addQuestionForTopic: t1 name: 'q1' description: 'this is q1'.
]

{ #category : #setUps }
UserTest >> makeTopics [
	t1 := Topic newWith: 'Python' desc: 'about Python language'.
	t2 := Topic newWith: 'Java' desc: 'about Java language'.
	
]

{ #category : #setUps }
UserTest >> makeUsers [
	"Add any changes to posts constuctor here"

	u1 := User new" WithUsername: 'Elio' andPassword: '123'".
	u2 := User new "WithUsername: 'Marco' andPassword: 'abc'".
	u3 := User new "WithUsername: 'Pablo' andPassword: '900'".
	
	u1 follow: u2.
	u3 follow: u2.
]

{ #category : #running }
UserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	cuoora := CuOOraSystem new.
	self makeTopics.
	self makeUsers.
		cuoora
		addUser: u1;
		addUser: u2;
		addUser: u3;
		addTopic: t1;
		addTopic: t2.
	self makeInterestsForUser .
	self makeQuestionsAndAddToUsers.
	self makeAnswersFromUsers .
]

{ #category : #tests }
UserTest >> testAddAnswer [ 
| tempAnsw |
	self assert: ( u1 getAllAnswers size)equals: 0.
	tempAnsw:= Answer new.
	u1 addAnswer: tempAnsw .
	self assert: ( u1 getAllAnswers size)equals: 1.
]

{ #category : #tests }
UserTest >> testAddAnswerToWithText [
	self assert: ( u1 getAllAnswers size)equals: 0.
	u1 addAnswerTo: q2 withText: 'prueba'.
	self assert: ( u1 getAllAnswers size)equals: 1.
]

{ #category : #tests }
UserTest >> testAddInterest [ 
	self assert: ( u1 getInterests includes: t1);
	deny: ( u1 getInterests includes: t2).
	u1 addInterest: t2.
	self assert: ( u1 getInterests includes: t2).
]

{ #category : #tests }
UserTest >> testAddQuestion [
	self assert: (u1 getQuestions size)equals: 1.
	u1 addQuestionForTopic: t1 name: 'q1' description: 'this is q1'.
	self assert: (u1 getQuestions size)equals: 2.
]

{ #category : #tests }
UserTest >> testAddQuestionForTopicNameDescription [
	self assert: ( u1 getQuestions size)equals: 1.
	u1 addQuestionForTopic: t1 name: 'ques1' description: 'desc1' .
	self assert: ( u1 getQuestions size)equals: 2.
]

{ #category : #tests }
UserTest >> testAskedQuestion [
	self assert: ( u1 askedQuestion: q1);
	deny: ( u1 askedQuestion: q2).
]

{ #category : #tests }
UserTest >> testDeleteAnswer [
	| tempAnsw |
	tempAnsw:= Answer new.
	u1 addAnswer: tempAnsw .
	self assert: ( u1 getAllAnswers size)equals: 1.
	u1 deleteAnswer: tempAnsw.
	self assert: ( u1 getAllAnswers size)equals: 0.
]

{ #category : #tests }
UserTest >> testDeleteQuestion [
	self assert: ( u1 getQuestions includes: q1).
	u1 deleteQuestion: q1.
	self deny: ( u1 getQuestions includes: q1)
]

{ #category : #tests }
UserTest >> testFollow [ 
	self assert: ( u3 followsUsers includes: u2 );
	deny: ( u3 followsUsers includes: u1).
	u3 follow: u1.
	self assert: ( u3 followsUsers includes: u1)
]

{ #category : #tests }
UserTest >> testFollowing [
	self 
	assert: ( u1 isFollower: u2 );
	deny: ( u2 isFollower: u1 ).
	u2 follow: u1.
	self assert: ( u2 isFollower: u1)
]

{ #category : #tests }
UserTest >> testGetMyReplies [
	self assert: ( u1 getMyReplies size)equals: 0.
	u1 addAnswerTo: q2 withText: 'prueba'.
	self assert: ( u1 getMyReplies size)equals: 1.
	u1 addAnswerTo: q1 withText: 'prueba'.
	self assert: ( u1 getMyReplies size)equals: 1.
]

{ #category : #tests }
UserTest >> testGetPointsFromUser [ 
	self assert: ( u1 getPointsFromUser )equals: 20;
	assert: ( u2 getPointsFromUser )equals: 220;
	assert: ( u3 getPointsFromUser )equals: 120
]

{ #category : #tests }
UserTest >> testHasNameHasPassword [
	| tempUser |
	tempUser := User newWith: 'prueba' andPass: 'prueba'.
	self assert: (tempUser hasName: 'prueba' hasPassword: 'prueba')
]

{ #category : #tests }
UserTest >> testHasPost [
	self assert: (u1 hasPost: q1);
	deny: (u1 hasPost: q3).
]

{ #category : #tests }
UserTest >> testIsFollower [
	self assert: ( u1 isFollower: u2);
	deny: (u1 isFollower: u3).
]

{ #category : #tests }
UserTest >> testRelevantQuestions [
	self assert: ( u1 relevantQuestions size)equals: 1.
	"agregamos un follow para que la cantidad de preguntas relevantes para el usuario cambie a 2"
	u1 follow: u3.
	self assert: ( u1 relevantQuestions size)equals: 2.
]

{ #category : #tests }
UserTest >> testRemoveInterest [ 
	self assert: ( u1 getInterests includes: t1).
	u1 removeInterest: t1.
	self deny: ( u1 getInterests includes: t1).
]
