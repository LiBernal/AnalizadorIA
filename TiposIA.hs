module TiposIA where

-- definicion del tipo Experimento
data Experimento = Experimento {
    modelo :: String,
    precision :: Float,
    perdida :: Float,
    epocas :: Int
} deriving (Show, Eq)


-- definicion del tipo Desempeño
data Desempeno = Excelente | Bueno | Regular | Deficiente 
    deriving (Show, Eq)

-- función auxiliar para crear un experimento más fácil
crearExperimento :: String -> Float -> Float -> Int -> Experimento
crearExperimento = Experimento