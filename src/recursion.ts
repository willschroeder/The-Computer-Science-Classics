export {}

/*
 O(3 ^ n)
 3 Branches run for each number of stairs, every time it needs to be calculated
*/
function stairJumper(jumpsTaken: Array<number>, stairsLeft: number, permutations: Array<Array<number>>) {
    if (stairsLeft < 0) {
        return 
    }
    if (stairsLeft == 0) {
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

it ("stairJumper", () => {
    let perms: Array<Array<number>> = []
    stairJumper([], 10, perms)
	expect(perms.length).toBe(274)
})

/*
O(n)
3 different branches * stairs = 3n
Multiplied instead of power because the value is cached, and each branch wont recalculate the value
*/
function stairJumperMemo(jumpsTaken: number, stairsLeft: number, memo: {[stairsLeft: number]: number}): number {
    if (stairsLeft == 0) {
        return 1
    }
    if (stairsLeft < 0) {
        return 0 
    }

    let count = 0
    for (let i = 1; i < 3+1; i++) {
        if (memo[stairsLeft-i]) {
            count += memo[stairsLeft-i] 
        }
        else {
            let got = stairJumperMemo(jumpsTaken + i, stairsLeft-i, memo)
            // console.log(`memo ${stairsLeft-i}: ${got}`)
            memo[stairsLeft-i] = got 
            count += got  
        }
    }

    return count 
}

it ("stairJumper", () => {
    expect(stairJumperMemo(0, 10, {})).toBe(274)
})


