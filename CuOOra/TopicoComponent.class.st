Class {
	#name : #TopicoComponent,
	#superclass : #WAComponent,
	#instVars : [
		'topico'
	],
	#category : #'CuOOra-Pruebas-Inti'
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
