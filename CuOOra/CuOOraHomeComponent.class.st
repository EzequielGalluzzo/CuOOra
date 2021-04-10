Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-UI'
}

{ #category : #callback }
CuOOraHomeComponent >> login [
	self call: LogInComponent new
]

{ #category : #callback }
CuOOraHomeComponent >> register [
	self call: RegisterComponent new
]

{ #category : #rendering }
CuOOraHomeComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ "agregue aCanvas form:[]"
			aCanvas paragraph: 'Bienvenido a CuOOra'.
			aCanvas
				paragraph:
					'Tu red social nueva, original, y  nunca antes vista de preguntas y respuestas!'.
			aCanvas anchor
				callback: [ self login ];
				with: [ aCanvas button: 'Iniciar Sesion' ].
			aCanvas space.
			aCanvas anchor
				callback: [ self register ];
				with: [ aCanvas button: 'Registrarse' ] ]
]
