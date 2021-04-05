Class {
	#name : #MyHomePageComponent,
	#superclass : #WAComponent,
	#instVars : [
		'user'
	],
	#category : #'CuOOra-Pruebas-Inti'
}

{ #category : #visiting }
MyHomePageComponent >> agregarPregunta [
self call: AskAQuestionComponent new.
	
]

{ #category : #visiting }
MyHomePageComponent >> front [ 
		self answer
]

{ #category : #visiting }
MyHomePageComponent >> logout [
	self session user: nil.
	self answer
]

{ #category : #rendering }
MyHomePageComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas button
				callback: [ self logout ];
				with: [ aCanvas label: 'salir' ].
				aCanvas button
				callback: [ self front ];
				with: [ aCanvas label: 'front page' ] ].
	aCanvas horizontalRule.
	aCanvas
		heading: 'Esta es tu pagina personal, ' , self session user name.
	aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas button
				callback: [ self agregarPregunta ];
				with: [ aCanvas label: 'Agregar Pregunta' ] ]
]
