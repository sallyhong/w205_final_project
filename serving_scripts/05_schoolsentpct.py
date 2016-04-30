import psycopg2
import sys

conn = psycopg2.connect(database="schoolstream", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
	
if len(sys.argv) == 2:
	#arg = (sys.argv[1]).split(',')
	#low = arg[0]
	#high = arg[1]
	school = sys.argv[1]
	school1 = '%' + school + '%'
	school2 = '%' + school
	school3 = school + '%'
	cur.execute("select \
	%s as school, \
	sentiment as s, \
	count(sentiment) as c, \
	cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2)) \
	as pct \
	from schoolpol \
	where lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s \
	group by s \
	order by s desc, c desc, pct desc \
	;", (school, school1, school2, school3))
	records = cur.fetchall()
	for rec in records:
	 print """  %s | %s | %s | %s pct"""%(rec[0],rec[1],rec[2], rec[3])
	conn.commit()
else:
	print "Error: Please use correct syntax: $ python 05_schoolsentpct.py [SCHOOL]"