#  WatchOS
---

## 1. Getting Started
- WatchOS 에서의 멋진 경험이란 앱과 정보를 풍부하게 적합한 방식으로 앱에 엑세스 하는 것을 의미한다.<br>
<br>
WatchOS의 유용한 앱은 다음을 따른다.<br>
<br>

1. 컴플리케이션을 사용하여 시계화면에 한눈에 볼수 있는 동적인 정보를 제공한다 
(*컴플리케이션? 애플워치 시계 페이스 화면에서 어플정보를 바로 확인해 볼 수 있는 기능)
2. 알람을 사용하여 적절하고 가치 있는 정보를 제공한다.
3. Siri를 사용하여 정보를 얻고 작업을 사용하도록 지원한다.
4. 필요한 경우 앱환경에서 더 많은 기능을 제공한다.



## 2. App

앱의 인터페이스를 눈에 잘 띄게 만들어라.
- 집중적이고 공간 효율적인 인터페이스로 사용자 상호 작용을 간소화한다.<br>
<br>

페어링된 iPhone이 범위를 벗어 났을 때 앱이 제대로 실행 되는지 확인한다.
-  iPhone이 근처에 없어도 콘텐츠는 최신상태이어야 한다.
-  [WatchOS 컨텐츠를 최신상태로 유지하기](https://developer.apple.com/documentation/watchkit/keeping_your_watchos_content_up_to_date),  [독립적인 WatchOS App 만들기](https://developer.apple.com/documentation/watchkit/creating_independent_watchos_apps)

인트로 화면을 포함하지 마라.<br>
앱에로고를 포함하지마라<br>
폰트, 색조, 이미지로 브랜드 아이덴티티를 표현함.<br>
일반 검정색 배경을 선호해라 (특정 요소에 색상을 적용해라.)<br>
<br>
<br>

## 3. 컴플리케이션
손목을 들어 올릴 때마다 볼 수 있는 시계 페이스에 적절한 관련 정보를 표시함.<br>
<br>
개인정보를 염두에 두어야한다. (AOD 때문일듯 [참고](https://developer.apple.com/documentation/clockkit/clkcomplicationdatasource/1627965-getprivacybehavior))<br>
데이터 업데이트 할 시기를 신중하게 고려하라<br>

https://developer.apple.com/design/human-interface-guidelines/watchos/interaction/navigation/

