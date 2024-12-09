## 2024-12-09
## microdatasus - https://github.com/rfsaldanha/microdatasus

## Saldanha et al. (2019) - https://doi.org/10.1590/0102-311X00032419
## Paiva et al. (2022) - https://doi.org/10.1590/0102-311XPT096622
## Xavier (2024) - https://medium.com/@danielly.bx/realizando-download-de-dados-p%C3%BAblicos-do-datasus-com-o-pacote-microdatasus-do-r-218cf4181e47

## Instalar e carregar os pacotes necessários
#install.packages("remotes")
#remotes::install_github("rfsaldanha/microdatasus")
library(microdatasus)

## Dados de Autorização de Internação Hospitalar (AIH) reduzidas do Distrito Federal em Dezembro/2008
sih_df <- fetch_datasus(year_start = 2008, year_end = 2008, 
                        month_start = 12, month_end = 12, 
                        uf = "DF", 
                        information_system = "SIH-RD")
View(sih_df)

## Importando dados de variáveis específicas (duas possibilidades)
## 1: Definindo um vetor de variáveis (recomendável, boas práticas)
vars_select = c("MORTE", "CID_MORTE", "DIAG_PRINC")
sih_df_vars1 <- fetch_datasus(year_start = 2008, year_end = 2008, 
                              month_start = 12, month_end = 12, 
                              uf = "DF", vars = vars_select,
                              information_system = "SIH-RD")
View(sih_df_vars1)

## 2: Definindo as variáveis diretamente na função
sih_df_vars2 <- fetch_datasus(year_start = 2008, year_end = 2008, 
                              month_start = 12, month_end = 12, 
                              uf = "DF", vars = c("MORTE", "CID_MORTE", "DIAG_PRINC"),
                              information_system = "SIH-RD")
View(sih_df_vars2)

## Importado dados de UFs específicas
ufs = c("DF", "GO", "MT", "MS")
sih_uf <- fetch_datasus(year_start = 2008, year_end = 2008, 
                        month_start = 12, month_end = 12, 
                        uf = ufs, vars = vars_select,
                        information_system = "SIH-RD")
View(sih_uf)

## Selecionando dados de CIDs específicas
## Função fetch_datasus() não permite definir as CID de interesse durante o download.
## Precisamos utilizar outras funções/pacotes do R.

## Definir CIDs de interesse
cids_select = c("J13", "J14")

## 1. Função subset, RBase
sih_uf_filtrado <- subset(sih_uf, DIAG_PRINC %in% cids_select)
View(sih_uf_filtrado)

## 2. Seleção por coluna
sih_uf_filtrado2 <- sih_uf[sih_uf$DIAG_PRINC %in% cids_select, ]
View(sih_uf_filtrado2)

## 3. Tidyverse
#install.packages("tidyverse")
library(tidyverse)
sih_uf_filtrado3 <- sih_uf |>
View(sih_uf_filtrado3)
  filter(DIAG_PRINC %in% cids_select)