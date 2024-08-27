-- create schema
create schema marathon authorization postgres;
--set path to schema
set search_path to marathon
show search_path

-- Create Table --
-- Team Table
create table team(
	team_id serial primary key,
	team_name varchar(50) unique not null,
	coach varchar(50) not null,
	home_ground varchar(100) not null,
	founded_year INT not null,
	owner varchar(50) not null
)

-- Player table
create table players(
	player_id serial primary key,
	player_name varchar(50) not null,
	team_id int not null references team(team_id),
	role varchar(30) not null,
	age int not null,
	matches_played int not null
)

-- Matches table
create table matches(
	match_id serial primary key,
	match_date date not null,
	venue varchar(100) not null,
	team1_id int not null references team(team_id),
	team2_id int not null references team(team_id),
	winner_team_id int references team(team_id)
)

-- Fan_Engagement table
create table fan_engagement(
	engagement_id serial primary key,
	match_id int not null references matches(match_id),
	fan_id int not null,
	engagement_type varchar(50) not null,
	engagement_time timestamp not null
)



-- Insert Data --
--Teams
INSERT INTO Team (team_name, coach, home_ground, founded_year, owner)
VALUES
('Mumbai Indians', 'Mahela Jayawardene', 'Wankhede Stadium', 2008, 'Reliance Industries'),
('Chennai Super Kings', 'Stephen Fleming', 'M. A. Chidambaram Stadium', 2008, 'India Cements'),
('Royal Challengers Bangalore', 'Sanjay Bangar', 'M. Chinnaswamy Stadium', 2008, 'United Spirits'),
('Kolkata Knight Riders', 'Brendon McCullum', 'Eden Gardens', 2008, 'Red Chillies Entertainment'),
('Delhi Capitals', 'Ricky Ponting', 'Arun Jaitley Stadium', 2008, 'GMR Group &amp; JSW Group');

--Players
INSERT INTO Players (player_name, team_id, role, age, matches_played)
VALUES
('Rohit Sharma', 1, 'Batsman', 36, 227),
('Jasprit Bumrah', 1, 'Bowler', 30, 120),
('MS Dhoni', 2, 'Wicketkeeper-Batsman', 42, 234),
('Ravindra Jadeja', 2, 'All-Rounder', 35, 210),
('Virat Kohli', 3, 'Batsman', 35, 237),
('AB de Villiers', 3, 'Batsman', 40, 184),
('Andre Russell', 4, 'All-Rounder', 36, 140),
('Sunil Narine', 4, 'Bowler', 35, 144),
('Rishabh Pant', 5, 'Wicketkeeper-Batsman', 26, 98),
('Shikhar Dhawan', 5, 'Batsman', 38, 206);

--Matches
INSERT INTO Matches (match_date, venue, team1_id, team2_id, winner_team_id)
VALUES
('2024-04-01', 'Wankhede Stadium', 1, 2, 1),
('2024-04-05', 'M. A. Chidambaram Stadium', 2, 3, 3),
('2024-04-10', 'M. Chinnaswamy Stadium', 3, 4, 4),
('2024-04-15', 'Eden Gardens', 4, 5, 4),
('2024-04-20', 'Arun Jaitley Stadium', 5, 1, 1),
('2024-04-25', 'Wankhede Stadium', 1, 3, 3),
('2024-05-01', 'M. A. Chidambaram Stadium', 2, 5, 2),
('2024-05-05', 'M. Chinnaswamy Stadium', 3, 1, 1),
('2024-05-10', 'Eden Gardens', 4, 2, 2),
('2024-05-15', 'Arun Jaitley Stadium', 5, 4, 4);

