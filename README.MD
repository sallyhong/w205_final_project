W205 - School Twitter Stream

Requirements:
Python 2.7+
Postgres (9.5 was used in our case)
Python Dependencies:
tweepy
psycopg2
textblob
json

00. Create database in postgres with:
DB Name: schoolstream
USER: postgres
PASS: pass
PORT: 5432

Sample commands for centos.
$ su - postgres
$ psql
# create database schoolstream;
# \q

In our case, we had to add the option 'template template0' to create the database.

There is a sample database if you do not wish to collect your own twitter data. If you wish to use the sample database, load into the database:
$ psql schoolstream < xx_sample_tweet_database.sql


If you wish to create your own database, follow the below steps:

01. Run 01_twitter_table_schema.sql to create table schema for twitter data recording table.

02. Run 02_schoolstreamtwitter.py to start twitter feed
Python Dependencies:
tweepy
psycopg2
textblob
json

If the recording is a success, you will see the message "Yay!"
If the recording is a failure, you will see the error and the message "Oh no it failed!"
If the recording is a failure, the script will restart.
CTRL + C to break and end the stream.

03. Run 03_generate_schoolpol_table_from_twitter.sql to generate the schoolpol table from the raw twitter data. Then you may start using the serving scripts.

04. Serving Scripts
Inside the serving scripts folder, there are 6 serving scripts. The descriptions of the serving scripts are contained within the project report.

Short description of the serving scripts:
S01. 01_candschoolcount.py
   Description: See how many times candidate comes up at each school
   Input: candidate
   Output: candidate, school, count

S02. 02_toptweetsentment.py
   Description: See the top tweet of X candidate and count by sentiment
   Input: positive or negative, candidate
   Output: candidate, tweet, sentiment, count

S03. 03_toptweetscandschool.py
   Description: See the top tweets for THAT school about X candidate
   Input: candidate, school
   Output: candidate, school, tweet, sentiment, count

S04. 04_schoolcandsentpct.py
   Decription: Show breakdown of candidates + sentiment + count
   Input:  school
   Output: school, candidate, sentiment, count, percentage of candidate's total count

S05. 05_schoolsentpct.py
   Description: Breakdown of a sentiment of a school
   Input: school
   Output: school, sentiment, count, percentage of school's total count

S06. 06_highestsentschoolcand.py
Description: See which schools have the highest sentiment % for a candidate
   Input: positive or negative, candidate
   Output: candidate, sentiment, school, count, percentage of total sentiment count
