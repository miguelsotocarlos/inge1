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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:59:00'!
initialize
	top := OOStackContainer new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:39:47'!
isEmpty
	^ top isLast.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:02:17'!
pop
	|poppedElement|
	poppedElement := self top.
	top := 	top next.
	^ poppedElement.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:49:41'!
push: anObject
	|temp|
	temp := top.
	top := OOStackElement withValue: anObject andNext: temp.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:03:29'!
size
	^ top lengthUntilContainer.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:00:27'!
top
	^ top value.! !

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


!classDefinition: #YYYY category: 'Stack-Exercise'!
Object subclass: #YYYY
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!YYYY methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:40:37'!
isLast
	self subclassResponsibility.! !

!YYYY methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:03:42'!
lengthUntilContainer
	self subclassResponsibility.! !

!YYYY methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:56:36'!
next
	self subclassResponsibility.! !

!YYYY methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:00:42'!
value
	self subclassResponsibility.! !


!classDefinition: #OOStackContainer category: 'Stack-Exercise'!
YYYY subclass: #OOStackContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackContainer methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:52:41'!
isLast
	^ true.! !

!OOStackContainer methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:04:08'!
lengthUntilContainer
	^ 0.! !

!OOStackContainer methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:57:15'!
next
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackContainer methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:00:48'!
value
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
YYYY subclass: #OOStackElement
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:48:35'!
initializeWithValue: anObject andNext: aYYYY
	value := anObject.
	next :=  aYYYY.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:52:36'!
isLast
	^ false.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:04:31'!
lengthUntilContainer
	^  1 + next lengthUntilContainer.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:57:24'!
next
	^ next.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 17:00:59'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'as yet unclassified' stamp: 'DW 4/27/2022 16:50:21'!
withValue: anObject andNext: aYYYY
	|newOOStackElement|
	newOOStackElement := self new initializeWithValue: anObject andNext: aYYYY.
	^ newOOStackElement.! !
