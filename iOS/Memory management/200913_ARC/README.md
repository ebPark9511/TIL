# 200913 ARC

---


 ## 개념

- 개발자가 작성해야 했었던 메모리 해제 코드를 컴파일시에 적절하게 구문을 분석해 해제 코드를 삽입한다.


 ## strong, weak, unowned

* strong  

해당 래퍼런스에 대한 강한 참조를 유지한다.<br><br>


* weak

래퍼런스 카운터의 변화가 없다.

힙에서 어떤 메모리를 가리키고 있지만 힙에 없으면 nil로 리턴한다. (Optional 타입)<br><br>


* unowned

래퍼런스 카운터의 변화가 없다

해당 객체는 절대 nil일수 없다.<br><br>



## 메모리 누수 예시
 ```swift
 
 /* 예시 1) Delegate
 a. 자식 VC를 갖는 부모 VC가 있다.
 b. 부모 VC응 자식 VC를 대리하기 위하여 delegate를 자가 자신으로 설정한다.
 c. 부모 VC가 pop이 된다면. 
 메모리 상에서는 자식 VC와 부모 VC는 서로 강하게 참조하고 있는 상태이므로
 메모리는 해제 되지 않는다.

-> 해결책: delegate를 weak로 설정해둔다.
*/

weak var delegate: TestClass?

 /* 예시 2) Closure */
 
 
 class TestClass {
 var block : (()-> Void)? = nil
 var num = 5
 
 init(num: Int) {
    self.num = num
    block = { print(self.num) }
    }
}


var testClass = TestClass(nuM: 10)
testCalss = nil // deinit  미발생.


/* 위 경우.
block 인스턴스에서 self.num을 참조로 잡고 있어 nil로 세팅되어도
메모리 상에서는 서로 강하게 참조하고 있기 때문에 해제가 되지 않는다.


-> 해결책: 클로저 안의 참조하고 있는 프로퍼티들은 캡처하여 사용한다.
*/


block = { [weak self] in print(self?.num) }

```
        
