!classDefinition: #MarsRoverListenerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverListenerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:55:58'!
test01LoggerIsEmptyOnNoCommands

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self positionLoggerOf: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:57:01'!
test02LoggerLogsMoveNorth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self positionLoggerOf: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:57:10'!
test03LoggerLogsMoveSouth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self positionLoggerOf: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:57:41'!
test04LoggerLogsMoveEastAndMoveWest

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := self positionLoggerOf: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:58:55'!
test05LoggerLogsTurnToHeadEast

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self headingLoggerOf: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:59:10'!
test06LoggerLogsTurnToHeadWestSouthAndNorth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := self headingLoggerOf: marsRover.
	
	marsRover process: 'lllr'.
	
	logStream := logger readStream.
	self assert: 'North' equals: logStream nextLine.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'South' equals: logStream nextLine.	
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 13:59:58'!
test07MarsRoverSupportsMultiplePositionListeners

	| marsRover logger1 logStream1 logStream2 logger2 |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger1 := self positionLoggerOf: marsRover.
	logger2 := self positionLoggerOf: marsRover.
	
	marsRover process: 'f'.
	
	logStream1 := logger1 readStream.
	logStream2 := logger2 readStream.
	
	self assert: '1@2' equals: logStream1 nextLine.
	self assert: logStream1 atEnd.

	self assert: '1@2' equals: logStream2 nextLine.
	self assert: logStream2 atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 14:00:16'!
test08MarsRoverSupportsMultipleHeadingListeners

	| marsRover logger1 logStream1 logStream2 logger2 |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger1 := self headingLoggerOf: marsRover.
	logger2 := self headingLoggerOf: marsRover.
	
	marsRover process: 'l'.
	
	logStream1 := logger1 readStream.
	logStream2 := logger2 readStream.
	
	self assert: 'West' equals: logStream1 nextLine.
	self assert: logStream1 atEnd.

	self assert: 'West' equals: logStream2 nextLine.
	self assert: logStream2 atEnd.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 14:01:33'!
test09MonitoringWindowPositionIsEmptyByDefault

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := self positionMonitoringWindowOf: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: window position.
	! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 14:01:03'!
test10MonitoringWindowUpdatesPosition

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := self positionMonitoringWindowOf: marsRover.
	
	marsRover process: 'f'.
	
	self assert: '1@2' equals: window position.
! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 14:01:22'!
test11MonitoringWindowUpdatesFacingEast

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := self headingMonitoringWindowOf: marsRover.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Este' equals: window heading.
	! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 14:01:53'!
test12MonitoringWindowHeadingIsEmptyByDefault

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := self headingMonitoringWindowOf: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: window heading.
	! !

!MarsRoverListenerTest methodsFor: 'tests' stamp: 'DW 6/2/2022 14:02:23'!
test13MonitoringWindowUpdatesFacingNorthSouthAndWest

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := self headingMonitoringWindowOf: marsRover.
	
	marsRover process: 'l'.
	self assert: 'Apuntando al Norte' equals: window heading.
	
	marsRover process: 'l'.
	self assert: 'Apuntando al Oeste' equals: window heading.
	
	marsRover process: 'l'.
	self assert: 'Apuntando al Sur' equals: window heading.
	! !


!MarsRoverListenerTest methodsFor: 'listeners' stamp: 'DW 6/2/2022 12:18:05'!
headingLoggerOf: marsRover

	^ MarsRoverLogger new followHeadingChangesOn: marsRover; yourself.! !

!MarsRoverListenerTest methodsFor: 'listeners' stamp: 'DW 6/2/2022 12:44:26'!
headingMonitoringWindowOf: marsRover

	^ MarsRoverMonitoringWindow new followHeadingChangesOn: marsRover ; yourself! !

!MarsRoverListenerTest methodsFor: 'listeners' stamp: 'DW 6/2/2022 12:18:11'!
positionLoggerOf: marsRover

	^ MarsRoverLogger new followPositionChangesOn: marsRover; yourself.! !

!MarsRoverListenerTest methodsFor: 'listeners' stamp: 'DW 6/2/2022 12:45:22'!
positionMonitoringWindowOf: marsRover

	^ MarsRoverMonitoringWindow new followPositionChangesOn: marsRover; yourself! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'DW 6/2/2022 13:52:04'!
