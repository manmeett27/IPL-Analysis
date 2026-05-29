import pandas as pd

match_df = pd.read_csv("cleaned_dataset_of_match_records.csv")


# TOSS ANALYSIS TABLE

toss_analysis = match_df[[
    'match_number',
    'toss_won',
    'toss_decision',
    'winner'
]]

# Add Index
toss_analysis.insert(
    0,
    'id',
    range(1, len(toss_analysis) + 1)
)

# Save
toss_analysis.to_csv(
    "toss_analysis.csv",
    index=False
)








# TEAM PERFORMANCE TABLE

# Total Matches Played
team1_matches = match_df[['team1']].rename(
    columns={'team1': 'team'}
)

team2_matches = match_df[['team2']].rename(
    columns={'team2': 'team'}
)

all_teams = pd.concat([
    team1_matches,
    team2_matches
])

matches_played = all_teams.groupby('team').size().reset_index(
    name='matches_played'
)

# Wins
wins = match_df.groupby('winner').size().reset_index(
    name='wins'
).rename(columns={'winner': 'team'})

# Merge
team_performance = matches_played.merge(
    wins,
    on='team',
    how='left'
)

team_performance['wins'] = (
    team_performance['wins'].fillna(0)
)

# Losses
team_performance['losses'] = (
    team_performance['matches_played'] -
    team_performance['wins']
)

# Win Percentage
team_performance['win_percentage'] = (
    team_performance['wins'] /
    team_performance['matches_played']
) * 100

# Add Index
team_performance.insert(
    0,
    'id',
    range(1, len(team_performance) + 1)
)

# Save
team_performance.to_csv(
    "team_performance.csv",
    index=False
)






# PLAYER OF MATCH TABLE

player_awards = match_df[[
    'match_number',
    'man_of_match',
    'winner',
    'season'
]]

# Add Index
player_awards.insert(
    0,
    'id',
    range(1, len(player_awards) + 1)
)

# Save
player_awards.to_csv(
    "player_awards.csv",
    index=False
)





# VENUE ANALYSIS TABLE

venue_analysis = match_df.groupby(
    ['venue', 'location']
).agg(
    total_matches=('match_number', 'count')
).reset_index()

# Add Index
venue_analysis.insert(
    0,
    'id',
    range(1, len(venue_analysis) + 1)
)

# Save
venue_analysis.to_csv(
    "venue_analysis.csv",
    index=False
)