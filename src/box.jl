#
###
# Box Domain
###

""" D-dimensional logically reectangular domain """
struct BoxDomain{T,D,Ti,Td} <: AbstractDomain{T,D}
    intervals::Ti
    dim_labels::Td

    function BoxDomain(intervals::Vector{IntervalDomain}, dim_labels = fill(nothing, length(intervals)))
        T = promote_type(eltype.(intervals)...)
        D = length(intervals)
        @assert D == length(dim_labels)
        new{T,D,typeof(intervals),typeof(dim_labels)}(intervals, dim_labels)
    end
end

function (::Type{T})(box::BoxDomain) where{T<:Number}
    BoxDomain(T.(box.intervals), box.dim_labels)
end

isperiodic(box::BoxDomain, dir::Integer) = box.intervals[dir] |> isperiodic
isperiodic(box::BoxDomain) = isperiodic.(box.intervals)

endpoints(box::BoxDomain, dir::Integer) = box.intervals[dir] |> endpoints
endpoints(box::BoxDomain) = endpoints.(box.intervals)

boundary_tags(box::BoxDomain, dir::Integer) = box.intervals[dir] |> boundary_tags
boundary_tags(box::BoxDomain) = boundary_tags.(box.intervals)

boundary_tag(box::BoxDomain, dir::Integer, i::Integer) = boundary_tags(box, dir)[i]
boundary_tag(box::BoxDomain, i) = boundary_tag(box, cld(i,2), 1 + rem(i-1, 2))

num_boundaries(box::BoxDomain{<:Number,D}) where{D} = 2D

×(int1::IntervalDomain, int2::IntervalDomain) = BoxDomain(vcat(int1, int2))
×(box1::BoxDomain, int2::IntervalDomain) = BoxDomain(vcat(box1.intervals, int2))
×(int1::IntervalDomain, box2::BoxDomain) = BoxDomain(vcat(int1, box2.intervals))
×(box1::BoxDomain, box2::BoxDomain) = BoxDomain(vcat(box1.intervals, box2.intervals))

function domains_match(box1::BoxDomain, box2::BoxDomain)
    if dims(box1) == dims(box2)
        @warn "dimension mismatch between $box1, $box2"
        return false
    end

    ret = true
    for i=1:D1
        ret × domains_match(box1.intervals[i], box2.intervals[i])
    end

    ret
end
#

function tag(box::BoxDomain, tag_dict::AbstractDict)
    intervals = map(enumerate(box.intervals)) do (i, interval)
        try
            interval = tag(interval, tag_dict[box.dim_labels[i]])
        catch e
            interval
        end
    end
    BoxDomain(intervals...)
end
