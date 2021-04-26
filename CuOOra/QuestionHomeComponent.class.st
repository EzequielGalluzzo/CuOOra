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


    Implementation Points
"
Class {
	#name : #QuestionHomeComponent,
	#superclass : #MainComponent,
	#category : #'CuOOra-UI'
}

{ #category : #services }
QuestionHomeComponent class >> question: aQuestion [
	^ self new
		question: aQuestion.
]

{ #category : #protocol }
QuestionHomeComponent >> back [
	self answer
]

{ #category : #rendering }
QuestionHomeComponent >> botonVolver: aCanvas [
	aCanvas form: [ aCanvas button
				callback: [ self back ];
				with: 'Volver'  ]
]

{ #category : #accessing }
QuestionHomeComponent >> question: aQuestion [
	question:=aQuestion
]

{ #category : #rendering }
QuestionHomeComponent >> renderContent: aCanvas [
	self botonVolver: aCanvas.
	aCanvas heading
		level: 3;
		with: question name.
	aCanvas space.
	self detalles: aCanvas dePost: question.
	self topicos: aCanvas dePost: question.
	aCanvas paragraph: question content.
	self reacciones: aCanvas conPost: question.
	self session user
		ifNotNil: [ self agregarRespuesta: aCanvas aPost: question ].
	aCanvas heading level: 4; with: 'Respuestas:'.
	aCanvas horizontalRule.
	self respuestas: aCanvas
]

{ #category : #rendering }
QuestionHomeComponent >> respuestas: aCanvas [
	aCanvas
		unorderedList: [ question getOrderedAnswers
				do: [ :each | 
					aCanvas paragraph: each getText.
					aCanvas small
						class: 'det';
						with: [ self detalles: aCanvas dePost: each.
							aCanvas space.
							self reacciones: aCanvas conPost: each ] ] ]
]

{ #category : #hooks }
QuestionHomeComponent >> style [
	^ '
.det { 
color:grey; }	
.topic { 
  list-style-type: none;
  display: inline-block;
  padding-right: 5px;
  float:right;
}
.topicsmall  { 
  color: grey;
  font-size: small;
  list-style-type: none;
  display: inline-block;
  padding-right: 5px;
}
.topic:hover{
cursor: grab;
}
.list { 
  list-style-type: none;
  display: inline;
  float:right;
  margin: 0;
  padding: 0; }'
]
