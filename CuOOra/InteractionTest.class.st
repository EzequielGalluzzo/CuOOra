Class {
	#name : #InteractionTest,
	#superclass : #TestCase,
	#instVars : [
		'userLike',
		'userDislike',
		'userNil',
		'postLike',
		'postDislike',
		'postNil',
		'myLike',
		'myDislike',
		'user1',
		'cuoora'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
InteractionTest >> makeQuestionsAndAddToUsers [
	"Add any changes to posts constuctor here"

	postLike := Post new.
	postDislike := Post new.
	postNil := Post new
]

{ #category : #setUps }
InteractionTest >> makeUsers [
	user1 := User newWithUsername: 'myname' andPassword: '123'
]

{ #category : #setUps }
InteractionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	myLike := Like newFor: postLike.
	myDislike := Dislike newFor: postDislike
]

{ #category : #tests }
InteractionTest >> testDislike [

self assert: (myDislike  isDislike ).
self deny: (myDislike  isLike )
]

{ #category : #tests }
InteractionTest >> testLike [

	self assert: myLike isLike.
		self deny: myLike isDislike.

]
