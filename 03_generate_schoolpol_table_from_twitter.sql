--- Filters containing school keywords as filter ---
drop table if exists school;

select * into school from twitter
where lower(tweet) like '%princeton%' or
 lower(tweet) like '%harvard%' or
 lower(tweet) like '%yale%' or
 lower(tweet) like '%@columbia %' or
 lower(tweet) like '%@columbia %' or
 lower(tweet) like '%columbia uni%' or
 lower(tweet) like '%stanford%' or
 lower(tweet) like '%uchicago%' or
 lower(tweet) like '%@mit %' or
 lower(tweet) like '%dukeu%' or
 lower(tweet) like '%@penn %' or
 lower(tweet) like '%caltech%' or
 lower(tweet) like '%@cal %' or
 lower(tweet) like '%johnshopkins%' or
 lower(tweet) like '%johns hopkins%' or
 lower(tweet) like '%jhu %' or
 lower(tweet) like '%northwesternu%' or
 lower(tweet) like '%northwestern uni%' or
 lower(tweet) like '%ucberkeley%' or
 lower(tweet) like '%berkeley%' or
 lower(tweet) like '%dartmouth%' or
 lower(tweet) like '%@uva %' or
 lower(tweet) like '%nyuniversity%' or
 lower(tweet) like '%new york uni%' or
 lower(tweet) like '%umich%' or
 lower(tweet) like '%university of virginia%' or
 lower(tweet) like '%university of chicago%' or
 lower(tweet) like '%university of michigan%' or
 lower(tweet) like '%wharton%'
;

--- From filtered table of schools, filters containing candidate keywords as filter ---
drop table if exists schoolpol;

select * into schoolpol
from school
where lower(tweet) like '%@berniesanders%' or
lower(tweet) like '%@berniesanders' or
lower(tweet) like '@berniesanders%' or
lower(tweet) like '%@hillaryclinton%' or
lower(tweet) like '%@hillaryclinton' or
lower(tweet) like '@hillaryclinton%' or
lower(tweet) like '%@realdonaldtrump%' or
lower(tweet) like '%@realdonaldtrump' or
lower(tweet) like '@realdonaldtrump%' or
lower(tweet) like '%@obama%' or
lower(tweet) like '%@obama%' or
lower(tweet) like '@obama%' or
lower(tweet) like '%@tedcruz%' or
lower(tweet) like '%@tedcruz%' or
lower(tweet) like '@tedcruz%'
;

---This code outputs the sentiment (positive, neutral, negative) of candidate chosen, the percentage of positive, neutral, negative tweets compared to total tweets for given candidate.---

select * from
(
select 
'@berniesanders' as keyword,
sentiment as s,
count(sentiment) as c,
cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2))
as pct,
1 as sortorder
from tweetpolarity
where lower(tweet) like '%@berniesanders%' or
lower(tweet) like '%@berniesanders' or
lower(tweet) like '@berniesanders%'
group by s
union
select 
'@hillaryclinton' as keyword,
sentiment as s,
count(sentiment) as c,
cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2))
as pct,
2 as sortorder
from tweetpolarity
where lower(tweet) like '%@hillaryclinton%' or
lower(tweet) like '%@hillaryclinton' or
lower(tweet) like '@hillaryclinton%'
group by s
union
select 
'@realdonaldtrump' as keyword,
sentiment as s,
count(sentiment) as c,
cast(count(sentiment) * 100 /sum(count(*)) over() as decimal(18,2))
as pct,
3 as sortorder
from tweetpolarity
where lower(tweet) like '%@realdonaldtrump%' or
lower(tweet) like '%@realdonaldtrump' or
lower(tweet) like '@realdonaldtrump%'
group by s
) q
order by sortorder asc, s desc
;

--- The following will list count of tweets by school for the candidate. Change the WHERE clause to candidate you want.---
drop table if exists candschooltweet;

select
* into candschooltweet
from
(
select
'trump' as candidate,
case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end
as school,
count(tweet) as c
from schoolpol
where lower(tweet) like '%@realdonaldtrump%' or
lower(tweet) like '%@realdonaldtrump' or
lower(tweet) like '@realdonaldtrump%'
group by school
having
(case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end) is not null

union

select
'clinton' as candidate,
case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end
as school,
count(tweet) as c
from schoolpol
where lower(tweet) like '%@hillaryclinton%' or
lower(tweet) like '%@hillaryclinton' or
lower(tweet) like '@hillaryclinton%'
group by school
having
(case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end) is not null

union

select
'sanders' as candidate,
case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end
as school,
count(tweet) as c
from schoolpol
where lower(tweet) like '%@berniesanders%' or
lower(tweet) like '%@berniesanders' or
lower(tweet) like '@berniesanders%'
group by school
having
(case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end) is not null

union

select
'cruz' as candidate,
case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end
as school,
count(tweet) as c
from schoolpol
where lower(tweet) like '%@tedcruz%' or
lower(tweet) like '%@tedcruz' or
lower(tweet) like '@tedcruz%'
group by school
having
(case
when lower(tweet) like '%@harvard%' then 'harvard'
when lower(tweet) like '%harvard%' then 'harvard'
when lower(tweet) like '%yale%' then 'yale'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%@columbia %' then 'columbia'
when lower(tweet) like '%columbia uni%' then 'columbia'
when lower(tweet) like '%stanford%' then 'stanford'
when lower(tweet) like '%uchicago%' then 'uchicago'
when lower(tweet) like '%@mit %' then 'mit'
when lower(tweet) like '%dukeu%' then 'dukeu'
when lower(tweet) like '%@penn %' then 'upenn'
when lower(tweet) like '%caltech%' then 'caltech'
when lower(tweet) like '%@cal %' then 'berkeley'
when lower(tweet) like '%johnshopkins%' then 'jhu'
when lower(tweet) like '%johns hopkins%' then 'jhu'
when lower(tweet) like '%jhu %' then 'jhu'
when lower(tweet) like '%northwesternu%' then 'northwesternu'
when lower(tweet) like '%northwestern uni%' then 'northwesternu'
when lower(tweet) like '%ucberkeley%' then 'berkeley'
when lower(tweet) like '%berkeley%' then 'berkeley'
when lower(tweet) like '%dartmouth%' then 'dartmouth'
when lower(tweet) like '%@uva %' then 'uva'
when lower(tweet) like '%nyuniversity%' then 'nyu'
when lower(tweet) like '%new york uni%' then 'nyu'
when lower(tweet) like '%umich%' then 'umich'
when lower(tweet) like '%university of virginia%' then 'uva'
when lower(tweet) like '%university of chicago%' then 'uchicago'
when lower(tweet) like '%university of michigan%' then 'umich'
when lower(tweet) like '%wharton%' then 'upenn'
end) is not null
) q
order by candidate asc, c desc
;
