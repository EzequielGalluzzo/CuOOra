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
	#superclass : #WAComponent,
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

{ #category : #accessing }
TopicComponent >> model [
^ CuOOraSystem soleInstance 
]

{ #category : #rendering }
TopicComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self back ];
				with: [ aCanvas label: 'volver' ] ].
	aCanvas horizontalRule.
	aCanvas heading: 'Preguntas de topico: ' , topico name.
	aCanvas form
		class: 'follow';
		with: [ aCanvas button
				callback: [ self session user addInterest: topico ];
				with: [ aCanvas label: 'seguir' ] ].
	aCanvas heading
		level: 2;
		with: topico description.
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ topico relatedQuestions
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
								small: 'dislikes: ' , (self model getPostDislikes: each) asString.
							aCanvas paragraph: each content.
							aCanvas anchor
								callback: [ self session user likePost: each ];
								with: [ aCanvas label: 'like' ].
							aCanvas space.
							aCanvas anchor
								callback: [ self session user dislikePost: each ];
								with: [ aCanvas label: 'dislike' ].
							aCanvas horizontalRule ] ] ].
			aCanvas horizontalRule.
]

{ #category : #hooks }
TopicComponent >> style [
	^ '
.follow{
display: inline;
float: right;

}
.follow button {

  padding: 14px 40px;
  background-color: violet; 
  text-align: center;
  padding: 10px;
  border-radius: 5px;
font-size: 16px;
border-style: none;
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
