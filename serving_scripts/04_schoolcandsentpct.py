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
	cur.execute("select * from \
	( \
	select \
	%s as school, \
	'@berniesanders' as keyword, \
	sentiment as s, \
	count(sentiment) as c, \
	cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2)) \
	as pct, \
	1 as sortorder \
	from schoolpol \
	where (lower(tweet) like '%%@berniesanders%%' or \
	lower(tweet) like '%%@berniesanders' or \
	lower(tweet) like '@berniesanders%%') \
	and (lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s) \
	group by s \
	union \
	select \
	%s as school, \
	'@hillaryclinton' as keyword, \
	sentiment as s, \
	count(sentiment) as c, \
	cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2)) \
	as pct, \
	2 as sortorder \
	from schoolpol \
	where lower(tweet) like '%%@hillaryclinton%%' or \
	lower(tweet) like '%%@hillaryclinton' or \
	lower(tweet) like '@hillaryclinton%%' \
	and (lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s) \
	group by s \
	union \
	select \
	%s as school, \
	'@realdonaldtrump' as keyword, \
	sentiment as s, \
	count(sentiment) as c, \
	cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2)) \
	as pct, \
	3 as sortorder \
	from schoolpol \
	where lower(tweet) like '%%@realdonaldtrump%%' or \
	lower(tweet) like '%%@realdonaldtrump' or \
	lower(tweet) like '@realdonaldtrump%%' \
	and (lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s) \
	group by s \
	union \
	select \
	%s as school, \
	'@tedcruz' as keyword, \
	sentiment as s, \
	count(sentiment) as c, \
	cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2)) \
	as pct, \
	4 as sortorder \
	from schoolpol \
	where lower(tweet) like '%%@tedcruz%%' or \
	lower(tweet) like '%%@tedcruz' or \
	lower(tweet) like '@tedcruz%%' \
	and (lower(tweet) like %s or \
	lower(tweet) like %s or \
	lower(tweet) like %s) \
	group by s \
	) q \
	order by sortorder asc, s desc \
	;", (school, school1, school2, school3, school, school1, school2, school3, school, school1, school2, school3, school, school1, school2, school3))
	records = cur.fetchall()
	for rec in records:
	 print """  %s | %s | %s | %s | %s pct"""%(rec[0],rec[1],rec[2], rec[3], rec[4])
	conn.commit()
else:
	print "Error: Please use correct syntax: $ python 04_schoolcandsentpct.py [SCHOOL]"