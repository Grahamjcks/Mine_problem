(define (domain mine-world5)
(:requirements :adl)

(:types 
    cell item minebot lift charger station - object
    ore hammer extinguisher - item
    bigore - largeitem
)


(:predicates
    (ObjectIn ?y - object ?where - cell)
    (Adjacent ?cell1 - cell ?cell2 - cell)
    (MinebotHolding ?who - minebot)
    (ItemHeld ?who - minebot ?what - item)
    (RockBlocking ?where - cell)
    (LiftOn ?lift - lift)
    (Mined ?what - ore)
    (LargeMined ?what - bigore)
    (IsFire ?location - cell)
    (LargeHolding ?who - minebot)
)

(:functions
    (battery-amount ?who - minebot)
    (battery-capacity)
    (oil-change ?who - minebot)
    (well-capacity)
)

(:action CHARGE
    :parameters (?who - minebot ?where - cell ?charger - charger)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?charger ?where) (< (battery-amount ?who) (battery-capacity)) (> (oil-change ?who) 1))
    :effect (and (assign (battery-amount ?who) (battery-capacity)) (decrease (oil-change ?who) 1)) 
)

(:action EMPTYMOVE
    :parameters (?who - minebot ?from - cell ?to - cell)
    :precondition (and (Adjacent ?from ?to) (ObjectIn ?who ?from) (not (MinebotHolding ?who)) (not (LargeHolding ?who)) (>= (battery-amount ?who) 1) (> (oil-change ?who) 1))
    :effect (and (ObjectIn ?who ?to) (not (ObjectIn ?who ?from)) (decrease (battery-amount ?who) 1) (decrease (oil-change ?who) 2))
)

(:action FULLMOVE
    :parameters (?who - minebot ?from - cell ?to - cell)
    :precondition (and (Adjacent ?from ?to) (ObjectIn ?who ?from) (MinebotHolding ?who) (>= (battery-amount ?who) 3) (> (oil-change ?who) 1))
    :effect (and (ObjectIn ?who ?to) (not (ObjectIn ?who ?from)) (decrease (battery-amount ?who) 3) (decrease (oil-change ?who) 3))
)

(:action PICKUP
    :parameters (?what - item ?where - cell ?who - minebot)
    :precondition (and (ObjectIn ?what ?where) (ObjectIn ?who ?where) (not (MinebotHolding ?who)) (not (LargeHolding ?who)) (not (RockBlocking ?where)) (> (oil-change ?who) 1))
    :effect (and (MinebotHolding ?who) (ItemHeld ?who ?what) (not (ObjectIn ?what ?where)) (decrease (oil-change ?who) 1))
)

(:action LARGEPICKUP
    :parameters (?what - largeitem ?where - cell ?firstwho - minebot ?secondwho - minebot)
    :precondition (and (ObjectIn ?what ?where) (ObjectIn ?firstwho ?where) (ObjectIn ?secondwho ?where) (not (MinebotHolding ?firstwho)) (not (MinebotHolding ?secondwho)) (not (LargeHolding ?firstwho)) (not (LargeHolding ?secondwho)) (not (RockBlocking ?where)) (> (oil-change ?firstwho) 1) (> (oil-change ?secondwho) 1) )
    :effect (and (LargeHolding ?firstwho) (LargeHolding ?secondwho) (not (ObjectIn ?what ?where)) (LargeHolding ?firstwho) (LargeHolding ?secondwho) (decrease (oil-change ?firstwho) 1) (decrease (oil-change ?secondwho) 1))
)

(:action LARGEPUTDOWN
    :parameters (?what - largeitem ?where - cell ?firstwho - minebot ?secondwho - minebot)
    :precondition (and (ObjectIn ?firstwho ?where) (ObjectIn ?secondwho ?where) (> (oil-change ?firstwho) 1) (> (oil-change ?secondwho) 1))
    :effect (and (ObjectIn ?what ?where) (not (LargeHolding ?firstwho)) (not (LargeHolding ?secondwho)) (decrease (oil-change ?firstwho) 1) (decrease (oil-change ?secondwho) 1))
)

(:action LARGEMINE
    :parameters (?firstwho - minebot ?secondwho - minebot ?what - bigore ?where - cell ?lift - lift)
    :precondition (and (ObjectIn ?firstwho ?where) (ObjectIn ?secondwho ?where) (ObjectIn ?lift ?where) (LiftOn ?lift) (LargeHolding ?firstwho) (LargeHolding ?secondwho) (> (oil-change ?firstwho) 1) (> (oil-change ?secondwho) 1))
    :effect (and (not (LargeHolding ?firstwho)) (not (LargeHolding ?secondwho)) (LargeMined ?what) (decrease (oil-change ?firstwho) 1) (decrease (oil-change ?secondwho) 1))
)

(:action TURNON
    :parameters (?who - minebot ?lift - lift ?where - cell)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?lift ?where) (> (oil-change ?who) 1))
    :effect (and (LiftOn ?lift) (decrease (oil-change ?who) 1))

)

(:action BREAK
    :parameters (?who - minebot ?what - hammer ?where - cell)
    :precondition (and (MinebotHolding ?who) (ItemHeld ?who ?what) (ObjectIn ?who ?where) (RockBlocking ?where) (> (oil-change ?who) 1))
    :effect (and (not (RockBlocking ?where)) (decrease (oil-change ?who) 1))
)

(:action MINE
    :parameters (?who - minebot ?what - ore ?where - cell ?lift - lift)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?lift ?where) (LiftOn ?lift) (ItemHeld ?who ?what) (MinebotHolding ?who) (> (oil-change ?who) 1))
    :effect (and (not (MinebotHolding ?who)) (not (ItemHeld ?who ?what)) (Mined ?what) (decrease (oil-change ?who) 1))
)

(:action PUTDOWN
    :parameters (?who - minebot ?what - item ?where - cell)
    :precondition (and (ItemHeld ?who ?what) (MinebotHolding ?who) (> (oil-change ?who) 1))
    :effect (and (ObjectIn ?what ?where) (not (MinebotHolding ?who)) (decrease (oil-change ?who) 1))
)

(:action EXTINGUISH
    :parameters (?who - minebot ?what - extinguisher ?firelocation - cell ?where - cell)
    :precondition (and (ObjectIn ?who ?where) (MinebotHolding ?who) (ItemHeld ?who ?what) (Adjacent ?where ?firelocation) (IsFire ?firelocation) (> (oil-change ?who) 1))
    :effect (and (not (IsFire ?firelocation)) (decrease (oil-change ?who) 1))
)

(:action CHANGEOIL
    :parameters (?who - minebot ?where - cell ?station - station)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?station ?where) (< (oil-change ?who) (well-capacity)))
    :effect (assign (oil-change ?who) (well-capacity)) 
)



)