#
###
# DeformedDomain
###

"""
Deform D-dimensional domain via mapping

args:
   -reference domain
   -mapping function
        (x1,...,xD) = map(r1, ..., rD)
   -isrescaling - do optimizations if
    mapping is a simple rescaling
        x1 = a1 + λ1 * x1(r1), ...,
        xD = aD + λD * xD(rD)
   -isseparable - do optimizations if
    mapping is separable
        x1 = x1(r1), ...,
        xD = xD(rD)
"""
struct DeformedDomain{T,D,Tdom<:AbstractDomain{T,D}, Tm} <: AbstractDomain{T,D}
    domain::Tdom
    mapping::Tm
    isseparable::Bool
    isrescaling::Bool
end

function deform(domain, mapping = nothing;
                isseparable = false, isrescaling = false
               )
    DeformedDomain(domain, mapping, isseparable, isrescaling)
end

function (::Type{T})(dom::DeformedDomain) where{T<:Number}
    BoxDomain(T(dom), dom.mapping, dom.isseparable, dom.isrescaling)
end

