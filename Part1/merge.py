import pandas as pd
from sklearn.model_selection import train_test_split

# Define file paths
RATINGS_DATA_FILES = [
    'combined_data_1.txt',
    'combined_data_2.txt',
    'combined_data_3.txt',
    'combined_data_4.txt'
]

# Load movie names
movies = pd.read_csv('movie_titles.csv', encoding='ISO-8859-1')

# Check and remove 'date' column if it exists in movies
if 'date' in movies.columns:
    movies = movies.drop(columns=['date'])
else:
    print("'date' column not found in movies DataFrame.")

def process_ratings_file(filename):
    file_ratings = []
    current_movie_id = None
    
    with open(filename, 'r') as file:
        for line in file:
            line = line.strip()
            if line.endswith(':'):  # Identifies movie ID lines (e.g., '1234:')
                current_movie_id = int(line[:-1])  # Remove the colon
            else:
                user_id, rating, date = line.split(',')  # Assuming CSV format after movie ID
                file_ratings.append({
                    'movie_id': current_movie_id,
                    'user_id': int(user_id),
                    'rating': int(rating),
                })
    return file_ratings

# Process all ratings files
ratings_data = []
for ratings_file in RATINGS_DATA_FILES:
    ratings_data.extend(process_ratings_file(ratings_file))

# Convert to DataFrame
ratings_df = pd.DataFrame(ratings_data)

# Check columns before merging
print("Movies columns:", movies.columns)
print("Ratings columns:", ratings_df.columns)

# Merge ratings with movie names
merged_df = pd.merge(ratings_df, movies, on='movie_id', how='left')

# Split the data into training and testing sets
train_df, test_df = train_test_split(merged_df, test_size=0.2, random_state=42)

# Save the training and testing data separately
train_df.to_csv('merged_ratings.csv', index=False)
test_df.to_csv('test_merged_ratings.csv', index=False)

print('Merged ratings with movie names successfully.')
print(f'Training set size: {len(train_df)} rows')
print(f'Testing set size: {len(test_df)} rows')
