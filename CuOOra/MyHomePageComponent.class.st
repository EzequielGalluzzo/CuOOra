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
	topics:		<Object>
	user:		<Object>


    Implementation Points
"
Class {
	#name : #MyHomePageComponent,
	#superclass : #MainComponent,
	#instVars : [
		'user',
		'topics'
	],
	#category : #'CuOOra-UI'
}

{ #category : #rendering }
MyHomePageComponent >> __mostrarPreguntas: aCanvas [
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
MyHomePageComponent >> front [
	self call: LandingComponent new
]

{ #category : #visiting }
MyHomePageComponent >> logout [
	self session logout.
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #rendering }
MyHomePageComponent >> menu: aCanvas [
	aCanvas form
		class: 'inline';
		with: [ aCanvas button
				callback: [ self front ];
				with: [ aCanvas label: 'Pagina Principal' ].
				 aCanvas
					unorderedList: [ self session user getInterests
						do: [ :each | 
							aCanvas anchor
								callback: [ self mostrarPreguntasDeTopico: each ];
								with: [ aCanvas button: each name ] ] ] ]
]

{ #category : #rendering }
MyHomePageComponent >> mostrarPreguntas: aCanvas [
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

{ #category : #rendering }
MyHomePageComponent >> renderContent: aCanvas [
	self botonVolver: aCanvas.
	self mostrarTopicos: aCanvas.
	aCanvas heading
		level: 2;
		with: 'Esta es tu pagina personal, ' , self session user name.
	self mostrarPreguntas: aCanvas
]

{ #category : #hooks }
MyHomePageComponent >> style [
	^ '
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
  padding: 0; }
'
]
