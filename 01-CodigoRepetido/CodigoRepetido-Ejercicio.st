!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'helpers' stamp: 'CMS 4/11/2022 21:21:05'!
assertThat: aBlock runsInLessMillisecondsThan: milliseconds
	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (milliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'CMS 4/11/2022 21:46:47'!
assertThat: blockToTest throwsError: error andCheck: postErrorCheck
	[ blockToTest value. self fail ]
		on: error
		do: postErrorCheck.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'CMS 4/14/2022 17:16:23'!
assertThatThereAre: a activeUsers: b suspendedUsersAnd: c totalUsersIn: customerBook
	self assert: a equals: customerBook numberOfActiveCustomers.
	self assert: b equals: customerBook numberOfSuspendedCustomers.
	self assert: c equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'CMS 4/14/2022 17:25:31'!
customerBookWithCustomerNamed: customerName
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: customerName.
	^customerBook.! !


!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/11/2022 21:23:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat:
		[customerBook addCustomerNamed: 'John Lennon'.]
		runsInLessMillisecondsThan: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:26:26'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWithCustomerNamed: paulMcCartney .
	
	self assertThat:
		[customerBook removeCustomerNamed: paulMcCartney.]
		runsInLessMillisecondsThan: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/11/2022 21:49:07'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThat: 
		[ customerBook addCustomerNamed: '']  
		throwsError:  Error
		andCheck: [:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:28:27'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
				
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWithCustomerNamed: johnLennon .
	
	self assertThat: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		throwsError: NotFound 
		andCheck: [ 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:28:45'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWithCustomerNamed: paulMcCartney.

	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatThereAre:
		0 activeUsers:
		1 suspendedUsersAnd:
		1 totalUsersIn: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:29:04'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWithCustomerNamed: paulMcCartney.

	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatThereAre:
		0 activeUsers:
		0 suspendedUsersAnd:
		0 totalUsersIn: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:29:24'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWithCustomerNamed: johnLennon.
	
	self assertThat: [ customerBook suspendCustomerNamed: 'George Harrison'.]
		throwsError: CantSuspend
		andCheck: [
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:29:54'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWithCustomerNamed: johnLennon.

	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThat: [ customerBook suspendCustomerNamed: johnLennon.]
		throwsError: CantSuspend 
		andCheck: [
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:49:38'!
includesActiveCustomerNamed: customerName
	^active includes: customerName.! !

!CustomerBook methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:51:40'!
includesCustomerNamed: aName

	^(self includesActiveCustomerNamed: aName)
		or: [self includesSuspendedCustomerNamed: aName]! !

!CustomerBook methodsFor: 'testing' stamp: 'CMS 4/14/2022 17:51:22'!
includesSuspendedCustomerNamed: customerName
	^suspended includes: customerName.! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'CMS 4/14/2022 17:34:08'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'CMS 4/14/2022 17:34:44'!
numberOfCustomers
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'CMS 4/14/2022 18:15:45'!
remove: customer from: customerList andIfSuccessful: aBlock
	1 to: customerList size do:
	[ :index |
		customer = (customerList at: index)
			ifTrue: [
				customerList removeAt: index.
				aBlock value.
			]
	].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'CMS 4/14/2022 18:17:13'!
removeCustomerNamed: aName
	self remove: aName from: active andIfSuccessful: [^aName].
	self remove: aName from: suspended andIfSuccessful: [^aName].

	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'CMS 4/14/2022 17:50:27'!
suspendCustomerNamed: aName 
	
	(self includesActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
