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

 
    // Observable의 생명주기
    // 1. Create
    // 2. Subscribe
    // 3. onNext
    // ---- 끝 ----
    // 4. onCompleted  / onError
    // 5. Disposed
    
    // Observable.create 이 후 실행은
    // subscribe에서 이루어진다.
    // 끝나면 Disposed 된다. (completed 된 subscribe는 재사용이 불가능하다.)
    
    //RXSwift는 비동기적으로 데이터를 가져올때 클로져로 처리하지 않고
    // 리턴하여서 처리한다.
        func downloadJson(_ url: String) -> Observable<String?> {
            
            //1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법.
            
            // public static func create(_ subscribe: @escaping (RxSwift.AnyObserver<Self.Element>) -> RxSwift.Disposable) -> RxSwift.Observable<Self.Element>
            return Observable.create { emitter in
                let url = URL(string: MEMBER_LIST_URL)!
               let task = URLSession.shared.dataTask(with: url) {  (data, _, err) in //
                if let err = err { emitter.onError(err) }
                    
                    if let data = data,
                       let json = String(data: data, encoding: .utf8) {
                        emitter.onNext(json)
                    }
                emitter.onCompleted()
                    
               }
               
                task.resume()
                
                
                return Disposables.create()
            }
            
//            return Observable.create { f in
//                DispatchQueue.global().async {
//                    let url = URL(string: MEMBER_LIST_URL)!
//                    let data = try! Data(contentsOf: url)
//                    let json = String(data: data, encoding: .utf8)
//
//                    DispatchQueue.main.async {
//                        f.onNext(json)
//                    }
//                }
//
//                return Disposables.create()
//            }
    }
    
    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        //2. Observable로 오는 데이터를 받아서 처리하는 방법.
        _ = downloadJson(MEMBER_LIST_URL)
            // public func subscribe(_ on: @escaping (RxSwift.Event<Self.Element>) -> Void) -> RxSwift.Disposable
            .debug()
            .subscribe({ (event) in
                switch event {
                case let .next(json):
                    DispatchQueue.main.async {
                        self.editView.text = json
                        self.setVisibleWithAnimation(self.activityIndicator, false)
                    }
                case .completed:
                    // 클로저 종료
                    break
                case .error:
                    // 클로저 종료
                    break
                }
            })
        
        
//        dispose : 버리다.
//        disposable.dispose() // 동작을 취소 시킬수 있다.
    }
}

