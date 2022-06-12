!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:59:01'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:59:01'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:59:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:59:01'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:59:01'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:59:01'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #SalesInterfaceTest category: 'TusLibros'!
TestCase subclass: #SalesInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/9/2022 21:07:41'!
authenticatorWithSingleRegisteredUser
	^ CredentialAuthenticatorDouble withAutheticationBehavior: [:u :p | u=self validUser and: [p=self passwordOfValidUser]]! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/12/2022 15:23:58'!
defaultSalesInterface

	^ SalesInterface 
		withAuthenticator: (self authenticatorWithSingleRegisteredUser) 
		withCatalog: testObjectsFactory defaultCatalog 
		withMerchantProcessor: self merchantProcessorThatDoesNotFail! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/12/2022 15:25:07'!
defaultSalesInterfaceWithAutehnticator: anAuthenticator

	^ SalesInterface 
		withAuthenticator: anAuthenticator 
		withCatalog: testObjectsFactory defaultCatalog 
		withMerchantProcessor: self merchantProcessorThatDoesNotFail! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/12/2022 15:26:02'!
defaultSalesInterfaceWithMerchantProcessor: aMerchantProcessor

	^ SalesInterface 
		withAuthenticator: (self authenticatorWithSingleRegisteredUser) 
		withCatalog: testObjectsFactory defaultCatalog 
		withMerchantProcessor: aMerchantProcessor.! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/9/2022 20:59:25'!
denyingAutheticator

	^ CredentialAuthenticatorDouble withAutheticationBehavior: [:u :p | false].! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/9/2022 21:05:53'!
invalidPasswordOfValidUser
	^ '4321pass'.! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/12/2022 15:15:43'!
merchantProcessorThatDoesNotFail
	^ MerchantProcessorDouble withDebitBehavior: [:a :c | ].! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/12/2022 12:57:42'!
merchantProcessorThatFails
	^ MerchantProcessorDouble withDebitBehavior: [:a :c | SalesInterface debitErrorDescription].! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/9/2022 20:17:05'!
passwordOfValidUser
	^ 'pass123'.! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/9/2022 21:23:31'!
setUp
	testObjectsFactory := StoreTestObjectsFactory new.! !

!SalesInterfaceTest methodsFor: 'objects' stamp: 'DW 6/9/2022 20:17:09'!
validUser
	^ 'Juan'.! !


!SalesInterfaceTest methodsFor: 'assertions' stamp: 'DW 6/12/2022 15:37:37'!
shouldRaiseInvalidCartId: closure

	^ self should: closure
		raise: Error - MessageNotUnderstood
		withMessageText: SalesInterface invalidCartIdErrorDescription! !

!SalesInterfaceTest methodsFor: 'assertions' stamp: 'DW 6/12/2022 15:31:38'!
shouldRaiseInvalidCredentials: closure

	^ self should: closure
	
		raise: Error
		
		withMessageText: SalesInterface invalidCredentialsErrorDescription! !


!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:40:34'!
addDefaultItemTo: salesInterface withCartId: id

	^ salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 	1! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:44:25'!
assert: temp isEqualToListPurchasesOfDefaultUserOn: salesInterface

	^ self assert: temp equals: (salesInterface listPurchasesWithClientId: self validUser password: self passwordOfValidUser)! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:29:19'!
test01ListCartOfNewlyCreatedCartIsEmpty
	| id salesInterface |
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.
	self assert: Bag new equals: (salesInterface listCartWithCartId: id).! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:29:19'!
test02NewCartGenreatesUniqueIds
	| salesInterface id1 id2 |
	salesInterface := self defaultSalesInterface .
		
	id1 := self createCartOfDefaultUser: salesInterface.
	id2 := self createCartOfDefaultUser: salesInterface.
	self deny: (id1 = id2).! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:32:22'!
