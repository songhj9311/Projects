#install.packages("corrplot")
library(corrplot)
library(car)
library(leaps)
#### 실제 데이터 값 회귀분석 ####
proj <- read.csv("C:\\hojun13\\Pythonwork\\Analysis\\Data\\data\\부동산 파일\\프로젝트\\17년치 분기별 요인컬럼이름변경.csv", fileEncoding ="utf-8")
View(proj)

attach(proj)
fit <- lm(면적당거래가격~물가지수+GDP+기준금리+실업율+인구이동률)
summary(fit)
shapiro.test(resid(fit))
vif(fit)
View(proj)

### 상관계수 그래프로 표현
#proj <- proj[-1]
proj_cor <- cor(proj)
corrplot(proj_cor, method="number")

### 물가지수랑 GDP vif로 인해 한가지 제거
fit2 <- lm(면적당거래가격~GDP+기준금리+실업율+인구이동률)
summary(fit2)
shapiro.test(resid(fit2))
vif(fit2)
reduce.reg<-step(fit2, direction="backward")
reduce.reg
plot(fit2)
par(mfrow=c(2,2))

### 조합 보기
reduce.reg<-step(fit2, direction="backward")
reduce.reg
leap <- regsubsets(면적당거래가격~GDP+기준금리+실업율+인구이동률, data=proj, nbest=4)
par(mfrow=c(1, 1))
plot(leap, scale="adjr2")

fitt <- lm(면적당거래가격~GDP) 
summary(fitt)  # 람다승 x  : 72.79%,  람다승 : 83.17%
shapiro.test(resid(fitt))  #람다승 x  : 만족X, 람다승o : 9.308%(만족o)

fita1 <- lm(면적당거래가격~GDP+인구이동률)
summary(fita1)
shapiro.test(resid(fita1))
vif(fita1)
reduce.reg<-step(fita1, direction="backward")
reduce.reg
par(mfrow=c(2,2))
plot(fita1)

leapa1 <- regsubsets(면적당거래가격~GDP+인구이동률, data=proj, nbest=2)
par(mfrow=c(1, 1))
plot(leapa1, scale="adjr2")




## 위의 결과로 인구이동률 GDP 뽑아내서 확인하기
fit3 <- lm(면적당거래가격^-1~GDP+인구이동률)
summary(fit3) # 람다승x : 73.38% : 람다승 : 82.92
vif(fit3)
shapiro.test(resid(fit3))  # 람다승x : 정규분포x  람다승o : 0.09312 만족 O



# 하지만 인구이동률이 영향력이 없음 

powerTransform(면적당거래가격) #-1
powerTransform(실업율) # 0.73997
powerTransform(인구이동률) # -0.1151336
powerTransform(GDP) # 0.8564891


reduce.reg<-step(fit3, direction="backward")
reduce.reg

fit4 <- lm(면적당거래가격^-1~GDP+log(기준금리))
summary(fit4)
vif(fit4) #람다승 x : 73.6%  람다승 : 0.8376
shapiro.test(resid(fit4)) # 람다승 x : 정규분포x, 람다승o : 정규분포x


leap2 <- regsubsets(면적당거래가격^-1~GDP+기준금리+실업율+인구이동률, data=proj, nbest=4)
par(mfrow=c(1, 1))
plot(leap2, scale="adjr2")

fitt1 <- lm(면적당거래가격^-1 ~ GDP+log(기준금리)+실업율+인구이동률)
reduce.reg<-step(fitt1, direction="backward")
reduce.reg



## GDP랑 기준금리 관계보기
fit5 <- lm(면적당거래가격^-1~GDP+log(기준금리))
summary(fit5)
vif(fit5) 
shapiro.test(resid(fit5)) 
# 람다승 로그 했을경우 : 정규분포 o (11.14%)
leap3 <- regsubsets(면적당거래가격^-1~GDP+log(기준금리), data=proj, nbest=2)
par(mfrow=c(1, 1))
plot(leap3, scale="adjr2")

fit6 <- lm(면적당거래가격^-1~GDP+log(기준금리))
summary(fit6)
shapiro.test(resid(fit6))
plot(fit6)
par(mfrow=c(2,2))

fitt1 <- lm(면적당거래가격^-1 ~ GDP+log(기준금리))
reduce.reg<-step(fitt1, direction="backward")
reduce.reg

fits1 <- lm(면적당거래가격^-1~GDP+log(기준금리))
summary(fits1)
shapiro.test(resid(fits1))

#### 정규화버전 ####

nom_proj <- read.csv("C:\\hojun13\\Pythonwork\\Analysis\\Data\\data\\부동산 파일\\프로젝트\\17년치 분기별 정규화 요인컬럼이름변경.csv", fileEncoding ="utf-8")
View(nom_proj)

attach(nom_proj)
#nom_proj <- nom_proj[-1]
fitn1 <- lm(면적당거래가격~물가지수+GDP+기준금리+실업율+인구이동률)
summary(fitn1)

infra <- read.csv("C:\\hojun13\\Pythonwork\\Analysis\\Data\\data\\부동산 파일\\프로젝트\\인프라모든요인.csv", fileEncoding ="utf-8")
View(infra)

자치구별
계약연도
범죄건수
정류장수
편의점수
카페수
학교수
병원수
학원수
대학교수
매매가
전월세가

