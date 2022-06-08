!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'expiredCreditCard validCreditCard harryPotter aClockworkOrange'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'setUp' stamp: 'DW 6/6/2022 21:10:24'!
setUp
	expiredCreditCard := self expiredCreditCard.
	validCreditCard := self validCreditCard.
	harryPotter := 'Harry Potter'.
	aClockworkOrange := 'A Clockwork Orange'.! !


!TusLibrosTest methodsFor: 'credit cards' stamp: 'DW 6/6/2022 19:55:54'!
expiredCreditCard

	^ CreditCard expiredCreditCard! !

!TusLibrosTest methodsFor: 'credit cards' stamp: 'DW 6/6/2022 19:54:23'!
validCreditCard

	^ CreditCard validCreditCard! !


!TusLibrosTest methodsFor: 'catalogs' stamp: 'DW 6/6/2022 21:11:21'!
harryPotterCatalog
	| catalog |
	catalog := Dictionary new.
	catalog at: harryPotter put: 5.
	^ catalog.! !


!TusLibrosTest methodsFor: 'carts' stamp: 'DW 6/6/2022 21:10:56'!
cartWithHarryPotter
	^ self cartWithHarryPotterCatalog addBook: harryPotter.! !

!TusLibrosTest methodsFor: 'carts' stamp: 'DW 6/6/2022 19:23:14'!
cartWithHarryPotterCatalog
	^ Cart withCatalog: self harryPotterCatalog.! !


!classDefinition: #CartTest category: 'TusLibros'!
TusLibrosTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'CMS 6/6/2022 14:47:09'!
test01CartIsEmptyWhenCreated
	| cart |
	cart := Cart new.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:51:09'!
test02CartRemembersAddedBooks
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := harryPotter.
	cart addBook: book.
	self assert: (OrderedCollection with: book) equals: cart books asOrderedCollection .! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:05:43'!
test03CartRemembersBookAmount
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := harryPotter.
	cart addBook: book amount: 5.
	self assert: (cart amountOf: book) equals: 5.! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:05:54'!
test04BookAmmountIsCumulative
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := harryPotter.
	cart addBook: book amount: 5.
	cart addBook: book amount: 5.
	self assert: 10 equals: (cart amountOf: book).! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:06:02'!
test05BookAmmountToAddToCartMustBeAnInteger
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := harryPotter.
	self should: [cart addBook: book amount: 1.5]
	 raise: Error
	 withMessageText: Cart nonintegerBookQuantityErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:06:12'!
test06BookAmmountToAddToCartMustBeAtLeastOne
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := harryPotter.
	self should: [		cart addBook: book amount: 0.	]
		raise: Error
		withMessageText: Cart bookQuantitySmallerThanOneErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:06:20'!
test07NonemptyCartIsNotEmpty
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := harryPotter.
	cart addBook: book.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:06:36'!
test08BookAddedToCartMustBeListedInStore
	| cart book |
	cart := self cartWithHarryPotterCatalog.
	book := aClockworkOrange.
	self should: [cart addBook: book] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cart bookNotInStoreErrorDescription.! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TusLibrosTest subclass: #CheckoutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:10:19'!
test01CannotCheckoutEmptyCart
	| cart cashier |
	cart := self cartWithHarryPotterCatalog.
	cashier := Cashier new.
	self should: [cashier checkout: cart withCard: validCreditCard]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier checkoutEmptyCartErrorDescription.! !

!CheckoutTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:10:19'!
test02CheckoutOfCartWithASingleItemGivesAppropiateTicket
	| cart cashier ticket |
	cart := self cartWithHarryPotter.
	cashier := Cashier new.
	ticket := cashier checkout: cart withCard: validCreditCard.
	self assert: 5 equals: ticket.! !

!CheckoutTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:10:19'!
test03CheckoutOfCartWithMultipleItemsGivesAppropiateTicket
	| cart cashier ticket catalog |
	catalog := self harryPotterCatalog.
	catalog at: aClockworkOrange put: 10.
	
	cart := Cart withCatalog: catalog.
	cart addBook: harryPotter .
	cart addBook: aClockworkOrange .
	
	cashier := Cashier new.
	ticket := cashier checkout: cart withCard: validCreditCard.
	self assert: 15 equals: ticket.! !

!CheckoutTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:51:26'!
test04SalesBookIsEmptyByDefault
	| cashier |
	cashier := Cashier new.
	self assert: cashier salesBook isEmpty.! !

!CheckoutTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:49:51'!
test05CheckoutOfCartModifiesTheSalesBook
	| cashier cart |
	cart := self cartWithHarryPotter.
	cashier := Cashier new.
	cashier checkout: cart withCard: validCreditCard.
	self assert: (OrderedCollection with: harryPotter) equals: cashier salesBook.! !

!CheckoutTest methodsFor: 'tests' stamp: 'DW 6/6/2022 21:50:04'!
test06CannotCheckOutWithExpiredCard
	| cart cashier |
	cart := self cartWithHarryPotter.
	cashier := Cashier new.
	self should: [cashier checkout: cart withCard: expiredCreditCard]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier expiredCreditCardErrorDescription.
	self assert: cashier salesBook isEmpty.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TusLibrosTest subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'DW 6/6/2022 21:56:51'!