test03CannotCreateCartWithInvalidClientId
	| salesInterface |
	salesInterface := self defaultSalesInterfaceWithAutehnticator: self denyingAutheticator.
		
	self shouldRaiseInvalidCredentials: [self createCartOfDefaultUser: salesInterface]
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:31:54'!
test04CannotCreateCartWithInvalidPassword
	| salesInterface |
	salesInterface := self defaultSalesInterface .
		
	self shouldRaiseInvalidCredentials: [salesInterface createCartWithClientId: self validUser password: self invalidPasswordOfValidUser].
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:40:35'!
test05ListCartReflectsAddToCart
	| salesInterface id |
	salesInterface := self defaultSalesInterface .
		
	
	id := self createCartOfDefaultUser: salesInterface.
	self addDefaultItemTo: salesInterface withCartId: id.
	self assert: (Bag with: testObjectsFactory itemSellByTheStore) equals: (salesInterface listCartWithCartId: id).
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:51:52'!
test06AddToCartDoesntAffectOtherCarts
	| salesInterface id1 id2 |
	
	salesInterface := self defaultSalesInterface .
		
	id1 := self createCartOfDefaultUser: salesInterface.
	
	id2 := self createCartOfDefaultUser: salesInterface.
	
	self addDefaultItemTo: salesInterface withCartId: id1.
	
	self assert: (Bag new) equals: (salesInterface listCartWithCartId: id2).
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:38:26'!
test07CannotListCartWithInvalidCartId
	| salesInterface |
	
	salesInterface := self defaultSalesInterface .
		
	self shouldRaiseInvalidCartId: [salesInterface listCartWithCartId: nil]
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:38:12'!
test08CannotAddToCartWithInvalidCartId
	| salesInterface |
	
	salesInterface := self defaultSalesInterface .
		
	self shouldRaiseInvalidCartId: [salesInterface addToCartWithCartId: nil bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1].! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:29:19'!
test09CannotAddToCartAnItemNotSoldByTheStore
	| salesInterface id |
	
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.
	
	self should: [salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemNotSellByTheStore bookQuantity: 1]
		raise: Error - MessageNotUnderstood
		withMessageText: SalesInterface itemNotInCatalogErrorDescription.
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:29:19'!
test10AddToCartQuantityMustBeAPositiveNumber
	| salesInterface id |
	
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.
	
	self should: [salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: -1]
		raise: Error - MessageNotUnderstood
		withMessageText: SalesInterface quantityNotAPositiveIntegerErrorDescription.
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:29:19'!
test11AddToCartQuantityMustBeAnInteger
	| salesInterface id |
	
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.
	
	self should: [salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.5]
		raise: Error - MessageNotUnderstood
		withMessageText: SalesInterface quantityNotAPositiveIntegerErrorDescription.
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:32:51'!
test12ListPurchasesOfIvalidUserFails
	| salesInterface |
	
	salesInterface := self defaultSalesInterface .
		
	self shouldRaiseInvalidCredentials: [salesInterface listPurchasesWithClientId: self validUser password: self invalidPasswordOfValidUser]
		! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:44:26'!
test13ListPurchasesOfFreshClientIsEmpty
	| salesInterface |
	
	salesInterface := self defaultSalesInterface .
		
	self assert: Bag new isEqualToListPurchasesOfDefaultUserOn: salesInterface.! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:45:23'!
test14ListPurchasesAffectedByCheckout
	| salesInterface id |
	
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.

	salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
	
	self checkoutWithDefaultCardOn: salesInterface withCartId: id.
	
	self assert: (Bag with: testObjectsFactory itemSellByTheStore)  isEqualToListPurchasesOfDefaultUserOn: salesInterface.! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:45:54'!
test15ListPurchasesIsemptyBeforeCheckout
	| salesInterface id |
	
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.

	salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
		
	self assert: Bag new isEqualToListPurchasesOfDefaultUserOn: salesInterface.! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:48:21'!
