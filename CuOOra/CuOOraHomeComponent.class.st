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
			aCanvas button 
				callback: [ self login ];
				with: [ aCanvas label: 'Iniciar Sesion' ]. "anchor -> button; button ->label"
			aCanvas space.
			aCanvas button
				callback: [ self register ];
				with: [ aCanvas label: 'Registrarse' ] ] "anchor -> button; button ->label"
]
