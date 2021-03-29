Class {
	#name : #InteractionTest,
	#superclass : #TestCase,
	#instVars : [
		'postLike',
		'postDislike',
		'postNil',
		'myLike',
		'myDislike'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
InteractionTest >> makePosts [
	"Add any changes to posts constuctor here"

	postLike := Post new.
	postDislike := Post new.
	postNil := Post new
]

{ #category : #setUps }
InteractionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	postLike := Post new.
	postDislike := Post new.
	postNil := Post new.
	myLike := Like newFor: postLike.
	myDislike := Dislike newFor: postDislike
]

{ #category : #tests }
InteractionTest >> testDislike [
	| newDislike newLike |
	self assert: myDislike dislike equals: myDislike.
	newLike := myDislike like.
	self assert: myDislike like equals: newLike.
	newDislike := myDislike dislike.
	self assert: myDislike dislike equals: newDislike.
	self deny: myDislike dislike equals: newLike.
	self deny: myDislike like equals: newDislike
]

{ #category : #tests }
InteractionTest >> testLike [

	| newDislike newLike |
	self assert: myLike like equals: myLike.
	newDislike := myLike dislike.
	self assert: myLike dislike equals: newDislike.
	newLike := myLike like.
	self assert: myLike like equals: newLike.
	self deny: myLike dislike equals: newDislike.
	self deny: myLike like equals: newLike
]
