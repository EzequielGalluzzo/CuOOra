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
	post:		<Object>
	reaction:		<Object>
	timeAndDate:		<Object>


    Implementation Points
"
Class {
	#name : #Interaction,
	#superclass : #Object,
	#instVars : [
		'timeAndDate',
		'user'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Interaction class >> newFor: aUser [
	^ self new initializeForUser: aUser
]

{ #category : #initialization }
Interaction >> initializeForUser: aUser [
	user := aUser.
	timeAndDate := DateAndTime now
]

{ #category : #testing }
Interaction >> isOfUser: aUser [
	^ aUser == user
]
