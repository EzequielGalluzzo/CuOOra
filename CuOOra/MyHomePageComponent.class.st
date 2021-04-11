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
		'topics',
		'header'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
MyHomePageComponent >> agregarPregunta [
self call: AskAQuestionComponent new.
	
]

{ #category : #rendering }
MyHomePageComponent >> botonVolver: aCanvas [
	aCanvas form
		class: 'inline';
		with: [ aCanvas button
				callback: [ self front ];
				with: [ aCanvas label: 'Pagina Principal' ] ]
]

{ #category : #rendering }
MyHomePageComponent >> children [ 	
^ Array with: header
]

{ #category : #visiting }
MyHomePageComponent >> front [
	self call: LandingComponent new
]

{ #category : #initialization }
MyHomePageComponent >> initialize [ 
super initialize .
header := UserHeaderComponent new. 
]

{ #category : #visiting }
MyHomePageComponent >> logout [
	self session logout.
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #accessing }
MyHomePageComponent >> model [
	^ CuOOraSystem soleInstance 
]

{ #category : #rendering }
MyHomePageComponent >> mostrarPreguntas: aCanvas [
	aCanvas heading
		level: 3;
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
]

{ #category : #visiting }
MyHomePageComponent >> mostrarPreguntasDeTopico: aTopic [
	self call: (TopicComponent topico: aTopic)
]

{ #category : #rendering }
MyHomePageComponent >> mostrarTopicos: aCanvas [
aCanvas horizontalRule.
	aCanvas
		unorderedList: [ aCanvas label: 'Mis intereses: '. self session user getInterests 
				do: [ :each | 
					aCanvas anchor
						callback: [ self mostrarPreguntasDeTopico: each ];
						with: [ aCanvas button: ' ' , each name , ' ' ] ] ]
]

{ #category : #rendering }
MyHomePageComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas heading
		level: 2;
		with: 'Esta es tu pagina personal, ' , self session user name.
	self botonVolver: aCanvas.
	aCanvas div
		with: [ self mostrarPreguntas: aCanvas ]
]

{ #category : #hooks }
MyHomePageComponent >> style [
	^ '
.inline { 
 display: inline; }
'
]
