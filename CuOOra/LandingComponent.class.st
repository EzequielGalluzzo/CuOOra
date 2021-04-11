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
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password',
		'user',
		'header'
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

{ #category : #hooks }
LandingComponent >> children [ 
^ Array with: header
]

{ #category : #initialization }
LandingComponent >> initialize [
	super initialize.
	header := UserHeaderComponent new
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

{ #category : #accessing }
LandingComponent >> model [
	^ CuOOraSystem soleInstance
]

{ #category : #rendering }
LandingComponent >> mostrarOpcionesdeEntrar: aCanvas [
aCanvas
				paragraph:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: [ aCanvas label: 'registrarte' ].
					aCanvas button
						callback: [ self login ];
						with: [ aCanvas label: 'entrar' ] ]
]

{ #category : #rendering }
LandingComponent >> mostrarPreguntas: aCanvas [
	aCanvas
		unorderedList: [ self model getAllQuestions
				do: [ :each | 
					aCanvas
						render: [ aCanvas heading
								level: 3;
								with: each name.
							aCanvas
								small: (self model getUserForQuestion: each) name;
								small: ' | ';
								small: each date;
								small: ' | ';
								small: 'likes: ' , (self model getPostLikes: each) asString;
								small: ' ';
								small: 'dislikes:' , (self model getPostDislikes: each) asString.
							aCanvas paragraph: each content.
							self session user
								ifNotNil: [ aCanvas anchor
										callback: [ self session user likePost: each ];
										with: [ aCanvas label: 'like' ].
									aCanvas space.
									aCanvas anchor
										callback: [ self session user dislikePost: each ];
										with: [ aCanvas label: 'dislike' ] ].
							aCanvas horizontalRule ] ] ]
]

{ #category : #visiting }
LandingComponent >> registrar [
	self call: RegUserComponent new.

]

{ #category : #rendering }
LandingComponent >> renderContentOn: aCanvas [
	self session user ifNotNil: [ aCanvas render: header ].
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
.head {
   color: MediumSeaGreen;
	}
.loggedout { 
  display: block;
  padding: 5px;
  background-color: rgba(255, 99, 71, 0.5); 
  text-align: center;
  padding: 10px;
}'
]
