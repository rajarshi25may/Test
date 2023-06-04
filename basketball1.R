library(tidyverse)
require(cowplot)

sc <- read_csv("steph_curry_shot_data.csv")
lj <- read_csv("lebron_james_shot_data.csv")
kd <- read_csv("kevin_durant_shot_data.csv")


# CDF comparing Shot distance for Shots made
sc_shot_made <- filter(sc, shot_made==1)
lj_shot_made <- filter(lj, shot_made==1)
kd_shot_made <- filter(kd, shot_made==1)

sc_distance_made<-sc_shot_made$shot_distance
lj_distance_made<-lj_shot_made$shot_distance
kd_distance_made<-kd_shot_made$shot_distance

ggplot()+
  stat_ecdf(data=sc_shot_made, aes(shot_distance), color="darkblue" )+
  stat_ecdf(data=lj_shot_made, aes(shot_distance),  color="darkred" )+
  stat_ecdf(data=kd_shot_made, aes(shot_distance),  color="purple" )+
  xlab("Distance to basket for shot made, CDF")+
  ylab("")
ggsave("Comparisonbetweenplayers1.pdf")

threeplayers<-bind_rows(list( "Stephen Curry"=sc, "Lebron James"=lj, "Kevin Durrant"=kd) , .id="player")
threeplayers_shots_made <- filter(threeplayers, shot_made==1)
ggplot(three_players_shots_made, aes(shot_distance, colour=player))+
  geom_density(kernel="gaussian")
ggsave("Comparisonbetweenplayers2.pdf")

ggplot(threeplayers_shots_made,aes(player,shot_distance))+
  geom_boxplot()
      
  +
  coord_flip()+
  xlab("")+
  ylab("Boxplots of distance of shot made, by player")+
  theme_minimal()


ggsave("boxplot.pdf")
