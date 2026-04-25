# Functional AI Experiment Analysis System

A modular Haskell system for analyzing results from AI model experiments. This project was developed as a practical exercise in functional programming, demonstrating key Haskell concepts including custom data types, pattern matching, recursion, file handling, and automated reporting.

## Features

- Reads experimental data from a plain text file
- Processes multiple experiment results using list recursion and guards
- Calculates performance metrics (accuracy, precision, recall, F1-score)
- Classifies models by performance level (Excellent, Good, Average, Poor)
- Generates an automatic report saved to `reporte.txt`
- Fully modular design with separate modules for types, analysis, and I/O
