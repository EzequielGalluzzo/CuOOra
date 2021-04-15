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


    Implementation Points
"
Class {
	#name : #UserProfileComponent,
	#superclass : #MainComponent,
	#instVars : [
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
UserProfileComponent class >> user: aUser [
	^ self new
		user: aUser;
		yourself
]

{ #category : #protocol }
UserProfileComponent >> back [ 
self answer
]

{ #category : #rendering }
UserProfileComponent >> botonVolver: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self back ];
				with: 'Volver' ]
]

{ #category : #delegation }
UserProfileComponent >> follow [
	(self session user) follow: user
]

{ #category : #accessing }
UserProfileComponent >> myQuestions [
	^ user getQuestions

]

{ #category : #rendering }
UserProfileComponent >> renderContent: aCanvas [
	self botonVolver: aCanvas.
	aCanvas heading
		level: 1;
		with: 'Esta es el perfil de ' , user name.
	self session user
		ifNotNil: [ aCanvas
				form: [ aCanvas button
						callback: [ self follow ];
						with: 'Seguir' ] ].
	aCanvas heading
		level: 2;
		with: 'Mis preguntas:'.
	aCanvas horizontalRule.
	self mostrarPreguntas: aCanvas
]

{ #category : #hooks }
UserProfileComponent >> style [ 
^
'
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
  padding: 0; }'
]

{ #category : #accessing }
UserProfileComponent >> user: aUser [
	user:= aUser
]
