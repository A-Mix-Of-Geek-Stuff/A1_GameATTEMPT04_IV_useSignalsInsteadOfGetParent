extends Spatial
#Not an actual script!

#Problem: Character would stutter a few times when running into trees, or sometimes just running into nothing.

#SOLUTION:
#I lowered this entire level by -0.1 (y-axis).

#I assume the stuttering issue was caused by the character spawning in the game with their collision box intersecting slightly with the level's
#(I.e. character appeared in the game with their feet slightly in the ground).


