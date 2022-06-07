module Domains

""" D-Dimensional domain """
abstract type AbstractDomain{T,D} end

using Symbolics

import UnPack: @unpack
import Setfield: @set!

# overload
import Base: ∈, *, length
import Base: summary, display

# wrap
using DomainSets
using IntervalSets

# ref
# https://github.com/SciML/ModelingToolkit.jl/blob/master/src/domains.jl
# https://github.com/JuliaSymbolics/Symbolics.jl/blob/master/src/domains.jl

include("common.jl")
include("interval.jl")
include("box.jl")
include("deform.jl")
#include("map.jl")
#include("jac_map.jl")

end # module Domains
