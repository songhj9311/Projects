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

## 2번째 프로젝트
국내 스마트팜 도입을 위한 AI기반 토마토 생체정보 모니터링 시스템 및 품질 예측 모델 개발
<br>
## 📚 사용언어 및 모듈
<a href="https://www.python.org/" target="_blank"><img src="https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white"/></a>
<a href="https://jupyter.org/" target="_blank"><img src="https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white"/></a>
<a href="https://www.tensorflow.org/?hl=ko" target="_blank"><img src="https://img.shields.io/badge/Tensorflow-FF6F00?style=flat&logo=tensorflow&logoColor=white"/></a>
<a href="https://keras.io/" target="_blank"><img src="https://img.shields.io/badge/Keras-D00000?style=flat&logo=keras&logoColor=white"/></a>
<a href="https://scikit-learn.org/stable/index.html" target="_blank"><img src="https://img.shields.io/badge/Scikitlearn-F7931E?style=flat&logo=Scikitlearn&logoColor=white"/></a>
<a href="https://numpy.org/" target="_blank"><img src="https://img.shields.io/badge/Numpy-013243?style=flat&logo=numpy&logoColor=white"/></a>
<a href="https://pandas.pydata.org/" target="_blank"><img src="https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white"/></a>
<a href="https://www.r-project.org/" target="_blank"><img src="https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white"/></a>
<a href="https://www.r-project.org/" target="_blank"><img src="https://img.shields.io/badge/Flask-000000?style=flat&logo=flask&logoColor=white"/></a>
<a href="https://www.r-project.org/" target="_blank"><img src="https://img.shields.io/badge/PyTorch-EE4C2C?style=flat&logo=PyTorch&logoColor=white"/></a>

<br>

#### 1) 품질예측 모델
    - 환경데이터를 통해 품질(당도, 산도, 과중)을 예측하는 모델 구상
    - 데이터의 결측치에 대한 다양한 접근(Simple Imputation, KNN Imputation, Multivariate feature Imputation 등) 및 이상치 허용기준을 확립해 다양한 데이터 셋 구성
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/6b1bbcd2-509a-4604-9a44-fcbb2bbc05f8" width = "680" height = "380"/>
</div>
<br>

    - 준비한 데이터 셋에 다양한 ML 회귀모델(KNN, Linear, Lasso, Ridge, SVR 등) 테스트를 통한 최적 모델 탐색
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/372e9c21-4d62-46e0-bdca-c868931bdaa2" width = "680" height = "380"/>
</div>
<br>

    - 「과중·당도 ML 예측모델」회귀 예측모델생성
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/2af95d0c-b8d5-4fd9-8ddb-06fa61d4a5da" width = "680" height = "380"/>
</div>
<br>


    - 「산도 DLL 분류모델」생성 * 카테고리화된 산도 Label 고려
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/70bb74ee-3c93-48ef-9c4a-92ddf690a647" width = "680" height = "380"/>
</div>
<br>

#### 2) 질병 진단 모델
    - 「질병진단 모델 훈련 결과」
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/5b2d687b-4dfb-4db8-ac34-c84f94225051" width = "680" height = "380"/>
    <img src = "https://github.com/naleetwo/FinalProject/assets/128697640/a478e8be-7348-439b-a98c-0b9a4e3658f7" width = "400" height = "380"/>
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/5a2d9fd5-c081-4f8d-88e4-c1d68d9ea2b7" width = "600" height = "380"/>
</div><br>

#### 3) 생장 예측 모델
    - 「생육단계 판단 모델 훈련 결과」
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/7efbe451-cee1-499e-a26c-6a72e9725312" width = "680" height = "380"/>
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/1c9f186c-0cea-4c70-8c32-cb0d39b45332" width = "680" height = "380"/>
</div><br>

#### Web 서비스 구현
    - 웹 서비스 이용 시연
<div align = "center">
    <img src = "https://github.com/naleetwo/FinalProject/assets/127948197/991686e4-ed64-4d21-be44-5c9df3509a56" width = "680" height = "380"/>
