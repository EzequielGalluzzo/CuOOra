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
	question:		<Object>
	questionContent:		<Object>
	questionName:		<Object>
	questionTopics:		<Object>


    Implementation Points
"
Class {
	#name : #AskAQuestionComponent,
	#superclass : #MainComponent,
	#instVars : [
		'questionName',
		'questionContent',
		'questionTopics'
	],
	#category : #'CuOOra-UI'
}

{ #category : #adding }
AskAQuestionComponent >> addQuestion [ 

self session user addQuestionForTopic: questionTopics  name: questionName  description: questionContent 
]

{ #category : #adding }
AskAQuestionComponent >> addTopic: aTopic [
	questionTopics add: aTopic 
]

{ #category : #visiting }
AskAQuestionComponent >> home [
	self answer: MyHomePageComponent
]

{ #category : #initialization }
AskAQuestionComponent >> homeButton: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self home ];
				with: 'home page' ].
]

{ #category : #initialization }
AskAQuestionComponent >> initialize [ 
	super initialize.
	questionTopics := Set new.
]

{ #category : #accessing }
AskAQuestionComponent >> questionContent [
	^ questionContent
]

{ #category : #accessing }
AskAQuestionComponent >> questionContent: anObject [
	questionContent := anObject
]

{ #category : #accessing }
AskAQuestionComponent >> questionName [
	^ questionName
]

{ #category : #accessing }
AskAQuestionComponent >> questionName: anObject [
	questionName := anObject
]

{ #category : #rendering }
AskAQuestionComponent >> renderContent: aCanvas [
	self homeButton: aCanvas.
	aCanvas horizontalRule.
	aCanvas heading: 'Nueva Pregunta:'.
	aCanvas horizontalRule.
	aCanvas
		form: [ self renderTopicos: aCanvas.
			aCanvas
				paragraph: [ aCanvas label: 'Titulo de Pregunta: '.
					aCanvas break.
					aCanvas break.
					aCanvas textInput on: #questionName of: self ].
			aCanvas break.
			aCanvas
				paragraph: [ aCanvas label: 'Contenido de Pregunta: '.
					aCanvas break.
					(aCanvas textArea on: #questionContent of: self)
						columns: 80;
						rows: 5 ].
			aCanvas submitButton on: #save of: self ]
]

{ #category : #rendering }
AskAQuestionComponent >> renderTopicos: aCanvas [
	"Checkbox"

	aCanvas text: 'Elegir topicos de la pregunta: '.
	aCanvas break.
	aCanvas
		unorderedList: [ self model getAllTopics 
				do: [ :each | 
					aCanvas label: each name asString.
					aCanvas checkbox
						value: false;
						callback: [ :value | 
							value
								ifTrue: [ self addTopic: each ] ] ] ]
]

{ #category : #actions }
AskAQuestionComponent >> save [
	(question := Question
		newWithName: questionName
		topics: questionTopics
		andContent: questionContent) ifNil: [ ^ self ].
	self session user addQuestion: question.
	self answer
]
