# The Computer Science Classics

This is a collection of Algorithms, Puzzles, Design Patterns, Problems, and anything else that is essential enough to be deemed 'The Cannon' of computer science.

These are written in Swift 3, made in Xcode playgrounds. I chose Swift because I love the language, and I think it’s exceedingly clear to read. I don’t use most of the capabilities of Swift in order to document the concept as clearly and language agnostically possible.

Many things here are largely based around the very cool Swift Algorithm Club repo on GitHub.

TODOs

- Everything in the Searching playground
- https://github.com/raywenderlich/swift-algorithm-club/blob/master/Two-Sum%20Problem
- https://github.com/raywenderlich/swift-algorithm-club/blob/master/Monty%20Hall%20Problem
- https://github.com/raywenderlich/swift-algorithm-club/blob/master/Palindromes
- josephus problem
- compute prime factors
- Undo
- JSON parse
- compute factorials
- traveling salesman problem
- knapsack problem
- Dijkstra's algorithm
- https://github.com/raywenderlich/swift-algorithm-club/tree/master/Combinatorics
- https://github.com/raywenderlich/swift-algorithm-club/tree/master/Shunting%20Yard
- https://github.com/raywenderlich/swift-algorithm-club/tree/master/GCD
- Generally clean up some of the docs and add comments explaining concepts clearer. Reduce swift usage. Spelling.
- Better Readme

# Interview Tips

Planning
How does your brain go about doing it in an example? Vocalize and write down the steps. 
Sit down with it for 5-10 minutes to really build out a plan, thinking outside the box. 
What is an example of this happening in a real world program? 
What is the trick that will make this simple?
Will a sort help the situation?
Play around with it, how can you move or sort it? What would that expose? 
Generating every answer and counting them is probably not the most efficient. 
If you need to generate all permutations, do a part and then hand -1 off to recursion. This will be O(n!). Then use memoization to cache back to O(n)

During
Test every step 
Output a lot, take the time to have it do meaningful outputs 
Get the first case working with no loops, manually iterate if needed
Comment out blocks of code if you are unsure where something is not returning expected value
Save iterations to VS code 

Optimizing
Hashing is the most common way to avoid brute forcing something. 
When faced with a second internal loop, how can you cache the second loop?
