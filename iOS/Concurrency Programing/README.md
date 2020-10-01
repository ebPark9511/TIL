# 200908 동시성 프로그래밍.

---

## 개념


1) 동시성 프로그래밍 (싱글코어, 멀티코어)

        컨텐스트 스위치를 이용한 타임 슬라이스로 동시에 수행 되는 것처럼 보이는 기법.


2) 병렬성 프로그래밍 (멀티코어)

        실제로 두개 이상의 스레드가 동시에 처리되는 기법





## iOS 환경의 동시성 프로그래밍

iOS 환경에서 동시성 프로그래밍을 지원하는 종류는 3가지가 있다.


- GCD (Grand Central Dispatch) : 멀티 코어와 멀티 프로세싱 환경에서 최적화 된 프로그래밍을 할 수 있도록 애플이 개발한 기술.

- Operation Queue : 비동기적으로 수행되어야 하는 작업을 객체 지향적인 방법으로 사용한다. 내부적으로 GCD를 사용해 구현 되었다,

- Thread : 멀티 스레드 프로그래밍을 지원하기 위해 애플이 제공하는 Thread 클래스.





### 1) GCD

-  GCD는 앱이 블록 객체 (클로저) 형태로 작업을 전송할 수 있는 FIFO Queue를 제공하고 스케쥴링한다.
    
- Queue에 전달 된 작업은 시스템이 관리하는 스레드 풀에서 실행된다. (애플리케이션 레벨이 아닌 OS 레벨에서 처리.)
    
- 앱을 실행하면 시스템이 자동으로 메인 스레드 위에서 동작하는 Main Queue(Serial Queue)를 만들어 작업을 수행하고

    이외 여러개의 Global Queue(Concurrent Queue)를 만들어 Queue들을 관리한다.
  


```  

* Serial Queue: 큐에 추가 된 순서 대로 하나의 task를 처리한다. 
   
* Concurrent Queue: 큐에 추가 된 작업을 동시에 수행한다. 단 작업을 추가한 순으로 처리되는 것을 보장한다.

   작업은 순서에 관계 없이 완료 될 수 있으며 다음 작업 시작 시간이나 주어진 시간에 실행 중인 작업의 수를 알지 못한다.
   
   (코드 수준에서는 이를 신경 쓰면 안된다. (의도임)

```  


GCD에서 제공하는 Queue의 타입은 다음과 같다.

- Main Queue:  Serial Queue이며 메인 스레드 위에서 동작한다.

- Global Queue: Concurrent Queue이며 우선 순위에 따라 4개의 Queue가 존재한다. (high, default, low, background)

- Custom Queue: 커스텀으로 만드는 Queue. Serial일수도 Concurrent일수도 있지만. 모두 Global Queue에서 수행된다.


---

### **Global Queue의 Quality of Service Class**

어떤 작업을 멀티 스레딩으로 Concurrent 하게 처리시 Global-Queue에 작업을 추가한다.
이때 지정된 우선 순위에 따라 스케쥴링, CPU 및 I/O 처리량 타이머 대기시간으로 우선순위를 조절하게 된다.


```swift

struct DispatchQoS

```




1)  userInteractive 

즉각 반응, main thread에서 동작하는 UI 변경, 애니메이션 등 작업시에 들어간다.. 앱 실행시 해당 우선 순위로 할당된 작업은 많으면 안된다.
  _작업은 거의 순간에 실행되는 작업_
  
2)  userInitiated

사용자가 시작하고 즉각적인 결과가 필요한 작업, 저장된 문서를 열거나. 사용자가 UI에서 무언가를 클릭할 때 부여한다. 반응성과 성능에 중점을 준다.
  _작업은 거의 순간에 실행 되거나 몇초 혹은 그보다 빠른 작업._
  
3) utility

즉각적 결과가 필요치 않은 작업. 데이터 다운로드, 데이터 가져오기 등시. utility는 사용자가 볼 수 있는 진행상황(프로그래스 바)을 제공한다 반응성, 성능, 에너지 효율성간 균형을 둔다.
_작업은 몇초에서 몇분 정도 걸림._

4) Background

백그라운드에서 작동하며. 인덱싱, 동기화, 백업등 작업을 부여함. 에너지 효율성에 중점을 둔다. 
_작업은 분, 시간과 같이 상당한 시간이 든다._


 
 
 

### **Global Queue의 Special Quality of Service Class**


기본 유형 4가지 외에 특별한 2가지의 QoS가 있다.


1) default 

  userInitiated와 utility 사이 레벨임. 개발자가 분류 하기 위한 용도는 아니다. QoS가 지정되지 않을시 default를 갖게 되고 
  GCD Global Queue는 이 레벨에서 실행된다.

