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

{ #category : #testing }
CuOOraSystem >> addTopic: aTopic [
	(aTopic isCollection) 
	ifFalse: [ topics add: aTopic  ]
	ifTrue: [ topics addAll: aTopic ]
]

{ #category : #testing }
CuOOraSystem >> addTopic: aTopic forUser: aUser [
	(topics includes: aTopic)
	ifTrue: [ aUser addInterest: aTopic ] 
	ifFalse: [ ^ false ] 
]

{ #category : #testing }
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

{ #category : #action }
CuOOraSystem >> deleteQuestion: aQuestion [
	| user |
	aQuestion deleteAnswers.
	user := users detect: [ :u | u askedQuestion: aQuestion ].
	^ user deleteQuestion: aQuestion.
	
]

{ #category : #accessing }
CuOOraSystem >> getAllQuestions [
 ^ users flatCollect: [ :u | u getQuestions]
]

{ #category : #accessing }
CuOOraSystem >> getAllTopics [
	"es necesario que CuOOra conozca topicos? Como se construyen
	las relaciones bidireccionales?"

	^ topics
	"^ (users flatCollect: [ :u | u getInterests  ]) asSet."
]

{ #category : #reordering }
CuOOraSystem >> getAnswers: aQuestion [
	| aCol aColSorted |
	"given a question, I  need to ask the question for it's answers"
	aCol := aQuestion allAnswers.
	"then I need to sort all answers in relation to interaction points for each answer,
	from most points to least"
	aColSorted := aCol
		sort: [ :a :b | 
			(self getInteractionPoints: (self getPostInteractions: a))
				> (self getInteractionPoints: (self getPostInteractions: b)) ].
	^ aColSorted
]

{ #category : #'math functions' }
CuOOraSystem >> getInteractionPoints: aCollectionOfInteractions [
	| totalLikes totalDislikes |
	aCollectionOfInteractions isNotNil
		ifTrue: [ totalLikes := aCollectionOfInteractions
				sumNumbers: [ :each  | each isLike asBit ].
			totalDislikes := aCollectionOfInteractions
				sumNumbers: [ :each | each isDislike asBit ].
			^ totalLikes + (totalDislikes * -1) ]
		ifFalse: [ ^ 0 ]
]

{ #category : #'math functions' }
CuOOraSystem >> getPostBalance: aPost [
	| temp |
	temp := (self getPostLikes: aPost) asNumber.
	temp := temp - (self getPostDislikes: aPost) asNumber.
	^ temp
]

{ #category : #'math functions' }
CuOOraSystem >> getPostDislikes: aPost [
	^ (self getPostInteractions: aPost)
		sumNumbers: [ :each | each isDislike asBit ]
]

{ #category : #accessing }
CuOOraSystem >> getPostInteractions: aPost [
	| intCol newCol |
	"for this post, I need to collect all users interactions,
	and then find all interactions with a post which equals aPost"
	intCol := users
		flatCollect: [ :u | 
			u getInteractions
				ifNotEmpty: [ u getInteractions ]
				ifEmpty: [ OrderedCollection new] ].
	newCol :=  (intCol select: [ :i | i isOfPost: aPost ]) asSet.
	^ newCol
]

{ #category : #'math functions' }
CuOOraSystem >> getPostLikes: aPost [

	^ (self getPostInteractions: aPost)
		sumNumbers: [ :each | each isLike asBit ]
]

{ #category : #accessing }
CuOOraSystem >> getUserForPost: aPost [
	^ users
		detect: [ :each | each hasPost: aPost ]
		ifNone: [ nil ]
]

{ #category : #accessing }
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
	"now from all users to get the posts from all of their interactions,
	if the posts of those interactions correspond to the user posts collected above, sum
	points of the interactions"
	interactions := (users collect: [ :u | u getInteractions ]) flattened
		asOrderedCollection.
	interactions copy do: [ :i | posts do: [ :p | i isOfPost: p ] ].
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
	"this method would only add a topic to a user if it 
	also adds it to the system at the same time "
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

{ #category : #accessing }
CuOOraSystem >> questionsForTopic: aTopic [
	^ aTopic relatedQuestions 
]

{ #category : #refactoring }
CuOOraSystem >> relevantQuestionsForUser: aUser [
	| questions follows q |
	"first we collect all of the questions from all of the topics relevant to the user"
	questions := aUser getInterests collect: [ :t | t relatedQuestions ].
	"then we need to get all their followers and for each one get their questions"
	follows := aUser followsUsers.
	q := follows collect: [ :u | u getQuestions ].
	questions addAll: q.
	^ (questions flattened) asSet
]

{ #category : #initialization }
CuOOraSystem >> sampleData [ 
| pedro diego juan python java rust cpp javascript smalltalk OOP TDU OO1 PreguntaPedro RespuestaPedro PreguntaDiego RespuestaDiego| 
"topicos"
			python := Topic newWith: 'Python' desc: 'about Python language'.
			java := Topic newWith: 'Java' desc: 'about Java language'.
			rust := Topic newWith: 'Rust' desc: 'about Rust language'.
			javascript := Topic newWith: 'Javascript' desc: 'about Javascript language'.
			cpp := Topic newWith: 'C++' desc: 'about C++ language'.
			smalltalk  := Topic newWith: 'Smalltalk' desc: 'about Smalltalk language'.
			OOP := Topic newWith: 'OOP' desc: 'about Object Oriented Programming'.
			TDU := Topic newWith: 'Test De Unidad' desc: 'about Unit Testing'.
			OO1 := Topic newWith: 'OO1' desc: 'about Object Oriented 1'.
 topics addAll:  {python. java. rust. cpp. javascript. smalltalk. OOP. TDU. OO1}.

"topicos"


"users"
			pedro := User newWithUsername: 'pedro@cuoora.com' andPassword: 'pedro'.
			diego := User newWithUsername: 'diego@cuoora.com' andPassword: 'diego'.
			juan := User newWithUsername: 'juan@cuoora.com' andPassword: 'juan'.
			juan follow: diego.
			pedro follow: juan.
 users addAll: { pedro. diego. juan }.
"users"

"preguntas"
			PreguntaPedro := Question new.
			PreguntaPedro initializeWith:'¿Para que sirve el método SetUp?' topics: {OO1. TDU} and: 'No se para que sirve el metodo setUp.' .
			pedro addQuestion: PreguntaPedro .
			PreguntaDiego := Question new.
			PreguntaDiego initializeWith: '¿Qué significa #mesageNotUnderstood?' topics: {OO1. smalltalk } and: 'salta ese error y no se que significa.' .
			diego addQuestion: PreguntaDiego .
"preguntas"

"respuestas"
			pedro addAnswerTo: PreguntaDiego  withText: 'Sirve para instanciar los objetos que son evaluados por el test en un único método y que se ejecute siempre antes de cada test'.
			diego addAnswerTo: PreguntaPedro  withText: 'Singifica que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta'.

"respuestas"



]

{ #category : #accessing }
CuOOraSystem >> topicsForQuestion: aQuestion [

	"tengo que para topico preguntar si tiene esa pregunta en su coleccionn y si es asi "
	^ (topics select: [ :t | t hasRelatedQuestion: aQuestion ]) asSet.
]

{ #category : #utility }
CuOOraSystem >> userWithName: aName protectedBy: aPassword [
	^ users
		detect: [ :each | each hasName: aName hasPassword: aPassword ]
		ifNone: [ nil ]
]
