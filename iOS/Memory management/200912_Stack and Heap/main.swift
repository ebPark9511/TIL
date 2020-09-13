//
//  main.swift
//  200912_Staack and Heap
//
//  Created by 박은비 on 2020/09/12.
//

import Foundation
 
class CallByRef {
    var n1: Int?
}

struct CallByVal {
    var n1: Int
    var n2: Int
}



var valTest = CallByVal(n1: 2, n2: 3)
let reValTest = valTest
var refTest = CallByRef()
var reRefTest = refTest

 
//Stack에는 다른 주소 값을 갖고, 실제로는 값으로 할당되어 있다.
//0x00007ffeefbff468
//0x00007ffeefbff450
//refTest    _00912_Staack_and_Heap.CallByRef    0x0000000103063400
//reRefTest    _00912_Staack_and_Heap.CallByRef    0x0000000103063400
withUnsafePointer(to: valTest) { Pa in print(Pa) }
withUnsafePointer(to: reValTest) { Pa in print(Pa) }


// Stack에는 다른 주소값을 갖고 있지만 Heap에서 참조하는 인스턴스는 같다.
//0x00007ffeefbff430
//0x00007ffeefbff410
//refTest    _00912_Staack_and_Heap.CallByRef    0x0000000103063400
//reRefTest    _00912_Staack_and_Heap.CallByRef    0x0000000103063400
withUnsafePointer(to: refTest) { Pa in print(Pa) }
withUnsafePointer(to:  reRefTest) { Pa in print(Pa) }
 
