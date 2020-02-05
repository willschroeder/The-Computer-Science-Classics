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

let perms = []
stairJumper([], 10, perms)
console.log(perms.length)

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

console.log(stairJumperMemo(0, 10, {}))