Class {
	#name : #DislikeTest,
	#superclass : #TestCase,
	#instVars : [
		'i1'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #tests }
DislikeTest >> testIsDislike [
	i1:= Dislike  new.
	self assert: (i1 isDislike)
]

{ #category : #tests }
DislikeTest >> testIsLike [
	i1:= Dislike  new.
	self deny: (i1 isLike)
]
