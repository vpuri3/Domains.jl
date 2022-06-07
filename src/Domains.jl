module Domains

""" $D dimensional domain """
abstract type AbstractDomain{T,D} end

import Base: *

include("common.jl")
include("interval.jl")
include("box.jl")
include("deform.jl")
#include("map.jl")

end # module Domains
