"
""
Para registrar: 
|app |
app := WAAdmin register: LandingComponent  asApplicationAt: 'cuoora'.
app sessionClass: AUserSession.

Para limpiar:
CuOOraSystem clearSoleInstance.
app unregister 
""
"
Class {
	#name : #LandingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password',
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #visiting }
LandingComponent >> irACasa [
	self call: MyHomePageComponent new.
]

{ #category : #visiting }
LandingComponent >> listUsers: someUsers [
	self call: (ListUsersComponent users: someUsers)
]

{ #category : #'private protocol' }
LandingComponent >> login [ 	
self call: EntryComponent new.
]

{ #category : #accessing }
LandingComponent >> model [
	^ CuOOraSystem soleInstance
]

{ #category : #rendering }
LandingComponent >> mostrarOpcionesdeEntrar: aCanvas [
aCanvas
				paragraph:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: [ aCanvas label: 'registrarte' ].
					aCanvas button
						callback: [ self login ];
						with: [ aCanvas label: 'entrar' ] ]
]

{ #category : #visiting }
LandingComponent >> registrar [
	self call: RegUserComponent new.

]

{ #category : #rendering }
LandingComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'Bienvenido a CuOOra: Tu red social de preguntas'.
	aCanvas horizontalRule.
	self session user
		ifNil: [ aCanvas paragraph:
					'Hola! Bienvenido. Aqui puedes logearte, o si sos nuevo, registrate gratis!'.
			aCanvas
				form: [ aCanvas button
						callback: [ self registrar ];
						with: 'registrarse'.
					aCanvas button 
						callback: [ self login ];
						with: 'entrar' ] ]
		ifNotNil: [ aCanvas paragraph: 'Hola, bienvenido ' , self session user name.
			aCanvas
				form: [ aCanvas button 
						callback: [ self irACasa ];
						with: 'Home'  ] ].
	aCanvas horizontalRule.

	aCanvas
		form: [ aCanvas button 
				callback: [ self listUsers: self model getUsers ];
				with: 'Listar Usuarios' ].
	aCanvas horizontalRule
]
