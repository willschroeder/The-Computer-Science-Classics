type BSTNode = {
    value: number 
    parent?: BSTNode
    left?: BSTNode
    right?: BSTNode
}

function print(val: any) {
    console.log(val)
}

// O(log n)
function insert(root: BSTNode, val: number) {
    if (val > root.value) {
        if (!root.right) {
            root.right = {value: val, parent: root}
        }
        else {
            insert(root.right, val)
        }
    }
    else {
        if(!root.left) {
            root.left = {value: val, parent: root}
        }
        else {
            insert(root.left, val)
        }
    }
}

// O(n)
function inOrder(root: BSTNode, arr: Array<number>) {
    if (root.left) {
        inOrder(root.left, arr)
    }
    arr.push(root.value)
    if (root.right) {
        inOrder(root.right, arr)
    }
}

// O(log n) if tree is balanced, worse case is O(n)
function depthFirstSearch(root: BSTNode, val: number): BSTNode|undefined {
    if (root.value == val) {
        return root 
    }

    if (val < root.value && root.left) {
        return depthFirstSearch(root.left, val)
    }

    if (val > root.value && root.right) {
        return depthFirstSearch(root.right, val)
    }
}

// O(n) as it takes no advantage of the tree being balanced
function breadthFirstSearch(root: BSTNode, val: number): boolean {
    let arr: Array<BSTNode> = [root]
    
    while (arr.length > 0) {
        const node = arr.shift()!
        if (node.value == val) {
            return true 
        }

        if (node.left) {
            arr.push(node.left)
        }

        if (node.right) {
            arr.push(node.right)
        }
    }

    return false 
}

// O(n)
function depth(root: BSTNode): number {
    if (!root.left && !root.right) {
        return 1 
    }

    let leftDepth = 0
    if (root.left) {
        leftDepth = depth(root.left)
    }

    let rightDepth = 0 
    if (root.right) {
        rightDepth = depth(root.right)
    }

    return Math.max(leftDepth, rightDepth) + 1
}

// O(n)
function validTree(root: BSTNode, min: number, max: number): boolean {
    if (root.value > min && root.value < max) {
        let leftValid = true 
        if(root.left) {
            leftValid = validTree(root.left, min, root.value)
        }

        let rightValid = true 
        if (root.right) {
            rightValid = validTree(root.right, root.value, max)
        }
        
        return leftValid && rightValid
    }

    return false 
}

// O(n) as if the tree is just right nodes, you would have to get every one 
function pathToRoot(node: BSTNode): Array<BSTNode> {
    let seeker: BSTNode|undefined = node 
    let arr = []
    while (seeker) {
        arr.push(seeker)
        seeker = seeker.parent
    }
    return arr 
}

// O(n)
function firstCommonNode(root: BSTNode, x: number, y: number): BSTNode|undefined {
    let xNode = depthFirstSearch(root, x) // log n 
    let yNode = depthFirstSearch(root, y) // log n 

    if (!xNode || !yNode) {
        throw "X or Y value not found"
    }

    let xPath = pathToRoot(xNode) // n 
    let yPath = pathToRoot(yNode) // n 
    let lastCommonNode: BSTNode|undefined = xPath[0]

    while(xPath.length > 0 && yPath.length > 0) { // n 
        const xPop = xPath.pop() // 1
        const yPop = yPath.pop() // 1

        if (xPop?.value != yPop?.value) {
            return lastCommonNode
        }
        else {
            lastCommonNode = xPop
        }
    }
}

function remove(root: BSTNode, val: number) {
    // TODO 
    // If has no children, set parent's link to undefined
    // If left OR right, connect parent's link to child node
    // If left AND right, find the left most (smallest) node, unlink it, and replace self with node
        // Left & Right nodes are hooked up differently
}

//             7
//            /  \
//           6    8
//          /      \
//        2         9
//       /  \
//      1    4
//          /  \
//         3    5

let root: BSTNode = {value: 7}
const a = [6,8,9,2,1,4,3,5].map((val: number) => {
    insert(root, val)
})

print("In order print")
let arr: Array<number> = []
inOrder(root, arr)
print(arr)

print("DFS")
print(depthFirstSearch(root, 4)?.value)
print(depthFirstSearch(root, 55)?.value)

print("BFS")
print(breadthFirstSearch(root, 4))
print(breadthFirstSearch(root, 55))

print("Depth")
print(depth(root))

print("Valid Tree")
print(validTree(root, -100, 100))

print("Path to root")
let findFrom = depthFirstSearch(root, 3)!
print(pathToRoot(findFrom).map((i: BSTNode) => {return i.value}))

print("Common Node")
print(firstCommonNode(root,1,5)?.value)

export {}