test16ListPurchasesAfterTwoCheckoutsShowsContentsOfBothCarts
	| salesInterface id id2 |
	
	salesInterface := self defaultSalesInterface .
	
	id := self createCartOfDefaultUser: salesInterface.
	self addDefaultItemTo: salesInterface withCartId: id.
	self checkoutWithDefaultCardOn: salesInterface withCartId: id.
	
	id2 := self createCartOfDefaultUser: salesInterface.
	self addDefaultItemTo: salesInterface withCartId: id2.	
	self checkoutWithDefaultCardOn: salesInterface withCartId: id2.
		
	self assert: (Bag with: testObjectsFactory itemSellByTheStore with: testObjectsFactory itemSellByTheStore) isEqualToListPurchasesOfDefaultUserOn: salesInterface.! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:33:08'!
test17ListPurchasesFailesForInvalidCredentials
	| salesInterface |
	
	salesInterface := self defaultSalesInterface .

	self shouldRaiseInvalidCredentials: [salesInterface listPurchasesWithClientId: self validUser password: self invalidPasswordOfValidUser]
	! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:37:37'!
test18CantCheckoutCartWithInvalidId
	| salesInterface |
	
	salesInterface := self defaultSalesInterface .

	self shouldRaiseInvalidCartId: [self checkoutWithDefaultCardOn: salesInterface withCartId: nil].
! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:37:37'!
test19CantCheckoutTwice
	| salesInterface id |
	
	salesInterface := self defaultSalesInterface .
		
	id := self createCartOfDefaultUser: salesInterface.

	salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
	
	self checkoutWithDefaultCardOn: salesInterface withCartId: id.
	
	self shouldRaiseInvalidCartId: [	
		self checkoutWithDefaultCardOn: salesInterface withCartId: id.
	] ! !

!SalesInterfaceTest methodsFor: 'tests' stamp: 'DW 6/12/2022 15:50:20'!
test20CheckoutCartDoesNotCheckoutWhenMerchantProcessorFails
	| salesInterface id |
	
	salesInterface := self defaultSalesInterfaceWithMerchantProcessor: self merchantProcessorThatFails.
	
	id := self createCartOfDefaultUser: salesInterface.

	salesInterface addToCartWithCartId: id bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
		
	self should: [	
	salesInterface checkOutCartWithCartId: id ccn: '0123456789012345' cced: testObjectsFactory monthOfExpiredCreditCard cco: 'Carlos Miguel Soto'.
	] raise: Error - MessageNotUnderstood
	withMessageText: SalesInterface debitErrorDescription.
	
	self assert: (Bag new) isEqualToListPurchasesOfDefaultUserOn: salesInterface.! !


!SalesInterfaceTest methodsFor: 'actions' stamp: 'DW 6/12/2022 15:34:17'!
checkoutWithDefaultCardOn: salesInterface withCartId: id

	^ salesInterface checkOutCartWithCartId: id ccn: '0123456789012345' cced: testObjectsFactory monthOfNotExpiredCreditCard cco: 'Carlos Miguel Soto'! !

!SalesInterfaceTest methodsFor: 'actions' stamp: 'DW 6/12/2022 15:29:19'!
createCartOfDefaultUser: salesInterface

	^ salesInterface createCartWithClientId: self validUser password: self passwordOfValidUser! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'DW 6/12/2022 10:17:26'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'DW 6/12/2022 10:25:13'!
books
	^items ! !

!Cart methodsFor: 'queries' stamp: 'DW 6/12/2022 10:25:22'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'DW 6/12/2022 10:11:49'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'DW 6/12/2022 10:20:46'!
add: anItem
	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'DW 6/12/2022 10:20:31'!
add: aQuantity of: anItem
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'CMS 6/12/2022 12:17:29'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'DW 6/12/2022 15:59:01'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CredentialAuthenticatorDouble category: 'TusLibros'!
Object subclass: #CredentialAuthenticatorDouble
	instanceVariableNames: 'autheticationBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialAuthenticatorDouble methodsFor: 'initialize' stamp: 'DW 6/9/2022 20:46:38'!
