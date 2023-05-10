# PinkyStocky

## 프로젝트 소개

- 개요: 주식의 현재 주가와 차트, 경제 뉴스를 종합적으로 확인할 수 있는 앱입니다.
- 아키텍쳐: MVC
- 프로젝트 종류: 개인 프로젝트
- 진행 기간: 2023-02-22 ~ 2023-04-18



## 주요화면 및 기능

### 📈 주식 차트 화면 (Stock)
> - Reload 버튼을 눌러 실시간 주가를 업데이트 할 수 있습니다.
> - 주가를 받아오는 동안 Loading 화면을 나타냅니다.
> - UserDefaults를 사용하여 원하는 주식이 저장될 수 있게 구현했습니다.
> - 저장한 주식을 오른쪽으로 밀어 삭제할 수 있습니다.
> - 주식을 클릭하면 해당 주식의 자세한 데이터와 뉴스 기사 등을 확인할 수 있습니다.
> - 서치 바에 원하는 주식을 검색하여 주식을 메인 화면에 담을 수 있습니다.


|실시간 주가 업데이트|주식 삭제|주식의 Detail 화면|메인화면에 주식 담기|
|:---:|:---:|:---:|:---:|
|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/081482b9-6f8c-47d6-a93c-cabb48a78bab" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/0c069c72-80ac-45db-896c-f937bc0a00aa" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/5a804545-5fd2-40ef-80c9-f31644555551" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/90d4c3ec-9dda-4ad3-b6cd-4662b1db3e9f" width="200" height="400"/>|



### 🏦 금융 정보 화면 (Financial)
> - 환율과 코인의 실시간 가격을 확인할 수 있습니다. 오른쪽으로 스크롤하여 더 많은 데이터를 확인할 수 있습니다.
> - Reload 버튼을 눌러 실시간 환율과 코인 및 주식의 가격을 업데이트 할 수 있습니다.
> - 아래로 스크롤하여 최신 경제 뉴스를 확인할 수 있습니다. (테이블 뷰로 구현)
> - 우량주의 현재가와 실시간 데이터를 확인합니다.


|환율과 코인의 실시간 가격 확인|실시간 환율, 코인 및 주식 가격 업데이트|최신 경제 뉴스 확인|
|:---:|:---:|:---:|
|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/414755da-9f0b-4288-a27f-e1993d063499" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/a9eef009-f4e5-45aa-8737-f634b05e64d6" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/cb8abeaa-639a-415d-9eb5-fb8193692305" width="200" height="400"/>|



### 🌏 글로벌 뉴스 화면 (World Wide News)
> - 전 세계 최신 뉴스를 확인할 수 있는 화면입니다.
> - Top News를 큰 화면으로 배치했으며, 컬렉션 뷰를 통해 오른쪽으로 스크롤할 수 있도록 구현했습니다.
> - 아래로 스크롤하여 전 세계 최신 뉴스를 확인할 수 있습니다 (테이블 뷰로 구현)
> - 스크롤 바를 이용해 뉴스를 검색할 수 있도록 구현했습니다.

|Top News|최신 뉴스|최신 뉴스 검색|
|:---:|:---:|:---:|
|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/9e67c42b-7ffc-4c91-bfd8-dc829e044acd" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/67228bb0-2ad1-43a8-8da8-06653e954c70" width="200" height="400"/>|<img src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/a9863a05-4d3f-48f8-a534-1fa81ae7220a" width="200" height="400"/>|


## 고민의 흔적

1. **앱의 구조를 설계하는 것에 대한 고민** 
    
    🤔 : 주식을 디테일하게 보여주는 화면을 구성할 때, 한 화면에 5개의 화면이 들어가게끔 만들어주고 싶은데 어떻게 화면을 설계할 수 있을까? 또한 Navigation Bar를 Push & Pop 방식이 아닌 Present 방식으로 띄우고 싶은데 어떻게 해야 할까? 아래와 같이 말이다.

    <img width="200" alt="5개의 화면" src="https://github.com/Marigoldflower/PinkyStocky/assets/100112897/2bce7875-6f73-4542-90c1-7f80ce986d9d">

    - (1) 해당 주식의 이름
    
    - (2) 해당 주식의 차트 데이터
    
    - (3) 해당 주식의 주가를 한 눈에 볼 수 있도록 구성
    - (4) 해당 주식의 상장 코드 및 스톡리스트에 저장하는 버튼 구성
    
    - (5) 해당 주식의 최신 뉴스를 보여주는 화면
    



🥳 : **구현 방법은 다음과 같습니다.**

- 전 화면에서 넘기고자 할 때 **UINavigationController 루트 뷰 자체**를 Present로 넘기면 Navigation Bar를 Present 방식으로 배치시킬 수 있었습니다. 그렇게 (1)번 화면 주식의 이름을 적는 부분을 완성했습니다.
- UITableView에 속한 프로퍼티 tableHeaderView 내부에 UIView 두 개를 가지고 있는 뷰를 할당하여 (2)번 화면 주식 차트데이터와 (3)번 화면 주식의 주가를 정리한 데이터를 구현했습니다.
- UITableViewHeaderFooterView라는 class를 통해 테이블 뷰 바로 위에 Header 영역을 배치함으로 (4)번 화면 해당 주식의 상장 코드 및 스톡리스트에 저장하는 버튼을 구성하는 화면을 구현했습니다.
- (5)번 화면 해당 주식의 최신 뉴스를 보여주는 화면은 간단한 테이블 뷰로 구현했습니다.

(1)번 화면 주식의 이름을 적는 부분 구현. 

![스크린샷 2023-05-05 오후 4.31.18.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/dc85f019-742d-42ca-a202-6725293919b5/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.31.18.png)

