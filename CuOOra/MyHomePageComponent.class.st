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
	#superclass : #WAComponent,
	#instVars : [
		'user',
		'topics'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
MyHomePageComponent >> agregarPregunta [
self call: AskAQuestionComponent new.
	
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
MyHomePageComponent >> mostrarPreguntas: aCanvas [
	aCanvas heading
		level: 2;
		with: 'Mis Preguntas: '.
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ self session user getQuestions
				do: [ :each | 
					aCanvas
						render: [ aCanvas heading level: 3; with: each name.
							aCanvas break.
							aCanvas paragraph: each content ].
					aCanvas horizontalRule ] ].
	aCanvas anchor
		callback: [ self agregarPregunta ];
		with: [ aCanvas button: 'Nueva Pregunta' ].
	aCanvas horizontalRule
]

{ #category : #visiting }
MyHomePageComponent >> mostrarPreguntasDeTopico: aTopic [
	self call: (TopicoComponent topico: aTopic)
]

{ #category : #rendering }
MyHomePageComponent >> mostrarTopicos: aCanvas [
	aCanvas
		unorderedList: [ self session topics
				do: [ :each | 
					aCanvas anchor
						callback: [ self mostrarPreguntasDeTopico: each ];
						with: [ aCanvas label: ' | ' , each name , ' | ' ] ] ]
]

{ #category : #rendering }
MyHomePageComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self logout ];
				with: [ aCanvas label: 'salir' ].
			aCanvas button
				callback: [ self front ];
				with: [ aCanvas label: 'front page' ] ].
	aCanvas div: [ self mostrarTopicos: aCanvas ] .
	aCanvas horizontalRule.
	aCanvas
		heading: 'Esta es tu pagina personal, ' , self session user name.
	aCanvas horizontalRule.
	self mostrarPreguntas: aCanvas
]
