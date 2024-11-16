from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

# Flask-MySQLdb configuration
app.config["MYSQL_HOST"] = "classmysql.engr.oregonstate.edu"
app.config["MYSQL_USER"] = "cs340_user"  # Replace with your MySQL username
app.config["MYSQL_PASSWORD"] = "XXXX"  # Replace with your MySQL password
app.config["MYSQL_DB"] = "cs340_user"  # Replace with your database name
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
# Also change port at the bottom

mysql = MySQL(app)

##### Home Page Route #####
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM HurricaneSeasons")
    HurricaneSeasons = cur.fetchall()
    cur.close()
    return render_template('index.html', HurricaneSeasons=HurricaneSeasons)

# Route to add seasons
@app.route('/add_season', methods=['POST'])
def add_season():
    cur = mysql.connection.cursor()
    cur.execute("""
        INSERT INTO HurricaneSeasons (season_id, hurricane_count, tropical_storm_count, tropical_depression_count, first_storm_date, last_storm_date)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (
        request.form['season_id'],
        request.form['hurricane_count'],
        request.form['tropical_storm_count'],
        request.form['tropical_depression_count'],
        request.form['first_storm_date'],
        request.form['last_storm_date']
    ))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('index'))

# Route for updating/editing seasons
@app.route('/update_season', methods=['POST'])
def update_season():
    cur = mysql.connection.cursor()
    cur.execute("""
        UPDATE HurricaneSeasons
        SET hurricane_count = %s, tropical_storm_count = %s, tropical_depression_count = %s, 
            first_storm_date = %s, last_storm_date = %s
        WHERE season_id = %s
    """, (
        request.form['hurricane_count'],
        request.form['tropical_storm_count'],
        request.form['tropical_depression_count'],
        request.form['first_storm_date'],
        request.form['last_storm_date'],
        request.form['season_id']
    ))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('index'))


##### Tropical Systems Route #####
@app.route('/tropical_systems', methods=['GET', 'POST'])
def tropical_systems():
    cur = mysql.connection.cursor()
    if request.method == 'POST':  # Browsing based on a specific season
        season_id = request.form['seasonSelect']
        query = "SELECT * FROM TropicalSystems WHERE season_id = %s"
        cur.execute(query, (season_id,))
    else:  # Browse all systems
        query = "SELECT * FROM TropicalSystems"
        cur.execute(query)
    
    TropicalSystems = cur.fetchall()

    # Fetch available seasons for the dropdown menu
    cur.execute("SELECT season_id FROM HurricaneSeasons")
    HurricaneSeasons = cur.fetchall()
    cur.close()
    
    return render_template('TropicalSystems.html', TropicalSystems=TropicalSystems, HurricaneSeasons=HurricaneSeasons)

# Route to add tropical system
@app.route('/add_tropical_system', methods=['POST'])
def add_tropical_system():
    cur = mysql.connection.cursor()
    query = """
    INSERT INTO TropicalSystems (season_id, system_id, name, start_date, end_date, max_category, land_impact)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    data = (
        request.form['season_id'],
        request.form['system_id'],
        request.form['name'],
        request.form['start_date'],
        request.form['end_date'],
        request.form['max_category'],
        request.form['land_impact'],
    )
    cur.execute(query, data)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystems'))

# Route to update/edit tropical system
@app.route('/update_tropical_system', methods=['POST'])
def update_tropical_system():
    cur = mysql.connection.cursor()
    query = """
    UPDATE tropTropicalSystemsical_systems
    SET season_id = %s, name = %s, start_date = %s, end_date = %s, max_category = %s, land_impact = %s
    WHERE system_id = %s
    """
    data = (
        request.form['season_id'],
        request.form['name'],
        request.form['start_date'],
        request.form['end_date'],
        request.form['max_category'],
        request.form['land_impact'],
        request.form['system_id'],
    )
    cur.execute(query, data)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystems'))

# Route to delete tropical system
@app.route('/delete_tropical_system', methods=['POST'])
def delete_tropical_system():
    cur = mysql.connection.cursor()
    query = "DELETE FROM TropicalSystems WHERE system_id = %s"
    cur.execute(query, (request.form['system_id'],))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystems'))


##### Impacts Route #####
@app.route('/impacts', methods=['GET', 'POST'])
def impacts():
    cur = mysql.connection.cursor()

    # Fetch all impacts
    cur.execute("SELECT * FROM Impacts")
    Impacts = cur.fetchall()
    cur.close()

    return render_template('Impacts.html', Impacts=Impacts)

# Route to add new impact
@app.route('/add_impact', methods=['POST'])
def add_impact():
    cur = mysql.connection.cursor()

    # Insert a new impact
    query = "INSERT INTO Impacts (impact_id, impact_type) VALUES (%s, %s)"
    cur.execute(query, (request.form['impact_id'], request.form['impact_type']))
    mysql.connection.commit()
    cur.close()

    return redirect(url_for('Impacts'))


##### Tropical Systems Impacts #####
@app.route('/tropical_system_impacts', methods=['GET', 'POST'])
def tropical_system_impacts():
    cur = mysql.connection.cursor()
    if request.method == 'POST':  # Filter by season
        season_id = request.form.get('seasonSelect', '')
        query = "SELECT * FROM TropicalSystemImpacts WHERE season_id = %s"
        cur.execute(query, (season_id,))
    else:  # Fetch all
        query = "SELECT * FROM TropicalSystemImpacts"
        cur.execute(query)
    TropicalSystemImpacts = cur.fetchall()
    cur.close()
    return render_template('TropicalSystemImpacts.html', TropicalSystemImpacts=TropicalSystemImpacts)

# Route to add storm impact
@app.route('/add_tropical_system_impact', methods=['POST'])
def add_tropical_system_impact():
    cur = mysql.connection.cursor()
    query = """
    INSERT INTO TropicalSystemImpacts (season_id, system_id, impact_id, city, state, country, region, localized_impact_desc)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    data = (
        request.form['season_id'],
        request.form['system_id'],
        request.form['impact_id'],
        request.form['city'],
        request.form['state'],
        request.form['country'],
        request.form['region'],
        request.form['localized_impact_desc']
    )
    cur.execute(query, data)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystemImpacts'))

# Route to update storm impacts
@app.route('/update_tropical_system_impact', methods=['POST'])
def update_tropical_system_impact():
    cur = mysql.connection.cursor()
    query = """
    UPDATE TropicalSystemImpacts
    SET impact_id = %s, city = %s, state = %s, country = %s, region = %s, localized_impact_desc = %s
    WHERE season_id = %s AND system_id = %s
    """
    data = (
        request.form['impact_id'],
        request.form['city'],
        request.form['state'],
        request.form['country'],
        request.form['region'],
        request.form['localized_impact_desc'],
        request.form['season_id'],
        request.form['system_id']
    )
    cur.execute(query, data)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystemImpacts'))

# Route to delete impact
@app.route('/delete_tropical_system_impact', methods=['POST'])
def delete_tropical_system_impact():
    cur = mysql.connection.cursor()
    query = "DELETE FROM TropicalSystemImpacts WHERE system_id = %s"
    cur.execute(query, (request.form['system_id'],))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystemImpacts'))


##### Tropical System Stats Route #####
@app.route('/tropical_system_stats', methods=['GET', 'POST'])
def tropical_system_stats():
    cur = mysql.connection.cursor()
    if request.method == 'POST':  # Filter stats by season
        season_id = request.form['seasonSelect']
        query = "SELECT * FROM TropicalSystemStats WHERE season_id = %s"
        cur.execute(query, (season_id,))
    else:  # Fetch all stats
        query = "SELECT * FROM TropicalSystemStats"
        cur.execute(query)
    TropicalSystemStats = cur.fetchall()

    # Fetch seasons for dropdown
    cur.execute("SELECT season_id FROM HurricaneSeasons")
    HurricaneSeasons = cur.fetchall()
    cur.close()

    return render_template('TropicalSystemStats.html', TropicalSystemStats=TropicalSystemStats, HurricaneSeasons=HurricaneSeasons)

# Route to add stats
@app.route('/add_tropical_system_stat', methods=['POST'])
def add_tropical_system_stat():
    cur = mysql.connection.cursor()
    query = """
    INSERT INTO TropicalSystemStats (season_id, system_id, min_pressure, max_wind_speed, max_rainfall, max_storm_surge, death_count, injury_count, total_cost)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    data = (
        request.form['season_id'],
        request.form['system_id'],
        request.form['min_pressure'],
        request.form['max_wind_speed'],
        request.form['max_rainfall'],
        request.form['max_storm_surge'],
        request.form['death_count'],
        request.form['injury_count'],
        request.form['total_cost']
    )
    cur.execute(query, data)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystemStats'))

# Route to update stats
@app.route('/update_tropical_system_stat', methods=['POST'])
def update_tropical_system_stat():
    cur = mysql.connection.cursor()
    query = """
    UPDATE TropicalSystemStats
    SET season_id = %s, system_id = %s, min_pressure = %s, max_wind_speed = %s, max_rainfall = %s, max_storm_surge = %s, death_count = %s, injury_count = %s, total_cost = %s
    WHERE stat_id = %s
    """
    data = (
        request.form['season_id'],
        request.form['system_id'],
        request.form['min_pressure'],
        request.form['max_wind_speed'],
        request.form['max_rainfall'],
        request.form['max_storm_surge'],
        request.form['death_count'],
        request.form['injury_count'],
        request.form['total_cost'],
        request.form['stat_id']
    )
    cur.execute(query, data)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystemStats'))

# Route to delete stats
@app.route('/delete_tropical_system_stat', methods=['POST'])
def delete_tropical_system_stat():
    stat_id = request.form['stat_id']
    cur = mysql.connection.cursor()
    query = "DELETE FROM TropicalSystemStats WHERE stat_id = %s"
    cur.execute(query, (stat_id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('TropicalSystemStats'))


if __name__ == '__main__':
    app.run(debug=True, port=12017)