initializeAt: aPosition heading: aHeadingType
	position := PositionProxy with: aPosition.
	head := HeadingProxy with: (aHeadingType for: self).! !


!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:45:54'!
changeHeading: newMarsRoverHeading
	
	head setAndNotify: newMarsRoverHeading.! !

!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:45:38'!
headEast
	
	self changeHeading: (MarsRoverHeadingEast for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:45:38'!
headNorth
	
	self changeHeading: (MarsRoverHeadingNorth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:45:38'!
headSouth
	
	self changeHeading: (MarsRoverHeadingSouth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:45:38'!
headWest
	
	self changeHeading: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:43:09'!
rotateLeft
	
	head value rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'DW 6/2/2022 13:43:13'!
rotateRight
	
	head value rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'DW 6/2/2022 13:45:13'!
isAt: aPosition heading: aHeadingType

	^position value = aPosition and: [ head value isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:47:04'!
addToPosition: newPosition

	position setAndNotify: position value + newPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:42:45'!
moveBackward
	
	head value moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:46:41'!
moveEast
	
	self addToPosition: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:42:15'!
moveForward
	
	head value moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:46:41'!
moveNorth
	
	self addToPosition: 0@1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:46:41'!
moveSouth
	
	self addToPosition: 0@-1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'DW 6/2/2022 13:46:41'!
moveWest
	
	self addToPosition: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'accept listeners' stamp: 'DW 6/2/2022 13:46:18'!
followHeadingChangesWith: aMarsRoverLogger 
	
	head addListener: aMarsRoverLogger. ! !

!MarsRover methodsFor: 'accept listeners' stamp: 'DW 6/2/2022 13:47:20'!
followPositionChangesWith: aMarsRoverLogger 
	
	position addListener: aMarsRoverLogger ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'accept' stamp: 'DW 6/2/2022 13:30:44'!
accept: aVisitor
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'accept' stamp: 'HAW 5/30/2022 20:46:21'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingEast: self! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'accept' stamp: 'DW 6/2/2022 10:03:09'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingNorth: self! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'accept' stamp: 'DW 6/2/2022 10:03:16'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingSouth: self! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'accept' stamp: 'DW 6/2/2022 10:03:22'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingWest: self! !


!classDefinition: #MarsRoverListener category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverListener
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverListener methodsFor: 'follow' stamp: 'DW 6/2/2022 12:48:56'!
followHeadingChangesOn: aMarsRover 
	aMarsRover followHeadingChangesWith: self.! !

!MarsRoverListener methodsFor: 'follow' stamp: 'DW 6/2/2022 12:49:00'!
followPositionChangesOn: aMarsRover 
	aMarsRover followPositionChangesWith: self.! !


!MarsRoverListener methodsFor: 'position' stamp: 'DW 6/2/2022 12:51:51'!
positionChangedTo: aNewPosition
	self subclassResponsibility.! !


!MarsRoverListener methodsFor: 'heading' stamp: 'DW 6/2/2022 12:49:10'!
headingChangedTo: newMarsRoverHeading
	newMarsRoverHeading accept: self.! !

!MarsRoverListener methodsFor: 'heading' stamp: 'DW 6/2/2022 12:50:50'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast
	self subclassResponsibility.! !

!MarsRoverListener methodsFor: 'heading' stamp: 'DW 6/2/2022 12:50:29'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	self subclassResponsibility.! !

!MarsRoverListener methodsFor: 'heading' stamp: 'DW 6/2/2022 12:51:15'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	self subclassResponsibility.! !

!MarsRoverListener methodsFor: 'heading' stamp: 'DW 6/2/2022 12:50:40'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest
	self subclassResponsibility.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverListener subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'position' stamp: 'HAW 5/30/2022 20:22:16'!
positionChangedTo: aPosition

	log print: aPosition; newLine! !


!MarsRoverLogger methodsFor: 'heading' stamp: 'HAW 5/30/2022 20:46:36'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	log nextPutAll: 'East'; newLine! !

!MarsRoverLogger methodsFor: 'heading' stamp: 'DW 6/2/2022 10:01:00'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth
	
	log nextPutAll: 'North'; newLine! !

!MarsRoverLogger methodsFor: 'heading' stamp: 'DW 6/2/2022 10:01:27'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	
	log nextPutAll: 'South'; newLine! !

!MarsRoverLogger methodsFor: 'heading' stamp: 'DW 6/2/2022 10:01:13'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest
	
	log nextPutAll: 'West'; newLine! !


!MarsRoverLogger methodsFor: 'read' stamp: 'HAW 5/30/2022 20:23:26'!
readStream
	
	^ReadStream on: log contents ! !


!MarsRoverLogger methodsFor: 'initalize' stamp: 'HAW 5/30/2022 20:25:00'!
initialize

	log  := WriteStream on: ''! !


!classDefinition: #MarsRoverMonitoringWindow category: 'MarsRover-WithHeading'!
MarsRoverListener subclass: #MarsRoverMonitoringWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverMonitoringWindow methodsFor: 'heading' stamp: 'DW 6/2/2022 12:35:13'!
heading
	^ heading.! !

!MarsRoverMonitoringWindow methodsFor: 'heading' stamp: 'DW 6/2/2022 12:39:38'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	heading := 'Apuntando al Este'! !

!MarsRoverMonitoringWindow methodsFor: 'heading' stamp: 'DW 6/2/2022 12:39:52'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	heading := 'Apuntando al Norte'.! !

!MarsRoverMonitoringWindow methodsFor: 'heading' stamp: 'DW 6/2/2022 12:40:16'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	heading := 'Apuntando al Sur'.! !

!MarsRoverMonitoringWindow methodsFor: 'heading' stamp: 'DW 6/2/2022 12:40:03'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 
	heading := 'Apuntando al Oeste'.! !


!MarsRoverMonitoringWindow methodsFor: 'position' stamp: 'DW 6/2/2022 12:26:29'!
position
	^ position! !

!MarsRoverMonitoringWindow methodsFor: 'position' stamp: 'DW 6/2/2022 12:26:01'!
positionChangedTo: aPoint 
	position := aPoint asString.! !


!MarsRoverMonitoringWindow methodsFor: 'initialize' stamp: 'DW 6/2/2022 12:36:50'!
initialize
	position  := ''.
	heading := ''.! !


!classDefinition: #NotifyingProxy category: 'MarsRover-WithHeading'!
Object subclass: #NotifyingProxy
	instanceVariableNames: 'value listeners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!NotifyingProxy methodsFor: 'notifying' stamp: 'DW 6/2/2022 13:35:29'!
addListener: newListener
	listeners add: newListener.! !

!NotifyingProxy methodsFor: 'notifying' stamp: 'DW 6/2/2022 13:38:08'!
notifyNewValue: newValue toListener: listener
	self subclassResponsibility.! !


!NotifyingProxy methodsFor: 'accessing' stamp: 'DW 6/2/2022 13:37:36'!
setAndNotify: newValue
	value := newValue.
	listeners do: [:listener | self notifyNewValue: newValue toListener: listener].! !

!NotifyingProxy methodsFor: 'accessing' stamp: 'DW 6/2/2022 13:35:15'!
value
	^ value.! !


!NotifyingProxy methodsFor: 'initialize' stamp: 'DW 6/2/2022 13:35:57'!
initializeWith: initialValue
	value := initialValue.
	listeners := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotifyingProxy class' category: 'MarsRover-WithHeading'!
NotifyingProxy class
	instanceVariableNames: ''!

!NotifyingProxy class methodsFor: 'as yet unclassified' stamp: 'DW 6/2/2022 13:44:06'!
with: initialValue
	^ self new initializeWith: initialValue.! !


!classDefinition: #HeadingProxy category: 'MarsRover-WithHeading'!
NotifyingProxy subclass: #HeadingProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingProxy methodsFor: 'notifying' stamp: 'DW 6/2/2022 13:39:51'!
notifyNewValue: newHeading toListener: listener
	listener headingChangedTo: newHeading.! !


!classDefinition: #PositionProxy category: 'MarsRover-WithHeading'!
NotifyingProxy subclass: #PositionProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionProxy methodsFor: 'notifying' stamp: 'DW 6/2/2022 13:48:09'!
notifyNewValue: newPosition toListener: listener
	listener positionChangedTo: newPosition.! !
