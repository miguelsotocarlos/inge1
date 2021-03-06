!classDefinition: #AccountTransactionTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountTransactionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransactionTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 12:56:47'!
test01WireTransferReducesSenderBalance
	| sender receiver |
	sender := ReceptiveAccount new.
	Deposit register: 200 on: sender.
	
	receiver := ReceptiveAccount new.
	
	WireTransfer transfer: 50 from: sender to: receiver.
	
	self assert: sender balance equals: 150.
	
	
	! !

!AccountTransactionTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 13:03:03'!
test02WireTransferIncreasesReceiverBalance
	| sender receiver |
	sender := ReceptiveAccount new.
	Deposit register: 200 on: sender.
	
	receiver := ReceptiveAccount new.
	
	WireTransfer transfer: 50 from: sender to: receiver.
	
	self assert: receiver balance equals: 50.
	
	
	! !

!AccountTransactionTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 13:11:00'!
test04WireTransferKnowsItsAmount
	| sender receiver transfer |
	sender := ReceptiveAccount new.
	Deposit register: 200 on: sender.
	
	receiver := ReceptiveAccount new.
	
	transfer := WireTransfer transfer: 50 from: sender to: receiver.
	
	self assert: transfer value equals: 50.

	
	
	! !

!AccountTransactionTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 13:28:23'!
test05WireTransferKnowsAssociatedDepositAndWithdrawal
	| sender receiver transfer |
	sender := ReceptiveAccount new.
	Deposit register: 200 on: sender.
	
	receiver := ReceptiveAccount new.
	
	transfer := WireTransfer transfer: 50 from: sender to: receiver.
	
	self assert: (sender hasRegistered: (transfer withdrawal)).
	self assert: (receiver hasRegistered: (transfer deposit)).
	
	
	! !

!AccountTransactionTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 13:35:04'!
test06WithdrawalAndDepositKnowAssociatedWireTransfer
	| sender receiver transfer |
	sender := ReceptiveAccount new.
	Deposit register: 200 on: sender.
	
	receiver := ReceptiveAccount new.
	
	transfer := WireTransfer transfer: 50 from: sender to: receiver.
	
	self assert: transfer equals: transfer withdrawal associatedWireTransfer.
	self assert: transfer equals: transfer deposit associatedWireTransfer.
	
	
	! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 15:56:06'!
test01EmptyAccountHasZeroBalanceInAccountSummary
	| account summary |
	account := ReceptiveAccount new.
	summary := AccountSummary of: account.
	self assert: summary text equals: 'Balance = 0'.! !

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/25/2022 15:59:51'!
test02AccountSummaryShowsCorrectBalance
	| account summary |
	account := ReceptiveAccount new.
	Deposit register: 500 on: account.
	summary := AccountSummary of: account.
	self assert: (summary text endsWith: 'Balance = 500').! !

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/30/2022 14:02:37'!
test03AccountSummaryShowsDeposit
	| account summary expected |
	account := ReceptiveAccount new.
	Deposit register: 500 on: account.
	summary := AccountSummary of: account.
	expected :=
'Dep�sito por 500.
Balance = 500'.
	self assert: summary text equals: expected.! !

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/30/2022 14:02:52'!
test04AccountSummaryShowsMultipleDeposits
	| account summary expected |
	account := ReceptiveAccount new.
	Deposit register: 500 on: account.
	Deposit register: 10000 on: account.

	summary := AccountSummary of: account.
	expected :=
'Dep�sito por 500.
Dep�sito por 10000.
Balance = 10500'.
	self assert: summary text equals: expected.! !

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/30/2022 14:03:06'!
test05AccountSummaryShowsWithdrawals
	| account summary expected |
	account := ReceptiveAccount new.
	Withdraw register: 500 on: account.

	summary := AccountSummary of: account.
	expected :=
'Extracci�n por 500.
Balance = -500'.
	self assert: summary text equals: expected.! !

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/30/2022 14:03:30'!
test06AccountSummaryShowsWireTransferWithdrawals
	| sender receiver summary expected |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	WireTransfer transfer: 500 from: sender to: receiver. 

	summary := AccountSummary of: sender.
	expected :=
'Salida por transferencia de 500.
Balance = -500'.
	self assert: summary text equals: expected.! !

!ReportTest methodsFor: 'tests' stamp: 'CMS 5/30/2022 14:03:41'!
test07AccountSummaryShowsWireTransferDeposits
	| sender receiver summary expected |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	WireTransfer transfer: 500 from: sender to: receiver. 

	summary := AccountSummary of: receiver.
	expected :=
