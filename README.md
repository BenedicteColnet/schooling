# Schooling induces a gender gap in math: Evidence from 2 million children


This repository contains the code used for data treatment, analysis, and plots production of the paper entitled "Schooling induces a gender gap in math: Evidence from 2 million children".


For privacy reasons, the associated data can not be made public. But to ensure reproducible science and peer review, the code used to analyze the data is made public.

In particular, the scripts are written in `R`,and each notebook or script contains one step.

- `1_Article_preproces.Rmd` contains the data preprocessing, such as the management of missing values.
- `2_Article_composite_covariate.Rmd` contains the script to create composite covariates, such as the averaged scores per period.
- `3_Article_create_classes.Rmd` contains the script to generate a data set with covariates averaged on each class.
- `4_Article_Graph_Finaux_1.rmd`, `4_Article_Graph_Finaux_2.rmd`, `6_Article_Graph_Finaux_3.rmd`, `9_Matching_plots.Rmd` contains the scripts to plot the Figures of the article.
- `7_Article_Data_Modeles_Final_VF.Rmd` and `8_Article_Multini_Math_Final_VF.Rmd` contains the model
- `Matching_script.R` contains the matching procedure (as it takes time to run on a typical personal computer, matching was launched on clusters, and then results were analyzed through `9_Matching_plots.Rmd`)
