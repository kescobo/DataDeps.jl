const registry = Dict{String, AbstractDataDep}()

function RegisterDataDep(name::String, remotepath, hash;
        fetch_method=download,
        post_fetch_method=identity,
        extra_message="")
    if haskey(registry, name)
        warn("Over-writing registration of the datadep: $name")
    end
    registry[name] = DataDep(name,remotepath,hash,fetch_method,post_fetch_method, extra_message)
end

function RegisterDataDep(name::String, message::String)
    if haskey(registry, name)
        warn("Over-writing registration of the datadep: $name")
    end
    registry[name] = ManualDataDep(name, message)
end

"""
    is_valid_name(name)

This checks if a datadep name is valid.
This basically means it must be a valid folder name on windows.

"""
function is_valid_name(name)
    namechars = collect(name)
    !any( namechars .∈ "\\/:*?<>|") && !any(Base.UTF8prox.iscntrl.(namechars))
end
