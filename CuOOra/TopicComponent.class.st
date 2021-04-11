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
	topico:		<Object>


    Implementation Points
"
Class {
	#name : #TopicComponent,
	#superclass : #MainComponent,
	#instVars : [
		'topico'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
TopicComponent class >> topico: unTopico [
	^ self new
		topico: unTopico ;
		yourself
]

{ #category : #protocol }
TopicComponent >> back [ 
	self answer
]

{ #category : #rendering }
TopicComponent >> detalles: aCanvas paraPost: each [.
							aCanvas
								small: (self model getUserForQuestion: each) name;
								small: ' | ';
								small: each date;
								small: ' | ';
								small: 'likes: ' , (self model getPostLikes: each) asString;
								small: ' ';
								small: 'dislikes: ' , (self model getPostDislikes: each) asString.
]

{ #category : #accessing }
TopicComponent >> header: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self back ];
				with: [ aCanvas label: 'volver' ] ].
]

{ #category : #rendering }
TopicComponent >> mostrarBotones: aCanvas [
	aCanvas form
		class: 'follow';
		with: [ aCanvas button
				callback: [ self session user addInterest: topico ];
				with: [ aCanvas label: 'seguir' ].
			aCanvas space.
			aCanvas button
				callback: [ self session user removeInterest: topico ];
				with: [ aCanvas label: 'dejar de seguir' ] ].
]

{ #category : #rendering }
TopicComponent >> preguntas: aCanvas [
	aCanvas
		unorderedList: [ topico relatedQuestions
				do: [ :each | 
					aCanvas
						render: [ aCanvas heading
								level: 4;
								with: each name.
							self detalles: aCanvas paraPost: each.
							aCanvas paragraph: each content.
							self reacciones: aCanvas dePost: each.
							aCanvas horizontalRule ] ] ].
]

{ #category : #rendering }
TopicComponent >> reacciones: aCanvas dePost: each [
							aCanvas anchor
								callback: [ self session user likePost: each ];
								with: [ aCanvas label: 'like' ].
							aCanvas space.
							aCanvas anchor
								callback: [ self session user dislikePost: each ];
								with: [ aCanvas label: 'dislike' ].
]

{ #category : #rendering }
TopicComponent >> renderContent: aCanvas [
   self header: aCanvas.
	aCanvas horizontalRule.
	aCanvas heading: 'Preguntas de topico: ' , topico name.
	self mostrarBotones: aCanvas.
	aCanvas heading
		level: 2;
		with: topico description.
	aCanvas horizontalRule.
	self preguntas: aCanvas.
	aCanvas horizontalRule
]

{ #category : #hooks }
TopicComponent >> style [
	^ '
.follow{
  display: inline;
  float: right;
}
.follow button:hover {
  cursor: grab;
  color:white;
  background-color: #C984DE;
}
.follow button:active {
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
.follow button {
  padding: 10px;
  background-color: violet;
  text-align: center;
  font-size: 16px;
  border-style: none;
  border: none;
  border-radius: 10px;
  box-shadow: 0 5px #999;
}'
]

{ #category : #accessing }
TopicComponent >> topico [
	^ topico 
]

{ #category : #accessing }
TopicComponent >> topico: aTopic [ 
	topico := aTopic 
]
