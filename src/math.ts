export {}

function pow(val: number, exp: number): number {
    if (exp === 0) {
        return 1 
    }
    
    const isNegative = exp < 0
    if (isNegative) {
        exp *= -1
    }

    let total = val
    for (let i = 1; i < exp; i++) {
        total = total * val 
    }

    if (isNegative) {
        total = 1 / total 
    }

    return total 
}

it("pow", () => {
    expect(pow(5,5)).toBe(3125)
    expect(pow(-5,5)).toBe(-3125)
    expect(pow(5,-5)).toBe(0.00032)
    expect(pow(8,1)).toBe(8)
    expect(pow(5,0)).toBe(1)
})

