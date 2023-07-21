# Goalkeeper-Clustering

Description: Application of unsupervised learning to football goalkeeper scouting

Summary: In this project, I used advanced metrics from the 2022-23 season to perform k-means clustering on goalkeepers who played at least 450 minutes in Europe's top-five domestic leagues (Premier League, La Liga, Bundesliga, Serie A, Ligue 1). Investigating the characteristics of each cluster centroid allowed me to formulate written descriptions of each cluster. These written descriptions, paired with the assignments for each player in the dataset could be a useful tool for scouts when seeking to identify transfer targets that fit their desired profile.

Data: The data was sourced from [Football Reference]([url](https://fbref.com/en/comps/Big5/keepersadv/players/Big-5-European-Leagues-Stats)https://fbref.com/en/comps/Big5/keepersadv/players/Big-5-European-Leagues-Stats). From there, given its relatively small size, I loaded it into Excel to view it and quickly rename some columns for clarity before saving as a csv to be used in R (this file is attached as "GK Clustering.csv"). With the data in R, I removed a few metrics that I determined were either redundant or uninteresting for the clustering task and standardized them (centered at 0 with a standard deviation of one).

K-Means Clustering: The file “GK Clustering.R” contains the code I used to perform the clustering task. The cluster player assignment and centroid data frames were found in R and exported to Excel to clean up formatting for the presentation (these files are titled “Cluster Assignments.xlsv” and “Cluster Centroids.xlsv” respectively).

Presentation: A presentation which contains my findings and conclusions is attached as “GK Clustering – Eamon Gara Grady.pdf.”
