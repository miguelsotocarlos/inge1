!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:52:28'!
test01RoverDoesNothingWhenEmptyStringIsSent
	self rover: (self roverHeading: South) didNothingAfterSending: #('') .
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:35:20'!
test02RoverMovesForwardOnce
	self rover: (self roverHeading: South) movedRelatively: 0@-1 afterSending: #('f').
! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:36:07'!
test03RoverMovesForwardMultipleTimes
	self rover: (self roverHeading: South) movedRelatively: 0@-2 afterSending: #('f' 'f').
! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:36:38'!
test04RoverMovesBackwardsOnce
		self rover: (self roverHeading: South) movedRelatively: 0@1 afterSending: #('b').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:38:01'!
test05RoverMovesBackwardsMultipleTimes
		self rover: (self roverHeading: South) movedRelatively: 0@2 afterSending: #('b' 'b').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:22:04'!
test06RoverFacesSouthTurnsLeftAndThenFacesEast
	self rover: (self roverHeading: South) faces: (East new) afterSending: #('l')! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:20:59'!
test07RoverFacesEastTurnsLeftAndThenFacesNorth
	self rover: (self roverHeading: East) faces: (North new) afterSending: #('l')! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:22:39'!
test08RoverFacesNorthTurnsLeftAndThenFacesWest
	self rover: (self roverHeading: North) faces: (West new) afterSending: #('l')! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:22:53'!
test09RoverFacesWestTurnsLeftAndThenFacesSouth
	self rover: (self roverHeading: West) faces: (South new) afterSending: #('l')! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:44:13'!
test10RoverFacingNorthMovesNorthWhenSentForward
		self rover: (self roverHeading: North) movedRelatively: 0@1 afterSending: #('f').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:46:02'!
test11RoverFacingWestMovesWestWhenSentForward
		self rover: (self roverHeading: West) movedRelatively: -1@0 afterSending: #('f').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:45:52'!
test12RoverFacingEastMovesEastWhenSentForward
		self rover: (self roverHeading: East) movedRelatively: 1@0 afterSending: #('f').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:44:57'!
test13RoverFacingEastMovesWestWhenSentBackwards
		self rover: (self roverHeading: East) movedRelatively: -1@0 afterSending: #('b').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:23:59'!
test14RoverFacingEastFacesSouthAfterTurningRight
	self rover: (self roverHeading: East) faces: (South new) afterSending: #('r')! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:23:39'!
test15RoverFacingNorthFacesEastAfterTurningRight
	self rover: (self roverHeading: North) faces: (East new) afterSending: #('r')! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:46:51'!
test16RoverProcessesStringWithMultipleCommands
	self rover: (self roverHeading: North) movedRelatively: 0@2 afterSending: #('ff').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:46:33'!
test17RoverProcessesStringWithDifferentCommands
	self rover: (self roverHeading: North) movedRelatively: 0@1 afterSending: #('ffb').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:53:09'!
test18RoverDoesNothingWhenInvalidCommandIsSent
	
	self rover: (self roverHeading: North) didNothingAfterSending: #('x') .! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:53:30'!
test19RoverDoesntProcessCommandsAfterInvalidCommand	
	self rover: (self roverHeading: North) didNothingAfterSending: #('xf').! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/16/2022 14:58:36'!
test20RoverIsAtStartingPosition	
	|rover| 
	rover := MarsRover at: 2@3 heading: South.
	
	self assert: 2@3 equals: rover position.! !


!MarsRoverTests methodsFor: 'assertions' stamp: 'DW 5/16/2022 14:54:43'!
rover: marsRover didNothingAfterSending: anArrayOfCommandStrings
	
	self rover: marsRover movedRelatively: 0@0 afterSending: anArrayOfCommandStrings.
	self rover: marsRover faces: marsRover facingDirection afterSending: anArrayOfCommandStrings.
	! !

