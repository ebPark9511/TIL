//
//  main.swift
//  200907_method swizzling
//
//  Created by 박은비 on 2020/09/07.
//

import Foundation


// NSString.appending(_:) 함수를 method swizzling으로 교체할것임.
  
class SwizzlingTest {
    
    func swizzlingNSStringAppending() {
        
        let originalMethod = class_getInstanceMethod(NSString.self, #selector(NSString.appending(_:)))
        let swizzledMethod = class_getInstanceMethod(SwizzlingTest.self, #selector(ebparkAppending(_:)))

        guard let original = originalMethod,
            let swizzled = swizzledMethod else {
            return
        }

        method_exchangeImplementations(original, swizzled)
    }

    
    @objc func ebparkAppending(_ str: String) -> String{
        return "method swizzling ebpark \(str)"
    }
}




var str: NSString = "method swizzling!!"

str = str.appending("### origin") as NSString
print(str) // method swizzling!!### origin

let swizzlingTest = SwizzlingTest()
swizzlingTest.swizzlingNSStringAppending()


print(str.appending("### swizzling")) // method swizzling ebpark ### swizzling
