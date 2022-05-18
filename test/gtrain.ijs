prolog './gtrain.ijs'
NB. (# i.@#) ------------------------------------------------------------

randuni''

NB. (# i.@#) y on boolean y is recognized as a special phrase by the interpreter

f=: # i.@#

g=: 3 : 0
 y # i.#y
  :
 x # i.#y
)

(f -: g) ?1e4$2
(f -: g) 1=?1e4$10
(f -: g) 1e4$1
(f -: g) 1e4$0
(f -: g) 0
(f -: g) 1
(f -: g) ,0
(f -: g) ,1

(f -: g) 2-1=?1e4$10
(f -: g) ?20$20
(f -: g) j./?2 20$20

(f -: g)&> #:&.> i.16 16
(f -: g)&> ? &.> (100+i.4 5)$&.>2

(f -: g) ?100$2
(f -: g) ?100$3
(f -: g) ?0$2
(f -: g) ?0$3
(f -: g) 0,100$1
(f -: g) 0,101$1
(f -: g) 0,102$1
(f -: g) 0,103$1
(f -: g) 0,104$1

(?200$5)      (f -:g) 200$'triskaidekaphobia'
(j./?2 200$5) (f -:g) 200$'triskaidekaphobia'
(?200$5)      (f -:g) 200$u:'triskaidekaphobia'
(j./?2 200$5) (f -:g) 200$u:'triskaidekaphobia'
(?200$5)      (f -:g) 200$10&u:'triskaidekaphobia'
(j./?2 200$5) (f -:g) 200$10&u:'triskaidekaphobia'

i=: 1e3 ? 1e9
b=: 1 i}1 $. 1e9 ; 0 ; 0
(/:~ i) -: (# i.@#) b


NB. ({ ,) --------------------------------------------------------------

f=: { ,
g=: 4 : 'x { , y'

(?*/$x)     (f -: g) x=: ?10 10 10$2
(?2 3$*/$x) (f -: g) x=: ?10 10 10$2

(?*/$x)     (f -: g) x=: ?7 11 13$2e9
(?2 3$*/$x) (f -: g) x=: ?7 11 13$2e9

(?*/$x)     (f -: g) x=: o.?2 3 5 7 11$2e6
(?2 3$*/$x) (f -: g) x=: o.?2 3 5 7 11$2e6

'index error' -: 29 ({,) etx i.2 3 4


NB. ({. ,) --------------------------------------------------------------

f=: {. ,
g=: 4 : 'x {. , y'

((- ?@+:)*/$x) (f -: g) x=: ?10 10 10$2
((- ?@+:)*/$x) (f -: g) x=: ?7 11 13$2e9
((- ?@+:)*/$x) (f -: g) x=: o.?2 3 5 7 11$2e6


NB. (}. ,) --------------------------------------------------------------

f=: }. ,
g=: 4 : 'x }. , y'

((- ?@+:)*/$x) (f -: g) x=: ?10 10 10$2
((- ?@+:)*/$x) (f -: g) x=: ?7 11 13$2e9
((- ?@+:)*/$x) (f -: g) x=: o.?2 3 5 7 11$2e6


NB. (e. ,) --------------------------------------------------------------

f=: e. ,
g=: 4 : 'x e. , y'

1        (f -: g) ?10 10 10$2
(?2 3$2) (f -: g) ?10 10 10$2
(?2 3$9) (f -: g) ?10 10 10$2

'x'            (f -: g) a.{~?10 10 10$#a.
(a.{~?2 3$#a.) (f -: g) a.{~?10 10 10$#a.
(?2 3$9)       (f -: g) a.{~?10 10 10$#a.

'x'            (f -: g) adot1{~?10 10 10$#adot1
(adot1{~?2 3$#adot1) (f -: g) adot1{~?10 10 10$#adot1
(?2 3$9)       (f -: g) adot1{~?10 10 10$#adot1

'x'            (f -: g) adot2{~?10 10 10$#adot2
(adot2{~?2 3$#adot2) (f -: g) adot2{~?10 10 10$#adot2
(?2 3$9)       (f -: g) adot2{~?10 10 10$#adot2


NB. adverb adverb trains ------------------------------------------------

b =: + ((1 : '/') \)
'/\' -: 5!:5 <'b'


4!:55 ;:'adot1 adot2 sdot0 b f g i x'
randfini''


epilog''

