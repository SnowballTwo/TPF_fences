function data()
	local t = { }

	t.name = _("Citybuilder stopper")
	t.desc = _("Citybuilder stopper")

	t.yearFrom = 0
	t.yearTo = 0

	t.shapeWidth = 0.01 --0.04
	t.shapeStep = 1  --4.0
	t.shapeSleeperStep = 8.0 / 12.0

	t.ballastHeight = 0 -- -.01 -- -5.3
	t.ballastCutOff = 0 -- -2.1

	t.sleeperBase = 0 -- t.ballastHeight
	t.sleeperLength = 0 -- .02
	t.sleeperWidth = 0 -- .06
	t.sleeperHeight = 0 --.08
	t.sleeperCutOff = 0 --.02

	t.railTrackWidth = 0 -- 0.1
	t.railBase = 0 -- -25.0
	t.railHeight = 0 --.15
	t.railWidth = 0 -- .01
	t.railCutOff = 0 -- .02

	t.catenaryBase = 5.917 + t.railBase + t.railHeight
	t.catenaryHeight = -1

	t.trackDistance = 5.0

	t.speedLimit = 0.0 / 3.6
	t.speedCoeffs = { .85, 30.0, .6 }		-- curve speed limit = a * (radius + b) ^ c

	t.ballastMaterial = "track/ballast.mtl"
	t.sleeperMaterial = "track/sleeper.mtl"
	t.railMaterial = "track/rail.mtl"
	t.catenaryMaterial = "track/catenary.mtl"
	t.trackMaterial = "track/track_standard.mtl"
	t.tunnelWallMaterial = "track/tunnel_ug.mtl"
	t.tunnelHullMaterial = "track/tunnel_hull.mtl"

	t.catenaryPoleModel = "asset/snowball_farmer_fences/brick_wall4_middle_01.mdl"
	t.catenaryMultiPoleModel = "railroad/power_pole_1.mdl"
	t.catenaryMultiGirderModel = "railroad/power_pole_1a.mdl"
	t.catenaryMultiInnerPoleModel = "railroad/power_pole_1b.mdl"

	t.bumperModel = ""
	t.switchSignalModel = ""

	t.fillGroundTex = "Citybuilder_stopper_ballast_fill_transparent"
	t.borderGroundTex = "Citybuilder_stopper_ballast_transparent"

	t.cost = 0.0

	return t
end
