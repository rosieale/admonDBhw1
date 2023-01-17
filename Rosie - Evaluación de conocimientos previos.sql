 --Creación de DB y tablas
CREATE DATABASE PRUEBA

CREATE TABLE TEAMS(
    Team_ID INTEGER NOT NULL,
    Team_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (Team_ID)
);
CREATE TABLE MATCHES(
    Match_ID INTEGER NOT NULL,
    Host_Team INTEGER NOT NULL,
    Guest_Team INTEGER NOT NULL,
    Host_Goals INTEGER NOT NULL,
    Guest_Goals INTEGER NOT NULL,
    PRIMARY KEY (Match_ID)
);

--Insertar datos
INSERT INTO TEAMS VALUES
(10,'Give'),
(20,'Never'),
(30,'You'),
(40,'UP'),
(50,'Gonna');

INSERT INTO MATCHES VALUES 
(1,30,20,1,0),
(2,10,20,1,2),
(3,20,50,2,2)
(4,10,30,1,0),
(5,30,50,0,1);

--Select
SELECT * FROM MATCHES
SELECT * FROM TEAMS
 
 --Joins y Union
 SELECT t.Team_id, t.Team_name, COALESCE(SUM(Num_points), 0) AS Num_points
    FROM(
         SELECT t.Team_id, t.Team_name,
          (CASE WHEN m.Host_goals > m.Guest_goals THEN 3
                WHEN m.Host_goals = m.Guest_goals THEN 1
                WHEN m.Host_goals < m.Guest_goals THEN 0
                END) AS Num_points
         FROM TEAMS t
         JOIN MATCHES m
         ON t.Team_id = m.Host_team
         UNION
         SELECT t.team_id, t.team_name,
          (CASE WHEN m.Guest_goals > m.Host_goals THEN 3
                WHEN m.Guest_goals = m.Host_goals THEN 1
                WHEN m.Guest_goals < m.Host_goals THEN 0
                END) AS num_points
         FROM TEAMS t
         JOIN MATCHES m
         ON t.Team_id = m.Guest_team
    ) AS c
    RIGHT JOIN TEAMS t
    ON t.Team_id = c.Team_id
    GROUP BY t.Team_id, t.Team_name
    ORDER BY COALESCE(SUM(Num_points), 0) DESC, t.Team_id
    
