function stairJumper(jumpsTaken: Array<number>, stairsLeft: number, permutations: Array<Array<number>>) {
    if (stairsLeft <= 0) {
        permutations.push(jumpsTaken)
        return 
    }

    if (stairsLeft >= 3) {
        stairJumper(jumpsTaken.concat([3]), stairsLeft-3, permutations)
    }
    if (stairsLeft >= 2) {
        stairJumper(jumpsTaken.concat([2]), stairsLeft-2, permutations)
    }
    if (stairsLeft >= 1) {
        stairJumper(jumpsTaken.concat([1]), stairsLeft-1, permutations)
    }
}

let perms = []
stairJumper([], 3, perms)
console.log(perms)