!MarsRoverTests methodsFor: 'assertions' stamp: 'DW 5/16/2022 14:18:13'!
rover: marsRover faces: aCardinalDirection afterSending: anArrayOfCommandStrings

	anArrayOfCommandStrings do: 	[:commandString | marsRover send: commandString ].

	self assert: aCardinalDirection equals: marsRover facingDirection.! !

!MarsRoverTests methodsFor: 'assertions' stamp: 'DW 5/16/2022 14:43:06'!
rover: marsRover movedRelatively: expectedDisplacement afterSending: anArrayOfCommandStrings
	|initalPosition|
	
	initalPosition := marsRover position.
	
	anArrayOfCommandStrings do: [:commandString | marsRover send: commandString].
		
	self assert: initalPosition + expectedDisplacement equals: marsRover position.! !


!MarsRoverTests methodsFor: 'setUp' stamp: 'DW 5/16/2022 14:21:46'!
roverHeading: aCardinalDirection 
	^ MarsRover at: 0@0 heading: aCardinalDirection new! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'testing' stamp: 'DW 5/12/2022 21:33:03'!
= aCardinalDirection
	^ self class = aCardinalDirection class.! !


!CardinalDirection methodsFor: 'position displacement' stamp: 'CMS 5/15/2022 13:13:09'!
nextPositionInOppositeDirection: previousPosition
	^self oppositeDirection nextPositionInYourDirection: previousPosition.! !

!CardinalDirection methodsFor: 'position displacement' stamp: 'CMS 5/15/2022 12:21:33'!
nextPositionInYourDirection: previousPosition
	self subclassResponsibility.! !


!CardinalDirection methodsFor: 'relative directions' stamp: 'CMS 5/15/2022 12:33:16'!
oppositeDirection
	^self turnLeft turnLeft! !

!CardinalDirection methodsFor: 'relative directions' stamp: 'DW 5/12/2022 21:19:09'!
turnLeft
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'relative directions' stamp: 'CMS 5/15/2022 12:42:44'!
turnRight
	^self turnLeft turnLeft turnLeft.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'relative directions' stamp: 'DW 5/12/2022 21:20:18'!
turnLeft
	^ North new.! !


!East methodsFor: 'position displacement' stamp: 'CMS 5/15/2022 12:22:21'!
nextPositionInYourDirection: previousPosition
	^ previousPosition + (1@0).! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'relative directions' stamp: 'DW 5/12/2022 21:20:28'!
turnLeft
	^ West new.! !


!North methodsFor: 'position displacement' stamp: 'CMS 5/15/2022 12:22:29'!
nextPositionInYourDirection: previousPosition
	^ previousPosition + (0@1).! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'relative directions' stamp: 'DW 5/12/2022 21:20:45'!
turnLeft
	^ East new.! !


!South methodsFor: 'position displacement' stamp: 'CMS 5/15/2022 12:22:39'!
nextPositionInYourDirection: previousPosition
	^ previousPosition + (0@-1).! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'relative directions' stamp: 'DW 5/12/2022 21:21:02'!
turnLeft
	^ South new.! !


!West methodsFor: 'position displacement' stamp: 'CMS 5/15/2022 12:22:52'!
nextPositionInYourDirection: previousPosition
	^ previousPosition + (-1@0).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position facingDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'maneuvering - private' stamp: 'CMS 5/15/2022 13:13:22'!
moveBackwards
	position := facingDirection nextPositionInOppositeDirection: position.! !

!MarsRover methodsFor: 'maneuvering - private' stamp: 'CMS 5/15/2022 13:08:10'!
moveForwards
		position := facingDirection nextPositionInYourDirection: position.! !

!MarsRover methodsFor: 'maneuvering - private' stamp: 'CMS 5/15/2022 13:09:12'!
turnLeft
	facingDirection := facingDirection turnLeft.! !

!MarsRover methodsFor: 'maneuvering - private' stamp: 'CMS 5/15/2022 13:09:31'!
turnRight
	facingDirection := facingDirection turnRight.! !


!MarsRover methodsFor: 'testing' stamp: 'DW 5/12/2022 21:02:57'!
facingDirection
	^ facingDirection.! !

