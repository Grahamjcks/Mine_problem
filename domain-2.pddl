(define (domain mine-world2)
(:requirements :adl)

(:types 
    cell item minebot lift charger - object
    ore hammer - item
)


(:predicates
    (ObjectIn ?y - object ?where - cell)
    (Adjacent ?cell1 - cell ?cell2 - cell)
    (MinebotHolding ?who - minebot)
    (ItemHeld ?who - minebot ?what - item)
    (RockBlocking ?where - cell)
    (LiftOn ?lift - lift)
    (Mined ?what - ore)
)

(:functions
    (battery-amount ?who - minebot)
    (battery-capacity)
)

(:action CHARGE
    :parameters (?who - minebot ?where - cell ?charger - charger)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?charger ?where) (< (battery-amount ?who) (battery-capacity)))
    :effect (assign (battery-amount ?who) (battery-capacity)) 
)

(:action EMPTYMOVE
    :parameters (?who - minebot ?from - cell ?to - cell)
    :precondition (and (Adjacent ?from ?to) (ObjectIn ?who ?from) (not (MinebotHolding ?who)) (>= (battery-amount ?who) 1))
    :effect (and (ObjectIn ?who ?to) (not (ObjectIn ?who ?from)) (decrease (battery-amount ?who) 1))
)

(:action FULLMOVE
    :parameters (?who - minebot ?from - cell ?to - cell)
    :precondition (and (Adjacent ?from ?to) (ObjectIn ?who ?from) (MinebotHolding ?who) (>= (battery-amount ?who) 3))
    :effect (and (ObjectIn ?who ?to) (not (ObjectIn ?who ?from)) (decrease (battery-amount ?who) 3))
)

(:action PICKUP
    :parameters (?what - item ?where - cell ?who - minebot)
    :precondition (and (ObjectIn ?what ?where) (ObjectIn ?who ?where) (not (MinebotHolding ?who)) (not (RockBlocking ?where)) )
    :effect (and (MinebotHolding ?who) (ItemHeld ?who ?what) (not (ObjectIn ?what ?where)))
)

(:action TURNON
    :parameters (?who - minebot ?lift - lift ?where - cell)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?lift ?where))
    :effect (and (LiftOn ?lift))

)

(:action BREAK
    :parameters (?who - minebot ?what - hammer ?where - cell)
    :precondition (and (MinebotHolding ?who) (ItemHeld ?who ?what) (ObjectIn ?who ?where) (RockBlocking ?where))
    :effect (and (not (RockBlocking ?where)))
)

(:action MINE
    :parameters (?who - minebot ?what - ore ?where - cell ?lift - lift)
    :precondition (and (ObjectIn ?who ?where) (ObjectIn ?lift ?where) (LiftOn ?lift) (ItemHeld ?who ?what) (MinebotHolding ?who))
    :effect (and (not (MinebotHolding ?who)) (not (ItemHeld ?who ?what)) (Mined ?what))
)

(:action PUTDOWN
    :parameters (?who - minebot ?what - item ?where - cell)
    :precondition (and (ItemHeld ?who ?what) (MinebotHolding ?who))
    :effect (and (ObjectIn ?what ?where) (not (MinebotHolding ?who)))
)
)