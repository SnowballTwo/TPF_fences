function data()
return {
	numLanes = 2,
	streetWidth = 0.1,
	sidewalkWidth = 0.1,
	sidewalkHeight = 0.0,
	yearFrom = 1850,
	yearTo = 0,
	upgrade = false,
	country = true,
	speed = 0.0,
	type = "fence",
	name = _("Brick_Fence1"),
	desc = _("just a fence"),
	materials = {
		streetPaving = {
			
			size = { 6.0, 6.0 }
		},		
		streetBorder = {
			
			size = { 1.5, 0.625 }
		
		},			
		streetLane = {
			
			size = { 3.0, 3.0 }
		},
		streetStripe = {

		},
		streetStripeMedian = {

		},
		streetBus = {
		
		},
		streetTram = {
			
			size = { 2.0, 2.0 }
		},
		crossingLane = {
			
			size = { 3.0, 3.0 }
		},
		crossingBus = {
			name = ""		
		},
		crossingTram = {
			
			size = { 2.0, 2.0 }
		},
		crossingCrosswalk = {
			name = ""		
		},
		sidewalkPaving = {
			
			size = { 6.0, 6.0 }
		},
		sidewalkLane = {	

		},
		sidewalkBorderInner = {
				
			size = { 3, 0.6 }
		},
		sidewalkBorderOuter = {
					
			size = { 16.0, 0.3 }
		},
		sidewalkCurb = {
			
			size = { 3, .3 }
		},
		sidewalkWall = {
			
			size = { .3, .3 }
		},
		catenary = {
			
		}
	},
	assets = {
		
		
		Lamp = {
			name = "asset/snowball_farmer_fences/brick_wall1_street.mdl",
			offset = 0,
			distance = 3.0,
			prob = 1.0,
			offsetOrth = 0,
			randRot = false,
			oneSideOnly = true,
			alignToElevation = false,
			avoidFaceEdges = false,
			placeOnBridge = false,
		},  
		
		
	},
	bridges = {
		
	},
	cost = 1.0,
}
end
