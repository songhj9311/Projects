#### 경제적 요인 ####

fitt <- lm(면적당거래가격~GDP) 
summary(fitt)  # 람다승 x  : 72.37%,  람다승 : 83.17%
shapiro.test(resid(fitt))  #람다승 x  : 만족X, 람다승o : 9.308%(만족o)

fit6 <- lm(면적당거래가격^-1~GDP+log(기준금리))
summary(fit6) # 람다승 o : 84.98%
shapiro.test(resid(fit6)) # 정규분포o : 11.14% 

fitt1 <- lm(면적당거래가격^-1 ~ GDP+log(기준금리)+실업율+인구이동률)
reduce.reg<-step(fitt1, direction="backward")
reduce.reg


### 람다 값 
powerTransform(면적당거래가격) #-1
powerTransform(실업율) # 0.73997
powerTransform(인구이동률) # -0.1151336
powerTransform(GDP) # 0.8564891

Step:  AIC=-1170.77
면적당거래가격^-1 ~ GDP + log(기준금리)

#Df  Sum of Sq        RSS     AIC
#<none>                        2.0743e-06 -1170.8
#- log(기준금리)  1 2.8520e-07 2.3595e-06 -1164.0
#- GDP            1 3.2519e-06 5.3262e-06 -1108.6

전월세가 

fitr1 <- lm(전월세가^0.05~편의점수+log(카페수)+학교수+학원수)
summary(fitr1) # 람다승o : 55.81% 
shapiro.test(resid(fitr1)) # 람다승o  : 77.98%


fitr1 <- lm(전월세가^0.05~편의점수+log(카페수)+학교수+학원수+정류장수)
summary(fitr1) # 람다승o : 56.68% 
shapiro.test(resid(fitr1)) # 람다승o  : 94.19
# 설명계수는 올라가지만 정류장은 유의미한 값이 아니다


