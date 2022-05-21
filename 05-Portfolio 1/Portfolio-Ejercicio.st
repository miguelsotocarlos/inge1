!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'assertions' stamp: 'DW 5/21/2022 19:15:53'!
assert: number isBalanceOf: portfolio

	^ self assert: number equals: portfolio balance! !

!PortfolioTest methodsFor: 'assertions' stamp: 'DW 5/21/2022 19:00:33'!
should: aPortfolio failToAdd: aBankRegister
		self should: [aPortfolio add: aBankRegister] raise: Error description: Portfolio wouldntroduceCycleErrorDescription.! !


!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:15:53'!
test01EmptyPortfolioHasZeroBalance

	| portfolio |
	
	portfolio := Portfolio new.
		
	self assert: 0 isBalanceOf: portfolio .! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:15:53'!
test02PortfolioWithASingleAccountHasBalanceOfThatAccount
	| portfolio |
	
	portfolio := self portfolioWithSingleAccountWithBalance: 100.
		
	self assert: 100 isBalanceOf: portfolio .! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:15:53'!
test03PortfolioWithMultipleAccountsHasSumOfBalancesAsBalance
	|portfolio|
	portfolio := self portfolioWithSingleAccountWithBalance: 100.
	portfolio add: (self accountWithBalance: 50).
		
	self assert: 150 isBalanceOf: portfolio .! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:16:16'!
test04PortfolioKnowsRegisteredTransactionsOfItsAccounts
	| portfolio account transaction |

	account := self accountWithDepositOf: 300.
	transaction := account transactions at: 1.

	portfolio := Portfolio new.
	portfolio add: (account).
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 18:49:49'!
test05PortfolioDoesntKnowTransactionsNotRegisteredInItsAccounts
	| portfolio  transaction |

	transaction := (self accountWithDepositOf: 300) transactions at: 1.
	
	portfolio := Portfolio new.
	portfolio add: ReceptiveAccount new.
		
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:15:53'!
test06PortfolioHasBalanceOfSingleContainedPortfolioAsBalance
	| portfolio |
	
	portfolio := Portfolio new.
	portfolio add: (self portfolioWithSingleAccountWithBalance: 100).
	
	self assert: 100 isBalanceOf: portfolio .! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:15:53'!
test07PortfolioHasBalanceOfAllContainedPortfoliosAsBalance
	| portfolio |
	
	portfolio := Portfolio new.
	portfolio add: (self portfolioWithSingleAccountWithBalance: 50).
	portfolio add: (self portfolioWithSingleAccountWithBalance: 100).
	
	self assert: 150 isBalanceOf: portfolio .! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:15:53'!
test08PortfolioHasBalanceOfAllContainedAccountsAndPortfoliosAsBalance
	| portfolio |
	
	portfolio := self portfolioWithSingleAccountWithBalance: 50.
	portfolio add: (self portfolioWithSingleAccountWithBalance: 100).
	
	self assert: 150 isBalanceOf: portfolio .! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 18:52:00'!
test09PortfolioKnowsTransactionsOfSingleSubRegistry
	| portfolio account |
	
	account := self accountWithDepositOf: 100.
	
	portfolio := Portfolio new.
	portfolio add: account.
		
	self assert: account transactions equals: portfolio transactions.
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 18:54:29'!
test10PortfolioKnowsTransactionsOfManySubRegistries
	| portfolio account1 account2 transactions |
	
	account1 := self accountWithBalance: 100.
	account2 := self accountWithBalance: 150.

	transactions := account1 transactions addAll: account2 transactions; yourself.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.

	self assert: (portfolio transactions includesAllOf: transactions).
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:00:33'!
test11PortfolioCantBeAddedToItself
	| portfolio |
	portfolio := Portfolio new.
			
	self should: portfolio failToAdd: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:01:04'!
test12PortfolioCantAddItsOwnDirectDescendant
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account .
				
	self should: portfolio failToAdd: account.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:04:19'!
test13PortfolioCantAddItsIndirectDescendant
	| directDescendant portfolio indirectDescendant |
	portfolio := Portfolio new.	
	directDescendant := Portfolio new.
	indirectDescendant := ReceptiveAccount new.
	
	portfolio add: directDescendant.
	directDescendant add: indirectDescendant .
				
	self should: portfolio failToAdd: indirectDescendant.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:04:54'!
test14PortfolioCantAddDescendantOfItsOnlyParent
	| portfolio parentPortfolio descendantOfParent |
	portfolio := Portfolio new.
	parentPortfolio := Portfolio new.
	descendantOfParent := ReceptiveAccount new.
	
	parentPortfolio add: portfolio.
	parentPortfolio add: descendantOfParent.
				
	self should: portfolio failToAdd: descendantOfParent! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:05:39'!