(2)번 화면 주식 차트데이터와 (3)번 화면 주식의 주가를 정리한 데이터 구현.

![2번과 3번 화면 구현.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/adc91037-5598-4dac-ac36-91613124e497/2%E1%84%87%E1%85%A5%E1%86%AB%E1%84%80%E1%85%AA_3%E1%84%87%E1%85%A5%E1%86%AB_%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB_%E1%84%80%E1%85%AE%E1%84%92%E1%85%A7%E1%86%AB.png)

![2번과 3번 화면 구현 2.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5bc1ec38-3efb-4637-97f6-295b57abe45f/2%E1%84%87%E1%85%A5%E1%86%AB%E1%84%80%E1%85%AA_3%E1%84%87%E1%85%A5%E1%86%AB_%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%AB_%E1%84%80%E1%85%AE%E1%84%92%E1%85%A7%E1%86%AB_2.png)

(4)번 화면 해당 주식의 상장 코드 및 스톡리스트에 저장하는 버튼을 구성하는 화면 구현.

![스크린샷 2023-05-05 오후 4.52.23.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a494d18c-748f-4a6a-a07d-38ec9ed2ff18/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.52.23.png)

![스크린샷 2023-05-05 오후 5.00.58.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/58307a7b-6ac3-4f2b-9536-56bf776dcee0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.00.58.png)

1. **주식 차트를 그리는 과정에서 비동기적인 처리에 대한 고민**
    
    🤔 : 네트워크 비동기처리가 끝나지 않은 상태에서 차트 UI가 그려지면 차트에 값이 들어오지 않게 되어 차트가 보이지 않는 현상이 발생한다. 어떻게 해결해야 할까?
    
    🥳 : 네트워크 처리보다 차트를 그리는 시간이 더 빠르기 때문에 일어나는 문제입니다. 시점을 정확히 정해주기 위해 **DispatchGroup을 이용해 네트워크 비동기처리가 끝나는 시점을 한 번에 파악**한 후, **그 뒤에 차트를 그리도록 만들어주면 된다**고 생각했습니다. 
    

먼저 비동기 처리할 네트워크 메소드를 DispatchGroup으로 묶어준 뒤,

![스크린샷 2023-05-05 오후 5.11.33.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/02758892-1c64-4735-bc95-9e7b5e5203a8/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.11.33.png)

비동기 처리가 완료되면 Chart 데이터에 접근할 수 있도록 설계했습니다.

![스크린샷 2023-05-05 오후 5.12.10.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/dbaaf3fa-1633-4bec-a4f9-2289f400023d/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.12.10.png)

1. **네트워크** **데이터를 받아오는 동안 화면의 빈 공백을 어떻게 채울 것인지에 대한 고민**
    
    🤔 : 네트워크 데이터를 받아오는 시간이 길기 때문에, 그 시간동안 공백으로 화면이 뜨게 되는데, 어떻게 해야 더 좋은 유저 경험을 제공할 수 있을까?
    
    🥳 : 네트워크 데이터를 다 받아올 때까지 LoadingView를 생성해 빈 화면을 대체하였습니다. **LoadingView는 CGAffineTransform과 animate를 이용해 로딩 화면처럼 동작하도록 만들었습니다.**
    
    ![ezgif-5-24befe6922.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b1d8d89f-5b35-48be-8bd5-593193cfe870/ezgif-5-24befe6922.gif)
    

CGAffineTransform 메소드와 UIView animate 메소드 두 개를 이용해 LoadingView를 구현.

![스크린샷 2023-05-05 오후 6.45.37.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cb51b256-8efe-4980-8dbb-08f3c0074579/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_6.45.37.png)

1. **어떻게 해야 실시간으로 주식 데이터를 받아올 수 있을지에 대한 고민**
    
    🤔 : UserDefaults에 저장되면 그 값은 변하지 않는다. 실제 주식의 가격에 변동이 생길 때 UserDefaults 내에서도 실시간으로 값이 변하게끔 만들고 싶다. 어떻게 하면 UserDefaults 내에 있는 주식들의 주가에도 변동을 줄 수 있을까?
    
    ![스크린샷 2023-05-05 오후 7.02.23.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cdae0cf1-f3ab-477f-9bdc-477b5228091c/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7.02.23.png)
    
    ⬅️  빨간 네모 영역의 값이 주가가 변할 때마다 실시간으로 바뀌게 하고 싶다.
    

🥳 : Reload 버튼을 하나 만들었습니다. 사용자가 Reload 버튼을 누르면 viewDidLoad()를 실행하고 테이블 뷰를 reload하도록 만들었습니다. viewDidLoad 내에는 네트워크 통신 코드가 존재해 다시 통신을 하게 되며, 네트워크 통신이 끝난 후 UserDefaults에 새로운 값을 집어넣었습니다. 

사용자가 버튼을 누르면 viewDidLoad()를 다시 실행시키고 그 후 테이블 뷰를 리로드합니다.

![스크린샷 2023-05-05 오후 7.22.15.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1888fb97-941c-46de-901d-4b4080f0d275/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7.22.15.png)

viewDidLoad() 안에 있는 UserDefaults 전용 네트워크 통신 코드입니다. UserDefaults에 존재하는 주식의 상장 코드를 이용해 네트워크 통신을 진행했습니다. 주식 데이터에 필요한 요소들을 모두 넣어 인스턴스로 찍어낸 뒤, 기존에 있던 UserDefaults 내에 새롭게 할당했습니다.

![스크린샷 2023-05-05 오후 7.24.11.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/210d3170-b09c-45bb-bd63-cb253787bea1/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7.24.11.png)

Reload 버튼을 누를 때, TSLA 주가와 차트의 값이 변경되는 것을 확인할 수 있습니다.