initializeWithAutheticationBehavior: anAutheticationBehavior 
	autheticationBehavior := anAutheticationBehavior.! !

!CredentialAuthenticatorDouble methodsFor: 'initialize' stamp: 'DW 6/9/2022 21:00:14'!
password: password isValidForClientId: clientId 
	^autheticationBehavior value: clientId value: password.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CredentialAuthenticatorDouble class' category: 'TusLibros'!
CredentialAuthenticatorDouble class
	instanceVariableNames: ''!

!CredentialAuthenticatorDouble class methodsFor: 'instance creation' stamp: 'DW 6/9/2022 20:46:24'!
withAutheticationBehavior: anAutheticationBehavior 
	^self new initializeWithAutheticationBehavior: anAutheticationBehavior ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: 'behavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'debit' stamp: 'DW 6/12/2022 13:00:32'!
debit: anAmount from: aCreditCard
	^ behavior value: anAmount value: aCreditCard .! !


!MerchantProcessorDouble methodsFor: 'initialize' stamp: 'DW 6/12/2022 12:59:30'!
initalizeWithBehavior: debitBehavior 
	behavior := debitBehavior! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorDouble class' category: 'TusLibros'!
MerchantProcessorDouble class
	instanceVariableNames: ''!

!MerchantProcessorDouble class methodsFor: 'as yet unclassified' stamp: 'DW 6/12/2022 13:01:59'!
withDebitBehavior: debitBehavior
	^ self new initalizeWithBehavior: debitBehavior.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #SalesInterface category: 'TusLibros'!
Object subclass: #SalesInterface
	instanceVariableNames: 'lastId credentialAuthenticator carts catalog clientOfCart purchases merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesInterface methodsFor: 'initialize' stamp: 'DW 6/12/2022 16:02:37'!
initializeWithAuthenticator: aCredentialAutheticator withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor 
	
	credentialAuthenticator := aCredentialAutheticator.
	merchantProcessor := aMerchantProcessor.
	catalog := aCatalog.
	
	lastId := 0.
	carts := Dictionary new.
	clientOfCart := Dictionary new.
	purchases := Dictionary new.! !


!SalesInterface methodsFor: 'private' stamp: 'DW 6/12/2022 11:00:05'!
assertBookInCatalog: bookIsbn

	^ (catalog includesKey: bookIsbn) ifFalse: [self error: self class itemNotInCatalogErrorDescription]! !

!SalesInterface methodsFor: 'private' stamp: 'CMS 6/12/2022 12:39:26'!
assertCartWithIdExists: cartId
	(carts includesKey: cartId) ifFalse: [self error: self class invalidCartIdErrorDescription].! !

!SalesInterface methodsFor: 'private' stamp: 'DW 6/12/2022 11:17:22'!
assertQuantityIsAPositiveInteger: bookQuantity

	^ (bookQuantity <= 0 or: [(bookQuantity isKindOf: Integer) not]) ifTrue: [self error: self class quantityNotAPositiveIntegerErrorDescription].! !

!SalesInterface methodsFor: 'private' stamp: 'CMS 6/12/2022 11:34:41'!
authenticateClientWithId: password andPassword: clientId

	^ (credentialAuthenticator password: password isValidForClientId: clientId) ifFalse: [self error: self class invalidCredentialsErrorDescription]! !

!SalesInterface methodsFor: 'private' stamp: 'DW 6/12/2022 10:40:27'!
getCartWithId: cartId

	^ carts at: cartId ifAbsent: [self error: self class invalidCartIdErrorDescription]! !

!SalesInterface methodsFor: 'private' stamp: 'DW 6/12/2022 10:40:27'!
listCartWithCartId: cartId 
	^ (self getCartWithId: cartId) books.! !

!SalesInterface methodsFor: 'private' stamp: 'DW 6/12/2022 16:02:37'!
removeCartId: cartId

	carts removeKey: cartId.
	clientOfCart removeKey: cartId.! !


