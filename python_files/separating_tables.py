import pandas as pd
import os

# =========================
# LOAD DATA
# =========================

matches = pd.read_csv("each_match_records.csv")
balls = pd.read_csv("each_ball_records.csv")

# Create output folder
os.makedirs("output", exist_ok=True)

# =========================
# DIM TEAM
# =========================

teams = pd.concat([
    matches['team1'],
    matches['team2'],
    matches['winner'],
    matches['toss_won']
]).dropna().drop_duplicates().sort_values()

dim_team = pd.DataFrame({
    'team_id': range(1, len(teams) + 1),
    'team_name': teams.values
})

# =========================
# DIM PLAYER
# =========================

players = pd.concat([
    balls['batter'],
    balls['bowler'],
    matches['man_of_match']
]).dropna().drop_duplicates().sort_values()

dim_player = pd.DataFrame({
    'player_id': range(1, len(players) + 1),
    'player_name': players.values
})

# =========================
# DIM VENUE
# =========================

dim_venue = matches[['venue', 'location']].drop_duplicates().reset_index(drop=True)

dim_venue.insert(0, 'venue_id', range(1, len(dim_venue) + 1))

# =========================
# DIM SEASON
# =========================

dim_season = pd.DataFrame({
    'season': sorted(matches['season'].dropna().unique())
})

dim_season.insert(0, 'season_id', range(1, len(dim_season) + 1))

# =========================
# DIM DATE
# =========================

matches['date'] = pd.to_datetime(matches['date'])

dim_date = pd.DataFrame({
    'full_date': sorted(matches['date'].dropna().unique())
})

dim_date.insert(0, 'date_id', range(1, len(dim_date) + 1))

dim_date['year'] = pd.to_datetime(dim_date['full_date']).dt.year
dim_date['month'] = pd.to_datetime(dim_date['full_date']).dt.month
dim_date['day'] = pd.to_datetime(dim_date['full_date']).dt.day
dim_date['weekday'] = pd.to_datetime(dim_date['full_date']).dt.day_name()

# =========================
# LOOKUPS
# =========================

team_lookup = dict(zip(dim_team['team_name'], dim_team['team_id']))
player_lookup = dict(zip(dim_player['player_name'], dim_player['player_id']))
venue_lookup = dict(zip(dim_venue['venue'], dim_venue['venue_id']))
season_lookup = dict(zip(dim_season['season'], dim_season['season_id']))
date_lookup = dict(zip(dim_date['full_date'], dim_date['date_id']))

# =========================
# FACT MATCH
# =========================

fact_match = matches.copy()

fact_match['season_id'] = fact_match['season'].map(season_lookup)

fact_match['date_id'] = fact_match['date'].map(date_lookup)

fact_match['venue_id'] = fact_match['venue'].map(venue_lookup)

fact_match['team1_id'] = fact_match['team1'].map(team_lookup)

fact_match['team2_id'] = fact_match['team2'].map(team_lookup)

fact_match['winner_team_id'] = fact_match['winner'].map(team_lookup)

fact_match['toss_winner_team_id'] = fact_match['toss_won'].map(team_lookup)

fact_match['man_of_match_player_id'] = fact_match['man_of_match'].map(player_lookup)

fact_match = fact_match[[
    'match_number',
    'season_id',
    'date_id',
    'venue_id',
    'team1_id',
    'team2_id',
    'winner_team_id',
    'toss_winner_team_id',
    'man_of_match_player_id',
    'winner_runs',
    'winner_wickets',
    'toss_decision',
    'match_type'
]]

# =========================
# FACT BALL
# =========================

fact_ball = balls.copy()

fact_ball['batter_id'] = fact_ball['batter'].map(player_lookup)

fact_ball['bowler_id'] = fact_ball['bowler'].map(player_lookup)

fact_ball = fact_ball[[
    'match_no',
    'inningno',
    'over',
    'ballnumber',
    'batter_id',
    'bowler_id',
    'score',
    'outcome',
    'comment'
]]

# =========================
# FACT BATTING
# =========================

fact_batting = balls.groupby(
    ['match_no', 'batter'],
    as_index=False
).agg(
    runs=('score', 'sum'),
    balls=('ballnumber', 'count')
)

fact_batting['strike_rate'] = (
    fact_batting['runs'] * 100
) / fact_batting['balls']

fact_batting['batter_id'] = fact_batting['batter'].map(player_lookup)

# =========================
# FACT BOWLING
# =========================

fact_bowling = balls.groupby(
    ['match_no', 'bowler'],
    as_index=False
).agg(
    runs_conceded=('score', 'sum'),
    balls_bowled=('ballnumber', 'count')
)

fact_bowling['overs'] = round(
    fact_bowling['balls_bowled'] / 6,
    1
)

fact_bowling['economy'] = (
    fact_bowling['runs_conceded'] /
    fact_bowling['overs'].replace(0, 1)
)

fact_bowling['bowler_id'] = fact_bowling['bowler'].map(player_lookup)

# =========================
# SAVE TABLES
# =========================

dim_team.to_csv("output/dim_team.csv", index=False)
dim_player.to_csv("output/dim_player.csv", index=False)
dim_venue.to_csv("output/dim_venue.csv", index=False)
dim_season.to_csv("output/dim_season.csv", index=False)
dim_date.to_csv("output/dim_date.csv", index=False)

fact_match.to_csv("output/fact_match.csv", index=False)
fact_ball.to_csv("output/fact_ball.csv", index=False)
fact_batting.to_csv("output/fact_batting.csv", index=False)
fact_bowling.to_csv("output/fact_bowling.csv", index=False)

print("All tables created and saved successfully.")