"
Para registrar: 
|app |
app := WAAdmin register: LandingComponent  asApplicationAt: 'cuoora'.
app sessionClass: AUserSession.
"
Class {
	#name : #LandingComponent,
	#superclass : #MainComponent,
	#instVars : [
		'userName',
		'password'
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
	self session user ifNotNil: [
	self agregarPregunta: aCanvas.].
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
