# This script is to analyze airbnb data in Jersey City, NJ
# Author: Kevin Zolea
########################################
# See all the data from both tables
SELECT * FROM listings;
SELECT * FROM reviews;
########################################
#How many listings are there in Jersey City
SELECT COUNT(DISTINCT id) as listings
FROM listings;
########################################
# Which hosts have the most listings associated with their profile for this area
SELECT host_id,host_name, COUNT(*)
FROM listings
GROUP BY host_id,host_name
ORDER BY COUNT(*)DESC;
########################################
# What are the top host locations
SELECT host_location , COUNT(*)
FROM listings
GROUP BY host_location
ORDER BY COUNT(*)DESC;
########################################
# Find the top 20 most successful operators
SELECT id, listing_url, name, 30 - availability_30 AS booked_out_30 , 
CAST(REPLACE(Price,'$','') AS UNSIGNED) AS price_clean, 
CAST(REPLACE(Price,'$','') AS UNSIGNED)*(30 - availability_30) / beds AS proj_rev_30
FROM listings ORDER BY proj_rev_30 DESC LIMIT 20;
########################################
# What is the average rating across all the listings
SELECT AVG(review_scores_rating) AS average_review
FROM listings;
########################################
# Which hosts have the most mentions of the word dirty in their reviews
# In order to do this.. a join must be completed
SELECT host_id, host_url, host_name, COUNT(*) AS num_dirty_reviews FROM reviews INNER JOIN listings ON reviews.listing_id = listings.id
WHERE comments LIKE "%dirty%"
GROUP BY host_id, host_url, host_name ORDER BY num_dirty_reviews DESC;
########################################