#### 인프라 분석####
attach(infra)
fiti1 <-lm(매매가~범죄건수+정류장수+편의점수+카페수+학교수+병원수+대학교수+학원수, data=infra)
summary(fiti1)
shapiro.test(resid(fiti1))
vif(fiti1)


fiti2 <- lm(매매가^-0.25~범죄건수+정류장수+편의점수+카페수+학교수+병원수+대학교수+학원수)
summary(fiti2)
shapiro.test(resid(fiti2))
vif(fiti2)

leapi1 <- regsubsets(매매가^-0.25~범죄건수+정류장수+편의점수+카페수+학교수+병원수+대학교수+학원수, data=infra, nbest=8)
par(mfrow=c(1, 1))
plot(leap, scale="adjr2")


reduce.reg<-step(fiti2, direction="backward")
reduce.reg

powerTransform(매매가) # -0.27

fiti3 <- lm(매매가^-0.25<-카페수+학교수+학원수)
summary(fiti3)


fiti2 <-lm(매매가~범죄건수+정류장수+편의점수+카페수+학교수+대학교수+병원수, data=infra)
summary(fiti2)
shapiro.test(resid(fiti2))
vif(fiti2)
### 병원은 다중공선성이 너무 높아 제외!!

fiti3 <-lm(매매가~범죄건수+정류장수+편의점수+카페수+학교수+대학교수+학원수, data=infra)
vif(fiti3)

reduce.reg<-step(fiti3, direction="backward")
reduce.reg
vif(fiti3)

fiti3 <-lm(log(매매가)~카페수+학원수, data=infra)
summary(fiti3)
shapiro.test(resid(fiti3))

fiti4 <-lm(매매가~정류장수+카페수+학교수+대학교수+범죄건수+편의점수, data=infra)
summary(fiti4)
shapiro.test(resid(fiti4))
vif(fiti4)

reduce.reg<-step(fiti4, direction="backward")
reduce.reg

powerTransform(매매가)
attach(infra)
fiti5 <- lm(매매가~카페수, data=infra)
summary(fiti5)
shapiro.test(resid(fiti5))
#### 인프라(전세 분석)####

fitr1 <-lm(전월세가~범죄건수+정류장수+편의점수+카페수+학교수+대학교수+학원수+병원수)
summary(fitr1)
shapiro.test(resid(fitr1))
vif(fitr1)

fitr2 <-lm(전월세가~카페수+학원수+log(학교수))
summary(fitr2)
shapiro.test(resid(fitr2))
vif(fitr2)

powerTransform(전월세가)
powerTransform(카페수)
powerTransform(학원수)

fitr3 <- lm(전월세가~log(카페수)+학원수)
summary(fitr3)
shapiro.test(resid(fitr3))
vif(fitr3)

#library(leaps)

leap <- regsubsets(전월세가~범죄건수+정류장수+편의점수+카페수+학교수+대학교수+학원수+병원수, data=infra, nbest=8)
par(mfrow=c(1, 1))
plot(leap, scale="adjr2")

fitr4 <-lm(전월세가~정류장수+편의점수+카페수+학교수+학원수)
summary(fitr4)
vif(fitr4)
shapiro.test(resid(fitr4))

fitr5 <-lm(전월세가~학원수+학교수)
summary(fitr5)
vif(fitr5)
shapiro.test(resid(fitr5))

powerTransform(카페수)
powerTransform(학원수)
powerTransform(학교수)
powerTransform(전월세가)

View(infra)
infra<- infra[c(-1:-3)]
infra_cor <- cor(infra)
proj_cor <- cor(proj)
corrplot(infra_cor, method="number")


leap <- regsubsets(전월세가~학교수+학원수, data=infra, nbest=2)
par(mfrow=c(1, 1))
plot(leap, scale="adjr2")

reg <- lm(전월세가^0.05~대학교수+편의점수+log(카페수)+범죄건수+병원수+학교수+학원수+정류장수, data=infra)
reduce.reg<-step(reg, direction="backward")
reduce.reg

fitr1 <- lm(전월세가^0.05~편의점수+log(카페수)+학교수+학원수+정류장수)
summary(fitr1) # 람다승o : 55.81% 
shapiro.test(resid(fitr1)) # 람다승o  : 77.98% 
vif(fitr1)

fitr2 <- lm(전월세가^0.05~카페수+학교수+학원수)
summary(fitr2)
shapiro.test(resid(fitr2))


leapr1 <- regsubsets(전월세가^0.05~편의점수+log(카페수)+학교수+학원수+정류장수, data=infra, nbest=5)
par(mfrow=c(1, 1))
plot(leapr1, scale="adjr2")
ncvTest(reg)

reg <- lm(전월세가^0.05~편의점수+log(카페수)+학교수+학원수+정류장수, data=infra)
reduce.reg<-step(reg, direction="backward")
reduce.reg

leapr1 <- regsubsets(전월세가^0.05~대학교수+편의점수+log(카페수)+범죄건수+병원수+학교수+학원수+정류장수, data=infra, nbest=8)
par(mfrow=c(1, 1))
plot(leapr1, scale="adjr2")
ncvTest(reg)

plot(fitr1)
par(mfrow=c(2,2))

