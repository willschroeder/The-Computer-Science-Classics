type TrieNode = {
    value?: string 
    parent?: TrieNode
    isWord: boolean
    children: {[letter: string]: TrieNode}
}

function print(val: any) {
    console.log(val)
}

function insert(root: TrieNode, word: String) {
    let node = root 

    while (word.length > 0) {
        let letter = word[0]

        if(!node.children[letter]) {
            node.children[letter] = {value: letter, isWord: false, children: {}, parent: node}
        }

        word = word.slice(1)
        node = node.children[letter]
    }

    node.isWord = true 
}

function find(root: TrieNode, word: String): TrieNode|undefined {
    let node = root 

    while(word.length > 0) {
        let letter = word[0]

        if (!node.children[letter]) {
            return 
        }

        word = word.slice(1)
        node = node.children[letter]
    }

    if (node.isWord) {
        return node 
    }
}

function contains(root: TrieNode, word: string): boolean {
    return find(root, word) !== undefined 
}

function remove(root: TrieNode, word: String) {
    let node = find(root, word)
    if (!node) {
        return 
    }
   
    node.isWord = false 

    while(node) {
        if (node.isWord || node.value == undefined) {
            return 
        }

        let letter = node.value
        node = node.parent 
        delete node!.children[letter]
    }
}

let root: TrieNode = {isWord: false, children: {}}

print(contains(root, "test"))

insert(root, "apple")
insert(root, "a")

print(contains(root, "apple"))
print(contains(root, "app"))
print(contains(root, "a"))

remove(root, "apple")
print(contains(root, "apple"))

export {}
