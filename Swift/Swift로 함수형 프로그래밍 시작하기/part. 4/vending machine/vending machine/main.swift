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
 
 */


open class VendingMachine {
    private enum VendingMachineError: Error {
        case wrongCoin
        case notMenu
    }
    
    private enum VendingMachineReservedWords {
        case getCoin(coin: Int)
        case offerProduct(menu: String)
        case reset
    }
    
    private enum CurrentState {
        case balance(_ coin: Int)
        case offer(menu: String, coin: Int)
        case reset(coin: Int)
        case lack
    }

    typealias Product = (String, Int)
    
    private var menu: Dictionary<String, Int>
    private var coin: Int = 0
    private var state: CurrentState = .reset(coin: 0) {
        willSet { printState(newValue) }
    }
     
    init(menu: Dictionary<String, Int>) {
        self.menu = menu
    }
      
    private func resetCoin() {
        coin = 0
        printState(.balance(coin))
    }
    
    private func getMenu(_ menu: String) throws -> Product {
        if let price = self.menu[menu] {
            return (menu, price)
        }
         
        throw VendingMachineError.notMenu 
    }
     
    private func printState(_ state: CurrentState) {
        switch state {
        case .balance(coin : let coin):
            print("현재 금액은 \(coin) 입니다.")
        case .offer(menu: let menu, coin: let coin):
            print("\(menu)(\(coin)원) 상품이 나왔습니다.")
        case .lack:
            print("잔액이 부족합니다.")
        case .reset(coin: let coin):
            print("잔액 \(coin)원이 나왔습니다.")
        }
    }
    
    
    private func operateVendingMachine(_ word: VendingMachineReservedWords) {
        do {
            
            switch word {
            case .getCoin(coin: let coin):
                guard coin == 100 || coin == 500 || coin == 1000 else {
                    throw VendingMachineError.wrongCoin
                }
                self.coin += coin
                printState(.balance(self.coin))
                
            case .offerProduct(menu: let menu):
                let product = try getMenu(menu)
                
                if coin < product.1 {
                    printState(.lack)
                    return
                }
                
                coin = coin - product.1
                printState(.offer(menu: product.0, coin: product.1))
                
            case .reset:
                printState(.reset(coin: coin))
                resetCoin()
            }
            
        } catch VendingMachineError.wrongCoin {
            print("not defined coin")
        } catch VendingMachineError.notMenu {
            print("doesn't have menu")
        } catch {
            print("error")
        }
    }
    
    func put(_ words: UserWords) {
        switch words {
        case .putCoin(coin: let coin):
            operateVendingMachine(.getCoin(coin: coin))
        case .putMenu(menu: let menu):
            operateVendingMachine(.offerProduct(menu: menu))
        case .reset:
            operateVendingMachine(.reset)
        }
        
    }
    
}


 
let drinkVendingMachine = VendingMachine(menu: ["cola": 1000,
                                                "cider": 1100,
                                                "Fanta": 1200] )

enum UserWords {
    case putCoin(coin: Int)
    case putMenu(menu: String)
    case reset
}
 
while true {
    
    if let read = readLine(){
        
        if let coin = Int(read) {
            drinkVendingMachine.put(.putCoin(coin: coin))
        } else {
            if read == "reset" {
                drinkVendingMachine.put(.reset)
                continue
            }
             
            drinkVendingMachine.put(.putMenu(menu: read))
        }
    }
}
