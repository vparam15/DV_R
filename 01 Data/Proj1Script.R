require(dplyr)
require(extrafont)
require(ggplot2)
require(ggthemes)
require(gplots)
require(grid)
require(jsonlite)
require(lubridate)
require(RCurl)
require(reshape2)
require(rstudioapi)
require(tableplot)
require(tidyr)
require(jsonlite)
require(RCurl)
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from titanic"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_vp5467', PASS='orcl_vp5467', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
summary(df)
head(df)

require(extrafont)

#Chart 1: Age and fare of all data points, including those for which sex is null.
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Titanic') +
  labs(x="Age", y=paste("Fare")) +
  layer(data=df, 
        mapping=aes(x=as.numeric(as.character(AGE)), y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

#Chart 2: Age and fare of all data points for which sex is not null.
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Titanic') +
  labs(x="Age", y=paste("Fare")) +
  layer(data=subset(df, SEX != 'null'), 
        mapping=aes(x=as.numeric(as.character(AGE)), y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

#Chart 3: All passengers for which sex is not null, divided by sex and ranked by fare. Dot color indicates survival.
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_grid(PCLASS~SURVIVED) +
  labs(title='Titanic') +
  labs(x="SURVIVED", y=paste("FARE")) +
  layer(data=subset(df, SEX != 'null'), 
        mapping=aes(x=SEX, y=as.numeric(as.character(FARE)), color=as.character(SURVIVED)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

#Chart 4: All passengers for which sex is not null, divided by sex, passenger class, and survival and ranked by fare.
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_grid(PCLASS~SURVIVED, labeller = label_both) +
  labs(title='Titanic') +
  labs(x="SURVIVED", y=paste("FARE")) +
  layer(data=subset(df, SEX != 'null'), 
        mapping=aes(x=as.character(SEX), y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

#Chart 5: All passengers aged 10 and younger for which sex is not null, divided by sex, passenger class, and survival and ranked by fare.
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_grid(PCLASS~SURVIVED, labeller = label_both) +
  labs(title='Titanic where age <= 10') +
  labs(x="SURVIVED", y=paste("FARE")) +
  layer(data=subset(df, as.numeric(as.character(AGE)) <= 10), 
        mapping=aes(x=as.character(SEX), y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

#Chart 6: All passengers for which sex is not null, divided by survival and sex and ordered by fare and age.
ggplot() + 
  coord_cartesian() +
  scale_x_continuous() +
  scale_y_continuous() +
  facet_grid(SURVIVED~SEX, labeller = label_both) +
  labs(title='Survival by age, fare, and sex',x='Age',y='Fare') +
  layer(data=subset(df, SEX != 'null'),
        mapping=aes(x=as.numeric(as.character(AGE)),y=as.numeric(as.character(FARE)),color=SEX),
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )
  