!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 20:33:21'!
importFromData: data

	^ CustomerImporter valueFrom: (ReadStream on: data) into: session! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 20:33:30'!
test01ImportValidData

	self importFromData: self validImportData..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:19:02'!
test02ImportInvalidRecordTypeFails


	self should: [	 self importFromData: self dataWithInvalidType.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.
	self assertNoCustomersWereImported.! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:19:13'!
test03ImportCustomerRecordTooShortFails

	self should: [	self importFromData: self dataWithCustomerTooShort.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		
	self assertNoCustomersWereImported.! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:19:18'!
test04ImportCustomerRecordTooLongFails

	self should: [	self importFromData: self dataWithCustomerTooLong.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		
	self assertNoCustomersWereImported.! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:20:52'!
test05ImportAdressRecordTooShortFails

	self should: [	self importFromData: self dataWithAddressTooShort.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		
	self assertNoAdressesWereImported.! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:19:49'!
test06ImportAdressRecordTooLongFails

	self should: [	self importFromData: self dataWithAddressTooLong.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		
	! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 20:55:06'!
test07ImportAdressRecordWithoutCustomerFails

	self should: [	self importFromData: self dataWithOnlyAdress.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:20:12'!
test08ImportWithEmptyLineFails

	self should: [	self importFromData: self dataWithEmptyLine.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		
	self assertNoCustomersWereImported.! !

!ImportTest methodsFor: 'tests' stamp: 'DW 6/23/2022 21:20:20'!
test09ImportInvalidRecordTypeWithValidPrefixFails

	self should: [	self importFromData: self dataWithInvalidTypeWithValidPrefix.]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerImporter invalidRecordErrorDescription.		
	self assertNoCustomersWereImported.! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'DW 6/23/2022 21:19:02'!
assertNoCustomersWereImported
	self assert: (session		selectAllOfType: Customer) isEmpty.! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:54:33'!
dataWithAddressTooLong
	^'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,TooLong'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:53:10'!
dataWithAddressTooShort
		^
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:34:26'!
dataWithCustomerTooLong

	^
'C,Pepe,Sanchez,D,22333444,tooLong'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:32:48'!
dataWithCustomerTooShort

	^
'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:59:47'!
dataWithEmptyLine
	^'
'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:32:44'!
dataWithInvalidType

	^
'D,Pepe,Sanchez,D,22333444'
! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 21:11:32'!
dataWithInvalidTypeWithValidPrefix
	^ 'Cx,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:40:36'!
dataWithOnlyAdress
	^ 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'DW 6/23/2022 20:45:31'!
validImportData

	^
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream lastCustomer line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'DW 6/23/2022 20:43:12'!
importAdress
	
	| newAddress |
	(record size = 6) ifFalse: [self error: self class invalidRecordErrorDescription].
	lastCustomer ifNil: [self error: self class invalidRecordErrorDescription].

	newAddress := Address new.
	

	lastCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DW 6/23/2022 20:34:49'!
importCustomer
	(record size = 5) ifFalse:[self error: self class invalidRecordErrorDescription].
	lastCustomer := Customer new.
	lastCustomer firstName: record second.
	lastCustomer lastName: record third.
	lastCustomer identificationType: record fourth.
	lastCustomer identificationNumber: record fifth.
	session persist: lastCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DW 6/23/2022 21:13:35'!
importRecord
	record ifEmpty: [self error: self class invalidRecordErrorDescription].
	(record first = 'C') ifTrue: [^self importCustomer].
	(record first = 'A') ifTrue: [^self importAdress].
	self error: self class invalidRecordErrorDescription.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DW 6/23/2022 20:02:13'!
parseLine

	^ line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DW 6/23/2022 20:02:13'!
value

	line := readStream nextLine.

	[ line notNil ] whileTrue: [
		record := self parseLine.	
		self importRecord.

		line := readStream nextLine. ].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error description' stamp: 'DW 6/23/2022 20:13:56'!
invalidRecordErrorDescription
	^ 'Invalid record found'.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
