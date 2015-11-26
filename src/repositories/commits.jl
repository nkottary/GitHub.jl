###############
# Commit Type #
###############

type Commit <: GitHubType
    sha::Nullable{GitHubString}
    message::Nullable{GitHubString}
    author::Nullable{Owner}
    committer::Nullable{Owner}
    commit::Nullable{Commit}
    url::Nullable{HttpCommon.URI}
    html_url::Nullable{HttpCommon.URI}
    comments_url::Nullable{HttpCommon.URI}
    parents::Nullable{Vector{Commit}}
    stats::Nullable{Dict}
    files::Nullable{Vector{Content}}
    comment_count::Nullable{Int}
end

Commit(data::Dict) = json2github(Commit, data)
Commit(sha::AbstractString) = Commit(Dict("sha" => sha))

namefield(commit::Commit) = commit.sha

###############
# API Methods #
###############

function commits(repo; options...)
    path = "/repos/$(name(repo))/commits"
    return map(Commit, github_get_json(path; options...))
end

function commit(repo, sha; options...)
    path = "/repos/$(name(repo))/commits/$(name(sha))"
    return Commit(github_get_json(path; options...))
end
