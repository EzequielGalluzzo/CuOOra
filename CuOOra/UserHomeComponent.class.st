Class {
	#name : #UserHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-UI'
}

{ #category : #rendering }
UserHomeComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: 'Este es tu muro como usuario!' , self session user name
]
