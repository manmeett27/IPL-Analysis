import pandas as pd

# df = pd.read_csv('each_ball_records.csv')
# print(df.columns)

# df[['match_no', 'ballnumber', 'inningno', 'over', 'score']] = df[['match_no', 'ballnumber', 'inningno', 'over', 'score']].astype(int)

# df[['batter', 'bowler', 'outcome']] = (
#     df[['batter', 'bowler', 'outcome']]
#     .apply(lambda x: x.str.strip())
# )

# df.to_csv('cleaned_dataset_of_ball_records.csv', index=False)

df1 = pd.read_csv('each_match_records.csv')
# print(df1.columns)

df1[['winner_runs', 'winner_wickets']] = (
    df1[['winner_runs', 'winner_wickets']]
    .fillna(0)
)

df1[['season', 'match_number', 'winner_runs', 'winner_wickets']] = df1[['season', 'match_number', 'winner_runs', 'winner_wickets']].astype(int)

df1['date'] = pd.to_datetime(
    df1['date'],
    format='%d-%m-%Y'
)

df1[['match_type', 'venue', 'location', 'team1', 'team2', 'toss_won', 'toss_decision', 'umpire1', 'umpire2', 'reserve_umpire', 'match_referee', 'winner', 'man_of_match']] = (
    df1[['match_type', 'venue', 'location', 'team1', 'team2', 'toss_won', 'toss_decision', 'umpire1', 'umpire2', 'reserve_umpire', 'match_referee', 'winner', 'man_of_match']] 
    .apply(lambda x: x.str.strip())
)

df1.to_csv('cleaned_dataset_of_match_records.csv', index=False)

