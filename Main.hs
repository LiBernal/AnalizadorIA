module Main where

import TiposIA
import AnalisisIA
import ArchivoIA
import System.IO

-- Programa principal:
-- importa los módulos anteriores
main :: IO ()
main = do
    -- Mostrar inicio
    putStrLn "=== SISTEMA DE ANALISIS DE EXPERIMENTOS IA ===\n"
    
    -- Leer archivo
    experimentos <- leerExperimentos "experimentos.txt"
    
    -- Mostrar datos leídos
    putStrLn $ "Se encontraron " ++ show (length experimentos) ++ " experimentos\n"
    
    -- Mostrar análisis en consola
    putStrLn "=== ANALISIS EN CONSOLA ===\n"
    
    -- Total de modelos
    putStrLn $ "Total de modelos: " ++ show (contarExperimentos experimentos)
    
    -- Promedio de precisión
    putStrLn $ "Promedio de precision: " ++ show (promedioPrecision experimentos)
    
    -- Promedio de pérdida
    putStrLn $ "Promedio de perdida: " ++ show (promedioPerdida experimentos)
    
    -- Suma de épocas
    putStrLn $ "Suma total de epocas: " ++ show (sumarEpocas experimentos)
    
    -- Mejor modelo
    let mejor = mejorPrecision experimentos
    putStrLn $ "\n=== MEJOR MODELO ==="
    putStrLn $ "Modelo: " ++ modelo mejor
    putStrLn $ "Precision: " ++ show (precision mejor)
    putStrLn $ "Clasificacion: " ++ show (clasificar mejor)
    
    -- Clasificación de todos
    putStrLn $ "\n=== CLASIFICACION POR MODELO ==="
    mapM_ imprimirClasificacion experimentos
    
    -- Buscar un modelo específico
    putStrLn $ "\n=== BUSQUEDA DE MODELOS ==="
    let modeloBuscar = "CNN"
    if buscarModelo modeloBuscar experimentos
        then putStrLn $ " El modelo '" ++ modeloBuscar ++ "' existe en los datos"
        else putStrLn $ " El modelo '" ++ modeloBuscar ++ "' no se encontró"
    
    -- Generar y guardar reporte
    putStrLn "\nGenerando reporte completo..."
    let reporte = generarReporte experimentos
    escribirReporte "reporte.txt" reporte
    
    -- Mostrar ubicación del reporte
    putStrLn "\n=== PROGRAMA FINALIZADO ==="
    putStrLn "Revisa el archivo 'reporte.txt' para ver el análisis completo"
    
    -- Ejemplo de uso de función con patrones
    putStrLn "\n=== EJEMPLOS DE FUNCIONES CON PATRONES ==="
    putStrLn $ "¿Lista vacía? " ++ show (esListaVacia experimentos)
    case primerExperimento experimentos of
        Just exp -> putStrLn $ "Primer modelo: " ++ modelo exp
        Nothing -> putStrLn "No hay experimentos"
    putStrLn $ "Nombres de modelos: " ++ show (extraerNombres experimentos)

-- Función auxiliar para imprimir clasificación
imprimirClasificacion :: Experimento -> IO ()
imprimirClasificacion exp = do
    let desem = clasificar exp
    putStrLn $ "  " ++ modelo exp ++ ": " ++ 
                show (precision exp) ++ " -> " ++ show desem
