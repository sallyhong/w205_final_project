import psycopg2
import sys

conn = psycopg2.connect(database="schoolstream", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
	
if len(sys.argv) == 3:
	if (sys.argv[1] == 'positive') or (sys.argv[1] == 'negative'):
		#arg = (sys.argv[1]).split(',')
		#low = arg[0]
		#high = arg[1]
		sentiment = sys.argv[1]
		print sentiment
		candidate = sys.argv[2]
		cand1 = '%' + candidate + '%'
		cand2 = '%' + candidate
		cand3 = candidate + '%'
		cur.execute("select \
		%s as candidate, \
		tweet, \
		sentiment, \
		count(sentiment) as c \
		from schoolpol \
		where (lower(tweet) like %s or \
		lower(tweet) like %s or \
		lower(tweet) like %s) and \
		lower(sentiment) like %s \
		group by sentiment, tweet \
		order by c desc \
		limit 1;", (candidate, cand1, cand2, cand3, sentiment))
		records = cur.fetchall()
		for rec in records:
		 print """  "%s": %s | %s | Count: %s"""%(rec[0],rec[1],rec[2], rec[3])
		conn.commit()
	else:
		print "Error: Please use correct syntax: $ python 02_topsweetsentiment.py [POSITIVE/NEGATIVE] [CANDIDATE]"
else:
	print "Error: Please use correct syntax: $ python 02_topsweetsentiment.py [POSITIVE/NEGATIVE] [CANDIDATE]"