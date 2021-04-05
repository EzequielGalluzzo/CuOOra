Class {
	#name : #AskAQuestionComponent,
	#superclass : #WAComponent,
	#instVars : [
		'questionName',
		'questionContent',
		'questionTopics'
	],
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #adding }
AskAQuestionComponent >> addQuestion [ 

self session user addQuestionForTopic: questionTopics  name: questionName  description: questionContent 
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

{ #category : #accessing }
AskAQuestionComponent >> questionTopics [
	^ questionTopics
]

{ #category : #accessing }
AskAQuestionComponent >> questionTopics: anObject [
	questionTopics := anObject
]

{ #category : #rendering }
AskAQuestionComponent >> renderContentOn: aCanvas [

	aCanvas
		form: [ aCanvas optionGroup: [: each | self model getAllTopics].
			aCanvas label: 'Titulo de Pregunta: '.
			aCanvas textInput on: #questionName of: self.
			aCanvas label: 'Contenido de Pregunta: '.
			aCanvas textInput on: #questionContent of: self ]
]
