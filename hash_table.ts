export {}

type HashTable = {
    a: Array<Array<HashValue>>
    size: number
}

type HashValue = {
    key: string 
    value: string 
}

// https://github.com/darkskyapp/string-hash/blob/master/index.js
function hashStr(str: string) {
    var hash = 5381 
    var i = str.length

    while(i) {
      hash = (hash * 33) ^ str.charCodeAt(--i)
    }
  
    return hash >>> 0
}

function slotForKey(key: string, size: number): number {
    return hashStr(key) % size
}

// O(1) slot lookup, O(n) if collision if having to search though slot
function findHashValueIndex(a: Array<HashValue>, key: string): number {
    if (a.length == 0) {
        return -1 
    }

    for (let i = 0; i < a.length; i++) {
        if (a[i].key == key) {
            return i 
        }
    }

    return -1
}

// O(1) slot lookup, O(1) amortized to push value
function set(hash: HashTable, key: string, value: string) {
    let slotIndex = slotForKey(key, hash.size)
    let slotListIndex = findHashValueIndex(hash.a[slotIndex], key)

    if (slotListIndex > -1) {
        hash.a[slotIndex][slotListIndex].value = value 
    }
    else {
        hash.a[slotIndex].push({key: key, value: value})
    }
}

// O(1)
function get(hash: HashTable, key: string): string|undefined {
    let slotIndex = slotForKey(key, hash.size)
    let slotListIndex = findHashValueIndex(hash.a[slotIndex], key)

    if (slotListIndex > -1) {
        return hash.a[slotIndex][slotListIndex].value
    }
} 

// O(1)
function del(hash: HashTable, key: string) {
    let slotIndex = slotForKey(key, hash.size)
    let slotListIndex = findHashValueIndex(hash.a[slotIndex], key)

    if (slotListIndex > -1) {
        hash.a[slotIndex].splice(slotListIndex, 1)
    }
}

function hashTableConstructor(size: number): HashTable {
    const hash: HashTable = {a: [], size: size}
    for(let i = 0; i < size; i++) {
        hash.a[i] = []
    }
    return hash 
}

it ("Hash Table", () => {
    const hash = hashTableConstructor(10)
    set(hash, "foo", "bar")
    expect(get(hash, "foo")).toBe("bar")
    set(hash, "foo", "other")
    expect(get(hash, "foo")).toBe("other")
    del(hash, "foo")
    expect(get(hash, "foo")).not.toBeDefined()
})

it ("Hash Table One Slot", () => {
    const smallHash = hashTableConstructor(1)
    set(smallHash, "foo", "bar")
    set(smallHash, "test", "lol")
    expect(get(smallHash, "foo")).toBe("bar")
    expect(get(smallHash, "test")).toBe("lol")

    del(smallHash, "foo")
    expect(get(smallHash, "foo")).not.toBeDefined()
})
