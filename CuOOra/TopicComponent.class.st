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
	topico:		<Object>


    Implementation Points
"
Class {
	#name : #TopicComponent,
	#superclass : #MainComponent,
	#instVars : [
		'topico'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
TopicComponent class >> topico: unTopico [
	^ self new
		topico: unTopico ;
		yourself
]

{ #category : #protocol }
TopicComponent >> back [ 
	self answer
]

{ #category : #accessing }
TopicComponent >> getQuestions [
	^ topico relatedQuestionsOrderedByDate
]

{ #category : #accessing }
TopicComponent >> header: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self back ];
				with: 'volver'].
]

{ #category : #rendering }
TopicComponent >> mostrarBotones: aCanvas [
	aCanvas form
		class: 'follow';
		with: [ aCanvas button
				callback: [ self session user addInterest: topico ];
				with: 'seguir' .
			aCanvas space.
			aCanvas button
				callback: [ self session user removeInterest: topico ];
				with: 'dejar de seguir' ].
]

{ #category : #rendering }
TopicComponent >> renderContent: aCanvas [
	self header: aCanvas.
	aCanvas horizontalRule.
	aCanvas heading: 'Preguntas de topico: ' , topico name.
	self session user ifNotNil: [ self mostrarBotones: aCanvas ].
	aCanvas heading
		level: 2;
		with: topico description.
	aCanvas horizontalRule.
	self mostrarPreguntas: aCanvas.
	aCanvas horizontalRule
]

{ #category : #hooks }
TopicComponent >> style [
	^ '
.topicsmall  { 
  color: grey;
  font-size: small;
  list-style-type: none;
  display: inline-block;
  padding-right: 5px;
}
.follow{
  display: inline;
  float: right;
}
.follow button:hover {
  cursor: grab;
  color:white;
  background-color: #C984DE;
}
.follow button:active {
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
.follow button {
  padding: 10px;
  background-color: violet;
  text-align: center;
  font-size: 16px;
  border-style: none;
  border: none;
  border-radius: 10px;
  box-shadow: 0 5px #999;
'
]

{ #category : #accessing }
TopicComponent >> topico [
	^ topico 
]

{ #category : #accessing }
TopicComponent >> topico: aTopic [ 
	topico := aTopic 
]
