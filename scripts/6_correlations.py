import pandas as pd

# import data
temp_attributes = pd.read_csv('temp_attributes.csv')

# create a correlation matrix
numeric_attributes = temp_attributes.drop(columns = ['song_name', 'song_type', 'release_date_standard', 'song_id'])
correlations = numeric_attributes.corr(method = 'pearson')

# export csv
correlations.to_csv('correlations.csv')