!MarsRover methodsFor: 'testing' stamp: 'DW 5/12/2022 20:47:35'!
position
	^ position! !


!MarsRover methodsFor: 'maneuvering' stamp: 'CMS 5/15/2022 13:37:33'!
send: commandString
	commandString do: [:commandCharacter | | command |
		command := RoverCommand with: commandCharacter ifInvalid: [^self].
		command executeOn: self.
	].
! !


!MarsRover methodsFor: 'initialization' stamp: 'DW 5/16/2022 14:58:56'!
initializeAt: startingPosition heading: aCardinalDirection 
	position :=startingPosition .
	facingDirection := aCardinalDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'DW 5/12/2022 20:44:56'!
at: startingPosition heading: aCardinalDirection 
	^self new initializeAt: startingPosition heading: aCardinalDirection ! !


!classDefinition: #RoverCommand category: 'MarsRover'!
Object subclass: #RoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommand methodsFor: 'command execution' stamp: 'CMS 5/15/2022 13:36:42'!
executeOn: roverToManeuver
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommand class' category: 'MarsRover'!
RoverCommand class
	instanceVariableNames: ''!

!RoverCommand class methodsFor: 'instance creation' stamp: 'CMS 5/15/2022 13:43:56'!
with: commandCharacter ifInvalid: alternativeBlock
	^(self subclasses detect: [:subclass | subclass represents: commandCharacter] ifNone: alternativeBlock) new.! !


!classDefinition: #RoverCommandBackwards category: 'MarsRover'!
RoverCommand subclass: #RoverCommandBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommandBackwards methodsFor: 'command execution' stamp: 'CMS 5/15/2022 13:35:45'!
executeOn: roverToManeuver
	roverToManeuver moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommandBackwards class' category: 'MarsRover'!
RoverCommandBackwards class
	instanceVariableNames: ''!

!RoverCommandBackwards class methodsFor: 'as yet unclassified' stamp: 'CMS 5/15/2022 13:42:08'!
represents: commandCharacter
	^commandCharacter = $b.! !


!classDefinition: #RoverCommandForwards category: 'MarsRover'!
RoverCommand subclass: #RoverCommandForwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommandForwards methodsFor: 'command execution' stamp: 'CMS 5/15/2022 13:35:51'!
executeOn: roverToManeuver
	roverToManeuver moveForwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommandForwards class' category: 'MarsRover'!
RoverCommandForwards class
	instanceVariableNames: ''!

!RoverCommandForwards class methodsFor: 'as yet unclassified' stamp: 'CMS 5/15/2022 13:42:01'!
represents: commandCharacter
	^commandCharacter = $f.! !


!classDefinition: #RoverCommandTurnLeft category: 'MarsRover'!
RoverCommand subclass: #RoverCommandTurnLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommandTurnLeft methodsFor: 'command execution' stamp: 'CMS 5/15/2022 13:35:55'!
executeOn: roverToManeuver
	roverToManeuver turnLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommandTurnLeft class' category: 'MarsRover'!
RoverCommandTurnLeft class
	instanceVariableNames: ''!

!RoverCommandTurnLeft class methodsFor: 'as yet unclassified' stamp: 'CMS 5/15/2022 13:41:56'!
represents: commandCharacter
	^commandCharacter = $l.! !


!classDefinition: #RoverCommandTurnRight category: 'MarsRover'!
RoverCommand subclass: #RoverCommandTurnRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommandTurnRight methodsFor: 'command execution' stamp: 'CMS 5/15/2022 13:36:00'!
executeOn: roverToManeuver
	roverToManeuver turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommandTurnRight class' category: 'MarsRover'!
RoverCommandTurnRight class
	instanceVariableNames: ''!

!RoverCommandTurnRight class methodsFor: 'as yet unclassified' stamp: 'CMS 5/15/2022 13:41:48'!
represents: commandCharacter
	^commandCharacter = $r.! !