'Entrada por transferencia de 500.
Balance = 500'.
	self assert: summary text equals: expected.! !

!ReportTest methodsFor: 'tests' stamp: 'DW 5/29/2022 16:58:28'!
test08NetTransferReportIsZeroOnNoTransfers
	| account report |
	account := ReceptiveAccount new.
	report := NetTransferReport of: account.
	self assert: 0 equals: report netTransferValue.! !

!ReportTest methodsFor: 'tests' stamp: 'DW 5/29/2022 17:02:12'!
test09NetTransferReportShowsValueOfWireTransferDeposit
	| sender receiver report |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	WireTransfer transfer: 500 from: sender to: receiver. 
	report := NetTransferReport of: receiver.
	self assert: 500 equals: report netTransferValue.! !

!ReportTest methodsFor: 'tests' stamp: 'DW 5/29/2022 17:06:17'!
test10NetTransferReportIgnoresSimpleDeposits
	| account report |
	account := ReceptiveAccount new.
	Deposit register: 500 on: account .
	report := NetTransferReport of: account.
	self assert: 0 equals: report netTransferValue.! !

!ReportTest methodsFor: 'tests' stamp: 'DW 5/29/2022 17:17:11'!
test11NetTransferReportShowsValueOfWireTransferWithdrawal
	| sender receiver report |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	WireTransfer transfer: 500 from: sender to: receiver. 
	report := NetTransferReport of: sender.
	self assert: -500 equals: report netTransferValue.! !

!ReportTest methodsFor: 'tests' stamp: 'DW 5/29/2022 17:53:44'!
test12ReportsWorkOnEmptyPortfolios
	| portfolio report |
	portfolio := Portfolio new.
	report := AccountSummary of: portfolio.
	self assert: 'Balance = 0' equals: report text.! !

!ReportTest methodsFor: 'tests' stamp: 'DW 5/29/2022 17:53:57'!
test13ReportsWorkOnPortfolioWithTransactions
	| portfolio report account expected|
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	Deposit register: 500 on: account.
	
	portfolio add: account.
	
	report := AccountSummary of: portfolio.
	
	expected :=
'Dep�sito por 500.
Balance = 500'.
	self assert: expected equals: report text.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'category-name' stamp: 'DW 5/29/2022 17:53:14'!
fillReport: anAccountSummary 
	accounts do: [:account | account fillReport: anAccountSummary].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'CMS 5/25/2022 16:31:33'!
fillReport: report
	transactions do: [:transaction | report reportTransaction: transaction].
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:39:37'!
reportSimpleDeposit: transaction
	self subclassResponsibility.! !

!AccountReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:40:20'!
reportSimpleWithdraw: transaction
	self subclassResponsibility.! !

!AccountReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:30:39'!
reportTransaction: transaction
	transaction fillReport: self.
! !

!AccountReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:40:39'!
reportTransferDeposit: transaction
	self subclassResponsibility.! !

!AccountReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:40:44'!
reportTransferWithdraw: transaction
	self subclassResponsibility.! !


!AccountReport methodsFor: 'initialization' stamp: 'CMS 5/30/2022 14:28:08'!
initializeWithAccount: anAccount	anAccount fillReport: self.
	self reportAccount: anAccount.! !

!AccountReport methodsFor: 'initialization' stamp: 'CMS 5/30/2022 14:28:53'!
reportAccount: anAccount
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'as yet unclassified' stamp: 'DW 5/29/2022 17:42:22'!
of: anAccount
	^self new initializeWithAccount: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'account text'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'text manipulation' stamp: 'CMS 5/25/2022 16:37:57'!
add: line
	text := text append: line.! !

