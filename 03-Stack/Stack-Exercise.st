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

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'CMS 4/28/2022 14:07:36'!
setUp
	sentenceFinderByPrefix := SentenceFinderByPrefix new.	! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'CMS 4/28/2022 15:55:55'!
assertStack: aStack hasContents: anOrderedContainer
	anOrderedContainer reverseDo: [:element |
		self deny: aStack isEmpty.
		self assert: aStack pop = element.
	].
	self assert: aStack isEmpty.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 15:40:26'!
test01SearchOnEmptyStackReturnsNoSentences
	|stack sentences|
	stack := OOStack new.
	sentences := sentenceFinderByPrefix findSentencesWithPrefix: 'A' inStack: stack.
	self assert: sentences isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 14:19:41'!
test02SearchOnStackWithTwoSentencesFindsOnlyTheSencenceWithTheSearchedPrefix
	|stack sentences expectedResult|
	stack := OOStack new.
	stack push: 'A ...'.
	stack push: 'B ...'.
	sentences := sentenceFinderByPrefix findSentencesWithPrefix: 'A' inStack: stack.
	
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'A ...'.
	
	self assert: (sentences = expectedResult).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 15:54:22'!
test03SearchPreservesStack
	|stack|
	stack := OOStack new.
	stack push: 'A ...'.
	sentenceFinderByPrefix findSentencesWithPrefix: 'A' inStack: stack.
	
	self assertStack: stack hasContents: (OrderedCollection with: 'A ...').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 15:17:34'!
test04SearchIsCaseSensitive
	|stack searchResult|
	stack := OOStack new.
	stack push: 'A ...'.
	searchResult := sentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: searchResult isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 15:41:52'!
test05SearchWithEmptyPrefixRaisesError
	|stack|
	stack := OOStack new.
	self
		should: [sentenceFinderByPrefix findSentencesWithPrefix: '' inStack: stack]
		raise: Error
		description: SentenceFinderByPrefix emptyPrefixErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 15:42:28'!
test06SearchWithPrefixContainingWhitespaceRaisesError
	|stack|
	stack := OOStack new.
	self
		should: [sentenceFinderByPrefix findSentencesWithPrefix: ' ' inStack: stack]
		raise: Error
		description: SentenceFinderByPrefix prefixContainsWhitespaceErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CMS 4/28/2022 15:54:06'!
test07SearchPreservesStackOrder
	|stack|
	stack := OOStack new.
	stack push: 'A'.
	stack push: 'B'.
	sentenceFinderByPrefix findSentencesWithPrefix: 'A' inStack: stack.
	
	self assertStack: stack hasContents: (OrderedCollection with: 'A' with: 'B').! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOImmutableStack class' category: 'Stack-Exercise'!
OOImmutableStack class
	instanceVariableNames: ''!

!OOImmutableStack class methodsFor: 'error descriptions' stamp: 'CMS 4/28/2022 15:23:58'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


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

!OOEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 15:43:26'!
tail
	self error: self class stackEmptyErrorDescription.! !

!OOEmptyImmutableStack methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 15:43:20'!
top
	self error: self class stackEmptyErrorDescription.! !


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

!OOStack class methodsFor: 'error descriptions' stamp: 'CMS 4/28/2022 15:24:37'!
stackEmptyErrorDescription
	^ OOImmutableStack stackEmptyErrorDescription! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'search' stamp: 'CMS 4/28/2022 15:58:06'!
findSentencesWithPrefix: prefix inStack: stack
	|top rest|
	self ensurePrefixDoesntContainWhitespace: prefix.
	self ensurePrefixIsntEmpty: prefix.
	
	stack isEmpty ifTrue: [^OrderedCollection new].
	top := stack pop.
	rest := self findSentencesWithPrefix: prefix inStack: stack.
	stack push: top.

	(top beginsWith: prefix) ifTrue: [rest add: top].
	^rest.! !


!SentenceFinderByPrefix methodsFor: 'precondition checks' stamp: 'CMS 4/28/2022 15:36:52'!
ensurePrefixDoesntContainWhitespace: prefix
	(prefix findString: ' ') = 0 ifFalse: 
		[self error: self class prefixContainsWhitespaceErrorDescription.]! !

!SentenceFinderByPrefix methodsFor: 'precondition checks' stamp: 'CMS 4/28/2022 15:31:11'!
ensurePrefixIsntEmpty: prefix
	prefix = '' ifTrue: [self error: self class emptyPrefixErrorDescription.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 15:29:14'!
emptyPrefixErrorDescription
	
	^ 'prefix is empty!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'CMS 4/28/2022 15:29:39'!
prefixContainsWhitespaceErrorDescription
	
	^ 'prefix contains whitespace!!!!!!'! !
