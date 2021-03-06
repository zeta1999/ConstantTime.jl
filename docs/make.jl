using Documenter
using ConstantTime


makedocs(
    modules = [ConstantTime],
    format = Documenter.HTML(prettyurls=false),
    sitename = "ConstantTime.jl",
    authors = "Bogdan Opanchuk",
    pages = [
        "Home" => "index.md",
        "Version history" => "history.md",
    ],
)


function circleci_workaround()

    m = match(r"([\w\._-]+)/([\w\._-]+).git?$", ENV["CIRCLE_REPOSITORY_URL"])
    ENV["TRAVIS_REPO_SLUG"] = "$(m[1])/$(m[2])"

    ENV["TRAVIS_PULL_REQUEST"] = string(haskey(ENV, "CIRCLE_PULL_REQUEST"))

    if haskey(ENV, "CIRCLE_TAG")
        ENV["TRAVIS_TAG"] = ENV["CIRCLE_TAG"]
    end

    ENV["TRAVIS_BRANCH"] = ENV["CIRCLE_BRANCH"]
end


if haskey(ENV, "CIRCLECI")
    circleci_workaround()
end


deploydocs(
    repo = "github.com/nucypher/ConstantTime.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
