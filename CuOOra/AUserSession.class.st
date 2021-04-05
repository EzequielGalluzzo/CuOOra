Class {
	#name : #AUserSession,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #accessing }
AUserSession >> user [
	^ user
]

{ #category : #accessing }
AUserSession >> user: anObject [
	user := anObject
]
