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

it ("stairJumperMemo", () => {
    expect(stairJumperMemo(0, 10, {})).toBe(274)
})


function waysToMakeChange(left: number): number {
    if (left < 0) {
        return 0 
    }

    if (left == 0) {
        return 1 
    }

    const coins = [1,5,10,25]
    let ways = coins.map((coin) => {
        return waysToMakeChange(left - coin)
    })

    return ways.reduce((accumulator, currentValue) => { return accumulator + currentValue }) 
}

it ("waysToMakeChange", () => {
    expect(waysToMakeChange(1)).toBe(1)
    expect(waysToMakeChange(5)).toBe(2)
    expect(waysToMakeChange(25)).toBe(916)
})

type KSItem = {
    weight: number
    value: number 
}

function valueForKSItems(items: Array<KSItem>): number {
    return items.reduce((accumulator, current) => { return accumulator + current.value}, 0)
}

function zeroToOneKnapsack(items: Array<KSItem>, maxWeight: number, soFar: Array<KSItem> = [], weight: number = 0): Array<KSItem> {
    if (weight > maxWeight) {
        return []
    }

    if (items.length == 0) {
        return soFar
    }

    const item = items[0]
    const newItems = items.slice(1)
    
    const withItem = zeroToOneKnapsack(newItems, maxWeight, soFar.concat(item), weight + item.weight)
    const withoutItem = zeroToOneKnapsack(newItems, maxWeight, soFar, weight)

    return (valueForKSItems(withItem) > valueForKSItems(withoutItem)) ? withItem : withoutItem
}

it ("zeroToOneKnapsack", () => {
    const items: Array<KSItem> = [
        {weight: 5, value: 1},
        {weight: 2, value: 2},
        {weight: 4, value: 5},
    ]
    expect(valueForKSItems(zeroToOneKnapsack(items, 9))).toEqual(7)
})