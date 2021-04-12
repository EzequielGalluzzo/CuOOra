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


    Implementation Points
"
Class {
	#name : #UserHeaderComponent,
	#superclass : #HeaderComponent,
	#category : #'CuOOra-UI'
}

{ #category : #'private protocol' }
UserHeaderComponent >> logout [
	self session logout.
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #rendering }
UserHeaderComponent >> mostrarLogout: aCanvas [
aCanvas
		form class: 'right'; with: [ aCanvas label:'Hola, ', self session user name, '  '.
			   aCanvas button
				callback: [ self logout ];
				with: 'salir']
]

{ #category : #rendering }
UserHeaderComponent >> mostrarTopicos: aCanvas [
	aCanvas
		unorderedList  class: 'left'; with: [ aCanvas label: 'Mis intereses: '. self session user getInterests 
				do: [ :each | 
					aCanvas label class:'em'; with: ' ' , each name , ' ' ] ]
]

{ #category : #rendering }
UserHeaderComponent >> renderContentOn: aCanvas [
	aCanvas div
		class: 'top';
		with: [ self session isLoggedIn ifTrue: [self mostrarTopicos: aCanvas.
			self mostrarLogout: aCanvas ]]
]

{ #category : #hooks }
UserHeaderComponent >> style [
	^ '

.em {
	font-style: italic;
	}
.left {
   float: left;
   margin: 0;
	padding: 5px;
	display: inline; 
	}
.right{ 
  font-weight: bold;
  text-align: right;
  display: block;  
  padding: 5px;
  margin: 0;
  background-color: lightgrey;
}

'
]