--Fan_Engagement
INSERT INTO Fan_Engagement (match_id, fan_id, engagement_type, engagement_time)
VALUES
(1, 101, 'Tweet', '2024-04-01 18:30:00'),
(1, 102, 'Like', '2024-04-01 18:35:00'),
(2, 103, 'Comment', '2024-04-05 20:00:00'),
(2, 104, 'Share', '2024-04-05 20:05:00'),
(3, 105, 'Tweet', '2024-04-10 16:00:00'),
(3, 106, 'Like', '2024-04-10 16:05:00'),
(4, 107, 'Comment', '2024-04-15 21:00:00'),
(4, 108, 'Share', '2024-04-15 21:10:00'),
(5, 109, 'Tweet', '2024-04-20 19:00:00'),
(5, 110, 'Like', '2024-04-20 19:05:00'),
(6, 111, 'Comment', '2024-04-25 20:00:00'),
(6, 112, 'Share', '2024-04-25 20:10:00'),
(7, 113, 'Tweet', '2024-05-01 18:00:00'),
(7, 114, 'Like', '2024-05-01 18:05:00'),
(8, 115, 'Comment', '2024-05-05 19:30:00'),
(8, 116, 'Share', '2024-05-05 19:35:00'),
(9, 117, 'Tweet', '2024-05-10 20:30:00'),
(9, 118, 'Like', '2024-05-10 20:35:00'),
(10, 119, 'Comment', '2024-05-15 21:45:00'),
(10, 120, 'Share', '2024-05-15 21:50:00');



-- Query --
-- 1.Retrieve the Details of All Matches Played at a Specific Venue 'Wankhede Stadium'
select m.match_id, m.match_date, m.venue, t1.team_name as "Team1",
    t2.team_name as "Team2"
from matches m
join team t1 on m.team1_id = t1.team_id
join team t2 on m.team2_id = t2.team_id
where m.venue = 'Wankhede Stadium'

-- 2.List the Players Who Are Older Than 30 Years and Have Played More Than 200Matches
select * from players where age>30 and matches_played > 200;

-- 3. Display the Number of Matches Played with title "Number of Matches" at Each Venue 
select venue as "Venue", count(match_id) as "Number of Matches" from matches group by venue

-- 4. Find the match dates and venues for matches where the winner was Mumbai Indians.
select m.match_date, m.venue, t.team_name from matches m 
	join team t on m.winner_team_id = t.team_id
	where t.team_name like 'Mumbai Indians';

-- 5. Retrieve details of all matches played by Mumbai Indians, and the match was won by a team other than Mumbai Indians.
--joins
select m.match_id, m.match_date, m.venue, t1.team_name as "Team1",t2.team_name as "Team2",w.team_name as "Winner Team"
from matches m
join team t1 on m.team1_id = t1.team_id
join team t2 on m.team2_id = t2.team_id
join Team w on m.winner_team_id = w.team_id
where (t1.team_name = 'Mumbai Indians' or t2.team_name = 'Mumbai Indians') 
	and w.team_name != 'Mumbai Indians';

-- using case (Final)
select m.match_id,
       m.match_date,
       m.venue,
       case 
           when t1.team_name = 'Mumbai Indians' and m.team2_id = m.winner_team_id then t1.team_name
           when t2.team_name = 'Mumbai Indians' and m.team1_id = m.winner_team_id then t2.team_name
       end as "Participating Team",
       case 
           when t1.team_name = 'Mumbai Indians' and m.team2_id = m.winner_team_id then t2.team_name
           when t2.team_name = 'Mumbai Indians' and m.team1_id = m.winner_team_id then t1.team_name
       end as "Winner Team"
from matches m
join team t1 on m.team1_id = t1.team_id
join team t2 on m.team2_id = t2.team_id
where (t1.team_name = 'Mumbai Indians' and m.team2_id = m.winner_team_id)
   or (t2.team_name = 'Mumbai Indians' and m.team1_id = m.winner_team_id);



--Phase 3---
--1.   Find the player who participated in the highest number of winning matches. Display the Player Name along with the total number of winning matches .
select  p.player_name, count(m.match_id) as winning_matches_count
from players p
join matches m on p.team_id = m.winner_team_id
group by p.player_name
order by winning_matches_count desc limit 1;

--2. Determine the venue with the highest number of matches played and the total fan engagements at that venue. Display the Venue , Total Matches , Total Fan Engagements.
select m.venue, count(m.match_id) as "Total Matches", count(f.engagement_id) 
from matches m
join fan_engagement f on m.match_id=f.match_id
group by m.venue
order by "Total Matches"
limit 1

--3. Find the player who has the most fan engagements across all matches.Display the player name and the count of fan engagements .
select p.player_name, count(f.engagement_id) as engagement_count
from players p
join matches m on p.team_id=m.team1_id or p.team_id = m.team2_id
join fan_engagement f on m.match_id=f.match_id
group by p.player_name
order by p.player_name

