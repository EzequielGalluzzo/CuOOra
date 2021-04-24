"
Para registrar: 
|app |
app := WAAdmin register: LandingComponent  asApplicationAt: 'cuoora'.
app sessionClass: AUserSession.
"
Class {
	#name : #MainComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
		'questions',
		'question',
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
MainComponent >> agregarPregunta [
self call: AskAQuestionComponent new.
	
]

{ #category : #rendering }
MainComponent >> agregarPregunta: aCanvas [
	aCanvas anchor
		callback: [ self agregarPregunta ];
		with: [ aCanvas button: 'Nueva Pregunta' ]
]

{ #category : #visiting }
MainComponent >> agregarRespuesta: aPost [
self call: (AnswerComponent paraPregunta: aPost)
]

{ #category : #rendering }
MainComponent >> agregarRespuesta: aCanvas aPost: aPost [
	self session isLoggedIn
		ifTrue: [ aCanvas
				form: [ aCanvas button
						callback: [ self agregarRespuesta: aPost ];
						with: 'Agregar Respuesta' ] ]
		ifFalse: [ aCanvas
				small: '' ]
]

{ #category : #accessing }
MainComponent >> author: aPost [
	^ (self model getUserForPost: aPost)
]

{ #category : #hooks }
MainComponent >> children [
	^ Array with: header
]

{ #category : #rendering }
MainComponent >> detalles: aCanvas dePost: each [
	aCanvas
		form: [ aCanvas anchor
				callback: [ self userProfile: (self author: each) ];
				with: 'de ' , (self author: each) name ].
	aCanvas
		small: ' | ';
		small: each date;
		small: ' | ';
		small: (self model getNumberOfLikes: each) asString , ' likes';
		small: ' ';
		small: (self model getNumberOfDislikes: each) asString , ' dislikes'.
]

{ #category : #accessing }
MainComponent >> getQuestions [
	^ (self myQuestions
		asSortedCollection: [ :a :b | a postTimeDate > b postTimeDate ])
		first: self quantity
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
	aCanvas
		unorderedList: [ self getQuestions
				do: [ :each | 
					aCanvas
						render: [ aCanvas anchor
								callback: [ self preguntaConRespuestas: each ];
								with: [ aCanvas heading
										level: 3;
										with: each name.
									 ].
							aCanvas space.
							self detalles: aCanvas dePost: each.
							aCanvas
								small: ' | respuestas: ' , each allAnswers size asString.
							self topicos: aCanvas dePost: each.
							aCanvas paragraph: each content.
							self reacciones: aCanvas conPost: each.
							self session user
								ifNotNil: [ self agregarRespuesta: aCanvas aPost: each ].
							aCanvas horizontalRule ] ] ]
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

{ #category : #accessing }
MainComponent >> myQuestions [
^ self model getAllQuestions
]

{ #category : #visiting }
MainComponent >> preguntaConRespuestas: aQuestion [
	self call: (QuestionHomeComponent question: aQuestion)
]

{ #category : #size }
MainComponent >> quantity [
	^ (self myQuestions size > 4)
	ifTrue: [5]
	ifFalse: [self myQuestions size ]
]

{ #category : #rendering }
MainComponent >> reacciones: aCanvas conPost: aPost [
	self session user
		ifNotNil: [ aCanvas anchor
				callback: [ self session user likePost: aPost ];
				with: 'like'.
			aCanvas space.
			aCanvas anchor
				callback: [ self session user dislikePost: aPost ];
				with: 'dislike' ]
		ifNil: [ aCanvas small: '' ]
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
.det 
{ color: grey; }
.topicsmall  { 
  color: grey;
  font-size: small;
  list-style-type: none;
  display: inline-block;
  padding-right: 5px;
}'
]

{ #category : #rendering }
MainComponent >> topicos: aCanvas dePost: each [
	aCanvas
		unorderedList: [ aCanvas label
				class: 'topicsmall';
				with: 'topicos: '.
			(self model topicsForQuestion: each)
				do: [ :t | 
					aCanvas listItem
						class: 'topicsmall';
						with: [ aCanvas anchor
								callback: [ self mostrarPreguntasDeTopico: t ];
								with: [ aCanvas label: t name ] ] ] ]
]

{ #category : #visiting }
MainComponent >> userProfile: aUser [ 
	self call: (UserProfileComponent user: aUser).
]
