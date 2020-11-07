//
//  main.swift
//  vending machine
//
//  Created by 은비 on 2020/11/05.
//

import Foundation
 
/*
 프로젝트로 만들 것은 음료수 자동판매기 입니다.
 음료수는 콜라, 사이다, 환타 세 종류로 한정하고,
 사용할 수 있는 지폐는 100원, 500원, 1000원 으로 한정합니다.

 프로그램은 콘솔에서 동작하는 것을 기본으로 합니다.
 그래서 입력값은 사용자로부터 명령어를 입력받아 처리합니다.
 출력값도 콘솔출력으로 처리합니다.
 
 100
 현재 금액은 100 입니다.
 500
 현재 금액은 600 입니다.
 cola
 잔액이 부족합니다.
 500
 현재 금액은 1100 입니다.
 cola
 콜라(1000원) 상품이 나왔습니다.
 현재 금액은 100 입니다.
 reset
 잔액 100원이 나왔습니다.
 현재 금액은 0 입니다.
 
 */
 
enum CurrentState: Int {
    case put = 0
    case sell
    case reset
    case change
    case lack
    // Error 클래스 만들어야함. ->
// 에러 상황은 올바르지 않은 코인이 들어왔을경우
}
 
 
class VendingMachine {
    var menu: Dictionary<String, Int>
    var coin: Int = 0
    var state: CurrentState = .reset {
        willSet { printState(newValue) }
    }
    
    init(menu: Dictionary<String, Int>) {
        self.menu = menu
    }
    
    func putCoin(_ coin: Int) -> Bool{
        guard coin == 100 || coin == 500 || coin == 1000 else { return false }
        
        
        self.coin = self.coin + coin
        
    }
    
    func printState(_ state: CurrentState) {
        switch state {
        case .put:
            print("현재 금액은 \(coin) 입니다.")
        case .sell:
            print("콜라(1000원) 상품이 나왔습니다.")
        case .change:
            print("잔액 100원이 나왔습니다.")
        case .lack:
            print("잔액이 부족합니다.")
        default:
            return
        }
    }
     
}


/*
 콜라 : 1000
 사이다 : 1100
 환타 : 1200
 */


let drinkVendingMachine = VendingMachine(menu: ["cola": 1000, "cider": 1100, "Fanta": 1200] )

// 사용자 입장에서는
// 코인을 넣고, 상품을 선택하고, 잔돈을 받는 일을 해야함.

while true {
    if let read = readLine(){
        if let coin = Int(read) {
            if drinkVendingMachine.putCoin(coin)
        }
        
    }
}
