Pkg.update()

Pkg.add("IJulia")
 # Kernal for Jupyter, requires jupyter already in PATH
 # https://github.com/JuliaLang/IJulia.jl

Pkg.add("Gadfly")
 # http://gadflyjl.org
 # Plotting and data visualisation

Pkg.add("RDatasets")
 # https://github.com/johnmyleswhite/RDatasets.jl
 # The RDatasets package provides an easy way for Julia users to experiment with
 # most of the standard data sets that are available in the core of R as well as
 # datasets included with many of R's most popular packages.

# Pkg.add("HDF5")
 # https://github.com/JuliaIO/HDF5.jl
 # HDF5 is a file format and library for storing and accessing data, commonly
 # used for scientific data. HDF5 files can be created and read by numerous
 # programming languages. This package provides an interface to the HDF5 library
 # for the Julia language.

# Pkg.add("TensorFlow")
 # https://github.com/malmaud/TensorFlow.jl
 # Wrapper around TensorFlow, the popular open source dataflow library for
 # symbolic maths, machine learning, neural networks from Google.

# TODO consider these, the top 20 all time Julia Packages
# DONE IJulia - Julia Kernal for Jupyter
# DONE Gadfly - Plotting and data visualisation
#      Mocha - Deep Learning
#      Knet - Deep Learning
#      JuMP - Mathematical Optimization (linear, mixed-integer, conic, semidefinite, nonlinear)
#      DataFrames - Tools for working with tabular data
#      Plots - visualizations and data analysis
#      DifferentialEquations - solve differential equations
#      PyCall - call and fully interoperate with Python
#      DSGE - Solve and estimate Dynamic Stochastic General Equilibrium models
#      Cxx - C++ Foreign Function Interface (FFI) and REPL.
# DONE TensorFlow - TensorFlow
#      Distributions - probability distributions and associated functions
#      Optim - Optimization functions for Julia
#      Escher -  UI components
#      MXNet - Deep Learning
#      Flux - ML library
#      Convex - Disciplined Convex Programming
#      Turing - probabilistic programming
