prolog './gj.ijs'
NB. j. ------------------------------------------------------------------

jdot =. 0j1&*

(j. -: jdot) 0.1*_500+?10 20$1000
(j. -: jdot) (?40$100)*^0j1*?40$100

a =. 0.1 * _500 + ?10 20$1000
b =. 0.1 * _500 + ?10 20$1000
(a j. b) -: a+0j1*b
(a j.&(^@j.) b) -: (^0j1*a)+0j1*^0j1*b
(3 j. b ) -: 3+0j1*b
(a j. _4) -: a+0j1*_4

a -: [ &. j. a

'domain error' -: j. etx 'abc'
'domain error' -: j. etx <'abc'
'domain error' -: j. etx u:'abc'
'domain error' -: j. etx <u:'abc'
'domain error' -: j. etx 10&u:'abc'
'domain error' -: j. etx <10&u:'abc'

'domain error' -: 'abc' j. etx 3
'domain error' -: 'abc' j.~etx 3
'domain error' -: 4     j. etx <'abc'
'domain error' -: 4     j.~etx <'abc'
'domain error' -: (u:'abc') j. etx 3
'domain error' -: (u:'abc') j.~etx 3
'domain error' -: 4     j. etx <u:'abc'
'domain error' -: 4     j.~etx <u:'abc'
'domain error' -: (10&u:'abc') j. etx 3
'domain error' -: (10&u:'abc') j.~etx 3
'domain error' -: 4     j. etx <10&u:'abc'
'domain error' -: 4     j.~etx <10&u:'abc'

'length error' -: 3 4   j. etx 5 6 7
'length error' -: 3 4   j.~etx 5 6 7
'length error' -: 3 4   j. etx i.3 4
'length error' -: 3 4   j.~etx i.3 4


NB. complex numbers -----------------------------------------------------

16     =  type 3j4
9j8    -: +/2j3 7j5
2j_3   -: +2j3

_5j_2  -: -/2j3 7j5
_2j_3  -: -2j3

_1j31  -: */2j3 7j5
(*2j3) -: (%|) 2j3
t      -: *t=.0 0j1 _1 0j_1 1

(29j11%74) -: %/2j3 7j5
(2j_3%13)  -: %2j3

NB. -0
a =. 1 % __  NB. -0
__ -: % a
a = 0.
__ __ -: % +. a j. a
_ __ -: % +. 0 j. a
__ _ -: % +. a j. 0
_ _ -: % +. 0 j. 0
1 = # ~. , % +. a j. 3 # a
2 = # ~. , % +. a j. 3 # 0.

f =: (j./"1@:(+"1) -: +&:(j./"1))  NB. test cmplx add.  Last axis must be length 2
f2 =: {{  NB. x iterations, max axis length y
 for. i. x do.
  rs =. 1 >. ? y  NB. max shape
  xs =. (- 0.2 0.5 0.2 _ I. ?0) }. rs [ ys =. (- 0.2 0.5 0.2 _ I. ?0) }. rs
  xd =: (xs,2) ?@$ 0 [ yd =: (ys,2) ?@$ 0
  assert. xd u yd
 end.
1
}}
1000 (f f2) 5 5 5 20
f =: (j./"1@:(-"1) -: -&:(j./"1))  NB. test cmplx add.  Last axis must be length 2
1000 (f f2) 5 5 5 20


4!:55 ;:'a b f f2 jdot t xd yd'



epilog''

