using Documenter, Maui

pages = [
    "Home" => "index.md",
        ],
]

makedocs(
   sitename = "FourierFlows.jl",
    authors = "Nick Lucido",
    # modules = [Maui],
     # format = format,
      pages = pages,
    doctest = true,
     # strict = true,
      clean = true,
  # checkdocs = :exports
)

deploydocs(
    repo = "github.com/NickLucido/Maui.jl.git",
)
