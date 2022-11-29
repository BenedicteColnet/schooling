knitr::opts_chunk$set(echo = TRUE)

# Seed because random sampling and matching
set.seed(123)

# Parameters to set before launch of the pipeline
IMPUTED = "imputed" # "imputed" "non-imputed"
ANNEE_COHORTE = "2018" 
SCENARIO = 7
ESTIMAND = "ATT" # effect of being a girl

# Libraries
library(MatchIt)

# Data loading
load(paste0("./data/cohort_", ANNEE_COHORTE, "_", IMPUTED, "_after_2_composite_covariate.RData"))



covariates_used_for_matching <- c(Math_T1_P, "T1_Language", "Categ_Etab_CP", "IPS_Etab_CP", "Age_CP", "ID_Classe_CP")
data.to.match <- data_depp[, c(covariates_used_for_matching, "T1_Math_Rank", "T2_Math_Rank", "T3_Math_Rank", "Sexe", "ID_Eleve", "T2_Lire_Text_Cut_P_Rank")]

data.to.match$Sexe <- ifelse(data.to.match$Sexe == "Girls", 1, 0)


if (SCENARIO == 0){
  data.to.match[, c("T1_Language", Math_T1_P, "IPS_Etab_CP") ] <- round(data.to.match[, c("T1_Language", Math_T1_P, "IPS_Etab_CP")], 0)
  
  matched.data <- matchit(Sexe ~ Categ_Etab_CP + IPS_Etab_CP + Age_CP + T1_Language + T1_Ecri_Nombre_P + T1_Lire_Nombre_P + T1_Resoud_Pb_P + T1_Denombrer_P + T1_Compa_Nombre_P + T1_Ligne_Num_P, 
                          method = "exact", 
                          #cutpoints = list(IPS_Etab_CP = 10, Age_CP = 6), # IPS binned in 10, and age tolerate to 2 months
                          #k2k = TRUE,
                          discard = "both",
                          estimand = ESTIMAND,
                          data = data.to.match)  
  
} else if (SCENARIO == 1){
  data.to.match[, c("T1_Language", Math_T1_P, "IPS_Etab_CP") ] <- round(data.to.match[, c("T1_Language", Math_T1_P, "IPS_Etab_CP")], 0)
  
  matched.data <- matchit(Sexe ~ Categ_Etab_CP + IPS_Etab_CP + Age_CP + T1_Language + T1_Ecri_Nombre_P + T1_Lire_Nombre_P + T1_Resoud_Pb_P + T1_Denombrer_P + T1_Compa_Nombre_P + T1_Ligne_Num_P, 
                          method = "cem", 
                          cutpoints = list(IPS_Etab_CP = 10, Age_CP = 6), # IPS binned in 10, and age tolerate to 2 months
                          k2k = TRUE,
                          #discard = "both", # not used with coarsened matching
                          estimand = ESTIMAND,
                          data = data.to.match)  
  
} else if (SCENARIO ==  2) {
  data.to.match[, c("T1_Language", Math_T1_P) ] <- round(data.to.match[, c("T1_Language", Math_T1_P)], 0)
  
  matched.data <- matchit(Sexe ~ Categ_Etab_CP + IPS_Etab_CP + Age_CP + T1_Language + T1_Ecri_Nombre_P + T1_Lire_Nombre_P + T1_Resoud_Pb_P + T1_Denombrer_P + T1_Compa_Nombre_P + T1_Ligne_Num_P, 
                          method = "cem", 
                          cutpoints = list(IPS_Etab_CP = 10, Age_CP = 4), # IPS binned in 10, and age tolerate to 3 months
                          k2k = TRUE,
                          grouping = list(Categ_Etab_CP = list(c("Public", "Private"), c("REP", "REP+"))),
                          #discard = "both", # not used with coarsened matching
                          estimand = ESTIMAND,
                          data = data.to.match)  
  
}


file.name <- paste0("./results/output_13_Matching_", IMPUTED, "_", ANNEE_COHORTE, "_SCENARIO_", SCENARIO, "_", ESTIMAND, ".RData")

save(matched.data, data.to.match, file = file.name)




