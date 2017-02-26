import Foundation

/*

 Hash Table
 
*/

// Q: What are ways to organize [[Element]]s when they get too large?
// A: When a bucket gets too large, add more buckets and recalculate keys to split between the new buckets

struct HashTable<Key: Hashable, Value> {
    typealias Element = (key: Key, value: Value)
    
    var buckets: [[Element]]
    
    init(capacity: Int) {
        buckets = [[Element]](repeating: [], count: capacity)
    }
    
    func indexForKey(key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }

    func valueForKey(key: Key) -> Value? {
        let index = indexForKey(key: key)
        
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        
        return nil
    }
    
    mutating func updateOrAddValue(value: Value, forKey key: Key) {
        let index = indexForKey(key: key)
        
        //Find the key in this bucket 
        for var element in buckets[index] {
            if element.key == key {
                element.value = value
                return
            }
        }
        
        //Is new element, add to chain
        buckets[index].append((key: key, value: value))
    }
    
    mutating func removeValueForKey(key: Key) -> Value? {
        let index = indexForKey(key: key)
        
        var count = 0
        for element in buckets[index] {
            if element.key == key {
                let oldValue = buckets[index][count].value
                buckets[index].remove(at: count)
                return oldValue
            }
            count += 1
        }
        
        return nil
    }
    
    subscript(key: Key) -> Value? {
        get {
            return valueForKey(key: key)
        }
        set {
            if let value = newValue {
                updateOrAddValue(value: value, forKey: key)
            }
            else {
                removeValueForKey(key: key)
            }
        }
    }
}

var hashTable = HashTable<String, String>(capacity: 5)
hashTable["firstName"] = "Steve"   // create
let x = hashTable["firstName"]     // read
hashTable["firstName"] = "Tim"     // update
hashTable["firstName"] = nil       // delete
