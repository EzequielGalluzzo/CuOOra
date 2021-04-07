"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
 
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	topics:		<Object>
	user:		<Object>


    Implementation Points
"
Class {
	#name : #AUserSession,
	#superclass : #WASession,
	#instVars : [
		'user',
		'topics'
	],
	#category : #'CuOOra-UI'
}

{ #category : #testing }
AUserSession >> isLoggedIn [
    ^ user isNil not
]

{ #category : #accessing }
AUserSession >> login: aUser [
    user := aUser
]

{ #category : #visiting }
AUserSession >> logout [
	user := nil.
]

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
