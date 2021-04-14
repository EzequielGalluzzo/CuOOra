"
Para registrar: 
|app |
app := WAAdmin register: LandingComponent  asApplicationAt: 'cuoora'.
app sessionClass: AUserSession.

Para limpiar:
CuOOraSystem clearSoleInstance.
app unregister 

Para Testear: 
topic1 := Topic newWith: 'Python' desc: 'about Python language'.
	topic2 := Topic newWith: 'Java' desc: 'about Java language'.
	topic3 := Topic newWith: 'Rust' desc: 'about Rustn language'.
	topicCollection := OrderedCollection new.
	topicCollection
		add: topic1;
		add: topic2.
	user1 := User newWithUsername: 'Elio' andPassword: '123'.
	user2 := User newWithUsername: 'Marco' andPassword: 'abc'.
	user3 := User newWithUsername: 'Pablo' andPassword: '900'.
	question1 := Question
		newWithName: 'Q1'
		topics: topicCollection
		andContent: 'How are Java and Python different?'.
	question2 := Question
		newWithName: 'Q2'
		topics: topic3
		andContent: 'What are some uses for Rust?'.
	question3 := Question
		newWithName: 'Q3'
		topics: topic1
		andContent: 'What is a lambda function in Python?'.
	question4 := Question
		newWithName: 'Q4'
		topics: topic2
		andContent: 'Can I work with memory in Java?'.
	user1
		addQuestion: question1;
		addQuestion: question2;
		addQuestion: question3.
	user2 addQuestion: question4.
""three likes for q1""

	user1 likePost: question1.
	user2 likePost: question1.
	user3 likePost: question1.
	user3 likePost: question1.
	""two likes q2""
	user1 likePost: question2.
	user2 likePost: question2.
	""one like one dislike q2""
	user1 dislikePost: question3.
	user1 likePost: question3.
	user3 dislikePost: question3.
	user3 dislikePost: question3.
	""three dislikes for q4""
	user3 dislikePost: question4.
	user1 dislikePost: question4.
	user2 dislikePost: question4.
cuoora := CuOOraSystem new.
	cuoora
		addUser: user1;
		addUser: user2;
		addUser: user3.
	cuoora
		addTopic: topicCollection;
		addTopic: topic3


"
Class {
	#name : #LandingComponent,
	#superclass : #MainComponent,
	#instVars : [
		'userName',
		'password',
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #rendering }
LandingComponent >> autorizar: aCanvas [
	self session isLoggedIn
		ifFalse: [ aCanvas div class:'loggedout'; with: [aCanvas
				small:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: 'registrarse'.
					aCanvas button
						callback: [ self login ];
						with: 'entrar' ] ]]
		ifTrue: [ aCanvas
				form: [ aCanvas button
						callback: [ self irACasa ];
						with: 'Home' ] ]
]

{ #category : #visiting }
LandingComponent >> irACasa [
	self call: MyHomePageComponent new.
]

{ #category : #visiting }
LandingComponent >> listUsers: someUsers [
	self call: (ListUsersComponent users: someUsers)
]

{ #category : #'private protocol' }
LandingComponent >> login [ 	
self call: EntryComponent new.
]

{ #category : #rendering }
LandingComponent >> mostrarOpcionesdeEntrar: aCanvas [
aCanvas
				paragraph:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: 'registrarte' .
					aCanvas button
						callback: [ self login ];
						with: 'entrar' ]
]

{ #category : #rendering }
LandingComponent >> mostrarPreguntas: aCanvas [
	aCanvas
		unorderedList: [ self getQuestions
				do: [ :each | 
					aCanvas
						render: [ aCanvas anchor
								callback: [ self preguntaConRespuestas: each ];
								with: [ aCanvas heading
										level: 3;
										with: each name ].
							aCanvas space.
							self detalles: aCanvas dePost: each.
							aCanvas
								small: ' | respuestas: ' , each allAnswers size asString.
							self topicos: aCanvas dePost: each.
							aCanvas paragraph: each content.
							self reacciones: aCanvas conPost: each.
							self agregarRespuesta: aCanvas aPost: each.
							aCanvas horizontalRule ] ] ]
]

{ #category : #visiting }
LandingComponent >> registrar [
	self call: RegUserComponent new.

]

{ #category : #rendering }
LandingComponent >> renderContent: aCanvas [

	self autorizar: aCanvas.
	aCanvas heading
		class: 'head';
		with: 'Bienvenido a CuOOra: Tu red social de preguntas'.
	aCanvas horizontalRule.
	self mostrarPreguntas: aCanvas
	"
	aCanvas
		form: [ aCanvas button 
				callback: [ self listUsers: self model getUsers ];
				with: 'Listar Usuarios' ].
	aCanvas horizontalRule"
]

{ #category : #hooks }
LandingComponent >> style [
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
.head {
   color: MediumSeaGreen;
	}
.loggedout { 
  display: block;
  padding: 5px;
  background-color: rgba(255, 99, 71, 0.5); 
  text-align: center;
  padding: 10px;
}
'
]
