Class {
	#name : #AskAQuestionComponent,
	#superclass : #WAComponent,
	#instVars : [
		'question',
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
				with: [ aCanvas label: 'home page' ] ].
]

{ #category : #initialization }
AskAQuestionComponent >> initialize [ 
	super initialize.
	questionTopics := Set new.
]

{ #category : #accessing }
AskAQuestionComponent >> model [ 	
^ CuOOraSystem soleInstance 
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
AskAQuestionComponent >> renderContentOn: aCanvas [
	self homeButton: aCanvas.
	aCanvas horizontalRule.
	aCanvas heading: 'Nueva Pregunta:'.
	aCanvas horizontalRule.
	aCanvas
		form: [ 	self renderTopicos: aCanvas.
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
		unorderedList: [ self session topics
				do: [ :each | aCanvas  label: each name asString.
					aCanvas checkbox 
						value: each;
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
