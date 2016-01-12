library("Boruta")
library("mlbench")
data(Ozone)
Ozone = na.omit(Ozone)

# str(Ozone)

set.seed(1)
Boruta.Ozone =Boruta(V4 ~ . , data  = Ozone, doTrace = 2, ntree= 500)
Boruta.Ozone
# plot(Boruta.)