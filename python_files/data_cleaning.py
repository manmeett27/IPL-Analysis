import pandas as pd

df = pd.read_csv("each_ball_records.csv")

# separating raw relation into Batting relation
batting = df.groupby('batter').agg(
    runs=('score', 'sum'),
    balls=('ballnumber', 'count')
).reset_index()

batting['strike_rate'] = (
    batting['runs'] / batting['balls']
) * 100

batting.insert(0, 'id', range(1, len(batting) + 1))

batting.to_csv("batting.csv", index=False)





# separating raw relation into Bowling relation
df['wicket'] = df['outcome'].apply(
    lambda x: 1 if x == 'w' else 0
)

bowling = df.groupby('bowler').agg(
    runs_conceded=('score', 'sum'),
    balls=('ballnumber', 'count'),
    wickets=('wicket', 'sum')
).reset_index()

bowling['overs'] = bowling['balls'] / 6

bowling['economy'] = (
    bowling['runs_conceded'] / bowling['overs']
)

bowling['bowling_average'] = (
    bowling['runs_conceded'] / bowling['wickets']
)

bowling['bowling_strike_rate'] = (
    bowling['balls'] / bowling['wickets']
)

bowling.insert(0, 'id', range(1, len(bowling) + 1))

bowling.to_csv("bowling.csv", index=False)






# Match-wise table
match = df.groupby('match_no').agg(
    total_runs=('score', 'sum'),
    total_wickets=('wicket', 'sum'),
    total_balls=('ballnumber', 'count')
).reset_index()

match['total_overs'] = (
    match['total_balls'] / 6
)

match.insert(
    0,
    'id',
    range(1, len(match) + 1)
)

match.to_csv(
    "matches.csv",
    index=False
)








# Over-wise summary
over = df.groupby('over').agg(
    total_runs=('score', 'sum'),
    total_wickets=('wicket', 'sum'),
    total_balls=('ballnumber', 'count')
).reset_index()

# Add run rate
over['run_rate'] = (
    over['total_runs'] /
    (over['total_balls'] / 6)
)

# Add index
over.insert(
    0,
    'id',
    range(1, len(over) + 1)
)

# Save file
over.to_csv(
    "over.csv",
    index=False
)