(define (problem problem4-problem)
    (:domain mine-world4)

(:objects 
c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 c16 c17 c18 c19 c20 c21 c22 c23 - cell
Minebot1 - minebot
Minebot2 - minebot
Hammer - hammer
A B C - ore
D - bigore
Lift - lift
Charger - charger
Extinguisher - extinguisher
)

(:init
(= (battery-capacity) 40)

; minebot1 is in cell c17
(ObjectIn Minebot1 c17)
; minebot2 is in cell c17
(ObjectIn Minebot2 c4)
; ore is in cell c1, c3, c10
(ObjectIn A c1) (ObjectIn B c3) (ObjectIn C c10)
; rock is in cell c3, c8, c10, c13
(RockBlocking c1) (RockBlocking c10) (RockBlocking c3) (RockBlocking c13)
; hammer is in cell c8
(ObjectIn Hammer c8)
; lift is in cell c23
(ObjectIn Lift c23)
; charger is in cell c12
(ObjectIn Charger c12)
; fire is in cell c7, extinguisher is in cell c14
(IsFire c7)
(ObjectIn Extinguisher c14)
;bigore  in c13
(ObjectIn D c13)
; cell a isAdjacent cell b
(Adjacent c2 c3) (Adjacent c2 c7) (Adjacent c7 c11) (Adjacent c11 c12)
(Adjacent c11 c17) (Adjacent c13 c14) (Adjacent c14 c15) (Adjacent c15 c16)
(Adjacent c16 c17) (Adjacent c17 c19) (Adjacent c19 c22) (Adjacent c22 c21)
(Adjacent c21 c23) (Adjacent c20 c21) (Adjacent c18 c20) (Adjacent c15 c18)
(Adjacent c9 c13) (Adjacent c8 c9) (Adjacent c4 c9) (Adjacent c4 c5)
(Adjacent c5 c6) (Adjacent c1 c5) (Adjacent c6 c10) (Adjacent c10 c15)

(Adjacent c3 c2) (Adjacent c7 c2) (Adjacent c11 c7) (Adjacent c12 c11)
(Adjacent c17 c11) (Adjacent c14 c13) (Adjacent c15 c14) (Adjacent c16 c15)
(Adjacent c17 c16) (Adjacent c19 c17) (Adjacent c22 c19) (Adjacent c21 c22)
(Adjacent c23 c21) (Adjacent c21 c20) (Adjacent c20 c18) (Adjacent c18 c15)
(Adjacent c13 c9) (Adjacent c9 c8) (Adjacent c9 c4) (Adjacent c5 c4)
(Adjacent c6 c5) (Adjacent c5 c1) (Adjacent c10 c6) (Adjacent c15 c10)
)

(:goal 
    (and
    (Mined A)
    (Mined B)
    (Mined C)
    (not (IsFire c7))
    (LargeMined D)
))
)
