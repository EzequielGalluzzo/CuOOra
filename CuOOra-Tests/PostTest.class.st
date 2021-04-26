Class {
	#name : #PostTest,
	#superclass : #TestCase,
	#instVars : [
		'p1',
		'p2',
		'p3',
		'p4',
		'u1',
		'u2',
		'u3',
		'u4',
		'u5'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
PostTest >> makeInteractions [
	p1 likePost: u2.
	p1 likePost: u3.
	p1 likePost: u4.
	p1 dislikePost: u5.
	
	p2 likePost: u2.
	p2 likePost: u3.
	p2 dislikePost: u4.
	p2 dislikePost: u5.
	
	p3 likePost: u2.
	p3 dislikePost: u3.
	p3 dislikePost: u4.
	p3 dislikePost: u5.
]

{ #category : #setUps }
PostTest >> makePostAndUsers [
	p1 := Post new.
	p1 initialize.
	p2 := Post new.
	p2 initialize.
	p3 := Post new.
	p3 initialize.
	p4 := Post new.
	p4 initialize.
		
	
	
	u1 := User new.
	u1 initializeWith: 'u1' and: '' .
	u2 := User new.
	u2 initializeWith: 'u2' and: ''.
	u3 := User new.
	u3 initializeWith: 'u3' and: ''.
	u4 := User new.
	u4 initializeWith: 'u4' and: ''.
	u5 := User new.
	u5 initializeWith: 'u5' and: ''.
	

]

{ #category : #setUps }
PostTest >> setUp [
	super setUp.
	self makePostAndUsers;
	makeInteractions.
	
]

{ #category : #tests }
PostTest >> testDislikePost [ 
	self assert: ( p4 getNumberOfDislikes  )equals: 0.
	p4 dislikePost: u1.
	self assert: ( p4 getNumberOfDislikes  )equals: 1.
]

{ #category : #tests }
PostTest >> testGetNumberOfDislikes [
	self assert: ( p1 getNumberOfDislikes  )equals: 1;
	assert: ( p2 getNumberOfDislikes )equals: 2;
	assert: ( p3 getNumberOfDislikes )equals: 3
]

{ #category : #tests }
PostTest >> testGetNumberOfLikes [
	self assert: ( p1 getNumberOfLikes )equals: 3;
	assert: ( p2 getNumberOfLikes )equals: 2;
	assert: ( p3 getNumberOfLikes )equals: 1
]

{ #category : #tests }
PostTest >> testGetPoints [
	self assert: ( p1 getPoints )equals: 2;
	assert: ( p2 getPoints )equals: 0;
	assert: ( p3 getPoints )equals: -2
]

{ #category : #tests }
PostTest >> testLikePost [
	self assert: ( p4 getNumberOfLikes )equals: 0.
	p4 likePost: u1.
	self assert: ( p4 getNumberOfLikes )equals: 1.
]
