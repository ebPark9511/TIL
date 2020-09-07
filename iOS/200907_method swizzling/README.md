# 200907 Method Swizzling
---

런타임 시 원래의 메서드를 원하는 메서드로 바꿔 사용할 수 있다.

(Obj-C 런타임 기능이다.)



```swift 

class SwizzlingTest { 
    func swizzlingNSStringAppending() {
        
        let originalMethod = class_getInstanceMethod(NSString.self, #selector(NSString.appending(_:)))
        let swizzledMethod = class_getInstanceMethod(SwizzlingTest.self, #selector(ebparkAppending(_:)))
        // mehtod를 #selector로 찾아 가져온다.

        guard let original = originalMethod,
            let swizzled = swizzledMethod else {
            return
        }

        method_exchangeImplementations(original, swizzled)
        // 가져온 메서드를 상기 함수를 이용하여 바꿔준다.
    }

    
    @objc func ebparkAppending(_ str: String) -> String{
        return "method swizzling ebpark \(str)"
    }
}

``` 

런타임에 swizzlingNSStringAppending() 메서드를 수행시 NSString.appending 함수는

내가 구현한 ebparkAppending으로 교체된다.



```swift 

var str: NSString = "method swizzling!!" 
str = str.appending("### origin") as NSString

print(str) // method swizzling!!### origin


let swizzlingTest = SwizzlingTest() 
swizzlingTest.swizzlingNSStringAppending()
 
print(str.appending("### swizzling")) // method swizzling ebpark ### swizzling

 
``` 

 
 
 ### 주의사항.
 
 - 스위즐링한 메서드를 또 스위즐링 하지 않는지 체크 필요함.
 
 - 최신 iOS 가 올라올 시 동작 여부 체크 필요함.
 
 - 스위즐링을 하려는 경우. 앱 개발자가 무엇을 스위즐링 하고 있는지 정확히 알고 있어야 한다.
