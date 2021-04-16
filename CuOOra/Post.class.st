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
	fechaHoraDeCreacion:		<Object>
	interacciones:		<Object>


    Implementation Points
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'time',
		'date',
		'timedate'
	],
	#category : #'CuOOra-Model'
}

{ #category : #accessing }
Post >> date [
	^ date asString , ' ' , time print24
]

{ #category : #initialization }
Post >> initialize [
	time := Time now.
	date := Date today.
]

{ #category : #accessing }
Post >> postTimeDate [
	^ (date + time )asDateAndTime 
]
