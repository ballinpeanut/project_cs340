-- @ denotes variables from the backend


-- QUERIES USED IN Hurricane Seasons (index page)

    -- Populate Hurricane Seasons table with available data
    SELECT * FROM HurricaneSeasons ORDER BY season_id ASC

    -- Add a new hurricane season entry
    INSERT INTO HurricaneSeasons (season_id, hurricane_count, tropical_storm_count, tropical_depression_count, first_storm_date, last_storm_date) 
    VALUES (@seasonID, @hurricaneCount, @tropicalStormCount, @tropicalDepressionCount, @firstStormDate, @lastStormDate);

    -- Update a specific Hurricane Season's details (season ID, counts, or dates)
    UPDATE HurricaneSeasons
    SET hurricane_count = @hurricane_count, tropical_storm_count = @tropical_storm_count, tropical_depression_count = @tropical_depression_count, first_storm_date = @first_storm_date, last_storm_date = @last_storm_date
    WHERE season_id = @seasonID


-- QUERIES USED IN TropicalSystems PAGE

    -- Get all tropical systems for a selected season
    SELECT * 
    FROM TropicalSystems 
    WHERE season_id = @seasonID;

    -- Get all systems available from TropicalSystems table and order by season_id and system_id
    SELECT * 
    FROM TropicalSystems 
    ORDER BY season_id, system_id ASC

    -- Get available seasons from HurricaneSeasons table for use in dropdown menu
    SELECT season_id 
    FROM HurricaneSeasons

    -- Add a new tropical system entry to a specific hurricane season
    INSERT INTO TropicalSystems (season_id, system_id, name, start_date, end_date, max_category, land_impact) 
    VALUES (@seasonID, @systemID, @name, @startDate, @endDate, @maxCategory, @landImpact);

    -- Update details of a specific tropical system (e.g., max category or land impact status) based on the system ID
    UPDATE TropicalSystems 
    SET name = @name, start_date = @start_date, end_date = @end_date, max_category = @maxCategory, land_impact = @landImpact 
    WHERE season_id = @seasonID AND system_id = @systemID;

    -- Delete a specific tropical system record from the database
    DELETE FROM TropicalSystems 
    WHERE season_id = @seasonID AND system_id = @systemID;


-- QUERIES USED IN IMPACTS TABLE

    -- SELECT all data from Impacts table
    SELECT *
    FROM Impacts;

    -- ADD a new impact type (e.g., flooding, wind damage) to the Impacts table
    INSERT INTO Impacts (impact_id, impact_type) 
    VALUES (@impactID, @impactType);

    -- UPDATE impact description using the impact_id in the Impacts table
    UPDATE Impacts
    SET impact_type = @impact_type
    WHERE impact_id = @impact_id;


-- QUERIES USED IN TropicalSystemImpacts TABLE

    -- SELECT all storms in a season (used in a dropdown)
    SELECT * 
    FROM TropicalSystemImpacts 
    WHERE season_id = @seasonID;

    -- SELECT all storms in the TropicalSystemImpacts table ordered by season and system IDs in ascending order
    SELECT *
    FROM TropicalSystemImpacts
    ORDER BY season_id, system_id ASC;

    -- fetch all seasons from HurricaneSeasons table (used in dropdown)
    SELECT season_id 
    FROM HurricaneSeasons 
    ORDER BY season_id ASC;

    -- SELECT all storms and name for a selected season within the TropicalSystem Impacts table
    SELECT system_id, name 
    FROM TropicalSystems 
    WHERE season_id = @seasonID 
    ORDER BY system_id ASC;

    -- select all impact ids and impact_types from Impacts table
    SELECT impact_id, impact_type 
    FROM Impacts 
    ORDER BY impact_id ASC;

    -- Associate an impact with a tropical system (M:M relationship), including specific location data and impact description
    INSERT INTO TropicalSystemImpacts (season_id, system_id, impact_id, city, state, country, region, localized_impact_desc) 
    VALUES (@seasonID, @systemID, @impactID, @city, @state, @country, @region, @localizedImpactDesc);

    -- Delete entry from TropicalSystemImpacts where it matches to the id
    DELETE FROM TropicalSystemImpacts 
    WHERE id = %s;


-- QUERIES USED IN TropicalSystemStats PAGE

    -- Filter stats by season using SELECT query, only shows storms for specified season from dropdown
    SELECT * 
    FROM TropicalSystemStats 
    WHERE season_id = %s

    -- Show all systems in the TropicalSystemStats table, ordered by season and system IDs in ascending order
    SELECT * 
    FROM TropicalSystemStats 
    ORDER BY season_id, system_id ASC

    -- fetch all seasons from HurricaneSeasons table (used in dropdown)
    SELECT season_id 
    FROM HurricaneSeasons 
    ORDER BY season_id ASC;

    -- SELECT all storms and name for a selected season within the TropicalSystem Impacts table
    SELECT system_id, name 
    FROM TropicalSystems 
    WHERE season_id = @seasonID 
    ORDER BY system_id ASC;

    -- Add a new set of statistics for a tropical system (includes data like wind speed, rainfall, etc.)
    INSERT INTO TropicalSystemStats (season_id, system_id, min_pressure, max_wind_speed, max_rainfall, max_storm_surge, death_count, injury_count, total_cost) 
    VALUES (@seasonID, @systemID, @minPressure, @maxWindSpeed, @maxRainfall, @maxStormSurge, @deathCount, @injuryCount, @totalCost);

    -- UPDATE attributes in the STATS table where stat id matches up
    UPDATE TropicalSystemStats
    SET min_pressure = @minPressure, max_wind_speed = @maxWindSpeed, max_rainfall = @maxRainfall, max_storm_surge = @maxStormSurge, death_count = @deathCount, injury_count = @injuryCount, total_cost = @totalCost
    WHERE stat_id = @statID;

    -- DELETE entry matching up to the selected stat id
    DELETE FROM TropicalSystemStats WHERE stat_id = %s

