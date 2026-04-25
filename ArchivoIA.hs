module ArchivoIA where

import TiposIA
import AnalisisIA
import System.IO

-- leer archivo
leerExperimentos :: String -> IO [Experimento]
leerExperimentos nombreArchivo = do
    contenido <- readFile nombreArchivo
    let lineas = lines contenido
        -- Saltar la cabecera (primera línea)
        datos = drop 1 lineas
    return (map parsearLinea datos)

-- parsear una línea del archivo
parsearLinea :: String -> Experimento
parsearLinea linea = 
    let palabras = words linea
    in case palabras of
        [nombre, prec, perd, ep] -> Experimento {
            modelo = nombre,
            precision = read prec,
            perdida = read perd,
            epocas = read ep
        }
        _ -> error $ "Formato incorrecto en linea: " ++ linea

-- escribir reporte final
generarReporte :: [Experimento] -> String
generarReporte expList = 
    let total = length expList
        promPrec = promedioPrecision expList
        promPerd = promedioPerdida expList
        sumaEpo = sumarEpocas expList
        mejor = mejorPrecision expList
        excelentesBuenos = modelosExcelentesOBuenos expList
        tuplas = obtenerTuplas expList
    in unlines [
        "================== REPORTE DE EXPERIMENTOS ==================",
        "",
        "RESUMEN GENERAL:",
        "-----------------",
        "Total de modelos analizados: " ++ show total,
        "Promedio de precision: " ++ show promPrec,
        "Promedio de perdida: " ++ show promPerd,
        "Suma total de epocas: " ++ show sumaEpo,
        "",
        "MEJOR MODELO:",
        "-----------------",
        "Modelo: " ++ modelo mejor,
        "Precision: " ++ show (precision mejor),
        "Perdida: " ++ show (perdida mejor),
        "Epocas: " ++ show (epocas mejor),
        "Desempeno: " ++ show (clasificar mejor),
        "",
        "CLASIFICACION DE MODELOS:",
        "-----------------",
        "Modelos Excelentes o Buenos: " ++ show (length excelentesBuenos),
        unlines [ "  - " ++ modelo m ++ " (" ++ show (precision m) ++ ") -> " ++ show (clasificar m) | m <- excelentesBuenos ],
        "",
        "LISTA DE TODOS LOS MODELOS (Modelo, Precision):",
        "-----------------",
        unlines [ "  - " ++ fst t ++ ": " ++ show (snd t) | t <- tuplas ],
        "",
        "DETALLE COMPLETO:",
        "-----------------",
        unlines [ "Modelo: " ++ modelo e ++ 
                  " | Precision: " ++ show (precision e) ++ 
                  " | Perdida: " ++ show (perdida e) ++ 
                  " | Epocas: " ++ show (epocas e) ++
                  " | Desempeno: " ++ show (clasificar e) 
                | e <- expList],
        "============================================================="
    ]

-- Escribir reporte a archivo
escribirReporte :: String -> String -> IO ()
escribirReporte nombreArchivo contenido = do
    writeFile nombreArchivo contenido
    putStrLn $ "Reporte generado exitosamente en: " ++ nombreArchivo