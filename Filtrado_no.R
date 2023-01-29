library(openxlsx)
library(DataCombine)

# importar datos

monr <- read.xlsx("data/INPUT_ameresco.xlsx")

# quitamos las conversaciones dobles
monr <- subset(monr, id_conv != "MÇx.EC.1.txt")
monr <- subset(monr, id_conv != "MÇx.EC.2.txt")
monr <- subset(monr, id_conv != "MÇx.EC.3.txt")
monr <- subset(monr, id_conv != "MÇx.LS.1.txt")


# CAMBIO DE ID DE CONVERSACIONES A LA NOMENCLATURA AMERESCO

monr$id_conv <- gsub("MÇx.AC.3.txt",
                     "MTY_001_02_15",
                     monr$id_conv,
                     perl = TRUE)

monr$id_conv <- gsub("MÇx.AC.4.txt",
                     "MTY_003_02_15",
                     monr$id_conv,
                     perl = TRUE)


monr$id_conv <- gsub("MÇx.JM.2.txt",
                     "MTY_015_02_15",
                     monr$id_conv,
                     perl = TRUE)

monr$id_conv <- gsub("MÇx.KA.4.txt",
                     "MTY_013_02_13",
                     monr$id_conv,
                     perl = TRUE)


monr$id_conv <- gsub("MÇx.LS.2.txt",
                     "MTY_054_03_15",
                     monr$id_conv,
                     perl = TRUE)

monr$id_conv <- gsub("MÇx.MM.20.txt",
                     "MTY_026_04_15",
                     monr$id_conv,
                     perl = TRUE)


monr$id_conv <- gsub("Word",
                     "MTY_053_03_15",
                     monr$id_conv,
                     perl = TRUE)


# eliminar .eaf en el ID de las conversaciones
monr$id_conv <- gsub(".eaf",
                     "",
                     monr$id_conv,
                     perl = TRUE)

# añadir columna con la ID del hablante 
monr$id_h <- paste(data.no$id_conv, data.no$participante, sep = "_")




# filtrar 
no <-  grepl.sub(data = monr, # the df
                 pattern = "¿no?", # concordance
                 Var = "intervencion") # the column


# eliminar la columna de tiempos (no son necesarias para este análisis) y la de participante porque está vacía

no <- subset(no, select = -c(tmin, tmax, participante))

# reordenar columnas

no <-.no[ , c(1,4,2,3)]



data.no$Contexto <- gsub("¿no",
                         "\n¿no\n",
                         data.no$Contexto,
                         perl = TRUE)

write.xlsx(no, "corpus/OUTPUT_no_Monr.xlsx")

