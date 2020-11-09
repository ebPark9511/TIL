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

//Error 클래스 정의
// 1. 잘못된 코인을 넣었을때.
// 2. 없는 메뉴를 골랐을때.
enum VendingMachineError: Error {
    case wrongCoin
    case notMenu
}

 
enum CoinState: Int {
    case success = 0
    case fail
}
 
enum CurrentState: Int {
    case put = 0
    case sell
    case reset
    case change
    case lack
}
 
 
open class VendingMachine {
    
    // 자판기 예약어
    enum VendingMachineReservedWords {
        case putCoin(coin: Int)
        case putMenu(menu: String)
        case reset
    }
    
    var menu: Dictionary<String, Int>
    var coin: Int = 0
    var state: CurrentState = .reset {
        willSet { printState(newValue) }
    }
    
  
    
      
    
    init(menu: Dictionary<String, Int>) {
        self.menu = menu
    }
      
    func put(_ word: VendingMachineReservedWords) throws {
  
        switch word {
        case .putCoin(coin: let coin):
            guard coin == 100 || coin == 500 || coin == 1000 else {
                throw VendingMachineError.wrongCoin
            }
            self.coin += coin
            printState(.put)
            
        case .putMenu(menu: let menu):
            guard self.menu.contains(where: { $0.key == menu }) else {
                throw VendingMachineError.notMenu
            }
            
        case .reset:
            print("reset")
  
        }
        
  
    }
    
    func getMenu(_ menu: String) {
        if let price = self.menu[menu] {
           
            if self.coin < price {
                printState(.lack)
                return
            }
            
            self.coin = self.coin - price
            printState(.sell)
            return
        }
        
        if menu == "reset" {
            self.coin = 0
            printState(.reset)
        }
         
        return // 오류
    }
    
    func printState(_ state: CurrentState) {
        switch state {
        case .put:
            print("현재 금액은 \(coin) 입니다.")
        case .sell:
            print("콜라(1000원) 상품이 나왔습니다.")
        case .change:
            print("잔액 100원이 나왔습니다.")
            printState(.put)
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
        
        do {
            
            // 하기부분도 자판기 책임.
            // input된 데이터를 check하여 putCoin과 putReservedWords로 나눔
            if let coin = Int(read) {
                try drinkVendingMachine.put(.putCoin(coin: coin))
            } else {
                if read == "reset" {
                    try drinkVendingMachine.put(.reset)
                } else {
                    try drinkVendingMachine.put(.putMenu(menu: read))
                }
            }
            
        } catch VendingMachineError.wrongCoin {
            print("잘못된 코인.")
        } catch VendingMachineError.notMenu {
            print("존재하지 않는 메뉴")
        }
        
        
    }
}
