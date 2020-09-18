//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class 나중에생기는데이터<T> {
    private let task: (@escaping (T) -> Void) -> Void
    
    // 생성하면서 클로저를 갖고 있다가.
    init(task: @escaping (@escaping (T)->Void)-> Void) {
        self.task = task
    }
    
    // 저장해 놓았던 task를 실행하면서 실행될 f를 매개변수로 전달해줌.
    func 나중에오면(_ f: @escaping (T) -> Void) {
        task(f)
    }
    
}
class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }

//    func downloadJson(_ url: String,
//                      _ completion: @escaping(String?) -> Void) {
    // completion으로 일일히 처리해주긴 귀찮아서 리턴값으로 처리하기 귀한 방안이 만들어졌다.
    
    
    //RXSwift는 비동기적으로 데이터를 가져올때 클로져로 처리하지 않고
    // 리턴하여서 처리한다.
        func downloadJson(_ url: String) -> Observable<String?> {
            
            return Observable.create { f in
                DispatchQueue.global().async {
                    let url = URL(string: MEMBER_LIST_URL)!
                    let data = try! Data(contentsOf: url)
                    let json = String(data: data, encoding: .utf8)
                    
                    DispatchQueue.main.async {
                        f.onNext(json)
//                        f.onCompleted()
                    }
                }
                
                return Disposables.create()
            }
    }
    
    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
         
        let disposable = downloadJson(MEMBER_LIST_URL)
//        subscribe는 Disposable를 리턴한다.
            .subscribe({ (event) in
                switch event {
                case let .next(json):
                    self.editView.text = json
                    self.setVisibleWithAnimation(self.activityIndicator, false)
                case .completed:
                    // 클로저 종료
                    break
                case .error:
                    // 클로저 종료
                    break
                }
            })
        
        
        // dispose : 버리다.
//        disposable.dispose() // 동작을 취소 시킬수 있다.
    }
}