test15PortfolioCantAddDescendantOfAnyParent
	| portfolio parentPortfolio1 parentPortfolio2 descendantOfParent1 descendantOfParent2 |
	portfolio := Portfolio new.
	parentPortfolio1 := Portfolio new.
	parentPortfolio2 := Portfolio new.
	
	descendantOfParent1 := ReceptiveAccount new.
	descendantOfParent2 := ReceptiveAccount new.

	parentPortfolio1 add: descendantOfParent1.
	parentPortfolio2 add: descendantOfParent2. 

	parentPortfolio1 add: portfolio.
	parentPortfolio2 add: portfolio.
				
	self should: portfolio failToAdd: descendantOfParent1.
	self should: portfolio failToAdd: descendantOfParent2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:07:32'!
test16PortfolioCantAddDescendantOfIndirectAncestor
	| portfolio directAncestor indirectAncestor descendantOfIndirectAncestor |
	
	portfolio := Portfolio new.
	directAncestor := Portfolio new.
	indirectAncestor := Portfolio new.
	
	directAncestor add: portfolio.
	indirectAncestor add: directAncestor.
	
	descendantOfIndirectAncestor := ReceptiveAccount new.
	indirectAncestor add: descendantOfIndirectAncestor.
				
	self should: portfolio failToAdd: descendantOfIndirectAncestor.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/21/2022 19:08:02'!
test17PortfolioCantAddAncestorOfDescendantOfAncestor
	| portfolio ancestor ancestorOfDescendantOfAncestor descendantOfAncestor |
	
	portfolio := Portfolio new.
	ancestor := Portfolio new.
	ancestor add: portfolio.
	
	descendantOfAncestor := ReceptiveAccount new.
	ancestor add: descendantOfAncestor.
	
	ancestorOfDescendantOfAncestor := Portfolio new.
	ancestorOfDescendantOfAncestor add: descendantOfAncestor.
				
	self should: portfolio failToAdd: ancestorOfDescendantOfAncestor.! !


!PortfolioTest methodsFor: 'portfolio creation' stamp: 'DW 5/16/2022 21:33:16'!
portfolioWithSingleAccountWithBalance: balance
	|portfolio|
	portfolio := Portfolio new.
	portfolio add: (	self accountWithBalance: balance).
	^ portfolio.
	
	! !


!PortfolioTest methodsFor: 'account creation' stamp: 'DW 5/21/2022 18:48:40'!
accountWithBalance: balance	
	^ self accountWithDepositOf: balance.! !

!PortfolioTest methodsFor: 'account creation' stamp: 'DW 5/21/2022 18:47:43'!
accountWithDepositOf: balance	
	| account |
	account := ReceptiveAccount new.
	Deposit register: balance on: account.
	^ account.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'DW 5/16/2022 20:54:32'!
modifyBalance: aBalanceTotal
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'DW 5/16/2022 20:27:02'!
modifyBalance: aBalanceTotal

	^ aBalanceTotal + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'DW 5/16/2022 20:09:34'!
initializeFor: aValue

	value :=  aValue ! !


!Withdraw methodsFor: 'value' stamp: 'DW 5/16/2022 20:26:45'!
modifyBalance: aBalanceTotal

	^ aBalanceTotal - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankRegistry category: 'Portfolio-Ejercicio'!
Object subclass: #BankRegistry
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankRegistry methodsFor: 'balance' stamp: 'DW 5/19/2022 20:51:16'!
balance
	self subclassResponsibility.! !


!BankRegistry methodsFor: 'transactions' stamp: 'DW 5/19/2022 20:51:52'!
transactions
	self subclassResponsibility.! !


!BankRegistry methodsFor: 'testing' stamp: 'DW 5/21/2022 18:04:17'!
anyDescendantSatisfies: aCondition
	^ (aCondition value: self) or: [self anyStrictDescendantSatisfies: aCondition].! !

!BankRegistry methodsFor: 'testing' stamp: 'DW 5/21/2022 18:12:56'!
anyStrictAncestorSatisfies: aCondition
	^ self subclassResponsibility.! !

!BankRegistry methodsFor: 'testing' stamp: 'DW 5/21/2022 14:53:33'!
anyStrictDescendantIsDescendantOfAncestorsOf: aBankRegistry
	self subclassResponsibility.! !

!BankRegistry methodsFor: 'testing' stamp: 'DW 5/19/2022 20:51:40'!
hasRegistered: anAccountTransaction
	self subclassResponsibility.! !

