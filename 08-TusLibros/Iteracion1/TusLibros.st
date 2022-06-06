!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 14:47:09'!
test01CartIsEmptyWhenCreated
	| cart |
	cart := Cart new.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 15:03:06'!
test02CartRemembersAddedBooks
	| cart book |
	cart := Cart new.
	book := Book new.
	cart addBook: book.
	self assert: (OrderedCollection withAll: cart books) equals: (OrderedCollection with: book).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 15:05:35'!
test03CartRemembersBookAmount
	| cart book |
	cart := Cart new.
	book := Book new.
	cart addBook: book amount: 5.
	self assert: (cart amountOf: book) equals: 5.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 15:06:57'!
test04BookAmmountIsCumulative
	| cart book |
	cart := Cart new.
	book := Book new.
	cart addBook: book amount: 5.
	cart addBook: book amount: 5.
	self assert: 10 equals: (cart amountOf: book).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 15:20:57'!
test05BookAmmountToAddToCartMustBeAnInteger
	| cart book |
	cart := Cart new.
	book := Book new.
	self should: [
		cart addBook: book amount: 1.5.
	] raise: Error description: Cart nonintegerBookQuantityErrorDescription.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 15:25:52'!
test06BookAmmountToAddToCartMustBeAtLeastOne
	| cart book |
	cart := Cart new.
	book := Book new.
	self should: [
		cart addBook: book amount: 0.
	] raise: Error description: Cart bookQuantitySmallerThanOneErrorDescription.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CMS 6/6/2022 15:36:46'!
test07NonemptyCartIsNotEmpty
	| cart book |
	cart := Cart new.
	book := Book new.
	cart addBook: book.
	self deny: cart isEmpty.! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'bookAmounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:00:25'!
addBook: aBook 
	self addBook: aBook amount: 1.! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:23:50'!
addBook: aBook amount: bookAmount
	self assertBookAmountIsValid: bookAmount.
	bookAmounts at: aBook put: (bookAmount + (bookAmounts at: aBook ifAbsent: [0])).! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 14:59:30'!
amountOf: aBook
	^bookAmounts at: aBook.! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:24:33'!
assertBookAmountIsAnInteger: bookAmount
	(bookAmount isKindOf: Integer) ifFalse: [self error: self class nonintegerBookQuantityErrorDescription.].
! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:24:43'!
assertBookAmountIsAtLeastOne: bookAmount
	bookAmount >= 1 ifFalse: [self error: self class bookQuantitySmallerThanOneErrorDescription.].! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:24:59'!
assertBookAmountIsValid: bookAmount
	self assertBookAmountIsAnInteger: bookAmount.
	self assertBookAmountIsAtLeastOne: bookAmount.! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:03:15'!
books
	^bookAmounts keys.! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:00:09'!
initialize
	bookAmounts := Dictionary new.! !

!Cart methodsFor: 'category-name' stamp: 'CMS 6/6/2022 15:27:07'!
isEmpty
	^bookAmounts isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'CMS 6/6/2022 15:15:35'!
bookQuantitySmallerThanOneErrorDescription
	^'Book quantity must be at least one'.! !

!Cart class methodsFor: 'instance creation' stamp: 'CMS 6/6/2022 15:21:27'!
nonintegerBookQuantityErrorDescription
	^'Book amount must be an integer'.! !
