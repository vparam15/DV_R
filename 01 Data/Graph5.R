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
