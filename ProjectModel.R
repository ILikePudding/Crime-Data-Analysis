#Importing and trimming Data
crimeDataFull = read.csv("D:/Downloads/MATH4322 Group Project/Crime_Data_from_2010_to_2019.csv")
crimeDataFull = subset(crimeDataFull, Vict.Age != 0)
crimeDataFull = subset(crimeDataFull, crimeDataFull$Crm.Cd != 944)
crimeDataFull = subset(crimeDataFull, crimeDataFull$Crm.Cd != 954)
crimeDataFull = subset(crimeDataFull, crimeDataFull$Premis.Cd != 601)
crimeDataFull = subset(crimeDataFull, crimeDataFull$Premis.Cd != 750)
crimeDataFull = subset(crimeDataFull, crimeDataFull$Premis.Cd != 803)
crimeData = crimeDataFull[sample(1:nrow(crimeDataFull), 2500), ] 

#Creating Variables to Use
crimeData$isViolentCrime = ifelse(crimeData$Crm.Cd %in% c(952,231,230,624,622,623,860,840,761,235,627,813,814,922,753,822,921,882,236,626,910,920,956,762,760,435,436,113,820,625,946,932,122,121,438,931,210,810,815,251,250,821,763,928,647,756), 1, 0)
#Premise
crimeData$isInAlley = ifelse(crimeData$Premis.Cd == 103, 1, 0)
crimeData$isInApartment = ifelse(crimeData$Premis.Cd %in% c(139,502), 1, 0)
crimeData$isInBusiness = ifelse(crimeData$Premis.Cd %in% c(513, 227, 139, 711, 255, 217, 208, 408, 605, 602, 608, 607, 207, 733,409, 218, 414, 228, 247, 245, 248, 229, 219, 405, 252, 250, 713, 603, 230, 231, 232, 404, 242, 243, 714, 606, 142, 403, 412, 703, 209, 604, 413, 205, 407, 716, 734, 715, 222, 738, 202, 402, 239, 410, 401, 754, 220, 735, 249, 234, 203, 406, 211, 411, 235, 147, 732, 221, 225, 210, 706, 727, 737, 739, 742, 741, 216, 233, 238, 415, 716, 244, 206, 223, 236, 121), 1, 0)
crimeData$isInEducationLocation = ifelse(crimeData$Premis.Cd %in% c(722, 704, 721, 720, 723, 729, 724), 1, 0)
crimeData$isInGovernmentFac = ifelse(crimeData$Premis.Cd %in% c(725, 752, 726, 251), 1, 0)
crimeData$isInHealthcareFac = ifelse(crimeData$Premis.Cd %in% c(237, 701, 719, 246, 755), 1, 0)
crimeData$isInHotel = ifelse(crimeData$Premis.Cd %in% c(503), 1, 0)
crimeData$isInHouse = ifelse(crimeData$Premis.Cd %in% c(501, 516), 1, 0)
crimeData$isInJail = ifelse(crimeData$Premis.Cd %in% c(753), 1, 0)
crimeData$isInMotel = ifelse(crimeData$Premis.Cd %in% c(505), 1, 0)
crimeData$isInOtherPrem = ifelse(crimeData$Premis.Cd %in% c(506, 140, 117, 141, 708, 712, 748, 155, 728, 143, 707, 144, 744, 145, 743, 253, 731, 740, 710, 116, 109, 108, 123, 146, 125, 709, 148, 149, 746, 736, 138, 120, 730, 749, 150, 151, 107, 213, 751), 1, 0)
crimeData$isInOtherHome = ifelse(crimeData$Premis.Cd %in% c(512, 508, 104, 514, 517, 509, 510, 504, 119, 511, 518, 127), 1, 0)
crimeData$isInRoad = ifelse(crimeData$Premis.Cd %in% c(110, 808, 105, 102, 101, 106, 152), 1, 0)
crimeData$isInTownhouse = ifelse(crimeData$Premis.Cd %in% c(507), 1, 0)
crimeData$isInTransportation = ifelse(crimeData$Premis.Cd %in% c(115, 810, 807, 214, 124, 128, 112, 111, 804, 834, 809, 958, 874, 922, 903, 900, 801, 135, 153, 136, 811, 806, 130, 132, 131, 133, 134, 705, 114, 129, 215, 154, 126, 137, 212, 113, 156, 157, 122), 1, 0)
crimeData$isInWork = ifelse(crimeData$Premis.Cd %in% c(305, 118, 241, 203, 301, 204, 747, 702, 303, 254, 745), 1, 0)
#Race
crimeData$isWhite = ifelse(crimeData$Vict.Descent == 'W', 1, 0)
crimeData$isBlack = ifelse(crimeData$Vict.Descent == 'B', 1, 0)
crimeData$isHispanic = ifelse(crimeData$Vict.Descent == 'H', 1, 0)
crimeData$isOtherRace = ifelse(crimeData$Vict.Descent %in% c('W','B','H'), 0, 1)

#Things to use: Age, Time, Race, Premise, LAT, LON
#summary(crimeData)
#crimeData_pred = glm(crimeData$isViolentCrime ~ crimeData$Vict.Age + crimeData$TIME.OCC + crimeData$isWhite + crimeData$isBlack + crimeData$isHispanic + crimeData$isOtherRace, family="binomial")
crimeData_pred = glm(isViolentCrime ~ Vict.Age + TIME.OCC + isWhite + isBlack + isInAlley + isInApartment + isInBusiness + isInEducationLocation + isInGovernmentFac + isInHealthcareFac + isInHotel + isInHouse + isInJail + isInMotel + isInOtherPrem + isInOtherHome + isInRoad + isInTownhouse + isInWork + isHispanic + LAT + LON, data = crimeData, family="binomial")
summary(crimeData_pred)

#Splitting things into training and testing data
set.seed(2000)
meanPredError = 0
for(i in 1:10){
  trainCutOff = sample(1:nrow(crimeData), nrow(crimeData)*0.8)
  crimeDataTrain = crimeData[trainCutOff,]
  crimeDataTest = crimeData[-trainCutOff,]
  crimeDataTrainPred = glm(isViolentCrime ~ Vict.Age + TIME.OCC + isWhite + isBlack + isInAlley + 
                             isInApartment + isInBusiness + isInEducationLocation + 
                             isInGovernmentFac + isInHealthcareFac + isInHotel + isInHouse + 
                             isInJail + isInMotel + isInOtherPrem + isInOtherHome + isInRoad + 
                             isInTownhouse + isInWork + isHispanic + LAT + LON, 
                            data = crimeDataTrain, family="binomial")
  #summary(crimeDataTrainPred)
  crimeDataTestPred = glm(isViolentCrime ~ Vict.Age + TIME.OCC + isWhite + isBlack + isInAlley + 
                            isInApartment + isInBusiness + isInEducationLocation + 
                            isInGovernmentFac + isInHealthcareFac + isInHotel + isInHouse + 
                            isInJail + isInMotel + isInOtherPrem + isInOtherHome + isInRoad + 
                            isInTownhouse + isInWork + isHispanic + LAT + LON, 
                          data = crimeDataTest, family="binomial")
  crimeDataMSE = mean((crimeDataTest$isViolentCrime - 
                         predict(crimeDataTrainPred, newdata=crimeDataTest,type="response"))^2)
  meanPredError = meanPredError + sqrt(crimeDataMSE)
  print(sqrt(crimeDataMSE))
}
meanPredError = meanPredError / 10
print(meanPredError)


