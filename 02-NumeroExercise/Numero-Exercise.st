!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DW 4/25/2022 10:41:55'!
- aSubtrahend
	^self  subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:45:14'!
addToEntero: anEnteroToAddTo
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:45:43'!
addToFraccion: aFraccionToAddTo
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:44:24'!
divideAFraccion: aFraccionToDivide
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:44:12'!
divideAnEntero: anEnteroToDivide
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:46:09'!
multiplyToEntero: anEnteroToMultiplyTo
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:45:57'!
multiplyToFraccion: aFraccionToMultiplyTo
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:47:06'!
subtractFromEntero: anEnteroToSubtractFrom
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'DW 4/25/2022 10:47:54'!
subtractFromFraccion: aFraccionToSubtractFrom
	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de n\FAmero inv\E1lido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'private' stamp: 'DW 4/20/2022 14:18:01'!
addToEntero: anEnteroToAddTo 
	
	^ self class with: value + anEnteroToAddTo integerValue.! !

!Entero methodsFor: 'private' stamp: 'DW 4/20/2022 14:37:16'!
addToFraccion: aFraccionToAddTo 
	
	^ aFraccionToAddTo addToEntero: self.! !

!Entero methodsFor: 'private' stamp: 'DW 4/20/2022 15:25:18'!
divideAFraccion: aFraccionToDivide 
	^ aFraccionToDivide numerator / (aFraccionToDivide denominator * self).
	! !

!Entero methodsFor: 'private' stamp: 'DW 4/21/2022 21:26:13'!
divideAnEntero: anEnteroToDivide 
	
	self subclassResponsibility.! !

!Entero methodsFor: 'private' stamp: 'DW 4/25/2022 10:35:41'!
divideCoprimeEntero: anEntero
	self subclassResponsibility.! !

!Entero methodsFor: 'private' stamp: 'DW 4/20/2022 14:32:11'!
multiplyToEntero: anEnteroToMultiplyTo 
	
	^self class with: value * anEnteroToMultiplyTo integerValue.
	! !

!Entero methodsFor: 'private' stamp: 'DW 4/20/2022 14:36:57'!
multiplyToFraccion: aFraccionToMultiplyTo 
	
	^ aFraccionToMultiplyTo multiplyToEntero: self.! !

!Entero methodsFor: 'private' stamp: 'DW 4/25/2022 11:14:39'!
subtractFromEntero: anEnteroToSubtractFrom
	
	^ self class with: anEnteroToSubtractFrom integerValue - value.! !

!Entero methodsFor: 'private' stamp: 'DW 4/25/2022 11:27:40'!
subtractFromFraccion: aFraccionToSubtractFrom
	^ aFraccionToSubtractFrom numerator - (self * aFraccionToSubtractFrom denominator) / aFraccionToSubtractFrom denominator
! !


!Entero methodsFor: 'arithmetic operations' stamp: 'DW 4/20/2022 14:33:25'!
* aMultiplier 
	
	^aMultiplier multiplyToEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DW 4/20/2022 14:25:33'!
+ anAdder 
	
	^ anAdder addToEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DW 4/25/2022 11:10:17'!
- aSubtrahend 
	^ aSubtrahend subtractFromEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DW 4/20/2022 15:13:58'!
/ aDivisor 

	^aDivisor divideAnEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DW 4/21/2022 20:42:37'!
fibonacci

	self subclassResponsibility.	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'CMS 4/20/2022 16:16:24'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'DW 4/21/2022 20:44:30'!
incluyeA: anEntero
	self subclassResponsibility.! !

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est\E1 definido aqu\ED para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'DW 4/21/2022 20:51:24'!
with: aValue 
	|tipoDeEntero|
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	tipoDeEntero := Entero subclasses detect: [: subclase | subclase incluyeA: aValue].

	^tipoDeEntero new initializeWith: aValue.! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'CMS 4/20/2022 16:37:28'!
fibonacci
	^Entero with: 1.
		! !


!Cero methodsFor: 'private' stamp: 'DW 4/21/2022 21:25:35'!
divideAnEntero: anEntero
	
	self error: self class canNotDivideByZeroErrorDescription.
! !

!Cero methodsFor: 'private' stamp: 'DW 4/21/2022 21:37:40'!
divideCoprimeEntero: anEntero
	self error: self class canNotDivideByZeroErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'instance creation' stamp: 'DW 4/21/2022 20:46:31'!
