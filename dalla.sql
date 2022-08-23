use project;
select top 10*from df_dallas_availability;
select top 10* from host_dallas_df;
select top 10* from listing_dallas_df;
select top 10*from review_dallas_df;

/* 1. Counrt the no of super host and Normal host and all the metrivs distringuish between the suoerhost and normalhost*/

select count(*) as Total_No_of_SH from host_dallas_df where host_is_superhost=1;
select count(*) as Total_No_of_NH from host_dallas_df where host_is_superhost=0;

-- Response rate
select host_is_superhost,avg(host_response_rate)  as 'Response_rate'  from host_dallas_df
where host_is_superhost is not null
group by host_is_superhost;



/*select case 
when host_is_superhost = 1 then avg(host_response_rate) 
when host_is_superhost = 0 then avg(host_response_rate)
end as Response_rate
from host_dallas_df where host_response_rate is not null group by host_is_superhost;*/

-- Acceptance rate
select host_is_superhost,avg(host_acceptance_rate)  as 'Acceptance rate'  from host_dallas_df
where host_is_superhost is not null
group by host_is_superhost;

/*select case 
when host_is_superhost = 1 then avg(host_acceptance_rate) 
when host_is_superhost = 0 then avg(host_acceptance_rate)
end as Response_rate
from host_dallas_df where host_acceptance_rate is not null group by host_is_superhost;*/

--Count of Host_Id which is superhost is verified and vice versa.
select host_is_superhost, host_identity_verified, count(host_id) as No_of_Host from host_dallas_df 
group by host_is_superhost, host_identity_verified;


--total no of superhost has verified_id and not verified_id and total no of normalhost has verified_id and not verified_id
select host_is_superhost, sum(1) as Identity_verified,sum(0) as Not_Identity_verified
from host_dallas_df group by host_is_superhost;

/*select case 
when host_is_superhost = 0  then count(host_id)
when host_is_superhost = 1  then count(host_id)
end as a
from host_dallas_df group by host_is_superhost;
*/





			
--Count of Host_Id which is superhost as well have profile picture and vice versa.
select host_is_superhost, host_has_profile_pic, count(host_id) as No_of_Host from host_dallas_df where host_is_superhost is not null
group by host_is_superhost, host_has_profile_pic;

--total superhost has profile picture and total normalhost has profile picture
select host_is_superhost, sum(1) as profile_pic,sum(0) as no_profile_pic
from host_dallas_df group by host_is_superhost;


--Instant booking
select host_is_superhost, case when instant_bookable = 0 then 'instant_booking_not_available'
else 'instant_booking_available' end as bookable,
count from(select b.host_is_superhost,a.instant_bookable,
count(a.host_id)as count from host_dallas_df b inner join listing_dallas_df a
on b.host_id = a.host_id 
where b.host_is_superhost is not null group by
host_is_superhost, instant_bookable) as n



-- Review Scores
select a.host_is_superhost, avg(b.review_scores_value) as Avrg_score
from host_dallas_df as a join listing_dallas_df as b
on a.host_id = b.host_id
group by a.host_is_superhost;


select top 10* from listing_dallas_df;
select top 10* from host_dallas_df;
select top 10* from df_dallas_availability;
select top 10* from review_dallas_df;

--additional analysis
--1. total accomodated room for superhost and normal host
select a.host_is_superhost, sum(b.accommodates) as 'total accomodation'
from host_dallas_df as  a inner join listing_dallas_df as b
on a.host_id = b.host_id 
where a.host_is_superhost is not null group by
a.host_is_superhost;


--2. Total no of review for normalhost and superhost
select a.host_is_superhost, count(b.review_scores_value) as 'Total review' from listing_dallas_df as b
inner join host_dallas_df as a 
on a.host_id = b.host_id
where a.host_is_superhost is not null group by a.host_is_superhost;

--3. Total availabillity for normalhost and superhost
select a.host_is_superhost, count(b.available) as'Total availability'
from df_dallas_availability as b left join listing_dallas_df as c 
on c.id = b.listing_id left join host_dallas_df as a on a.host_id = c.host_id
where a.host_is_superhost is not null 
group by a.host_is_superhost;

--4. Average score for each categories
select a.host_is_superhost, avg(b.review_scores_cleanliness) as 'Avg For cleaning review', avg(b.review_scores_checkin) as 'Avg for checking review',
avg(b.review_scores_communication) as 'Avg for communication review', avg(b.review_scores_location) as 'Avg for location review'
from host_dallas_df as a join listing_dallas_df as b 
on a.host_id = b.host_id where a.host_is_superhost is not null
group by a.host_is_superhost;

--5. host listing count for both categories
select host_is_superhost,sum(host_listings_count) as 'Total of listing'  from host_dallas_df
where host_is_superhost is not null
group by host_is_superhost;

--6. price 
select a.host_is_superhost, avg(b.price) as 'Avergae price'
from df_dallas_availability as b left join listing_dallas_df as c 
on c.id = b.listing_id left join host_dallas_df as a on a.host_id = c.host_id
where a.host_is_superhost is not null 
group by a.host_is_superhost;

/* Q2. The three metrcies on which the normal host can focus to become a superhost
1. Response rate
2. Acceptance rate
3. review score */

-- Acceptance rate
select host_is_superhost,avg(host_acceptance_rate)  as 'Acceptance rate'  from host_dallas_df
where host_is_superhost is not null
group by host_is_superhost;

-- Response rate
select host_is_superhost,avg(host_response_rate)  as 'Response_rate'  from host_dallas_df
where host_is_superhost is not null
group by host_is_superhost;

