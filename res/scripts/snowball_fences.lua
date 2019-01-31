local transf = require "transf"
local vec4 = require "vec4"
local poly = require "snowball_fences_polygon"
local vec3 = require "snowball_fences_vec3"
local mat3 = require "snowball_fences_mat3"
local plan = require "snowball_fences_planner"

local fences = {}

fences.markerStore = nil
fences.finisherStore = nil
fences.markerId = "asset/snowball_fences_marker.mdl"
fences.finisherId = "asset/snowball_fences_finisher.mdl"
fences.firstRun = nil
fences.lastMarker = nil
fences.zone = "fencezone"

fences.fences = {
    {
        name=_("snowball_fences_fence_wood"),
        post = "asset/snowball_farmer_fences/wood_post.mdl",
        middle = "asset/snowball_farmer_fences/wood_middle.mdl",
        length = 3.0
    },
    {
        name=_("snowball_fences_fence_metal"),
        post = "asset/snowball_farmer_fences/metal_post.mdl",
        middle = "asset/snowball_farmer_fences/metal_middle.mdl",
        length = 2.8
    },
    {
        name=_("snowball_fences_fence_cow"),
        post = "asset/snowball_farmer_fences/cow_post.mdl",
        middle = "asset/snowball_farmer_fences/cow_middle.mdl",
        length = 2.11874
    },
    {
        name=_("snowball_farmer_fence_brick").." 1",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_01.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 2",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_02.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 3",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_03.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 4",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_04.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 5",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_05.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 6",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_06.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 7",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_07.mdl",
        length = 3
    },
    {
        name=_("snowball_farmer_fence_brick").." 8",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_08.mdl",
        length = 3
    },
    --[[{
        name=_("snowball_farmer_fence_brick").." 9",
        post = "asset/snowball_farmer_fences/brick_wall1_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall1_middle_09.mdl",
        length = 3
    },]]
    {
        name=_("snowball_farmer_fence_white").." 1",
        post = "asset/snowball_farmer_fences/brick_wall2_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall2_middle_01.mdl",
        length = 2
    },
    {
        name=_("snowball_farmer_fence_white").." 2",
        post = "asset/snowball_farmer_fences/brick_wall2_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall2_middle_02.mdl",
        length = 2
    },
    {
        name=_("snowball_farmer_fence_white").." 3",
        post = "asset/snowball_farmer_fences/brick_wall2_post_01.mdl",
        middle = "asset/snowball_farmer_fences/brick_wall2_middle_03.mdl",
        length = 1.8
    },
    {
        name=_("snowball_farmer_fence_plate"),
        post = nil,
        middle = "asset/snowball_farmer_fences/brick_wall3_middle_01.mdl",
        length = 2.2
    },
    --[[{
        name=_("snowball_farmer_fence_brick").." 1",
        post = nil,
        middle = "asset/snowball_farmer_fences/brick_wall4_middle_01.mdl",
        length = 3
    },]]
    {
        name=_("snowball_farmer_fence_hedge").." 2",
        post = nil,
        middle = "asset/snowball_farmer_fences/brick_wall4_middle_02.mdl",
        length = 3
    },
    {
        name=_("snowball_fences_fence_stockade"),
        post = nil,        
        middle = "asset/snowball_farmer_fences/stockade_middle.mdl",
        length = 3.3734
    }, 
    {
        name=_("snowball_fences_fence_rods"),
        post = nil,        
        middle = "asset/snowball_farmer_fences/rods_middle.mdl",
        length = 2.5
    },  
    {
        name=_("snowball_fences_fence_mesh"),
        post = nil,        
        middle = "asset/snowball_farmer_fences/mesh_middle.mdl",
        length = 3.05
    },    
    {
        name=_("snowball_fences_fence_azalea"),        
        decoration = {"decoration/snowball_fences_azalea_1.mdl", "decoration/snowball_fences_azalea_2.mdl"},
        length = 1.0
    },
    {
        name=_("snowball_fences_fence_boxwood"),        
        decoration = {"decoration/snowball_fences_boxwood_1.mdl", "decoration/snowball_fences_boxwood_2.mdl"},
        length = 1.0
    }
}

function fences.updateMarkers()
    if not fences.markerStore then
        fences.markerStore = {}
    end
    if not fences.finisherStore then
        fences.finisherStore = {}
    end

    return plan.updateEntityLists(fences.markerId, fences.markerStore, fences.finisherId, fences.finisherStore)
end

