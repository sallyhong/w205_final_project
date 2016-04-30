import psycopg2
import sys

conn = psycopg2.connect(database="schoolstream", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

if len(sys.argv) == 3:
	if (sys.argv[1] == 'positive') or (sys.argv[1] == 'negative'):
		sentiment = sys.argv[1]
		candidate = sys.argv[2]
		cand1 = '%' + candidate + '%'
		cand2 = '%' + candidate
		cand3 = candidate + '%'
		cur.execute("select \
		%s as candidate, \
		%s as sentiment, \
		case \
		when lower(tweet) like '%%@harvard%%' then 'harvard' \
		when lower(tweet) like '%%harvard%%' then 'harvard' \
		when lower(tweet) like '%%yale%%' then 'yale' \
		when lower(tweet) like '%%@columbia %%' then 'columbia' \
		when lower(tweet) like '%%@columbia %%' then 'columbia' \
		when lower(tweet) like '%%columbia uni%%' then 'columbia' \
		when lower(tweet) like '%%stanford%%' then 'stanford' \
		when lower(tweet) like '%%uchicago%%' then 'uchicago' \
		when lower(tweet) like '%%@mit %%' then 'mit' \
		when lower(tweet) like '%%dukeu%%' then 'dukeu' \
		when lower(tweet) like '%%@penn %%' then 'upenn' \
		when lower(tweet) like '%%caltech%%' then 'caltech' \
		when lower(tweet) like '%%@cal %%' then 'berkeley' \
		when lower(tweet) like '%%johnshopkins%%' then 'jhu' \
		when lower(tweet) like '%%johns hopkins%%' then 'jhu' \
		when lower(tweet) like '%%jhu %%' then 'jhu' \
		when lower(tweet) like '%%northwesternu%%' then 'northwesternu' \
		when lower(tweet) like '%%northwestern uni%%' then 'northwesternu' \
		when lower(tweet) like '%%ucberkeley%%' then 'berkeley' \
		when lower(tweet) like '%%berkeley%%' then 'berkeley' \
		when lower(tweet) like '%%dartmouth%%' then 'dartmouth' \
		when lower(tweet) like '%%@uva %%' then 'uva' \
		when lower(tweet) like '%%nyuniversity%%' then 'nyu' \
		when lower(tweet) like '%%new york uni%%' then 'nyu' \
		when lower(tweet) like '%%umich%%' then 'umich' \
		when lower(tweet) like '%%university of virginia%%' then 'uva' \
		when lower(tweet) like '%%university of chicago%%' then 'uchicago' \
		when lower(tweet) like '%%university of michigan%%' then 'umich' \
		when lower(tweet) like '%%wharton%%' then 'upenn' \
		end \
		as school, \
		count(sentiment) as c, \
		cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2)) \
		as pct \
		from schoolpol \
		where (lower(tweet) like %s or \
		lower(tweet) like %s or \
		lower(tweet) like %s) \
		and lower(sentiment) like %s \
		group by school \
		having \
		(case \
		when lower(tweet) like '%%@harvard%%' then 'harvard' \
		when lower(tweet) like '%%harvard%%' then 'harvard' \
		when lower(tweet) like '%%yale%%' then 'yale' \
		when lower(tweet) like '%%@columbia %%' then 'columbia' \
		when lower(tweet) like '%%@columbia %%' then 'columbia' \
		when lower(tweet) like '%%columbia uni%%' then 'columbia' \
		when lower(tweet) like '%%stanford%%' then 'stanford' \
		when lower(tweet) like '%%uchicago%%' then 'uchicago' \
		when lower(tweet) like '%%@mit %%' then 'mit' \
		when lower(tweet) like '%%dukeu%%' then 'dukeu' \
		when lower(tweet) like '%%@penn %%' then 'upenn' \
		when lower(tweet) like '%%caltech%%' then 'caltech' \
		when lower(tweet) like '%%@cal %%' then 'berkeley' \
		when lower(tweet) like '%%johnshopkins%%' then 'jhu' \
		when lower(tweet) like '%%johns hopkins%%' then 'jhu' \
		when lower(tweet) like '%%jhu %%' then 'jhu' \
		when lower(tweet) like '%%northwesternu%%' then 'northwesternu' \
		when lower(tweet) like '%%northwestern uni%%' then 'northwesternu' \
		when lower(tweet) like '%%ucberkeley%%' then 'berkeley' \
		when lower(tweet) like '%%berkeley%%' then 'berkeley' \
		when lower(tweet) like '%%dartmouth%%' then 'dartmouth' \
		when lower(tweet) like '%%@uva %%' then 'uva' \
		when lower(tweet) like '%%nyuniversity%%' then 'nyu' \
		when lower(tweet) like '%%new york uni%%' then 'nyu' \
		when lower(tweet) like '%%umich%%' then 'umich' \
		when lower(tweet) like '%%university of virginia%%' then 'uva' \
		when lower(tweet) like '%%university of chicago%%' then 'uchicago' \
		when lower(tweet) like '%%university of michigan%%' then 'umich' \
		when lower(tweet) like '%%wharton%%' then 'upenn' \
		end) is not null order by c desc; ", (candidate, sentiment, cand1, cand2, cand3, sentiment))
		records = cur.fetchall()
		for rec in records:
		 print """  %s | %s | %s | %s | %s """%(rec[0],rec[1],rec[2], rec[3], rec[4])
		conn.commit()
	else:
		print "Error: Please use correct syntax: $ python 06_highestsentschoolcand.py [POSITIVE/NEGATIVE] [CANDIDATE]"
else:
	print "Error: Please use correct syntax: $ python 06_highestsentschoolcand.py [POSITIVE/NEGATIVE] [CANDIDATE]"