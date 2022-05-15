!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:22:22'!
test01RoverDoesNothingWhenEmptyStringIsSent
	|rover|
	rover := MarsRover at: 0@0 heading: South new.
	rover send: ''.
	self assert:  0@0 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:36:44'!
test02RoverMovesForwardOnce
	|rover|
	rover := MarsRover at: 0@0 heading: South new .
	rover send: 'f'.
	self assert: 0@-1 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:36:39'!
test03RoverMovesForwardMultipleTimes
	|rover|
	rover := MarsRover at: 0@0 heading: South new.
	rover send: 'f'.
	rover send: 'f'.
	self assert: 0@-2 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:36:32'!
test04RoverMovesBackwardsOnce
	|rover|
	rover := MarsRover at: 0@0 heading: South new.
	rover send: 'b'.
	self assert: 0@1 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:36:27'!
test05RoverMovesBackwardsMultipleTimes
	|rover|
	rover := MarsRover at: 0@0 heading: South new.
	rover send: 'b'.
	rover send: 'b'.
	self assert: 0@2 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:24:00'!
test06RoverFacesSouthTurnsLeftAndThenFacesEast
	|rover|
	rover := MarsRover at: 0@0 heading: South new.
	rover send: 'l'.
	self assert: East new equals: rover facingDirection.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:24:05'!
test07RoverFacesEastTurnsLeftAndThenFacesNorth
	|rover|
	rover := MarsRover at: 0@0 heading: East new.
	rover send: 'l'.
	self assert: North new equals: rover facingDirection.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:24:09'!
test08RoverFacesNorthTurnsLeftAndThenFacesWest
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'l'.
	self assert: West new equals: rover facingDirection.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'DW 5/12/2022 21:24:15'!
test09RoverFacesWestTurnsLeftAndThenFacesSouth
	|rover|
	rover := MarsRover at: 0@0 heading: West new.
	rover send: 'l'.
	self assert: South new equals: rover facingDirection.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:15:13'!
test10RoverFacingNorthMovesNorthWhenSentForward
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'f'.
	self assert: 0@1 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:15:18'!
test11RoverFacingNorthMovesNorthWhenSentForward
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'f'.
	self assert: 0@1 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:19:02'!
test12RoverFacingEastMovesEastWhenSentForward
	|rover|
	rover := MarsRover at: 0@0 heading: East new.
	rover send: 'f'.
	self assert: 1@0 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:29:47'!
test13RoverFacingEastMovesWestWhenSentBackwards
	|rover|
	rover := MarsRover at: 0@0 heading: East new.
	rover send: 'b'.
	self assert: -1@0 equals: rover position.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:37:01'!
test14RoverFacingEastFacesSouthAfterTurningRight
	|rover|
	rover := MarsRover at: 0@0 heading: East new.
	rover send: 'r'.
	self assert: rover facingDirection equals: South new.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:39:45'!
test15RoverFacingNorthFacesEastAfterTurningRight
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'r'.
	self assert: rover facingDirection equals: East new.! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:49:13'!
test16RoverProcessesStringWithMultipleCommands
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'ff'.
	self assert: rover position equals: (0@2).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 12:54:03'!
test17RoverProcessesStringWithDifferentCommands
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'ffb'.
	self assert: rover position equals: (0@1).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 13:24:21'!
test18RoverDoesNothingWhenInvalidCommandIsSent
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'x'.
	self assert: rover position equals: (0@0).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CMS 5/15/2022 13:28:23'!
test19RoverDoesntProcessCommandsAfterInvalidCommand
	|rover|
	rover := MarsRover at: 0@0 heading: North new.
	rover send: 'xf'.
	self assert: rover position equals: (0@0).! !


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


!MarsRover methodsFor: 'initialization' stamp: 'DW 5/12/2022 21:22:00'!
initializeAt: startingPosition heading: aCardinalDirection 
	position := startingPosition.
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
