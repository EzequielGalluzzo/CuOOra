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
	header:		<Object>


    Implementation Points
"
Class {
	#name : #LoggedUserComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'CuOOra-UI'
}

{ #category : #hooks }
LoggedUserComponent >> children [
	^ Array with: header
]

{ #category : #initialization }
LoggedUserComponent >> initialize [
	super initialize.
	header := UserHeaderComponent new
]

{ #category : #rendering }
LoggedUserComponent >> renderContent: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
LoggedUserComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	self renderContent: aCanvas.
]