!AccountSummary methodsFor: 'text manipulation' stamp: 'CMS 5/30/2022 14:02:03'!
addLine: line
	self add: (line append: '
').! !

!AccountSummary methodsFor: 'text manipulation' stamp: 'DW 5/29/2022 17:42:01'!
addLineWithPeriod: line
	self addLine: (line append: '.').! !


!AccountSummary methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:42:01'!
reportSimpleDeposit: transaction	
	self addLineWithPeriod: ('Dep�sito por 'append: (transaction value asString)).! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:42:01'!
reportSimpleWithdraw: transaction	
	self addLineWithPeriod: ('Extracci�n por 'append: (transaction value asString)).! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:23:18'!
reportTransaction: transaction
	transaction fillReport: self.
! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:42:01'!
reportTransferDeposit: transaction	
	self addLineWithPeriod: ('Entrada por transferencia de 'append: (transaction value asString)).! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:42:01'!
reportTransferWithdraw: transaction	
	self addLineWithPeriod: ('Salida por transferencia de 'append: (transaction value asString)).! !


!AccountSummary methodsFor: 'reporting' stamp: 'CMS 5/25/2022 16:35:13'!
text
	^text.! !


!AccountSummary methodsFor: 'initialization' stamp: 'CMS 5/25/2022 16:38:02'!
initializeWithAccount: anAccount
	account := anAccount.
	text := ''.
	
	account fillReport: self.
	self add: ('Balance = ' append: (account balance asString)).! !


!classDefinition: #NetTransferReport category: 'Portfolio-Solucion'!
AccountReport subclass: #NetTransferReport
	instanceVariableNames: 'netTransferValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetTransferReport methodsFor: 'initialization' stamp: 'CMS 5/30/2022 14:23:39'!
initialize
	netTransferValue := 0.
! !

!NetTransferReport methodsFor: 'initialization' stamp: 'DW 5/29/2022 17:43:23'!
initializeWithAccount: anAccount
	netTransferValue := 0.
	anAccount fillReport: self.
! !

!NetTransferReport methodsFor: 'initialization' stamp: 'CMS 5/30/2022 14:27:10'!
reportAccount: anAccount! !


!NetTransferReport methodsFor: 'reporting' stamp: 'DW 5/29/2022 17:13:32'!
netTransferValue
	^ netTransferValue ! !


!NetTransferReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:28:05'!
reportSimpleDeposit: aTransaction
	! !

!NetTransferReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:28:12'!
reportSimpleWithdraw: aTransaction
	! !

!NetTransferReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:28:40'!
reportTransferDeposit: aTransaction
	netTransferValue := aTransaction affectBalance: netTransferValue.! !

!NetTransferReport methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:28:32'!
reportTransferWithdraw: aTransaction
	netTransferValue := aTransaction affectBalance: netTransferValue.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'transactionType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'initialize' stamp: 'CMS 5/30/2022 15:04:23'!
initializeWithValue: aValue
	transactionType := aValue.! !


!AccountTransaction methodsFor: 'reporting' stamp: 'DW 5/29/2022 17:27:12'!
fillReport: aReport
	^ transactionType fillReport: aReport withTransaction: self.! !


!AccountTransaction methodsFor: 'accessing' stamp: 'CMS 5/25/2022 15:38:44'!
associatedWireTransfer
	^transactionType associatedWireTransfer.! !

!AccountTransaction methodsFor: 'accessing' stamp: 'CMS 5/25/2022 15:09:59'!
value 
	^transactionType value.! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'CMS 5/30/2022 15:04:40'!
for: aValue
	| transaction |
	
	transaction := self withValue: (SimpleTransaction withValue: aValue).
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'CMS 5/25/2022 15:24:42'!
register: aValue on: account
	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'CMS 5/30/2022 15:04:45'!
withValue: aValue
	^self new initializeWithValue: aValue.! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'CMS 5/25/2022 15:18:38'!
affectBalance: aBalance

	^aBalance + self value ! !


!Deposit methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:27:40'!
fillReportAsLeg: aReport
	aReport reportTransferDeposit: self. ! !

!Deposit methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:27:46'!
fillReportAsSimple: aReport
	aReport reportSimpleDeposit: self. ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:27:24'!
fillReportAsLeg: aReport
	aReport reportTransferWithdraw: self. ! !

!Withdraw methodsFor: 'reporting - private' stamp: 'DW 5/29/2022 17:27:29'!
fillReportAsSimple: aReport
	aReport reportSimpleWithdraw: self. ! !


!Withdraw methodsFor: 'balance' stamp: 'CMS 5/25/2022 15:18:47'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #AccountTransactionValue category: 'Portfolio-Solucion'!
Object subclass: #AccountTransactionValue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransactionValue methodsFor: 'reporting' stamp: 'CMS 5/30/2022 15:01:24'!
fillReport: aReport withTransaction: transactionFillingTheReport
	self subclassResponsibility.! !


!AccountTransactionValue methodsFor: 'value' stamp: 'CMS 5/25/2022 15:43:32'!
value
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransactionValue class' category: 'Portfolio-Solucion'!
AccountTransactionValue class
	instanceVariableNames: ''!

!AccountTransactionValue class methodsFor: 'as yet unclassified' stamp: 'CMS 5/25/2022 15:45:43'!
noAssociatedWireTransferError
	^'No associated wire transfer'.! !


!classDefinition: #SimpleTransaction category: 'Portfolio-Solucion'!
AccountTransactionValue subclass: #SimpleTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SimpleTransaction methodsFor: 'initialization' stamp: 'CMS 5/25/2022 15:12:25'!
initializeWithValue: aValue
	value := aValue.! !


!SimpleTransaction methodsFor: 'reporting' stamp: 'DW 5/29/2022 17:26:37'!
fillReport: aReport withTransaction: transactionFillingTheReport
	transactionFillingTheReport fillReportAsSimple: aReport.

! !


!SimpleTransaction methodsFor: 'value' stamp: 'CMS 5/25/2022 15:10:22'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleTransaction class' category: 'Portfolio-Solucion'!
SimpleTransaction class
	instanceVariableNames: ''!

!SimpleTransaction class methodsFor: 'as yet unclassified' stamp: 'CMS 5/25/2022 15:20:59'!
withValue: value
	^self new initializeWithValue: value.! !


!classDefinition: #WireTransferLeg category: 'Portfolio-Solucion'!
AccountTransactionValue subclass: #WireTransferLeg
	instanceVariableNames: 'associatedWireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferLeg methodsFor: 'reporting' stamp: 'DW 5/29/2022 17:27:00'!
fillReport: aReport withTransaction: transactionFillingTheReport
	transactionFillingTheReport fillReportAsLeg: aReport.


! !


!WireTransferLeg methodsFor: 'initialization' stamp: 'CMS 5/25/2022 15:14:16'!
initializeFrom: aWireTransfer
	associatedWireTransfer := aWireTransfer.! !


!WireTransferLeg methodsFor: 'accessing' stamp: 'CMS 5/30/2022 14:00:15'!
associatedWireTransfer
	^associatedWireTransfer.! !


!WireTransferLeg methodsFor: 'value' stamp: 'CMS 5/25/2022 15:11:04'!
value
	^associatedWireTransfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransferLeg class' category: 'Portfolio-Solucion'!
WireTransferLeg class
	instanceVariableNames: ''!

!WireTransferLeg class methodsFor: 'as yet unclassified' stamp: 'CMS 5/25/2022 15:31:45'!
from: aTransaction
	^self new initializeFrom: aTransaction.! !


!classDefinition: #WireTransfer category: 'Portfolio-Solucion'!
Object subclass: #WireTransfer
	instanceVariableNames: 'value deposit withdrawal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransfer methodsFor: 'initialization' stamp: 'CMS 5/25/2022 13:01:05'!
initializeFor: aValue

	value := aValue ! !

!WireTransfer methodsFor: 'initialization' stamp: 'CMS 5/25/2022 13:41:33'!
setDeposit: aDeposit
	deposit := aDeposit! !

!WireTransfer methodsFor: 'initialization' stamp: 'CMS 5/25/2022 13:41:48'!
setWithdrawal: aWithdrawal
	withdrawal := aWithdrawal.! !


!WireTransfer methodsFor: 'accessing' stamp: 'CMS 5/25/2022 13:30:51'!
deposit
	^deposit! !

!WireTransfer methodsFor: 'accessing' stamp: 'CMS 5/25/2022 13:11:12'!
value

	^ value! !

!WireTransfer methodsFor: 'accessing' stamp: 'CMS 5/25/2022 13:30:46'!
withdrawal
	^withdrawal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransfer class' category: 'Portfolio-Solucion'!
WireTransfer class
	instanceVariableNames: ''!

!WireTransfer class methodsFor: 'instance creation' stamp: 'CMS 5/25/2022 13:01:40'!
for: aValue

	^ self new initializeFor: aValue ! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'CMS 5/30/2022 15:04:40'!
transfer: anAmount from: sender to: receiver 
	| transfer depositLeg withdrawLeg |
	transfer := WireTransfer for: anAmount.
	depositLeg := Deposit withValue: (WireTransferLeg from: transfer).
	withdrawLeg := Withdraw withValue: (WireTransferLeg from: transfer).
	
	transfer setDeposit: depositLeg.
	transfer setWithdrawal: withdrawLeg.
	sender register: withdrawLeg.
	receiver register: depositLeg.
	^transfer.! !
