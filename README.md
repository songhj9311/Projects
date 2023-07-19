## 1번째 프로젝트 소개
격하게 변하는 서울시 아파트 가격에 영향을 미치는 데이터 수집 및 요인 파악
## 개발기간
* 23.04.12 ~ 23.05.02

* ### 개발 환경

![종류](https://user-images.githubusercontent.com/127808906/235382737-7daa8bf7-ba0c-412b-932c-e3852eb71dbc.png)

- 'Python 3.9.13'
- 'R 4.2.3'
- 'Git 2.40.0.windows.1'
- 'R studio 2023.03.0+386'
- 'ERwin Data Modeler r7'
- 'MariaDB 10.11.1'
- 'Numpy 1.21.5'
- 'Pandas 1.4.4'
- 'matplotlib 3.5.2'
- 'seaborn 0.11.2'
- 'Scipy 1.9.1'
- 'Selenium 4.8.3'
- 'Scikit-learn 1.2.2'
- 'folium 0.14.0'
- 'plotly 5.9.0'
### 가설 설정

- **환경적 요인** (ex) 인프라, 범죄건수, ... 등등) 과 **경제적 요인** (ex) 기준금리, GDP, 물가지수, 유동성비율, ...등등)이

     **아파트 가격**에 영향을 미친다
### 데이터베이스 생성

#### 환경적 요인과 경제적요인을 정제해서 데이터베이스에 저장한다.
![제목 없음](https://user-images.githubusercontent.com/127808906/235381834-59ce0bfa-e78b-4c6c-bd78-e0b45b3a267e.png)


### 데이터 시각화
- *경제적 요인*을 **시계열 그래프**로 알아보고 *환경적 요인*은 **산점도**로 알아봄으로써 서로 어떤 영향을 주는지 시각적으로 알아본다.
- 시계열 그래프
![그림1](https://user-images.githubusercontent.com/127808906/235381781-f1819a41-70c3-4081-8474-11c3ce04e250.png)
- 산점도
![시각화](https://user-images.githubusercontent.com/127808906/235383471-19c0b45f-da6b-498c-817a-d7974835ab27.png)
##### 경제적요인-매매가

![경제_매매가](https://user-images.githubusercontent.com/129472378/235405113-740266c9-beab-4117-a586-90a8762a472b.PNG)
#### 결론

- 경제적 요인에 대한 분석 결과, 기준금리와 인구 이동률이 가장 큰 영향을 미치며 충분한 신뢰성이 있으며(결정계수 R^2=78%) 가장 중요한 변수들이라고 할 수 있습니다.
