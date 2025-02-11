import pandas as pd

# Define file paths
RATINGS_DATA_FILE = 'combined_data_1.txt'       # Ratings file without movie IDs in each row

# Load movie names
movies = pd.read_csv('movie_titles.csv', encoding='ISO-8859-1')

# Check and remove 'date' column if it exists in movies
if 'date' in movies.columns:
    movies = movies.drop(columns=['date'])
else:
    print("'date' column not found in movies DataFrame.")

# Process ratings file
ratings_data = []
current_movie_id = None

# Read the ratings.txt line by line
with open(RATINGS_DATA_FILE, 'r') as file:
    for line in file:
        line = line.strip()
        if line.endswith(':'):  # Identifies movie ID lines (e.g., '1234:')
            current_movie_id = int(line[:-1])  # Remove the colon
        else:
            user_id, rating, date = line.split(',')  # Assuming CSV format after movie ID
            ratings_data.append({
                'movie_id': current_movie_id,
                'user_id': int(user_id),
                'rating': int(rating),
            })

# Convert to DataFrame
ratings_df = pd.DataFrame(ratings_data)

# Check columns before merging
print("Movies columns:", movies.columns)
print("Ratings columns:", ratings_df.columns)

# Merge ratings with movie names
merged_df = pd.merge(ratings_df, movies, on='movie_id', how='left')

# Save the merged data
merged_df.to_csv('merged_ratings.csv', index=False)

print('Merged ratings with movie names successfully.')
