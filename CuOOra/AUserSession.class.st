Class {
	#name : #AUserSession,
	#superclass : #WASession,
	#instVars : [
		'user',
		'topics'
	],
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #accessing }
AUserSession >> topics [
	^ topics
]

{ #category : #accessing }
AUserSession >> topics: anObject [
	topics := anObject
]

{ #category : #accessing }
AUserSession >> user [
	^ user
]

{ #category : #accessing }
AUserSession >> user: anObject [
	user := anObject
]
