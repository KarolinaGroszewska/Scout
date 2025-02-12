# Scout
An app built for GHW: February using CreateML and the Netflix Prize Dataset to determine an individual's rating of a movie based on their previous preferences and the preferences of other users with similar tastes!

## Dataset and Script Info 
During GHW: AI/ML, I wanted the opportunity to experiment more with the CreateML tools built into Xcode to create a recommendation system. I had previously used CreateML to make a learning/test project, but nothing quite on this scale.

Thanks to others' recommendations and scouring Kaggle, I was introduced to the [Netflix Prize Data](https://www.kaggle.com/datasets/netflix-inc/netflix-prize-data) dataset, which was used for a Netflix-run contest to improve movie recommendation systems. In order to feed this dataset into CreateML, a lot of cleaning and reorganization had to be completed. CreateML requires datasets to look a specific way – having header names, userIDs, titles, and ratings. They also require separating test vs. train datasets outside. 

The final version of the dataset was uploaded to [Kaggle](https://www.kaggle.com/datasets/karigroszewska/netflix-prize-dataset-for-createml-recommender/data), and is available to be viewed by the public. The Kaggle dataset also includes the merge.py script added here for those who would like to clean up the data from Netflix Prize themselves, or for others to use in their own versions of the project.

## Application Info
