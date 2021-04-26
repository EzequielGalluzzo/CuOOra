Class {
	#name : #LikeTest,
	#superclass : #TestCase,
	#instVars : [
		'i1'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #tests }
LikeTest >> testIsDislike [
	i1:= Like new.
	self deny: (i1 isDislike )
]

{ #category : #tests }
LikeTest >> testIsLike [
	i1:= Like new.
	self assert: (i1 isLike)
]
