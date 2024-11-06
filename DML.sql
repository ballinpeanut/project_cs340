-- @ denotes variables from the backend


-- SELECT Queries

-- Get all hurricane seasons to populate dropdowns or for selection on various pages
SELECT season_id, hurricane_count, tropical_storm_count, tropical_depression_count, first_storm_date, last_storm_date 
FROM HurricaneSeasons;

-- Get all tropical systems for a selected season to display in a list on the season details page
SELECT season_id, system_id, name, start_date, end_date, max_category, land_impact 
FROM TropicalSystems 
WHERE season_id = @seasonID;

-- Get all impact types for a dropdown menu or selection list in forms related to impacts
SELECT impact_id, impact_type 
FROM Impacts;

-- Get all impacts associated with a specific tropical system (M:M relationship) for display on system details page
SELECT season_id, system_id, impact_id, city, state, country, region, localized_impact_desc 
FROM TropicalSystemImpacts 
WHERE season_id = @seasonID AND system_id = @systemID;

-- Get statistical data for a specific tropical system to display in a detailed view or for analysis
SELECT season_id, system_id, min_pressure, max_wind_speed, max_rainfall, max_storm_surge, death_count, injury_count, total_cost 
FROM TropicalSystemStats 
WHERE season_id = @seasonID AND system_id = @systemID;


-- INSERT Queries

-- Add a new hurricane season entry
INSERT INTO HurricaneSeasons (season_id, hurricane_count, tropical_storm_count, tropical_depression_count, first_storm_date, last_storm_date) 
VALUES (@seasonID, @hurricaneCount, @tropicalStormCount, @tropicalDepressionCount, @firstStormDate, @lastStormDate);

-- Add a new tropical system entry to a specific hurricane season
INSERT INTO TropicalSystems (season_id, system_id, name, start_date, end_date, max_category, land_impact) 
VALUES (@seasonID, @systemID, @name, @startDate, @endDate, @maxCategory, @landImpact);

-- Add a new impact type (e.g., flooding, wind damage) to the impacts table
INSERT INTO Impacts (impact_id, impact_type) 
VALUES (@impactID, @impactType);

-- Associate an impact with a tropical system (M:M relationship), including specific location data and impact description
INSERT INTO TropicalSystemImpacts (season_id, system_id, impact_id, city, state, country, region, localized_impact_desc) 
VALUES (@seasonID, @systemID, @impactID, @city, @state, @country, @region, @localizedImpactDesc);

-- Add a new set of statistics for a tropical system (includes data like wind speed, rainfall, etc.)
INSERT INTO TropicalSystemStats (season_id, system_id, min_pressure, max_wind_speed, max_rainfall, max_storm_surge, death_count, injury_count, total_cost) 
VALUES (@seasonID, @systemID, @minPressure, @maxWindSpeed, @maxRainfall, @maxStormSurge, @deathCount, @injuryCount, @totalCost);


-- UPDATE Queries

-- Update details of a specific tropical system (e.g., max category or land impact status) based on the system ID
UPDATE TropicalSystems 
SET max_category = @newMaxCategory, land_impact = @newLandImpact 
WHERE season_id = @seasonID AND system_id = @systemID;

-- Update an impact description for a tropical system in a specific location (M:M relationship)
UPDATE TropicalSystemImpacts 
SET localized_impact_desc = @newImpactDesc 
WHERE season_id = @seasonID AND system_id = @systemID AND impact_id = @impactID;

-- Set impact_id in TropicalSystemImpacts to NULL to disassociate an impact from a tropical system in a specific location
UPDATE TropicalSystemImpacts 
SET impact_id = NULL 
WHERE season_id = @seasonID AND system_id = @systemID AND impact_id = @impactID;


-- DELETE Queries

-- Delete a specific tropical system record from the database
DELETE FROM TropicalSystems 
WHERE season_id = @seasonID AND system_id = @systemID;

-- Delete a relationship between a tropical system and an impact (M:M relationship), removing the impact from the system in a specific location
DELETE FROM TropicalSystemImpacts 
WHERE season_id = @seasonID AND system_id = @systemID AND impact_id = @impactID;

-- Delete a hurricane season from the database, handling any associated records as needed
DELETE FROM HurricaneSeasons 
WHERE season_id = @seasonID;

-- Delete statistical data for a specific tropical system
DELETE FROM TropicalSystemStats 
WHERE season_id = @seasonID AND system_id = @systemID;

