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