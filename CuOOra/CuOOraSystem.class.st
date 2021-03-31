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
	topics:		<Object>
	users:		<Object>


    Implementation Points
"
Class {
	#name : #CuOOraSystem,
	#superclass : #Object,
	#instVars : [
		'topics',
		'users'
	],
	#category : #CuOOra
}

{ #category : #deleting }
CuOOraSystem >> deleteQuestion: aQuestion [
	| relevantAnswers |
	"collect all of the answers of all of my users and select those that are a response to 
	the questions I want to remove"
	relevantAnswers := (users flatCollect: [ :u | u myAnswers ])
		select: [ :ans | ans hasQuestion: aQuestion ].
	users do: [ :u | u deleteAnswers: relevantAnswers ].
	(users detect: [ :u | u askedQuestion: aQuestion ])
		deleteQuestion: aQuestion
]

{ #category : #accessing }
CuOOraSystem >> getAnswers: aQuestion [
	| user posts new orderedAnswers |
	"this is the implementation for the design preference 
in which a user owns interactions. For post that owns 
interactions implementation version see post class"
	user := users flatCollect: [ :u | u myQuestions ].
	posts := 
	"now that I have all the answers to a question, I have to find 
	the interactions to those answers"
	new := (users
		collect: [ :u | posts do: [ :p | u myInteractions do: [ :i | i hasPost: p ] ] ])
		flattened.
	orderedAnswers:= posts asSortedCollection: [ :p | p > 0 ] 
]

{ #category : #'math functions' }
CuOOraSystem >> getInteractionPoints: someInteractions [
	| totalLikes totalDislikes |
	totalLikes := someInteractions
		inject: 0
		into: [ :sum :each | sum + each isLike asBit ].
	totalDislikes := someInteractions
		inject: 0
		into: [ :sum :each | sum + each isDislike asBit ].
	^ totalLikes + (totalDislikes * -1)
]

{ #category : #'math functions' }
CuOOraSystem >> getPointsForUser: aUser [
	| user total posts new |
	"this method requires the user to own the interactions.
	the system must go through it's users to get the interactions 
	that are relevant. User have method getPoints 
	that can return the points for their questions
	 and for their answers to questions that are not their 
	own. We can get the likes and dislikes to their posts from the system."
	total := 0.
	user := users detect: [ :u | u is: aUser ].
	posts := user myAnswers.
	posts addAll: user myQuestions.
	new := (users
		collect: [ :u | posts do: [ :p | u myInteractions do: [ :i | i hasPost: p ] ] ])
		flattened.
	total sum: (self getInteractionPoints: new).
	total sum: user getPoints.
	^ total
	"at this point I know that posts don't know their 
	interactions, but I have interactions that know their posts.
	if I get ALL the interactions from the system via the users.
	this however makes it a bit difficult as posts don't know their 
	owners. So I need to intersect somwhow the posts from the user
	and interactions - if the interaction is to one of those posts,
	then I collect it. 
	That gives me a collection of interactions to my users
	posts. I can then make a method (for the system at this point)
	which adds these together 1 for likes and -1 for dislikes as 
	I currently have in 'post'."
]

{ #category : #accessing }
CuOOraSystem >> getQuestionsOfInterestForUser: aUser [
	| topicsForUser questions |

	topicsForUser := aUser interestedIn.
	questions addAll: topicsForUser relatedQuestions.
		questions := aUser followedUserQuestions.
	^ questions
]

{ #category : #initialization }
CuOOraSystem >> initialize [ 	
users := Set new.
topics := Set new.
]
