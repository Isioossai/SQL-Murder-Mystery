/* Murder occured on Januuary 15, 2018 and it took place in 
SQL city*/

-- start by retrieving the crime scene report
SELECT * FROM crime_scene_report
SELECT * FROM crime_scene_report
WHERE Date = 20180115 AND City = 'SQL City'

/* Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on ""Northwestern Dr"".
The second witness, named Annabel, lives somewhere on ""Franklin Ave"" */
SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC

-- Our First witness is Morty Schapiro
-- Id = 14887, licensse_id = 118009, address number = 4919, ssn = 111564949

--Find second witness
SELECT * FROM Person
WHERE Name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave'

/* Our Second witness is Annabel Miller, Id = 16371, license id = 490173,
ssn = 318771143 */

SELECT * FROM interview
WHERE person_id IN (14887, 16371)

/* Morty the first witness said "I heard a gunshot and then saw a man run out.
He had a ""Get Fit Now Gym"" bag. The membership number on the bag started with 
""48Z"". Only gold members have those bags. The man got into a car with a plate 
that included ""H42W""." */

/* Second witness Annabel said "I saw the murder happen, and I recognized the killer
from my gym when I was working out last week on January the 9th."*/

/* Clues : we are looking for
1. a guy who has a number 48z on a get fit now bag
2. Gold member
3. The man's plate number includes - H42W */

SELECT * FROM get_fit_now_member
WHERE id LIKE '48Z%' AND membership_status = 'gold'

/* Suspects :
1. Joe Germuska ; id = 48Z7A, person id = 28819, 
membership_start date =20160305, membership status = gold
2. Jeremy Bowers; id = 48Z55, person_id = 67318, membership start date = 20160101
membership status = gold*/

SELECT * FROM get_fit_now_check_in
WHERE check_in_date = 20180109 AND
membership_id IN ('48Z55', '48Z7A')

--Both suspects were at the gym on the 9th of jan according to the second witness

SELECT * FROM drivers_license

/*JOIN drivers_license table with person table
driver's license table can be tagged dl, person table as p*/
CREATE TABLE Joined_table AS
(SELECT dl.age, dl.height, dl.hair_color, dl.gender, dl.plate_number,
dl.car_make, dl.car_model, p.name, p.address_street_name, p.id
FROM Drivers_license AS dl
LEFT JOIN Person AS p
ON dl.id = p.license_id)

SELECT * FROM Joined_table
WHERE plate_number LIKE '%H42W%'

-- The Killer is JEREMY BOWERS

/* Congrats, you found the murderer! But wait, there's more... If you think you're up
for a challenge, try querying the interview transcript of the murderer to find the
real villain behind this crime. If you feel especially confident in your SQL skills, 
try to complete this final step with no more than 2 queries. Use this same INSERT 
statement with your new suspect to check your answer. */

SELECT * FROM Interview
WHERE person_id = 67318

/* Jeremy's statement : "I was hired by a woman with a lot of money. I don't 
know her name but I know she's around 5'5"" (65"") or 5'7"" (67""). She has red 
hair and she drives a Tesla Model S. I know that she attended the SQL Symphony
Concert 3 times in December 2017 */
CREATE TABLE Suspect_table AS
(SELECT * FROM Joined_table
WHERE height BETWEEN 65 AND 67
AND hair_color = 'red'
AND car_make = 'Tesla'
AND gender = 'female'
And car_model = 'Model S')

SELECT * FROM Suspect_table
/* Suspect Names: 
-Red Korb -78881
-Regina George - 90700
-Miranda Priestly - 99716 */

SELECT * FROM Facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND Date Between 20171201 AND 20171231
AND Person_id IN (78881, 900700, 99716)

SELECT s.id, s.age, s.height, p.id as person_id, p.name, p.address_street_name, p.ssn
FROM Suspect_table AS s
RIGHT JOIN Person as p
ON s.id = p.license_id

--MIRANDA PRIESTLY hired the assassin


