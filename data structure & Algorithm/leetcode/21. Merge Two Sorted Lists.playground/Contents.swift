  
  // 두 개의 정렬 된 연결 목록을 병합하고 새로운 정렬 된 목록으로 반환합니다. 새 목록은 처음 두 목록의 노드를 연결하여 만들어야합니다.
//  Input: 1->2->4, 1->3->4
//  Output: 1->1->2->3->4->4
  
// linkedList
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

 

// 두 개의 정렬 된 연결 목록을 병합하고 새로운 정렬 된 목록으로 반환합니다. 새 목록은 처음 두 목록의 노드를 연결하여 만들어야합니다.
class Solution {
    var head: ListNode?
    var mergeList: ListNode?
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil, l2 == nil { return head }
        
        var l1 = l1
        var l2 = l2
        var appendNode: ListNode? = nil
        
        if l1 != nil && l2 == nil {
            appendNode = l1
            l1 = l1?.next
        } else if l1 == nil && l2 != nil {
            appendNode = l2
            l2 = l2?.next
        } else {
            let l1Val = l1?.val ?? 0
            let l2Val = l2?.val ?? 0
            
            if l1Val < l2Val {
                appendNode = l1
                 
                l1 = l1?.next
            } else {
                appendNode = l2
                l2 = l2?.next
            }
              
        }
          
        if mergeList == nil {
            mergeList = ListNode(appendNode!.val)
            head = mergeList
        } else {
            if mergeList?.next != nil {
                mergeList = mergeList?.next
            }
            
            mergeList?.next = ListNode(appendNode!.val)
            
        }
        return mergeTwoLists(l1, l2)
         
    }
}

  
let sol = Solution()
  
  let l1 = ListNode(1)
  l1.next = ListNode(2)
  l1.next?.next = ListNode(4)
  
  
  let l2 = ListNode(1)
  l2.next = ListNode(3)
  l2.next?.next = ListNode(4)
  

  print("----")
  
  var n3 = sol.mergeTwoLists(l1, l2)
  
  print("----")
  
  while n3 != nil {
    print(n3?.val ?? -99)
    n3 = n3?.next
  }
