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
	#name : #MainComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
MainComponent >> agregarPregunta [
self call: AskAQuestionComponent new.
	
]

{ #category : #rendering }
MainComponent >> botonVolver: aCanvas [
	aCanvas form
		class: 'inline';
		with: [ aCanvas button
				callback: [ self front ];
				with: [ aCanvas label: 'Pagina Principal' ]]
]

{ #category : #hooks }
MainComponent >> children [
	^ Array with: header
]

{ #category : #rendering }
MainComponent >> detalles: aCanvas dePost: each [
	aCanvas
		small: (self model getUserForQuestion: each) name;
		small: ' | ';
		small: each date;
		small: ' | ';
		small: (self model getPostLikes: each) asString , ' likes';
		small: ' ';
		small: (self model getPostDislikes: each) asString , ' dislikes'.
]

{ #category : #initialization }
MainComponent >> initialize [
	super initialize.
	header := UserHeaderComponent new
]

{ #category : #accessing }
MainComponent >> model [
	^ CuOOraSystem soleInstance
]

{ #category : #rendering }
MainComponent >> mostrarPreguntas: aCanvas [
	aCanvas heading
		level: 3;
		with: 'Preguntas de Interes: '.
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ (self model relevantQuestionsForUser: self session user)
				do: [ :each | 
					aCanvas
						render: [ aCanvas heading
								level: 3;
								with: each name.
							aCanvas space.
							self detalles: aCanvas dePost: each.
							self topicos: aCanvas dePost: each.
							aCanvas paragraph: each content.
							self reacciones: aCanvas conPost: each.
							aCanvas horizontalRule ] ] ].
	aCanvas anchor
		callback: [ self agregarPregunta ];
		with: [ aCanvas button: 'Nueva Pregunta' ]
]

{ #category : #visiting }
MainComponent >> mostrarPreguntasDeTopico: aTopic [
	self call: (TopicComponent topico: aTopic)
]

{ #category : #rendering }
MainComponent >> mostrarTopicos: aCanvas [
	aCanvas
		unorderedList: [ self model getAllTopics
				do: [ :each | 
					aCanvas listItem
						class: 'topic';
						with: [ aCanvas anchor
								callback: [ self mostrarPreguntasDeTopico: each ];
								with: [ aCanvas button: each name ] ] ] ]
]

{ #category : #rendering }
MainComponent >> reacciones: aCanvas conPost: aPost [
							aCanvas anchor
								callback: [ self session user likePost: aPost ];
								with: [ aCanvas label: 'like' ].
							aCanvas space.
							aCanvas anchor
								callback: [ self session user dislikePost: aPost ];
								with: [ aCanvas label: 'dislike' ]
]

{ #category : #rendering }
MainComponent >> renderContent: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
MainComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	self renderContent: aCanvas.
]

{ #category : #hooks }
MainComponent >> style [
	^ '
.topic  { 
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
  padding: 0; 
}'
]

{ #category : #rendering }
MainComponent >> topicos: aCanvas dePost: each [
	aCanvas
		unorderedList: [ aCanvas label
				class: 'topic';
				with: 'topicos: '.
			(self model topicsForQuestion: each)
				do: [ :t | 
					aCanvas listItem
						class: 'topic';
						with: [ aCanvas anchor
								callback: [ self mostrarPreguntasDeTopico: t ];
								with: [ aCanvas label: t name ] ] ] ]
]