test01ExpiredCardIsExpiredOnExpireMonth
	|card|
	card := CreditCard expiringOn: (GregorianMonthOfYear juneOf: 2022).
	self assert: (card isExpiredOn: (GregorianMonthOfYear julyOf: 2022)).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'DW 6/6/2022 20:42:18'!
amountOf: aBook
	^books occurrencesOf: aBook.! !

!Cart methodsFor: 'testing' stamp: 'DW 6/6/2022 20:42:18'!
books
	^books asSet.! !

!Cart methodsFor: 'testing' stamp: 'DW 6/6/2022 20:42:18'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'add book' stamp: 'DW 6/6/2022 18:36:00'!
addBook: aBook 
	self addBook: aBook amount: 1.! !

!Cart methodsFor: 'add book' stamp: 'DW 6/6/2022 20:42:18'!
addBook: aBook amount: bookAmount
	self assertBookAmountIsValid: bookAmount.
	self assertBookIsInCatalog: aBook.
	books add: aBook withOccurrences: bookAmount.! !

!Cart methodsFor: 'add book' stamp: 'CMS 6/6/2022 15:24:33'!
assertBookAmountIsAnInteger: bookAmount
	(bookAmount isKindOf: Integer) ifFalse: [self error: self class nonintegerBookQuantityErrorDescription.].
! !

!Cart methodsFor: 'add book' stamp: 'CMS 6/6/2022 15:24:43'!
assertBookAmountIsAtLeastOne: bookAmount
	bookAmount >= 1 ifFalse: [self error: self class bookQuantitySmallerThanOneErrorDescription.].! !

!Cart methodsFor: 'add book' stamp: 'CMS 6/6/2022 15:24:59'!
assertBookAmountIsValid: bookAmount
	self assertBookAmountIsAnInteger: bookAmount.
	self assertBookAmountIsAtLeastOne: bookAmount.! !

!Cart methodsFor: 'add book' stamp: 'DW 6/6/2022 19:10:56'!
assertBookIsInCatalog: aBook
	^ (catalog keys includes: aBook) ifFalse: [self error: self class bookNotInStoreErrorDescription]! !


!Cart methodsFor: 'initialize' stamp: 'DW 6/6/2022 18:27:36'!
initalizeWithCatalog: aCollection 
	catalog := aCollection.! !

!Cart methodsFor: 'initialize' stamp: 'DW 6/6/2022 20:42:18'!
initialize
	books := Bag new.	
	catalog := self class defaultCatalog.! !


!Cart methodsFor: 'price' stamp: 'DW 6/6/2022 20:43:19'!
priceOfContents
	^ books sum: [:aBook | catalog at: aBook].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error description' stamp: 'DW 6/6/2022 18:34:36'!
bookNotInStoreErrorDescription
	^ 'Book not listed in the store'.! !

!Cart class methodsFor: 'error description' stamp: 'CMS 6/6/2022 15:15:35'!
bookQuantitySmallerThanOneErrorDescription
	^'Book quantity must be at least one'.! !

!Cart class methodsFor: 'error description' stamp: 'CMS 6/6/2022 15:21:27'!
nonintegerBookQuantityErrorDescription
	^'Book amount must be an integer'.! !


!Cart class methodsFor: 'instance creation' stamp: 'DW 6/6/2022 18:27:57'!
withCatalog: aCollection
	^ self new initalizeWithCatalog: aCollection.! !


!Cart class methodsFor: 'default values' stamp: 'DW 6/6/2022 18:41:18'!
defaultCatalog
	^ OrderedCollection new.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'DW 6/6/2022 21:47:50'!
checkout: aCart 
	aCart isEmpty ifTrue:[	self error: self class checkoutEmptyCartErrorDescription].
	salesBook addAll: aCart books.
	^ aCart priceOfContents.! !

!Cashier methodsFor: 'checkout' stamp: 'DW 6/6/2022 19:44:34'!
checkout: aCart withCard: aCreditCard 
	aCreditCard hasExpired ifTrue: [ self error: self class expiredCreditCardErrorDescription].
	^ self checkout: aCart.! !


!Cashier methodsFor: 'accessing' stamp: 'DW 6/6/2022 21:46:26'!
salesBook
	^ salesBook.! !


!Cashier methodsFor: 'initialize' stamp: 'DW 6/6/2022 21:46:14'!
initialize
	salesBook := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'DW 6/6/2022 20:59:27'!
checkoutEmptyCartErrorDescription
	^ 'Cannot check out an empty cart. Maybe it was already checked out?'.! !

!Cashier class methodsFor: 'error description' stamp: 'DW 6/6/2022 19:35:18'!
expiredCreditCardErrorDescription
	^ 'Credit card has expired'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'hasExpired'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'category-name' stamp: 'DW 6/6/2022 19:53:06'!
expiredCreditCard
	hasExpired := true.! !

!CreditCard methodsFor: 'category-name' stamp: 'DW 6/6/2022 19:44:10'!
hasExpired
	^hasExpired.! !

!CreditCard methodsFor: 'category-name' stamp: 'DW 6/6/2022 19:44:16'!
validCreditCard
	hasExpired := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error description' stamp: 'DW 6/6/2022 19:53:15'!
expiredCreditCard
	^self new expiredCreditCard.! !

!CreditCard class methodsFor: 'error description' stamp: 'DW 6/6/2022 19:39:55'!
validCreditCard
	^self new validCreditCard.! !
