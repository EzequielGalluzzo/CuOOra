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
		
	u2 likePost: q1.
	u3 likePost: q1.

	u3 dislikePost: q2.
	u1 dislikePost: q2.
	
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
	self makeInterestsForUser .
	self makeQuestionsAndAddToUsers.
	self makeAnswersFromUsers .
		cuoora
		addUser: u1;
		addUser: u2;
		addUser: u3;
		addTopic: t1;
		addTopic: t2.
]

{ #category : #tests }
UserTest >> testAddAndRemoveInterest [
	| u t |
	u := User new.
	t := Topic new.
	u addInterest: t.
	self assert: (u getInterests includes: t ).
	u removeInterest: t.
	self deny: (u getInterests includes: t).
]

{ #category : #tests }
UserTest >> testAddAnswers [
	self
	assert: ( u2 getAllAnswers size > 0 );
	assert: ( u1 getAllAnswers size = 0 );
	deny: ( u3 getAllAnswers size = 0 )
]

{ #category : #tests }
UserTest >> testAllQuestions [
	self 
	assert: (u1 getQuestions  includes: q1  );
	deny: (u1 getQuestions includes: q2);
	makeQuestionsForUsers ;
   assert: ( t1 relatedQuestions size > 0 ).
	u1 deleteQuestion: q1.
	self deny: (u1 getQuestions includes: q1);
	assert: ( u2 hasPost: q2);
	deny: ( u3 hasPost: q1)
	
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
UserTest >> testLikeDislikeYPuntos [
	self 
	assert: ( u1 getInteractions size = 1 );
	deny: ( u2 getInteractions size = 0)
]
