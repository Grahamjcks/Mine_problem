# Mine_problem

This project is fully created in pddl with incrementally more complex problems implementing A* in solving a multiple-goal maze problem. 
Note the pddl planner used cannot run on Mac without a shell.

To install the shell, I will link a separate repo.

##Original problem:
A mining robot is tasked with mining ores from an underground shaft and transporting them to a lift. 
The problem is solved when all ore has been successfully transported and mined. 
To get the ores, the robot must first clear any obstructions using a hammer, an item located on the map, and the robot has a maximum inventory of 1.
Once holding an ore, it must navigate to and turn on the lift. The problem definition is expandable, so any legal map consisting of adjacent
cell can be applied to the problem.

##problem hard:
I added additional ore, all of which are blocked by rock to the mine-map in which
the problem is still possible to solve. I also added additional cells, as it exponentially increased the search
space especially with additional adjacencies. Since the best-first search implemented by the ff planner
runs in O(n ∗ log(n)) at worst case without an evaluation function, the newer problem with double the
ore will be exponentially harder, as rather than evaluating out of a pool of n paths, it must now do so
with at least n ∗ (6! − 3!) without even consideration of the additional cells and moved hammer.

##cont.
