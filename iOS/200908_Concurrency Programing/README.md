# 200908 동시성 프로그래밍.

---

## 개념


1) 동시성 프로그래밍 (싱글코어, 멀티코어)

        컨텐스트 스위치를 이용한 타임 슬라이스로 동시에 수행 되는 것처럼 보이는 기법.


2) 병렬성 프로그래밍 (멀티코어)

        실제로 두개 이상의 스레드가 동시에 처리되는 기법





## iOS 환경의 동시성 프로그래밍

iOS 환경에서 동시성 프로그래밍을 지원하는 종류는 2가지가 있다.


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

Main Queue:  Serial Queue이며 메인 스레드 위에서 동작한다.

Global Queue: Concurrent Queue이며 우선 순위에 따라 4개의 Queue가 존재한다. (high, default, low, background)

Custom Queue: 커스텀으로 만드는 Queue. Serial일수도 Concurrent일수도 있지만. 모두 Global Queue에서 수행된다.

    