--4.Write an SQL query to find out which stadium and match had the highest fan engagement. The query should return the stadium name, match date, and the total number of fan engagements for that match, ordered by the latest match date .
select m.venue as stadium, m.match_date, count(f.engagement_id) as total_engagements
from matches m
join fan_engagement f on m.match_id = f.match_id
group by m.venue, m.match_date
order by total_engagements desc limit 1

-- 5.     Generate a report for the "Mumbai Indians" that includes details for each match they played:
-- a.      Match date.
-- b.     Opposing team's name.
-- c.      Venue.
-- d.     Total number of fan engagements recorded during each match.
-- e.      Name of the player from "Mumbai Indians" who has played the most matches up to the date of each 
SELECT m.match_date,
    CASE WHEN m.team1_id = mi.team_id THEN t2.team_name ELSE t1.team_name
    END AS opposing_team,
    m.venue, COUNT(f.engagement_id) AS total_fan_engagements,
    p.player_name AS top_player
FROM matches m
JOIN team mi ON m.team1_id = mi.team_id OR m.team2_id = mi.team_id
JOIN team t1 ON m.team1_id = t1.team_id
JOIN team t2 ON m.team2_id = t2.team_id
JOIN fan_engagement f ON m.match_id = f.match_id
JOIN players p ON p.team_id = mi.team_id
WHERE mi.team_name = 'Mumbai Indians'
GROUP BY m.match_date, opposing_team, m.venue, p.player_name
ORDER BY m.match_date;



-- Phase 4 --
--1. Create a view named TopPerformers that shows the names of players, their teams, and the number of matches they have played, filtering only those who have played more than 100 matches.
create view TopPerformers as
select p.player_name, t.team_name, p.matches_played
from players p
join team t on p.team_id = t.team_id
where p.matches_played > 100;

select * from  TopPerformers;

--2. Create a view named MatchHighlights that displays the match date, teams involved, venue, and the winner of each match.
create view MatchHighlights as
select m.match_date,t1.team_name as team1,
    t2.team_name as team2, m.venue,
    t3.team_name as winner
from matches m
join team t1 on m.team1_id = t1.team_id
join team t2 on m.team2_id = t2.team_id
left join team t3 on m.winner_team_id = t3.team_id;

select * from  MatchHighlights;

--3. Create a view named FanEngagementStats that summarizes the total engagements for each match, including match date and venue.
create view FanEngagementStats as
select m.match_date,m.venue,m.match_id,
    count(fe.engagement_id) as total_engagements
from matches m
join fan_engagement fe on m.match_id = fe.match_id
group by m.match_date, m.venue, m.match_id;

select * from  FanEngagementStats;

--4.   Create a view named TeamPerformance that shows each team's name, the number of matches played, and the number of matches won.
create view TeamPerformance as
select t.team_name,count(distinct m.match_id) as matches_played,
    count(distinct m2.match_id) as matches_won
from team t
left join matches m on t.team_id in (m.team1_id, m.team2_id)
left join matches m2 on t.team_id = m2.winner_team_id
group by t.team_name;

select * from  TeamPerformance;

--5. Create a view named TeamEngagementSummary that summarizes fan engagements for each team per match, including:
-- Match date and venue.
-- Team names (both teams).
-- Total number of engagements for each team in each match.
-- The date of the team's most engaged match (highest engagement).
-- The fan ID who engaged the most during the team's most engaged match.
create view TeamEngagementSummary as
    select m.match_date, m.venue, t1.team_name as team_1, t2.team_name as team_2, 
    count(case when f.match_id = m.match_id and t1.team_id in (m.team1_id, m.team2_id) then f.engagement_id end) as total_engagements_team1,
    count(case when f.match_id = m.match_id and t2.team_id in (m.team1_id, m.team2_id) then f.engagement_id end) as total_engagements_team2,
    max(f.engagement_time) as most_engaged_match_date,
    max(f.fan_id) as top_fan_id
    from matches m
    join team t1 on m.team1_id = t1.team_id
    join team t2 on m.team2_id = t2.team_id
    left join fan_engagement f on m.match_id = f.match_id
    group by m.match_date, m.venue, t1.team_name, t2.team_name;
select * from  TeamEngagementSummary;




