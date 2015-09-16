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
