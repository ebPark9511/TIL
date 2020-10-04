#  201004 Coordinator
---

- 패턴 적용시 MVVM-C, MVP-C 와 같은 형태로 표기함.

 
- 기존 화면 이동은 한 ViewController에서 이동해야하는 SecondViewController 객체를 만들고 navigationConroller의 pushViewController로 화면을 푸시해준다.
- 이 작업은 ViewController간의 커플링을 만든다.



- Coordinator Pattern을 사용하면 ViewController에서 화면 탐색 작업을 제거하여 관리 및 재사용 가능성을 높인다.
- Coordinator는 화면 탐색의 책임을 가져가여 앱에서는 화면간 연결에 대한 의존성 분리를. 할수 있다.


## Sample Project


** 참고 URL **
[https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps) 

[https://nsios.tistory.com/50](https://nsios.tistory.com/50)