!BankRegistry methodsFor: 'testing' stamp: 'DW 5/21/2022 17:48:46'!
isAncestorOf: aBankRegistry
	self subclassResponsibility.! !


!BankRegistry methodsFor: 'as yet unclassified' stamp: 'DW 5/21/2022 14:12:28'!
registerBeingAddedTo: aPortfolio.
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankRegistry subclass: #Portfolio
	instanceVariableNames: 'elems parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'DW 5/19/2022 20:46:14'!
balance
	^ elems sum: [:bankRegistry | bankRegistry balance] ifEmpty: 0.
		
! !


!Portfolio methodsFor: 'initialize' stamp: 'DW 5/21/2022 14:19:40'!
initialize
	parents := Set new.
	elems := OrderedCollection new.! !


!Portfolio methodsFor: 'modify' stamp: 'DW 5/21/2022 18:38:55'!
add: aBankRegistry 
	self shouldNotIntrudceCyclesAfterAdding: aBankRegistry.
	
	elems add: aBankRegistry.
	aBankRegistry registerBeingAddedTo: self.! !

!Portfolio methodsFor: 'modify' stamp: 'DW 5/21/2022 14:20:07'!
registerBeingAddedTo: aPortfolio.
	parents add: aPortfolio .! !

!Portfolio methodsFor: 'modify' stamp: 'DW 5/21/2022 18:39:52'!
shouldNotIntrudceCyclesAfterAdding: aBankRegistry 
	(self anyAncestorIsAncestorOfAnyDescendantOf: aBankRegistry) ifTrue: [self error: self class wouldntroduceCycleErrorDescription].! !


!Portfolio methodsFor: 'testing' stamp: 'DW 5/21/2022 18:15:45'!
anyAncestorIsAncestorOf: aBankRegistry 
	^ self anyAncestorSatisfies: [:anAncestor | anAncestor isAncestorOf: aBankRegistry].! !

!Portfolio methodsFor: 'testing' stamp: 'DW 5/21/2022 18:11:00'!
anyAncestorIsAncestorOfAnyDescendantOf: aBankRegistry 
	^ aBankRegistry anyDescendantSatisfies: [:aDescendant | self anyAncestorIsAncestorOf: aDescendant].! !

!Portfolio methodsFor: 'testing' stamp: 'DW 5/21/2022 18:14:52'!
anyAncestorSatisfies: aCondition
	^ (aCondition value: self) or: [self anyStrictAncestorSatisfies: aCondition].! !

!Portfolio methodsFor: 'testing' stamp: 'DW 5/21/2022 18:13:53'!
anyStrictAncestorSatisfies: aCondition
	^ parents anySatisfy: [:parent | parent anyAncestorSatisfies: aCondition].! !

!Portfolio methodsFor: 'testing' stamp: 'DW 5/21/2022 17:57:01'!
anyStrictDescendantSatisfies: aCondition 
	^ elems anySatisfy: [:child | child anyDescendantSatisfies: aCondition ]! !

!Portfolio methodsFor: 'testing' stamp: 'DW 5/19/2022 20:45:36'!
hasRegistered: aTransaction 
	^ elems anySatisfy: [:account | account hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'testing' stamp: 'DW 5/21/2022 17:59:17'!
isAncestorOf: aBankRegistry 
	^ self anyDescendantSatisfies: [:aDescendant | aDescendant = aBankRegistry].! !


!Portfolio methodsFor: 'transactions' stamp: 'DW 5/19/2022 21:46:09'!
transactions
	^ elems inject: OrderedCollection new into: [ :arr :elem |
		arr addAll: elem transactions; yourself
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'DW 5/21/2022 13:51:52'!
wouldntroduceCycleErrorDescription
	^ 'Adding that registry would introduce a cycle in the structure'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankRegistry subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DW 5/21/2022 14:12:16'!
registerBeingAddedTo: aPortfolio.
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'DW 5/16/2022 20:27:39'!
balance
	|balanceTotal|
	balanceTotal := 0.
	transactions do: [ :aTransaction | balanceTotal := aTransaction modifyBalance: balanceTotal].
	 ^ balanceTotal.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'DW 5/21/2022 14:53:57'!
anyStrictDescendantIsDescendantOfAncestorsOf: aBankRegistry
	^ false.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'DW 5/21/2022 18:03:54'!
anyStrictDescendantSatisfies: aCondition
	^ false.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'DW 5/21/2022 17:50:18'!
isAncestorOf: aBankRegistry
	^ self = aBankRegistry.! !
