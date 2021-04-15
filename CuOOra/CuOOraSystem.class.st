"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design: 

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: A system in which users interact asking questions and giving answers.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	topics:		<Object>
	users:		<Object>


    Implementation Points
"
Class {
	#name : #CuOOraSystem,
	#superclass : #Object,
	#instVars : [
		'topics',
		'users'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
CuOOraSystem class >> clearSoleInstance [ 
soleInstance := nil
]

{ #category : #'instance creation' }
CuOOraSystem class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self new sampleData ].
]

{ #category : #adding }
CuOOraSystem >> addTopic: aTopic [
	(aTopic isCollection) 
	ifFalse: [ topics add: aTopic  ]
	ifTrue: [ topics addAll: aTopic ]
]

{ #category : #'private-helpers' }
CuOOraSystem >> addTopic: aTopic forUser: aUser [
	(topics includes: aTopic)
	ifTrue: [ aUser addInterest: aTopic ] 
	ifFalse: [ ^ false ] 
]

{ #category : #adding }
CuOOraSystem >> addUser: aUser [
	users add: aUser 
]

{ #category : #adding }
CuOOraSystem >> addUser: aName pass: aPassword [
 | u |
 u := User newWithUsername: aName andPassword: aPassword.
 users add: u.
^ u
]

{ #category : #collection }
CuOOraSystem >> allQuestionsOrderedByDate [
	| aCol aColSorted |
	aCol := (users collect: [ :u | u getQuestions ]) flattened.
	aColSorted := aCol sort: [ :a :b | a postTimeDate > b postTimeDate ].
	^ aColSorted
]

{ #category : #deleting }
CuOOraSystem >> deleteQuestion: aQuestion [
	| user |
	aQuestion deleteAnswers.
	user := users detect: [ :u | u askedQuestion: aQuestion ].
	^ user deleteQuestion: aQuestion.
	
]

{ #category : #collection }
CuOOraSystem >> getAllQuestions [
 ^ users flatCollect: [ :u | u getQuestions]
]

{ #category : #accessing }
CuOOraSystem >> getAllTopics [
	"es necesario que CuOOra conozca topicos? Como se construyen
	las relaciones bidireccionales?"
	^ topics

]

{ #category : #'private-helpers' }
CuOOraSystem >> getInteractionPoints: aCollectionOfInteractions [
	| totalLikes totalDislikes |
		"SE TRANSFORMA EL BOOLEANO QUE DEVUELVE isLike A UN 
	UNO O UN CERO CON asBit PARA CADA INTERACCION Y LO MISMO PARA
	isDislike"
	aCollectionOfInteractions isNotNil
		ifTrue: [ totalLikes := aCollectionOfInteractions
				sumNumbers: [ :each | each isLike asBit ].
			totalDislikes := aCollectionOfInteractions
				sumNumbers: [ :each | each isDislike asBit ].
			"LA CANTIDAD DE DISLIKES LA CONVIERTO EN NEGATIVA"
			^ totalLikes + (totalDislikes * -1) ]
		ifFalse: [ ^ 0 ]

]

{ #category : #'private-helpers' }
CuOOraSystem >> getNumberOfDislikes: aPost [
	^ (self getPostInteractions: aPost)
		sumNumbers: [ :each | each isDislike asBit ]
]

{ #category : #'private-helpers' }
CuOOraSystem >> getNumberOfLikes: aPost [

	^ (self getPostInteractions: aPost)
		sumNumbers: [ :each | each isLike asBit ]
]

{ #category : #reordering }
CuOOraSystem >> getOrderedAnswers: aQuestion [
	| aCol aColSorted |
	"DADA UNA PREGUNTA LE PIDO TODAS SUS RESPUESTAS"
	aCol := aQuestion allAnswers.
	"LUEGO NECESITO ORDENAR CADA RESPUESTA POR LA CANTIDAD DE PUNTOS QUE 
	TIENE POR INTERACCIONES DE MAYOR A MENOR"
	aColSorted := aCol
		sort: [ :a :b | 
			(self getInteractionPoints: (self getPostInteractions: a))
				> (self getInteractionPoints: (self getPostInteractions: b)) ].
	^ aColSorted
]

{ #category : #'private-helpers' }
CuOOraSystem >> getPostBalance: aPost [
	| temp |
	"DEVUELVE PUNTOS TOTALES PARA UN POST"
	temp := (self getNumberOfLikes: aPost) asNumber.
	temp := temp - (self getNumberOfDislikes: aPost) asNumber.
	^ temp
]

{ #category : #'private-helpers' }
CuOOraSystem >> getPostInteractions: aPost [
	| intCol newCol |
	"DADO UN POST (PREGUNTA O RESPUESTA) NECESITO TODAS LAS INTERACCIONES
	DE TODOS LOS USUARIOS Y LUEGO ENCONTRAR CUALES INTERACCIONES CORRESPONDEN
	A ESE POST" 
	intCol := users
		flatCollect: [ :u | 
			u getInteractions
				ifNotEmpty: [ u getInteractions ]
				ifEmpty: [ OrderedCollection new ] ].
	newCol := (intCol select: [ :i | i isOfPost: aPost ]) asSet.
	^ newCol
]

{ #category : #'private-helpers' }
CuOOraSystem >> getUserForPost: aPost [
	^ users
		detect: [ :each | each hasPost: aPost ]
		ifNone: [ nil ]
]

{ #category : #'private-helpers' }
CuOOraSystem >> getUserForQuestion: aQuestion [
	^ users detect: [ :each | each askedQuestion: aQuestion ] ifNone: [ nil ]	
]

{ #category : #numeric }
CuOOraSystem >> getUserPoints: aUser [
	| total posts interactions |
	total := 0.
	total := total + aUser getPointsFromUser.
	posts := aUser getQuestions.
	posts addAll: aUser getAllAnswers.
	"BUSCA TODOS LOS LIKES Y DISLIKES DE TODOS LOS USUARIOS"
	interactions := (users collect: [ :u | u getInteractions ]) flattened
		asOrderedCollection.
	"PARA CADA REACCION LE PREGUNTA POR CADA POST DE USUARIO SI PERTENECE A ESE POST"
	interactions copy do: [ :i | posts do: [ :p | i isOfPost: p ] ].
	"SACA CUENTA DE LOS PUNTOS POR CADA INTERACCION RELEVANTE AL USUARIO"
	total := total + (self getInteractionPoints: interactions).
	^ total
]

{ #category : #accessing }
CuOOraSystem >> getUsers [
	^ users
]

{ #category : #initialization }
CuOOraSystem >> initialize [
	users := Set new.
	topics := Set
		new.
]

{ #category : #'instance creation' }
CuOOraSystem >> newTopic: aName desc: aDescription forUser: aUser [
	| t |
	t := self newTopic: aName description: aDescription.
	aUser addInterest: t.
	topics add: t.
	^ t
]

{ #category : #'instance creation' }
CuOOraSystem >> newTopic: aName description: aDescription [
	| t |
	t := Topic newWith: aName desc: aDescription.
	topics add: t.
	^ t

]

{ #category : #delegation }
CuOOraSystem >> questionsForTopic: aTopic [
	^ aTopic relatedQuestions 
]

{ #category : #collection }
CuOOraSystem >> relevantQuestionsForUser: aUser [
	| questions follows q |
	"PARA UN USUARIO SE PIDEN LOS TOPICOS DE INTERES Y A ESOS TOPICOS 
	SE LES PIDEN LAS PREGUNTAS RELACIONADAS"
	questions := aUser getInterests collect: [ :t | t relatedQuestions ].
	"LUEGO LE PEDIMOS AL USUARIO TODOS LOS USUARIOS QUE SIGUE"
	follows := aUser followsUsers.
	"LUEGO LE PEDIMOS A ESOS USUARIOS SUS PREGUNTAS"
	q := follows collect: [ :u | u getQuestions ].
	questions addAll: q.
	"SE DEVUELVE AS SET PORQUE SEGURO SE REPITEN Y FLATTENED POR SER 
	COLECCION DE COLECCIONES"
	^ questions flattened asSet 
]

{ #category : #reordering }
CuOOraSystem >> relevantQuestionsForUserOrderedByDate: aUser [
"DEVUELE LAS PREGUNTAS RELEVANTES DE UN USUARIO ORDENADOS POR FECHA Y HORA
MAYOR A MENOR"
	^ (self relevantQuestionsForUser: aUser)
		asSortedCollection: [ :a :b | a postTimeDate > b postTimeDate ]
]

{ #category : #initialization }
CuOOraSystem >> sampleData [
| pedro diego juan python java rust cpp javascript smalltalk OOP TDU OO1 PreguntaPedro PreguntaDiego |
	"topicos"
	python := Topic newWith: 'Python' desc: 'about Python language'.
	java := Topic newWith: 'Java' desc: 'about Java language'.
	rust := Topic newWith: 'Rust' desc: 'about Rust language'.
	javascript := Topic
		newWith: 'Javascript'
		desc: 'about Javascript language'.
	cpp := Topic newWith: 'C++' desc: 'about C++ language'.
	smalltalk := Topic
		newWith: 'Smalltalk'
		desc: 'about Smalltalk language'.
	OOP := Topic newWith: 'OOP' desc: 'about Object Oriented Programming'.
	TDU := Topic newWith: 'Test De Unidad' desc: 'about Unit Testing'.
	OO1 := Topic newWith: 'OO1' desc: 'about Object Oriented 1'.
	topics
		addAll:
			{python.
			java.
			rust.
			cpp.
			javascript.
			smalltalk.
			OOP.
			TDU.
			OO1}.

	"topicos"


	"users"
	pedro := User
		newWithUsername: 'pedro@cuoora.com'
		andPassword: 'pedro'.
	diego := User
		newWithUsername: 'diego@cuoora.com'
		andPassword: 'diego'.
	juan := User newWithUsername: 'juan@cuoora.com' andPassword: 'juan'.
	juan follow: diego.
	pedro follow: juan.
	users
		addAll:
			{pedro.
			diego.
			juan}.
	"users"

	"preguntas"
	PreguntaPedro := Question new.
	PreguntaPedro
		initializeWith: '¿Para que sirve el método SetUp?'
		topics:
			{OO1.
			TDU}
		and: 'No se para que sirve el metodo setUp.'.
	pedro addQuestion: PreguntaPedro.
	PreguntaDiego := Question new.
	PreguntaDiego
		initializeWith: '¿Qué significa #mesageNotUnderstood?'
		topics:
			{OO1.
			smalltalk}
		and: 'salta ese error y no se que significa.'.
	diego addQuestion: PreguntaDiego.
	"preguntas"

	"respuestas"
	pedro
		addAnswerTo: PreguntaDiego
		withText:
			'Sirve para instanciar los objetos que son evaluados por el test en un único método y que se ejecute siempre antes de cada test'.
	diego
		addAnswerTo: PreguntaPedro
		withText:
			'Singifica que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta'

	"respuestas"
]

{ #category : #collection }
CuOOraSystem >> topicsForQuestion: aQuestion [
	"tengo que para topico preguntar si tiene esa pregunta en su coleccionn"

	^ (topics select: [ :t | t hasRelatedQuestion: aQuestion ]) asSet
]

{ #category : #'private-helpers' }
CuOOraSystem >> userWithName: aName protectedBy: aPassword [
	^ users
		detect: [ :each | each hasName: aName hasPassword: aPassword ]
		ifNone: [ nil ]
]
