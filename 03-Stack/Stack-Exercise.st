!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinderByPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 14:07:36'!
setUp
	sentenceFinderByPrefix := SentenceFinderByPrefix new.	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 14:09:53'!
test01SearchOnEmptyStackReturnsNoSentences
	|stack sentences|
	stack := OOStack new.
	sentences := sentenceFinderByPrefix findSentencesWithPrefix: 'Paul McCartney' inStack: stack.
	self assert: sentences isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 14:19:41'!
test02SearchOnStackWithTwoSentencesFindsOnlyTheSencenceWithTheSearchedPrefix
	|stack sentences expectedResult|
	stack := OOStack new.
	stack push: 'A ...'.
	stack push: 'B ...'.
	sentences := sentenceFinderByPrefix findSentencesWithPrefix: 'A' inStack: stack.
	
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'A ...'.
	
	self assert: (sentences = expectedResult).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 14:24:02'!
test03SearchPreservesStack
	|stack|
	stack := OOStack new.
	stack push: 'A ...'.
	sentenceFinderByPrefix findSentencesWithPrefix: 'A' inStack: stack.
	
	self deny: stack isEmpty.
	self assert: stack top equals: 'A ...'.! !


!classDefinition: #OOImmutableStack category: 'Stack-Exercise'!
Object subclass: #OOImmutableStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:28:10'!
isEmpty
	self subclassResponsibility.! !

!OOImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:27:07'!
size
	self subclassResponsibility.! !

!OOImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:32:25'!
tail
	self subclassResponsibility.! !

!OOImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:28:49'!
top
	self subclassResponsibility.! !


!classDefinition: #OOEmptyImmutableStack category: 'Stack-Exercise'!
OOImmutableStack subclass: #OOEmptyImmutableStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:28:21'!
isEmpty
	^ true.! !

!OOEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:27:34'!
size
	^ 0.! !

!OOEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:32:34'!
tail
	self error: OOStack stackEmptyErrorDescription.! !

!OOEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:29:00'!
top
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OONonEmptyImmutableStack category: 'Stack-Exercise'!
OOImmutableStack subclass: #OONonEmptyImmutableStack
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONonEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:33:20'!
initializeWithTop: anObject andTail: aYYYY
	value := anObject.
	next :=  aYYYY.! !

!OONonEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:28:30'!
isEmpty
	^ false.! !

!OONonEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:27:47'!
size
	^  1 + next size.! !

!OONonEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:32:47'!
tail
	^ next.! !

!OONonEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:29:17'!
top
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONonEmptyImmutableStack class' category: 'Stack-Exercise'!
OONonEmptyImmutableStack class
	instanceVariableNames: ''!

!OONonEmptyImmutableStack class methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:37:50'!
withTop: anObject andTail: anImmutableStack
	^self new initializeWithTop: anObject andTail: anImmutableStack.
! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'myImmutableRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:45:07'!
initialize
	myImmutableRepresentation := OOEmptyImmutableStack new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:45:07'!
isEmpty
	^ myImmutableRepresentation isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:45:07'!
pop
	|poppedElement|
	poppedElement := self top.
	myImmutableRepresentation := 	myImmutableRepresentation tail.
	^ poppedElement.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:45:07'!
push: anObject
	myImmutableRepresentation := OONonEmptyImmutableStack withTop: anObject andTail: myImmutableRepresentation.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:45:07'!
size
	^ myImmutableRepresentation size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:45:07'!
top
	^ myImmutableRepresentation top.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 13:58:49'!
findSentencesWithPrefix: prefix inStack: stack
	|top rest|
	stack isEmpty ifTrue: [^OrderedCollection new].
	top := stack pop.
	rest := self findSentencesWithPrefix: prefix inStack: stack.
	stack push: top.
	(top beginsWith: prefix) ifTrue: [rest add: top].
	^rest.
	! !
