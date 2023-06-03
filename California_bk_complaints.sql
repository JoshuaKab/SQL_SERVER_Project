
1. The purpose of this analysis is to fund the marketing trends of the american bank datasets,
-- the main focus will be for on the state of California, the number of complaints, the type of complaints
-- and the name of the timely of response.

SELECT * 
FROM admin.consumercomplaints

2. the number of complaints in the state of california

SELECT 
COUNT(distinct ComplaintID) AS num_complaints
FROM admin.consumercomplaints
WHERE StateName = "CA"
--- the type of Compalints

SELECT Issue,
COUNT(distinct ComplaintID) AS num_complaints
FROM admin.consumercomplaints
WHERE StateName = "CA"
GROUP BY Issue
Order by num_complaints desc

--the names of loans taken

SELECT ProductName,
COUNT(distinct ComplaintID) as num_complaints
FROM admin.consumercomplaints
WHERE StateName = "CA"
Group by ProductName
order by num_complaints desc

--number of complaint trough the year and which year had the most complaints


SELECT 
EXTRACT(CAST(Year from DateReceived )AS DATE) AS Year,
COUNT(ComplaintID) AS num_Complaints
FROM admin.consumercomplaints
WHERE StateName = "CA"


