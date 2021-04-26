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
	answer:		<Object>
	question:		<Object>
	text:		<Object>


    Implementation Points
"
Class {
	#name : #AnswerComponent,
	#superclass : #MainComponent,
	#instVars : [
		'anAnswer',
		'text'
	],
	#category : #'CuOOra-UI'
}

{ #category : #factory }
AnswerComponent class >> paraPregunta: aQuestion [
	^ self new question: aQuestion
]

{ #category : #adding }
AnswerComponent >> addAnswer [
	self session user addAnswerTo: question withText: anAnswer
]

{ #category : #accessing }
AnswerComponent >> answerText [
	^ text
]

{ #category : #accessing }
AnswerComponent >> answerText: aText [
	text := aText
]

{ #category : #accessing }
AnswerComponent >> question [
	^ question
]

{ #category : #accessing }
AnswerComponent >> question: anObject [
	question := anObject
]

{ #category : #rendering }
AnswerComponent >> renderContent: aCanvas [
	aCanvas heading
		level: 2;
		with: question name.
	aCanvas paragraph: question content.
	aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas
				paragraph: [ (aCanvas textArea on: #answerText of: self)
						columns: 80;
						rows: 5 ].
			aCanvas submitButton on: #save of: self ]
]

{ #category : #actions }
AnswerComponent >> save [
	(anAnswer := Answer newWithText: text) ifNil: [ ^ self ].
	self session user addAnswerTo: question withText: text.
	self answer: true.
]
