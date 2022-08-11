# 곰튀김님의 4시간만에 Rxswift 배우기

- github : [https://github.com/iamchiwon/RxSwift_In_4_Hours/blob/step3/rx/Example/step1/Podfile](https://github.com/iamchiwon/RxSwift_In_4_Hours/blob/step3/rx/Example/step1/Podfile)
- 김튀김님의 github : [https://github.com/ClintJang/awesome-swift-korean-lecture/blob/master/README.md#rxswift](https://github.com/ClintJang/awesome-swift-korean-lecture/blob/master/README.md#rxswift)

### 소개

- 공식 홈페이지 : [https://reactivex.io/](https://reactivex.io/)
- reactiveX 시리즈 중 하나
    - API, oversable stream을 이용하여 비동기 프로그래밍을 하는 API
- 해당 사이트에서 docs를 들어가면 5가 존재
    - **observable, operator,** single**, subject, scheduler : 주요 개념**
    - 가장 중요한 게 observable!!
    - single은 덜 중요
- reasource에 들어가면 빠르게 배우는 거 많음 ㅎㅁㅎ 몰랐넹??

### 동기 비동기

동기 : 하나를 하면 다른 거는 못하게 막는 것

ex) 타이머가 돌아가고 있는데 사진이 나오게 하면 사진이 나올 때까지 타이머가 멈춤

비동기 : 상관없이 돌아가는 것

![스크린샷 2022-08-02 오후 2.26.27.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9979fedb-492e-4ac5-a722-f562fd135d83/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.26.27.png)

DispatchQueue를 넣으면 동기가 비동기가 됨

DispatchQueue에는 concurrency Queue(global)와 serial Queue가 있고 각각은 동기와 비동기로 나뉠 수 있다

UI건드는 거는 main스레드에서 돌려야 되니까 main에 넣음

⇒ DispatchQueue로 처리 하기가 너무 귀찮으니까!! 다양한 라이브러리가 존재 : promiseKit, boltKit, rxswift등등

**promiseKit**

![스크린샷 2022-08-02 오후 2.30.04.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/14d56d89-711f-4f88-80fc-dd25f63be107/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.30.04.png)

**rxSwift** - 비동기 처리를 쉽게 하기 위함, promiseKit와 동일하지만 거기에 operator가 있어서 더 특별함을 가진다고 볼 수 있음.

![스크린샷 2022-08-02 오후 2.30.49.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6dd24afa-40e3-4e36-8e8e-dae541f94851/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.30.49.png)

subscribe를 하면 disposable가 리턴됨 → 그걸로 취소가 가능

![스크린샷 2022-08-02 오후 2.35.29.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/623bed9c-93c7-4c36-a6bb-9b4ffbfa8016/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.35.29.png)

이 취소 작업을 dispatchQueue를 하면 flag로 하거나 하는 귀찮은 작업이 필요하므로 이러한 utility를 사용하면 더 쉬워짐

### DIsposeBag

disposable을 담는 백 

작업을 도중에 취소할 수 있다!

![스크린샷 2022-08-02 오후 2.39.28.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/70ceeb93-0f92-4a5a-9b79-8125bc53890d/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.39.28.png)

disposeBag = disposeBag()

insert로 담을 수 있지만 한꺼번에 버리는 함수가 없기 때문에 위의 문장처럼 새로 선언해주면 들어있던 disposable이 모두 사라진다

![스크린샷 2022-08-02 오후 2.40.04.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2919be39-073c-436f-a32d-d6a9e28a0142/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.40.04.png)

← 같은 코드를 간단하게 표현하는 방법

## Operator

이전에는 observable을 생성해서 seal에 onNext로 데이터를 넘겨줬었는데 귀찮아서 데이터를 직접받게 해주는 메소드가 존재함 : just

### Just : 그냥 바로 내려보냄

![스크린샷 2022-08-02 오후 2.45.06.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4f2dd03e-b69a-4ae4-acb7-a08428b275be/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.45.06.png)

### From : 배열 하나씩 내려보냄

![스크린샷 2022-08-02 오후 2.47.52.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f3d4faf5-7eec-46ac-aa9b-68fadb69e18b/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.47.52.png)

### Map & Filter

![스크린샷 2022-08-02 오후 2.48.01.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e76457ec-9d17-49c7-96ed-ff532ea5ac42/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.48.01.png)

![스크린샷 2022-08-02 오후 2.50.35.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/17289f40-f66c-4b1d-9d16-c018151e9ae4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.50.35.png)

![스크린샷 2022-08-02 오후 2.50.40.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f71f18ec-9519-44c1-a9a2-f1c1db1bcb00/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.50.40.png)

**→ Operator에는 생성(observable을 생성, create, just, from), 변환(map), 필터링(filter),결합(zip), 오류처리, 조건과 불린 연산자, 수학과 집계 연산자, 역압 연산자 등등 존재 : Docs Operators에 들어가면 다 있음, 사이트에 트리가 있어서 약간 읽어가면서 맞는 걸 선택할 수 있음!!**

# Marble Diagram

구슬은 데이터, 화살표는 스트림, 짝대기는 completed을 의미하며 complete되면 disposebag에 들어간다

엑스는 error를 의미!

ex)

![스크린샷 2022-08-02 오후 2.59.18.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/715eadf6-3199-4262-8519-aa708e2c78a8/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.59.18.png)

![스크린샷 2022-08-02 오후 2.59.32.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/37946a0e-42ab-406f-ad98-50b41100904b/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.59.32.png)

- 다르게 생긴 구슬은 움직일 수 있다
    
    ![스크린샷 2022-08-02 오후 3.00.51.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/090ed118-ac4e-49fc-a952-e63867a431a4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.00.51.png)
    

- 생성은 스트림이 아닌 걸 넣으면 스트림이 나오는 거고 map같은 애는 stream을 넣어서 Stream이 나오는 형태 → 따라서 map은 just로 스트림을 만든 후에 map을 사용할 수 있음!!, 처음부터 map을 사용할 수 없음, filter도 마찬가지!!

<aside>
💡 Rxswift의 경우 operator 설명이 적은 편이기 때문에 다른 RxJava 1.x와 같은 애로 같은 함수를 찾으면 된당!

</aside>

![스크린샷 2022-08-02 오후 3.07.41.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e01f0175-ce88-4911-9476-e7244fa7e967/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.07.41.png)

map은 데이터를 넣으면 데이터가 나오는데 flatMap은 데이터를 넣으면 stream이 나온다

[https://rxmarbles.com/](https://rxmarbles.com/) ← 이사이트로 마블을 그릴 수 있어서 테스트 가능

## Next, Error, Completed

작대기 : completed

전달되는 것 : next

엑스 : Error

operator로 만든 최종 얻은 데이터를 받아서 사용하려면 subscribe를 하며 된다!!

1. **subscribe()**
2. **subscribe(event)**

![스크린샷 2022-08-02 오후 3.14.19.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/59adb4b3-4e79-49e8-b1e4-484525b2e03b/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.14.19.png)

operator는 대부분 stream을 리턴하지만(Observable) subscribe는 리턴타입이 disposable임!

stream은 에러나 complete되는 경우 종료된다

1. **subscribe(?,?,?,?)**
- switch문으로 작성하는 경우 모든 케이스를 작성해야만 한다는 단점이 존재하므로 subscribe 인자에 원하는 case만 작성해줘도 된다! optional이기 때문!
    
    ![스크린샷 2022-08-02 오후 3.19.34.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/16104105-8b26-455d-9f9c-1d30863587cd/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.19.34.png)
    

dispose가 불리는 경우는 complete 혹은 error난 경우 불림

# Scheduler

exMap3는 main스레드에서 map, filter를 너무 많이 해서 스크롤이 멈춘다는 문제가 있음 

→ .observeOn(ConcurrentDispatchQueueScheduler(qos:.default))를 넣으면 concurrent스레드에서 가고 보여주기 직전에는 ui 는 메인스레드에서 해야하기 때문에 .observeOn(MainScheduler.instance)로 돌아가서 해야 한다

![스크린샷 2022-08-02 오후 3.24.37.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0567e730-6363-4829-9992-be6b2a2de41a/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.24.37.png)

observeOn을 건 다음부터 걸게 된다는 것 따라서 데이터를 로드하기 전에 다른 쓰레드로 가는 것이 좋음!

그렇다면 just에 바로 데이터를 가져오게 한다면 observeOn은 다음줄부터니까 안되자나!!

→ .subscribeOn으로 scheduler를 지정하면 얘는 어디에 두든 subscribe를 할 때 바로 동작하게 되어서 상관없게 된다!

cf. network queue를 따로 만들어서 사용한다면 다른 애들은 dispatchqueue로 하면 되니까 시간을 더 줄일 수 있다!

### SideEffect

operator들은 전부 sideEffect이 없지만 subscribe과 do라는 애만 sideEffect를 가짐

do : subscribe를 지나가기 전에 event를 감지하는 곳이라고 보면 됨 좀 더 자세하게 나눠서 작성 가능함

## RxCocoa(Rxswift 응용해보기)

Uikit를 다룰 때 편한 것들이 들어있음

ex) 이메일, 비번 잘 작성하면 버튼 활성화되도록 하는 예제

기존 : delegate 위임해서 action으로 확인해서 둘다 만족하면 버튼을 활성화시킴

→ rxswift는 비동기에 사용되는 것!! 데이터를 나중에 주기 때문에 ui에 대한 이벤트도 비동기로 처리 가능!!

stream에다가 event를 넣어주면 비동기로 ui를 처리할 수 있게 된다!!

- rxCocoa를 이용해서 rx.를 아웃렛에 넣어주면 그걸 비동기 처리하겠다는 의미가 됨!!

![스크린샷 2022-08-02 오후 4.25.35.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d4cbe26a-fba2-4da4-8211-1ac923d85300/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.25.35.png)

- 리팩토링해보자!
    - input : 아이디 입력, 비번 입력
    - output : 불빛, 로그인버튼 활성화

![스크린샷 2022-08-02 오후 4.36.17.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e2f2c162-a515-40e2-a840-3e5d411f3395/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.36.17.png)

# Subject

- asyncSubject, bahaviorSubject, publishSubject, replaySubject가 존재
- observable의 역할을 하면서 동시에 observable은 외부에서 이미 있는 데이터를 넣어줘야 하는데 subject는 외부의 데이터를 받아오면서 observable도 하는 것
- 외부에서 통제하는 observable

## BehaviorSubject

- default값을 지정하여 선언
- subscribe하면 default값을 내려주고 데이터가 발생하면 전달해주고 만약에 다른 애가 behaviorsubject를 subsribe하면 그 때의 최신값을 주고 계속 한다
- behaviorSubject가 다른 애를 subscribe할 수 있다는 것은 observable이라는 소리인데 스스로 데이터를 발생할 수 있음!
- observable은 just로 데이터를 갖고 있어서 준건데 subject는 데이터가 나중에 발생하면 외부에서 넣어줄 수 있는 것!!
- 넣어줄 수도 있고 observable할 수 있는 것!!

### PublishSubject

behaviorSubject는 디폴트 값이 없고 나중에 데이터가 생성되면 줌

### replaySubject

subsribe하고 나서 데이터 들어오면 보내지만 또subscribe하면 앞에꺼 다 줌

### asyncSubject

끝이 나야 전달이 되는 subject, 끝난 시점에 가장 마지막 꺼를 줌

 

![스크린샷 2022-08-02 오후 5.04.15.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/dd261ba5-fa1b-481d-8d26-0da9b3355e67/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.04.15.png)

![스크린샷 2022-08-02 오후 5.04.38.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5997b273-41e4-4274-b675-8960045bd756/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-08-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.04.38.png)

cf. 내가 추가한 빈칸일 때에도 불빛이 꺼지게 하는 코드