!SalesInterface methodsFor: 'interface' stamp: 'DW 6/12/2022 11:17:10'!
addToCartWithCartId: cartId bookIsbn: bookIsbn bookQuantity: bookQuantity 

	self assertBookInCatalog: bookIsbn.
	self assertQuantityIsAPositiveInteger: bookQuantity.
	
	(self getCartWithId: cartId) add: bookQuantity of: bookIsbn.! !

!SalesInterface methodsFor: 'interface' stamp: 'DW 6/12/2022 16:05:33'!
checkOutCartWithCartId: cartId ccn: creditCardNumber cced: expirationDate cco: ownerName
	| creditCard |
	self assertCartWithIdExists: cartId.
	
	creditCard := CreditCard expiringOn: expirationDate.
	
	[Cashier toCheckout: (carts at: cartId) 
			charging: creditCard 
			through: merchantProcessor 
			on: (DateAndTime now) 
			registeringOn: OrderedCollection new]
	on: Error
	do:  [self error: self class debitErrorDescription].
	
	self registerCheckoutOf: cartId.
	
	self removeCartId: cartId.! !

!SalesInterface methodsFor: 'interface' stamp: 'DW 6/12/2022 16:02:37'!
createCartWithClientId: clientId password: password 
	self authenticateClientWithId: password andPassword: clientId.
	lastId := lastId + 1.
	carts at: lastId put: (Cart acceptingItemsOf: catalog).
	clientOfCart at: lastId put: clientId.
	^ lastId! !

!SalesInterface methodsFor: 'interface' stamp: 'DW 6/12/2022 16:09:40'!
getClientPurchases: client

	^ purchases at: client ifAbsent: [purchases at: client put: Bag new] ! !

!SalesInterface methodsFor: 'interface' stamp: 'CMS 6/12/2022 12:02:21'!
listPurchasesWithClientId: clientId password: password
	self authenticateClientWithId: password andPassword: clientId.
	^(purchases at: clientId ifAbsent: [^Bag new]).! !

!SalesInterface methodsFor: 'interface' stamp: 'DW 6/12/2022 16:09:01'!
registerCheckoutOf: cartId

	| client |
	client _ clientOfCart at: cartId.
	(self getClientPurchases: client) addAll: (self getCartWithId: cartId) books.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SalesInterface class' category: 'TusLibros'!
SalesInterface class
	instanceVariableNames: ''!

!SalesInterface class methodsFor: 'instance creation' stamp: 'DW 6/12/2022 13:01:41'!
withAuthenticator: aCredentialAutheticator withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor 
	^self new initializeWithAuthenticator: aCredentialAutheticator withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor ! !


!SalesInterface class methodsFor: 'error description' stamp: 'DW 6/12/2022 13:07:20'!
debitErrorDescription
	^ 'could not debit'.! !

!SalesInterface class methodsFor: 'error description' stamp: 'DW 6/12/2022 10:39:19'!
invalidCartIdErrorDescription
	^ 'cart id does not reference a cart in the system'.! !

!SalesInterface class methodsFor: 'error description' stamp: 'DW 6/9/2022 21:36:27'!
invalidCredentialsErrorDescription
	^ 'Invalid Client Id'.! !

!SalesInterface class methodsFor: 'error description' stamp: 'DW 6/12/2022 10:47:57'!
itemNotInCatalogErrorDescription
	^ 'book not on sale'.! !

!SalesInterface class methodsFor: 'error description' stamp: 'DW 6/12/2022 11:13:09'!
quantityNotAPositiveIntegerErrorDescription
	^ 'quantity to add to a cart of an item must be a positive integer'. ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DW 6/12/2022 15:12:42'!
monthOfExpiredCreditCard
	
	^Month month: today monthIndex year: today yearNumber - 1.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DW 6/12/2022 15:17:40'!
monthOfNotExpiredCreditCard
	
	^Month month: today monthIndex year: today yearNumber + 1.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
