Class {
	#name : #InteractionTest,
	#superclass : #TestCase,
	#instVars : [
		'u1',
		'i1'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #setUps }
InteractionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	u1 := User newWith: 'prueba' andPass: ' '.
	i1 := Interaction new
]

{ #category : #tests }
InteractionTest >> testIsOfUser [
	i1 := Interaction newFor: u1.
	self assert: (i1 isOfUser: u1)
]
