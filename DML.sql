-- HURRICANESEASONS PAGE
-- get all seasons, counts, and dates to populate table
SELECT * FROM HurricaneSeasons;

-- insert hurricane season row
INSERT INTO HurricaneSeasons (season_id, hurricane_count, tropical_storm_count, tropical_depression_count,
first_storm_date, last_storm_date)
VALUES (
    :season_id_input,
    :hurricane_count_input,
    :tropical_storm_count_input,
    :tropical_depression_count_input,
    :first_storm_date_input,
    :last_storm_date_input
);

-- update season's data based on submission of the Update form
UPDATE HurricaneSeasons SET season_id = :season_id_input,
    hurricane_count = :hurricane_count_input,
    tropical_storm_count = :tropical_storm_count_input,
    tropical_depression_count = :tropical_depression_count_input,
    first_storm_date = :first_storm_date_input,
    last_storm_date = :last_storm_date_input
WHERE season_id = :season_id_from_the_update_form

-- get tropical storms
-- would like to be able to click on a year and display only the storms for that year
SELECT * FROM TropicalSystems;

-- insert tropical storm
INSERT INTO TropicalSystems (season_id, system_id, name, start_date, end_date, max_category, land_impact)
VALUES (
    :season_id_input,
    :system_id_input,
    :name_input,
    :start_date_input,
    :end_date_input,
    :max_category_input,
    :land_impact_input
);

-- update a tropical storm
UPDATE TropicalSystems SET :season_id_input,
    season_id = :season_id_input,
    system_id = :system_id_input,
    name = :name_input,
    start_date = :start_date_input,
    end_date = :end_date_input,
    max_category = :max_category_input,
    land_impact = :land_impact_input
WHERE system_id = :system_id_from_the_update_form AND season_id = :season_id_from_the_update_form