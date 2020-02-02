type BSTNode = {
    value: number 
    left?: BSTNode
    right?: BSTNode
}

function print(val: any) {
    console.log(val)
}

function insert(root: BSTNode, val: number) {
    print(val)
}

function inOrderPrint(root: BSTNode) {

}

// function depthFirstSearch(root: BSTNode, val: number): boolean {

// }

// function breadthFirstSearch(root: BSTNode, val: number): boolean {

// }

// function validTree(root: BSTNode): boolean {

// }

// function firstCommonNode(x: number, y: number): BSTNode {

// }

// function remove(root: BSTNode, val: number) {

// }

//             7
//            /  \
//           6    8
//          /      \
//        2         9
//       /  \
//      1    4
//          /  \
//         3    5

// for i in [6,8,9,2,1,4,3,5] {
//     bst.insert(value: i)
// }

let root: BSTNode = {value: 7}
const a = [6,8,9,2,1,4,3,5].map((val: number) => {
    insert(root, val)
})