function fences.getPoints(markers)
    local result = {}

    for i = 1, #markers do
        result[#result + 1] = markers[i].position        
    end

    return result
end

function fences.getPolygon(points)
    if #points < 1 then
        return nil
    elseif #points == 1 then
        return {points[1]}
    end

    local result = {}

    --right side
    for i = 1, #points - 1 do               
        result[#result + 1] = points[i]       
    end

    --left side
    for i = #points, 2, -1 do       
        result[#result + 1] = points[i]         
    end

    if #result == 0 then
        return nil
    end

    return result
end

function fences.fenceSegment(a, b, center, fence, rotation, result)

    local length = fence.length

    a[3] = game.interface.getHeight({a[1] + center[1], a[2] + center[2]}) - center[3]
    b[3] = game.interface.getHeight({b[1] + center[1], b[2] + center[2]}) - center[3]

    local v = vec3.sub(b, a)
    local vn = vec3.mul(vec3.length(v) / length, vec3.normalize(v))
    local o = vec3.normalize({v[2], -v[1], 0.0})

    local affine = mat3.affine(vn, o)

    local transform =
        transf.new(
        vec4.new(affine[1][1], affine[2][1], affine[3][1], .0),
        vec4.new(affine[1][2], affine[2][2], affine[3][2], .0),
        vec4.new(affine[1][3], affine[2][3], affine[3][3], .0),
        vec4.new(a[1], a[2], a[3], 1.0)
    )

    if fence.middle then
        result.models[#result.models + 1] = {
            id = fence.middle,
            transf = transform
        }
    end

    if fence.post then
        result.models[#result.models + 1] = {
            id = fence.post,
            transf = transf.rotZTransl(rotation, {x =b[1], y = b[2],z = b[3]})
        }
    end    

    if fence.decoration then        
        result.models[#result.models + 1] = {
            id = fence.decoration[math.random(1, #fence.decoration )],
            transf = transf.rotZTransl(math.random() * math.pi * 2.0, {x = b[1] + (math.random() - 0.5) * 0.2 * fence.length, y = b[2] + (math.random() - 0.5) * 0.2 * fence.length,z = b[3]})
        }
    end

end

function fences.fence(plantpoly, center, fence, face, result)
    local length = fence.length

    --Calculate the correct rotation of fence posts for every segment, no matter the orientation of the polygon
    local rf = 1
    if face == "left" then
        rf = -1
    end
    h = game.interface.getHeight({plantpoly[1][1] + center[1], plantpoly[1][2] + center[2]}) - center[3]
    
    if fence.post then
        result.models[#result.models + 1] = {
            id = fence.post,
            transf = transf.rotZTransl(
                math.atan2(rf * (plantpoly[2][2]-plantpoly[1][2]), rf * (plantpoly[2][1]-plantpoly[1][1])),
                {x = plantpoly[1][1], y = plantpoly[1][2], z =h})
        }
    end

    for i = 1, #plantpoly - 1 do
        local a = plantpoly[i]
        local b = plantpoly[i + 1]
        local r = math.atan2(rf * (b[2]-a[2]), rf * (b[1]-a[1]))
        local v = vec3.sub(b, a)
        local vn = vec3.normalize(v)

        local segmentLength = vec3.length(v)
        local segmentCount = math.floor(segmentLength / length + 0.5)
        if segmentCount == 0 then
            segmentCount = 1
        end

        local vs = vec3.mul(1 / segmentCount, v)

        for j = 1, segmentCount do
            local sa = vec3.add(a, vec3.mul(j - 1, vs))
            local sb = vec3.add(sa, vs)

            fences.fenceSegment(sa, sb, center, fence, r, result)
        end
    end
end

function fences.plan(result)
    fences.updateMarkers()

    if (fences.finisherStore) then
        for i = 1, #fences.finisherStore do
            local finisher = fences.finisherStore[i]
            game.interface.bulldoze(finisher.id)
        end
    end

    fences.finisherStore = {}

    for i = 1, #fences.markerStore + 1 do
        result.models[#result.models + 1] = {
            id = "asset/snowball_fences_marker.mdl",
            transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
        }
    end
   
    local points = fences.getPoints(fences.markerStore)    
    local poly = fences.getPolygon(points)
    local color = {0.9, 0.9, 0.9, 1}

    if poly then
        if #poly == 1 then
            local fencezone = {
                polygon = {{poly[1][1] - 5, poly[1][2], poly[1][3]}, {poly[1][1] + 5, poly[1][2], poly[1][3]}},
                draw = true,
                drawColor = color
            }
            game.interface.setZone(fences.zone, fencezone)
        else
            local fencezone = {polygon = poly, draw = true, drawColor = color}
            game.interface.setZone(fences.zone, fencezone)
        end
    end
end

function fences.reset(result)
    result.models[#result.models + 1] = {
        id = "asset/snowball_fences_finisher.mdl",
        transf = {0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1}
    }

    game.interface.setZone(fences.zone, nil)

    if not fences.markerStore then
        return
    end

    for i = 1, #fences.markerStore do
        local marker = fences.markerStore[i]
        game.interface.bulldoze(marker.id)
    end

    fences.markerStore = {}
end

function fences.build(result, fence, face, collision)
    result.models[#result.models + 1] = {
        id = "asset/snowball_fences_finisher.mdl",
        transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
    }

    if not fences.markerStore then
        return
    end

    if #fences.markerStore < 2 then
        return result
    end

    local points = fences.getPoints(fences.markerStore)
    
    local center = poly.makeCentered(points)

    game.interface.setZone(fences.zone, nil)

    for i = 1, #fences.markerStore do
        local marker = fences.markerStore[i]
        game.interface.bulldoze(marker.id)
    end

    fences.markerStore = {}
   
    local id = "asset/snowball_fences_fence_on.con"
    if (collision == 1) then
        id = "asset/snowball_fences_fence_auto.con"
    elseif collision == 2 then
        id = "asset/snowball_fences_fence_off.con"
    end

    game.interface.buildConstruction(
            id,
            {
                outline = points,
                fence = fence,
                face = face,
                center = {center[1], center[2], center[3]}
            },
            {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, center[1], center[2], center[3], 1}
        )
end

return fences
