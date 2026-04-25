module AnalisisIA where

import TiposIA

-- FUNCIONES CON GUARDAS
-- clasificar desempeño según precision
clasificar :: Experimento -> Desempeno 
clasificar exp
    | precision exp >= 0.95 = Excelente 
    | precision exp >= 0.85 = Bueno 
    | precision exp >= 0.75 = Regular 
    | otherwise = Deficiente

-- FUNCIONES RECURSIVAS
-- 1. Contar experimentos
contarExperimentos :: [Experimento] -> Int
contarExperimentos [] = 0 --caso base
contarExperimentos (_:xs) = 1 + contarExperimentos xs --recursivo

-- 2. Sumar epocas
sumarEpocas :: [Experimento] -> Int
sumarEpocas [] = 0
sumarEpocas (x:xs) = epocas x + sumarEpocas xs

-- 3. Buscar modelo por nombre
buscarModelo :: String -> [Experimento] -> Bool
buscarModelo _ [] = False
buscarModelo nombre (x:xs)
    | modelo x == nombre = True
    | otherwise = buscarModelo nombre xs

-- FUNCIONES DE ANALISIS
-- promedio de precisión
promedioPrecision :: [Experimento] -> Float
promedioPrecision expList = 
    let total = sum [precision e | e <- expList]
        cantidad = fromIntegral (length expList)
    in total / cantidad

-- promedio de perdida
promedioPerdida :: [Experimento] -> Float
promedioPerdida expList = 
    let total = sum [perdida e | e <- expList]
        cantidad = fromIntegral (length expList)
    in total / cantidad

-- modelo con mejor precisión
mejorPrecision :: [Experimento] -> Experimento
mejorPrecision (x:xs) = mejorPrecisionAux x xs
  where
    mejorPrecisionAux mejor [] = mejor
    mejorPrecisionAux mejor (y:ys)
        | precision y > precision mejor = mejorPrecisionAux y ys
        | otherwise = mejorPrecisionAux mejor ys

-- filtrado por umbral
filtrarPorUmbral :: Float -> [Experimento] -> [Experimento]
filtrarPorUmbral umbral expList = [e | e <- expList, precision e >= umbral]

-- Tuplas
obtenerTuplas :: [Experimento] -> [(String, Float)]
obtenerTuplas expList = [(modelo e, precision e) | e <- expList]

-- modelos excelente o buenos
modelosExcelentesOBuenos :: [Experimento] -> [Experimento]
modelosExcelentesOBuenos expList = 
    [e | e <- expList, clasificar e == Excelente || clasificar e == Bueno]

-- FUNCIONES CON AJUSTE DE PATRONES
-- lista vacia
esListaVacia :: [a] -> Bool 
esListaVacia [] = True 
esListaVacia _  = False

-- obtener primer elemento
primerExperimento :: [Experimento] -> Maybe Experimento
primerExperimento [] = Nothing
primerExperimento (x:_) = Just x

-- extraer solo los nombres
extraerNombres :: [Experimento] -> [String]
extraerNombres [] = []
extraerNombres (x:xs) = modelo x : extraerNombres xs