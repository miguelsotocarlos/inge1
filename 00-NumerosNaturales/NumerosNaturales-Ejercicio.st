!classDefinition: #I category: 'Numeros-Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:18:47'!
next

	^II! !

!I class methodsFor: 'next & previous' stamp: 'DW 4/6/2022 12:04:49'!
previous
	^ self error: 'negativeNumbersNotSupportedErrorDescription'.! !


!I class methodsFor: 'comparaciones' stamp: 'DW 4/6/2022 11:44:50'!
<= aNumber
	^ true.! !

!I class methodsFor: 'comparaciones' stamp: 'DW 4/6/2022 11:44:46'!
> aNumber
	^ false.! !


!I class methodsFor: 'operaciones' stamp: 'AS 4/4/2022 20:25:35'!
* aNatural

	^aNatural.! !

!I class methodsFor: 'operaciones' stamp: 'ARM 3/31/2022 21:19:14'!
+ aNatural

	^aNatural next! !

!I class methodsFor: 'operaciones' stamp: 'DW 4/6/2022 12:06:37'!
/ aNatural

	^ aNatural divideA: self.! !

!I class methodsFor: 'operaciones' stamp: 'DW 4/6/2022 11:22:40'!
divideA: dividendo
	^ dividendo.! !

!I class methodsFor: 'operaciones' stamp: 'AS 4/4/2022 20:30:28'!
sustraeteDe: minuendo
	^ minuendo previous.! !


!classDefinition: #II category: 'Numeros-Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'AS 4/4/2022 20:37:31'!
* unNatural
	^(previous * unNatural) + unNatural.! !

!II class methodsFor: 'operaciones' stamp: 'ARM 3/31/2022 21:27:43'!
+ unNatural

	^previous + unNatural next! !

!II class methodsFor: 'operaciones' stamp: 'AS 4/4/2022 20:28:33'!
- sustraendo
	^sustraendo sustraeteDe: self.! !

!II class methodsFor: 'operaciones' stamp: 'AS 4/4/2022 20:33:46'!
/ divisor
	^ divisor divideA: self.! !

!II class methodsFor: 'operaciones' stamp: 'DW 4/6/2022 12:02:02'!
divideA: dividendo
	dividendo = self ifTrue:[^I].
	self > (dividendo - self) ifTrue:[^ I].
	self > dividendo ifTrue:[^ self error: 'canNotDivideByBiggerNumberErrorDescription'].
	^ I + (dividendo - self / self).! !

!II class methodsFor: 'operaciones' stamp: 'AS 4/4/2022 20:30:05'!
sustraeteDe: minuendo
	^ minuendo previous - self previous.! !


!II class methodsFor: 'nameManipulation' stamp: 'AS 4/4/2022 21:41:08'!
if: string HasSuffix: suffix replaceWith: replacement 
	(string endsWith: suffix) ifTrue:[^(string withoutSuffix: suffix) , replacement].
	^ string.
	! !

!II class methodsFor: 'nameManipulation' stamp: 'AS 4/4/2022 21:11:20'!
ifNameHasSuffix: suffix replaceWith: replacement andCall: closure 
	(self name endsWith: suffix) ifTrue:[closure value: (self name withoutSuffix: suffix) , replacement].
	! !

!II class methodsFor: 'nameManipulation' stamp: 'AS 4/4/2022 22:01:30'!
nameOfNext
	|nameOfNext executeRule|
	
	nameOfNext := self name , 'I'.
	executeRule := [:a :b | nameOfNext := 	self if: nameOfNext HasSuffix: a replaceWith: b.].
	
	executeRule value: 'IIII' value: 'IV'.
	executeRule value: 'IVI' value: 'V'.
	executeRule value: 'VIV' value: 'IX'.
	executeRule value: 'IXI' value: 'X'.
	executeRule value: 'XXXX' value: 'XL'.
	executeRule value: 'XLX' value: 'L'.
	executeRule value: 'LXL' value: 'XC'.
	executeRule value: 'LXL' value: 'XC'.
	executeRule value: 'XCX' value: 'C'.	
	^ nameOfNext.! !


