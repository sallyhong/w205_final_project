import psycopg2
import sys

conn = psycopg2.connect(database="schoolstream", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
	
if len(sys.argv) == 3:
	#arg = (sys.argv[1]).split(',')
	#low = arg[0]
	#high = arg[1]
	candidate = sys.argv[1]
	cand1 = '%' + candidate + '%'
	cand2 = '%' + candidate
	cand3 = candidate + '%'
	school = sys.argv[2]
	school1 = '%' + school + '%'
	school2 = '%' + school
	school3 = school + '%'
	cur.execute("select \
	%s as candidate, \
	%s as school, \
	tweet, \
	sentiment, \
	count(sentiment) as c \
	from schoolpol \
	where (lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s) and \
	(lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s) \
	group by tweet, sentiment \
	order by c desc \
	limit 10;", (candidate, school, cand1, cand2, cand3, school1, school2, school3))
	records = cur.fetchall()
	for rec in records:
	 print """  "%s", "%s": %s | %s | Count: %s"""%(rec[0],rec[1],rec[2], rec[3], rec[4])
	conn.commit()
else:
	print "Error: Please use correct syntax: $ python 03_toptweetscandschool.py [CANDIDATE] [SCHOOL]"