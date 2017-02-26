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

class Node {
    var value: Character?
    weak var parent: Node?
    var children: [Character: Node] = [:] // A hashmap holding a char(key) to a node(value)
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
        var i = 0
        
        //Start traversing though the existing tree, using each character to determine the next node
        while i < characters.count {
            let character = characters[i]
            
            //If there is a node for this character, access it
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            }
                
            //Otherwise, we need to make one, and assign it the current character
            else {
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
            
            i += 1
        }
        
        //We have now either traversed or created the node for the last character, so its a word
        currentNode.isAWord = true
    }
    
    func contains(word: String) -> Node? {
        if word.isEmpty { return nil }
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
                return nil
            }
        }
        
        //We may not have marked this as a word, even if we have the nodes for it
        return currentNode.isAWord ? currentNode : nil
    }
    
    func remove(word: String) {
        if word.isEmpty { return }
        
        var currentNode = contains(word: word)!
        currentNode.isAWord = false
        
        //Remove until we hit root or a word
        while
            currentNode !== root,
            currentNode.children.count == 0,
            !currentNode.isAWord {
                
            let characterToRemove = currentNode.value
            currentNode = currentNode.parent!
            currentNode.children[characterToRemove!] = nil
        }
    }
}

let trie = Trie()

trie.contains(word: "test")

trie.insert(word: "apple")
trie.insert(word: "ap")
trie.insert(word: "a")

trie.contains(word: "apple")?.value
trie.contains(word: "ap")?.value
trie.contains(word: "a")?.value

trie.remove(word: "apple")
trie.contains(word: "a")?.value
trie.contains(word: "apple")?.value

trie.insert(word: "apple")
trie.contains(word: "apple")?.value
