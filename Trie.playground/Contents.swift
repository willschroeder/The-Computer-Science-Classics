/*
 
 Trie 
 
 Good for dictionary lookups
 This is a tree
 
 Each node has 26 nodes mapped to a letter, pointing to subnodes
 This creates a chain to a final destination, which has some kind of meaningful value.
 B -> A -> T (word) -> H -> S (word)
      |
      S
      |
      S (word)
*/


//https://github.com/raywenderlich/swift-algorithm-club/tree/master/Trie
//https://github.com/raywenderlich/swift-algorithm-club/blob/master/Trie/Trie.playground/Sources/Trie.swift

class Node {
    var value: Character?
    weak var parent: Node?
    var children: [Character: Node] = [:]
    var isAWord = false
    
    init() {}
    
    init(value: Character, parent: Node? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child: Character) {
        guard children[child] == nil else { return }
        children[child] = Node(value: child, parent: self)
    }
}

class Trie {
    let root = Node()
    
    func insert(word: String) {
        if word.isEmpty { return }
        var currentNode = root
        
        var characters = Array(word.lowercased().characters)
        var characterIndex = 0
        
        //Start traversing though the existing tree, using each character to determine the next node
        while characterIndex < characters.count {
            let character = characters[characterIndex]
            
            //If there is a node for this character, access it
            if let child = currentNode.children[character] {
                currentNode = child
            }
            //Otherwise, we need to make one, and assign it the current character
            else {
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
            
            characterIndex += 1
        }
        
        //We have now either traversed or created the node for the last character, so its a word
        currentNode.isAWord = true
    }
    
    func contains(word: String) -> Bool {
        if word.isEmpty { return false }
        var currentNode = root
        
        var characters = Array(word.lowercased().characters)
        var characterIndex = 0
        
        //Works the same as above, except if we don't have a node for a character, we don't have the word
        while characterIndex < characters.count {
            if let child = currentNode.children[characters[characterIndex]] {
                currentNode = child
                characterIndex += 1
            }
            else {
                return false
            }
        }
        
        //We may not have marked this as a word, even if we have the nodes for it
        return currentNode.isAWord
    }
    
    func remove(word: String) {
        if word.isEmpty { return }
        var currentNode = root

        var characters = Array(word.lowercased().characters)
        var characterIndex = 0
        
        //Traverse to the end, if we are unable to reach it, we never had this word to begin with
        while characterIndex < characters.count {
            guard let child = currentNode.children[characters[characterIndex]] else { return }
            currentNode = child
            characterIndex += 1
        }
        
        //This node has children that depend on it, so it can't be removed. We can unmark it as a word though.
        if currentNode.children.count > 0 {
            currentNode.isAWord = false
        }
        //Otherwise, we can remove nodes moving backwards until we reach one that isn't a word
        else {
            var characterToRemove = currentNode.value
            //Until we reach the end of the beginning of the word, or we find a node thats is a word
            while currentNode.children.count == 0 {
                //While we can still get a parent that isnt a word...
                if let parent = currentNode.parent, parent.isAWord == false {
                    //move the current node up to the parent, and delete the child
                    currentNode = parent
                    currentNode.children[characterToRemove!] = nil
                    characterToRemove = currentNode.value
                }
                else {
                    //We found a word
                    break
                }
            }
        }
    }
}

let trie = Trie()

trie.contains(word: "test")

trie.insert(word: "apple")
trie.insert(word: "ap")
trie.insert(word: "a")

trie.contains(word: "apple")
trie.contains(word: "ap")
trie.contains(word: "a")

trie.remove(word: "apple")
trie.contains(word: "a")
trie.contains(word: "apple")

trie.insert(word: "apple")
trie.contains(word: "apple")