incluyeA: anEntero
	^ anEntero = 0.! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'DW 4/21/2022 20:42:55'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
	! !


!EnteroMayorAUno methodsFor: 'private' stamp: 'DW 4/21/2022 21:35:20'!
divideAnEntero: anEnteroToDivide

	| greatestCommonDivisor numerator denominator |

	greatestCommonDivisor := anEnteroToDivide greatestCommonDivisorWith: self. 
	numerator := anEnteroToDivide // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.
	
	^ denominator divideCoprimeEntero: numerator.

	! !

!EnteroMayorAUno methodsFor: 'private' stamp: 'DW 4/25/2022 10:40:38'!
divideCoprimeEntero: anEntero
	^ Fraccion withReduced: anEntero overReduced: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'instance creation' stamp: 'DW 4/21/2022 20:46:59'!
incluyeA: anEntero
	^ anEntero > 1.! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'private' stamp: 'DW 4/21/2022 21:43:25'!
divideAnEntero: anEnteroToDivide

	^ anEnteroToDivide negated / self negated.! !

!EnteroNegativo methodsFor: 'private' stamp: 'DW 4/25/2022 10:40:30'!
divideCoprimeEntero: anEntero
	^ Fraccion withReduced: anEntero overReduced: self.! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'CMS 4/20/2022 16:13:30'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'instance creation' stamp: 'DW 4/21/2022 20:45:22'!
incluyeA: anEntero
	^ anEntero < 0.! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'CMS 4/20/2022 16:38:14'!
fibonacci
	^self! !


!Uno methodsFor: 'private' stamp: 'DW 4/21/2022 21:01:03'!
divideAnEntero: anEntero
	^ anEntero.! !

!Uno methodsFor: 'private' stamp: 'DW 4/21/2022 21:43:32'!
divideCoprimeEntero: anEntero
	^ anEntero.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'instance creation' stamp: 'DW 4/21/2022 20:47:09'!
incluyeA: anEntero
	^ anEntero = 1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DW 4/20/2022 14:35:57'!
* aMultiplier 
	
	 ^aMultiplier multiplyToFraccion: self. 
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DW 4/20/2022 14:26:38'!
+ anAdder 
	
	^anAdder addToFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DW 4/25/2022 11:10:48'!
- aSubtrahend

	^aSubtrahend subtractFromFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DW 4/20/2022 15:26:00'!
/ aDivisor 
	^aDivisor divideAFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'private' stamp: 'DW 4/20/2022 14:28:49'!
addToEntero: anEnteroToAddTo 
	
	^  numerator + (anEnteroToAddTo * denominator) / denominator.
	! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/20/2022 14:24:28'!
addToFraccion: aFraccionToAddTo 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionToAddTo denominator) + (denominator * aFraccionToAddTo numerator).
	newDenominator := denominator * aFraccionToAddTo denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/20/2022 15:27:00'!
divideAFraccion: aFraccionToDivide 
	^(denominator * aFraccionToDivide numerator) / (numerator * aFraccionToDivide denominator).! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/20/2022 15:13:44'!
divideAnEntero: anEnteroToDivide 

	^ denominator * anEnteroToDivide / numerator.
	! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/20/2022 14:32:56'!
multiplyToEntero: anEnteroToMultiplyTo 
	
	^numerator * anEnteroToMultiplyTo / denominator.
	! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/20/2022 14:35:45'!
multiplyToFraccion: aFraccionToMultiplyTo 
	
	^(numerator * aFraccionToMultiplyTo  numerator) / (denominator * aFraccionToMultiplyTo denominator)
	! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/25/2022 11:17:26'!
subtractFromEntero: anEnteroToSubtractFrom

	^   (anEnteroToSubtractFrom * denominator) - numerator / denominator.
	! !

!Fraccion methodsFor: 'private' stamp: 'DW 4/25/2022 11:26:45'!
subtractFromFraccion: aFraccionToSubtractFrom

	
	| newNumerator newDenominator |
	
	newNumerator := (denominator * aFraccionToSubtractFrom numerator) - (numerator * aFraccionToSubtractFrom denominator).
	newDenominator := denominator * aFraccionToSubtractFrom denominator.
	
	^newNumerator / newDenominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'DW 4/25/2022 10:39:51'!
withReduced: numerator overReduced: denominator
	"precondicion: los numeros son coprimos y distintos de uno. Es privada"
	
	^self new initializeWith: numerator over: denominator
	! !
