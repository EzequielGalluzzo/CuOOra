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
	#name : #TopicoComponent,
	#superclass : #WAComponent,
	#instVars : [
		'topico'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
TopicoComponent class >> topico: unTopico [
	^ self new
		topico: unTopico ;
		yourself
]

{ #category : #protocol }
TopicoComponent >> back [ 
	self answer
]

{ #category : #rendering }
TopicoComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self back ];
				with: [ aCanvas label: 'volver' ] ].
	aCanvas horizontalRule.
	aCanvas heading: 'Preguntas de topico: ' , topico name.
	aCanvas heading
		level: 2;
		with: topico description.
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ topico relatedQuestions
				do: [ :each | 
					aCanvas heading
						level: 3;
						with: each name.
					aCanvas render: each content ].
			aCanvas horizontalRule ]
]

{ #category : #accessing }
TopicoComponent >> topico [
	^ topico 
]

{ #category : #accessing }
TopicoComponent >> topico: aTopic [ 
	topico := aTopic 
]