!II class methodsFor: 'next & previous' stamp: 'AS 4/4/2022 21:04:40'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: (self nameOfNext).
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: 'removeAll' stamp: 'AS 4/4/2022 21:24:57'!
removeAllNext
	next ifNotNil: 
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'comparaciones' stamp: 'DW 4/6/2022 11:48:25'!
<= aNumber
	^ aNumber previous > self previous.! !

!II class methodsFor: 'comparaciones' stamp: 'DW 4/6/2022 11:44:37'!
> aNumber
	^aNumber  <= self.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Naturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Naturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !


!classDefinition: #IX category: 'Numeros-Naturales'!
II subclass: #IX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IX class' category: 'Numeros-Naturales'!
IX class
	instanceVariableNames: ''!

!IX class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := X.
	previous := VIII.! !


!classDefinition: #V category: 'Numeros-Naturales'!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: 'Numeros-Naturales'!
V class
	instanceVariableNames: ''!

!V class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VI.
	previous := IV.! !


!classDefinition: #VI category: 'Numeros-Naturales'!
II subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: 'Numeros-Naturales'!
VI class
	instanceVariableNames: ''!

!VI class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VII.
	previous := V.! !


!classDefinition: #VII category: 'Numeros-Naturales'!
II subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: 'Numeros-Naturales'!
VII class
	instanceVariableNames: ''!

!VII class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VIII.
	previous := VI.! !


!classDefinition: #VIII category: 'Numeros-Naturales'!
II subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: 'Numeros-Naturales'!
VIII class
	instanceVariableNames: ''!

!VIII class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IX.
	previous := VII.! !


!classDefinition: #X category: 'Numeros-Naturales'!
II subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'X class' category: 'Numeros-Naturales'!
X class
	instanceVariableNames: ''!

!X class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XI.
	previous := IX.! !


!classDefinition: #XI category: 'Numeros-Naturales'!
II subclass: #XI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XI class' category: 'Numeros-Naturales'!
XI class
	instanceVariableNames: ''!

!XI class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XII.
	previous := X.! !


!classDefinition: #XII category: 'Numeros-Naturales'!
II subclass: #XII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XII class' category: 'Numeros-Naturales'!
XII class
	instanceVariableNames: ''!

!XII class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XIII.
	previous := XI.! !


!classDefinition: #XIII category: 'Numeros-Naturales'!
II subclass: #XIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIII class' category: 'Numeros-Naturales'!
XIII class
	instanceVariableNames: ''!

!XIII class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XIV.
	previous := XII.! !


!classDefinition: #XIV category: 'Numeros-Naturales'!
II subclass: #XIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIV class' category: 'Numeros-Naturales'!
XIV class
	instanceVariableNames: ''!

!XIV class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XV.
	previous := XIII.! !


!classDefinition: #XV category: 'Numeros-Naturales'!
II subclass: #XV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XV class' category: 'Numeros-Naturales'!
XV class
	instanceVariableNames: ''!

!XV class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XVI.
	previous := XIV.! !


!classDefinition: #XVI category: 'Numeros-Naturales'!
II subclass: #XVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XVI class' category: 'Numeros-Naturales'!
XVI class
	instanceVariableNames: ''!

!XVI class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XVII.
	previous := XV.! !


!classDefinition: #XVII category: 'Numeros-Naturales'!
II subclass: #XVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XVII class' category: 'Numeros-Naturales'!
XVII class
	instanceVariableNames: ''!

!XVII class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := XVIII.
	previous := XVI.! !


!classDefinition: #XVIII category: 'Numeros-Naturales'!
II subclass: #XVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XVIII class' category: 'Numeros-Naturales'!
XVIII class
	instanceVariableNames: ''!

!XVIII class methodsFor: '--** private fileout/in **--' stamp: 'DW 4/6/2022 12:31:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := XVII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
IX initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!
X initializeAfterFileIn!
XI initializeAfterFileIn!
XII initializeAfterFileIn!
XIII initializeAfterFileIn!
XIV initializeAfterFileIn!
XV initializeAfterFileIn!
XVI initializeAfterFileIn!
XVII initializeAfterFileIn!
XVIII initializeAfterFileIn!