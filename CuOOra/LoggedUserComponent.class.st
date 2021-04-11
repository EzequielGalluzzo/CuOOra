Class {
	#name : #LoggedUserComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'CuOOra-UI'
}

{ #category : #hooks }
LoggedUserComponent >> children [
	^ Array with: header
]

{ #category : #initialization }
LoggedUserComponent >> initialize [
	super initialize.
	header := UserHeaderComponent new
]

{ #category : #rendering }
LoggedUserComponent >> renderContent: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
LoggedUserComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	self renderContent: aCanvas.
]
