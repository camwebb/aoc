# Day 11

Part 2 beat me. I had to look at solutions on Reddit. Perhaps I should
have left Part 2 incomplete, but I wanted to see if I could get my
code to work with _other people’s solution_, so I did submit my answer
and get a star for it.

The puzzle text “You'll need to find another way to keep your worry
levels manageable” has an infinite number of algorithmic solutions!
But only one will give the example conformation at rounds 1, 20, 1000,
etc. Yet one cannot work backwards in this highly complex system to
deduce which solution is likely. And the conformation in the example
in Part 2 for round 1 and round 20 were different from the exmaple in
Part 1, so we were not even trying to keep the divisor math the same
while keeping the numbers from exploding.

I tried: dividing by numbers other than 3, reseting worry levels for
each item to initial values as they are transferred, tried resetting
worry levels at the end of each round, tried `(if wl > 100) wl = 100`,
etc.

If there was a ‘tip-off’ I might have picked up on, it was that after
a few (hundred) rounds, the output often showed a collapse of
distribution towards just two monkeys. This _might_ then have
suggested to me that the test numbers must at least have the
possibility of division by each of the four test-divisors. And that
might have led me to the solution of keeping the worry levels small by
modding them on the product of all the test-divisors. But for me there
are some huge leaps of luck in that. And I have no modulus math
knowledge.

So, overall this puzzle was ~impossible for me to solve. Which is a
frustrating recognition. And makes the whole competition less fun.


