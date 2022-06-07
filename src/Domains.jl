module Domains

""" D-Dimensional domain """
abstract type AbstractDomain{T,D} end

# wrap
using DomainSets

import Base: *

include("common.jl")
include("interval.jl")
include("box.jl")
include("deform.jl")
#include("map.jl")

end # module Domains
