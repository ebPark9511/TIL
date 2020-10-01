//
//  main.swift
//  200908_ConCurrency Programing
//
//  Created by 박은비 on 2020/09/08.
//

import Foundation



// MARK: - GCD

// 출처: https://rhammer.tistory.com/324 [고무망치의 Dev N Life]
/*
 글로벌 큐의 우선순위 확인해보기.
 
 1->2->3->6->5->4
 */

class GCDTest {
    func run() {
        DispatchQueue.global().sync {
            print("1")
        }
        
        print("2")
        
        DispatchQueue.global().sync {
            /*
             sync이기 때문에 1->2->3을 보장한다.
             처리되는 동안 다른 작업을 진행하지 않는다.
             */
            sleep(2)
            print("3")
        }
        
        DispatchQueue.global(qos: .background).async {
            print("4")
        }
        
        DispatchQueue.global(qos: .userInteractive).async { // 우선순위
            print("5")
        }
        
        
        print("6")
        
        
        /*
         Custom Queue 만들어보기
         
         
         생성자.
         convenience init
         (label: String,
         qos: DispatchQoS = default,
         attributes: DispatchQueue.Attributes = default, // DispatchQueue.Attributes의 default는 Serial Queue다.
         autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = default,
         target: DispatchQueue? = default)
         */
        
        let queue1 = DispatchQueue(label: "queue1", qos: .background) // Serial Queue (메인 스레드에 생성되는 시리얼 큐 외에는 글로벌 큐에서 처리되기 때문에 qos 지정가능.)
        let queue2 = DispatchQueue(label: "queue2",qos: .background, attributes: .concurrent)
        let queue3 = DispatchQueue(label: "queue3",qos: .userInteractive, attributes: .concurrent)
        
        print("Custom Queue Test 1")
        //Custom Queue Test 1 -> 5 -> 4 -> 2 -> 3
        
        
        //어싱크여도 시리얼 큐이기 때문에 2->3 보장됨
        queue1.async {
            sleep(2)
            print("2")
        }
        queue1.async {
            print("3")
        }
        
        
        queue2.async {
            print("4")
        }
        
        queue3.sync { // 가장 우선순위가 높은 디스패치 큐기때문ㅁ에 5가 먼저 수행
            print("5")
        }
        
        
        
        
        sleep(10)
    }
    
}


// MARK: - Operation Queue
/* BlockOperation
 하나 이상의 블록의 동시 실행을 관리하는 Operation의 하위 클래스임.
 각 블록에 대해 별도의 Operation 객체를 만들 필용 없이.
 여러 블록을 한번에 실행 가능함.
 둘 이상의 블록을 실행할 때는 모든 블록이 실행을 마쳤을때만 작업 자체가 완료된것으로 간주된다.
  */


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


// waitUntilFinished? 작업객체가 작업을 완료할때까지 타 작업을 수행하지 않음.
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

 