2) Unspectified

  QoS 정보가 없을을 시스템에게 준다. 해당 QoS 환경에서 추론 되어야 한다.


[Dispatch Queue 테스트](https://github.com/ebPark9511/TIL/blob/master/iOS/200908_Concurrency%20Programing/main.swift) 
 
<br><br><br><br>

---
### 2) Operation Queue
-  Objtive-C 기반, 비동기적인 작업을 캡슐화하는 객체 지향적인 방법
    
- 추가된 Operation 객체의 우선순위, 준비 상태에 따라 Operation Queue 대기열에 있는 객체를 처리한다.
    
- 작업이 추가 된 후에는 작업을 직접 제거하는 것이 불가능하다. (취소, 완료시에만 대기열에서 제거 된다.)<br><br>



#### 2-1) Operation
- 추상 클래스, 서브클래싱 하여 사용해야함. 이 클래스는 자체 서브 클래스에서 수행해야하는 작업의 양을 최소화 하기 위해 상당한 양의 인프라를 제공함.

- 이 외에 Foundation framework에서 그대로 사용 가능한 구체적인 하위 클래스도 제공한다.
<br><br>



#### ① NSInvocationOperation : 이미 task를 수행할 function이 정의 되어 있다면 selector방식으로 해당 function을 넘겨 Operation을 생성한다. (selector를 swift에서 미지원하므로. Obj-C에서만 가능.)
#### ② NSBlockOperation : 현재 하나 이상의 블록 객체를 동시에 수행한다. 전달된 모든 block의 수행이 완료되어야 해당 Operation이 완료된 것으로 간주한다.
  <br>
  <br>


모든 Operation 객체는 다음 기능을 지원함. <br>

- operation 객체간의 그래프 기반 종속성 설장 지원 이러한 종속성은 종속된 모든 operation이 완료되기 전까지 지정된 operation을 실행 되지 않게 함.
- 작업의 완료 후 실행 되는 블록 지원
- KVO로 값을 모니터링
- 작업 우선순위 지정 가능
- 작업 처리 중 cancel 체계 지원<br>

앱의 main 스레드에서 코드를 실행하는 대신

하나 이상의 operation 객체를 큐에 제출하고 하나 이상의 개별 스레드에서 작업을 비 동기적으로 처리 가능.<br><br>

### **Concurrent Versus Non-concurrent Operations**
 NSOperation의 isConcurrent(=isAsynchronous) 메서드는 start 메서드가 호출된 스레드와 관련하여 operation이 동기/비동기인지
실행 여부를 알려준다.(디폴트 값은 동기실행으로 false 리턴)<br><br>

개발자가 Concurrent Operation 객체를 직접 구현할 필요는 없음.
non concurrent Operation 객체를 Operation Queue에 제출시에도 해당 Operation을 실행할 스레드가 큐 자체에서 생성되어 비동기로 처리가 됨.<br><br>
(Operation Queue도 내부적으론 GCD를 이용하다보니 
GCD에서 제공하는 큐인 Concurrent Queue에 객체가 추가되어 non concurrent 여도 concurrent로 수행된다는 이야기인듯.)

operation을 직접 정의시에는 Operation Queue에 추가하지 않고.
비동기적으로 실행하는 경우에 필요함.<br>




### **BlockOperation**
하나 이상의 블록의 동시 실행을 관리하는 Operation의 하위 클래스임.
각 블록에 대해 별도의 Operation 객체를 만들 필용 없이.
여러 블록을 한번에 실행 가능함.
둘 이상의 블록을 실행할 때는 모든 블록이 실행을 마쳤을때만 작업 자체가 완료된것으로 간주 된다.

```swift 
 
let block1 = BlockOperation.init {
    for i in 1...3 {
        print("blockOperation1 test \(i)")
        sleep(1)
    }
}


let block2 = BlockOperation.init {
    for i in 1...3 {
        print("blockOperation2 test \(i)")
        sleep(1)
    }
}

 
//blockOperation1.start()
//blockOperation2.start()

block2.addExecutionBlock { // 블록의 추가
    print("추가했음!222")
}


// GCD의 DispatchQueue로 제출되어 비동기로 처리
let queue = OperationQueue()
queue.addOperations([block1, block2], waitUntilFinished:true)

// 위 block1, block2 작업이 모두 수행 되어야지만 하기 "완료!" 가 추가됨.
print("완료!")


//excuted result
//blockOperation1 test 1
//blockOperation2 test 1
//blockOperation2 test 2
//blockOperation1 test 2
//blockOperation2 test 3
//blockOperation1 test 3
//완료!
 
``` 

 





 

https://aroundck.tistory.com/4606
https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide
https://zeddios.tistory.com/510