-- Review Scores
select a.host_is_superhost, avg(b.review_scores_value) as Avrg_score
from host_dallas_df as a join listing_dallas_df as b
on a.host_id = b.host_id
group by a.host_is_superhost;


select top 10* from review_dallas_df;
select top 10* from listing_dallas_df;
select top 10* from host_dallas_df;
select top 10* from df_dallas_availability;


/* Q3. The comments of reviewers vary for listings of Super Hosts vs Other Hosts 
we review the comment on the basis of word appear in the comments -- if there is positive words like great, good, satisfiable,responsive,awesome,loved,stay again,helpful,pleasure,
beautiful nice, clean, perfect, more stars, excellent, ideal, lovely stay, safe place, then it will consider as positive comments.

we review the comment on the basis of word appear in the comments -- if there is negative words like not recommended, not clean, cancelled, rude, not good,strong smell, 
then it will consider as negative comments.
*/

select a.host_is_superhost, count(b.reviewer_id) as 'Review count'
from review_dallas_df as b left join listing_dallas_df as c 
on b.listing_id = c.id left join host_dallas_df as a on a.host_id = c.host_id
where b.comments like '%great%' or  b.comments like'%good%' or b.comments like '%satisfiable%' or b.comments like '%responsive%' or b.comments like '%awesome %'
or b.comments like '%love%' or b.comments like '% stay again%' or b.comments like '% helpful%' or b.comments like '% pleasure %' or b.comments like '%beautiful%'
or b.comments like '%clean%' or b.comments like '%perfect%' or b.comments like '%more stars %' or b.comments like '%excellent %' or b.comments like '%ideal%'
or b.comments like '%safe place%' and a.host_is_superhost is not null 
group by a.host_is_superhost;


select case when host_is_superhost = 1 then 'super host'
else 'normal host'
end as host_categories, review_count from( select a.host_is_superhost, count(b.reviewer_id) as review_count
from review_dallas_df as b left join listing_dallas_df as c on b.listing_id = c.id  
 left join host_dallas_df as a on a.host_id = c.host_id
 where (b.comments like '%great%' or  b.comments like'%good%' or b.comments like '%satisfiable%' or b.comments like '%responsive%' or b.comments like '%awesome %'
or b.comments like '%love%' or b.comments like '% stay again%' or b.comments like '% helpful%' or b.comments like '%pleasure %' or b.comments like '%beautiful%'
or b.comments like '%clean%' or b.comments like '%perfect%' or b.comments like '%more stars %' or b.comments like '%excellent %' or b.comments like '%ideal%'
or b.comments like '%safe place%') and a.host_is_superhost is not null 
group by a.host_is_superhost) as m  ;




-- negative comments
select a.host_is_superhost, count(b.reviewer_id) as 'Review count'
from review_dallas_df as b left join listing_dallas_df as c 
on b.listing_id = c.id left join host_dallas_df as a on a.host_id = c.host_id
 where (b.comments like '%not recommended%' or  b.comments like'%bad smell%' or b.comments like '%urine smell%' or b.comments like '%not good%' or b.comments like '%not clean%'
or b.comments like '%rude%' or b.comments like '%cancelled%' or b.comments like '%bad behaviour%' or b.comments like'%noise%' or b.comments like'%dusty%' or b.comments like'% worst%'
or b.comments like'%disturbing%') and a.host_is_superhost is not null 
group by a.host_is_superhost;





select case when host_is_superhost = 1 then 'super host'
when host_is_superhost = 0 then  'normal host'
end as host_categories, review_count from(select a.host_is_superhost, count(b.reviewer_id) as review_count
from review_dallas_df as b left join listing_dallas_df as c on b.listing_id = c.id 
left join host_dallas_df as a on a.host_id = c.host_id
where (b.comments like '%not recommended%' or  b.comments like'%bad smell%' or b.comments like '%urine smell%' or b.comments like '%not good%' or b.comments like '%not clean%'
or b.comments like '%rude%' or b.comments like '%cancelled%' or b.comments like '%bad behaviour%' or b.comments like'%noise%' or b.comments like'%dusty%' or b.comments like'% worst%'
or b.comments like'%disturbing%') and a.host_is_superhost is not null 
group by a.host_is_superhost) as m ;

select top 10* from review_dallas_df;
select top 10* from listing_dallas_df;
select top 10* from host_dallas_df;
select top 10* from df_dallas_availability;

--Q4. Analyze do Super Hosts tend to have large property types as compared to Other Hosts
select a.host_is_superhost, avg(b.bedrooms) as 'Avg of beds' from host_dallas_df as a join listing_dallas_df as b
on a.host_id = b.host_id where a.host_is_superhost is not null
group by a.host_is_superhost


--Q5. Analyze the average price and availability of the listings for the upcoming year between Super Hosts and Other Hosts
select a.host_is_superhost, avg(b.price) as 'Avergae price', year(date) as 'Upcoming year'
from df_dallas_availability as b left join listing_dallas_df as c 
on c.id = b.listing_id left join host_dallas_df as a on a.host_id = c.host_id
where a.host_is_superhost is not null 
group by a.host_is_superhost, year(date);


select a.host_is_superhost, count(b.available) as'Total availability', year(date) as 'Upcoming year'
from df_dallas_availability as b left join listing_dallas_df as c 
on c.id = b.listing_id left join host_dallas_df as a on a.host_id = c.host_id
where a.host_is_superhost is not null 
group by a.host_is_superhost, year(date);


--Q 6. Analyze if there is some difference in above mentioned trends between Local Hosts or Hosts residing in other locations 
select top 10* from review_dallas_df;
select top 10* from listing_dallas_df;
select top 10* from host_dallas_df;
select top 10* from df_dallas_availability;
