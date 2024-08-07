using QuantumCircuits
using Documenter

DocMeta.setdocmeta!(QuantumCircuits, :DocTestSetup, :(using QuantumCircuits); recursive=true)

makedocs(;
    modules=[QuantumCircuits],
    authors="Piyush Kumar Singh <pksx9120@gmail.com>",
    sitename="QuantumCircuits.jl",
    format=Documenter.HTML(;
        canonical="https://iamPiyushKrSingh.github.io/QuantumCircuits.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => Any[
            "Random Matrices"=>"man/randMatrix.md",
            "Circuit Utilities"=>"man/circuitUtils.md",
            "Circuit Evolution"=>"man/circuitEvolve.md"
        ],
        "Public API" => "source.md",
    ],
)

deploydocs(;
    repo="github.com/iamPiyushKrSingh/QuantumCircuits.jl",
    devbranch="main",
)
