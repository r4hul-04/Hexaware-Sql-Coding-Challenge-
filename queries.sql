CREATE TABLE Crime (
CrimeID INT PRIMARY KEY,
IncidentType VARCHAR(255),
IncidentDate DATE,
Location VARCHAR(255),
Description TEXT,
Status VARCHAR(20));
CREATE TABLE Victim (
VictimID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255),
ContactInfo VARCHAR(255),
Age INT,
Injuries VARCHAR(255),
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
CREATE TABLE Suspect (
SuspectID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255),
Description TEXT,
Age INT,
CriminalHistory TEXT,
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
(1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
(2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
(3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo,Age ,Injuries)
VALUES
(1, 1, 'John Doe', 'johndoe@example.com',35 , 'Minor injuries'),
(2, 2, 'Jane Smith', 'janesmith@example.com',25 , 'Deceased'),
(3, 3, 'Alice Johnson', 'alicejohnson@example.com',45, 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, Age, CriminalHistory)
VALUES
(1, 1, 'Robber 1', 'Armed and masked robber',30, 'Previous robbery convictions'),
(2, 2, 'Unknown', 'Investigation ongoing',NULL, NULL),
(3, 3, 'Suspect 1', 'Shoplifting suspect',45, 'Prior shoplifting arrests');

Select * from Crime;
Select * from Suspect;
Select * from Victim;
-- 1;
select * from Crime where Status='Open';
-- 2);
Select Count(*) AS TotalNoOfIncidents From Crime;
-- 3);
Select Distinct IncidentType from Crime;
-- 4);
Select * from Crime where IncidentDate between '2023-09-01' and '2023-09-10';
-- 5);
Select Name, Age from Victim union Select Name, Age From  Suspect order by Age desc;
-- 6);
Select avg(Age) as AverageAge from(select Age from Victim union all select Age from Suspect) as A;
-- 7);
Select IncidentType, count(*) as Count from Crime where Status='Open' group by IncidentType;
-- 8);
Select Name from Victim where Name like '%Doe%' union Select name from Suspect where Name like '%Doe%';
-- 9);
select v.Name, c.Status from Victim v join Crime c on v.CrimeID = c.CrimeID
union
select s.Name, c.Status from Suspect s join Crime c on s.CrimeID = c.CrimeID;
-- 10);
Select distinct c.IncidentType from Crime c join Victim v on c.CrimeID=V.CrimeID 
where v.Age in(30,35) union Select Distinct c.IncidentType from Crime c join Suspect s on c.CrimeID=s.SuspectID 
where s.Age in(30,35);
-- 11);
Select Victim.Name from Victim join Crime where Crime.IncidentType='Robbery' 
union Select Suspect.Name from Suspect join Crime where Crime.IncidentType='Robbery';
-- 12);
Select IncidentType from Crime where Status='Open' group by IncidentType having Count(*)>1;
-- 13);
select distinct c.* from Crime c join Suspect s on c.CrimeID = s.CrimeID join Victim v on s.Name = v.Name;
-- 14);
Select c.*, v.Name as VictimName, v.ContactInfo, v.Injuries, s.Name as SuspectName, s.Description, s.CriminalHistory from Crime c
left join Victim v on c.CrimeID = v.CrimeID left join Suspect s on c.CrimeID = s.CrimeID;
-- 15);
Select distinct c.* from Crime c join Suspect s on c.CrimeID = s.CrimeID where s.Age > (select MAX(Age) from Victim where CrimeID = c.CrimeID);
-- 16);
Select Name, COUNT(*) as IncidentCount from Suspect group by Name having COUNT(*) > 1;
-- 17);
Select * from Crime where CrimeID not in (select distinct CrimeID from Suspect);
-- 18);
Select * from Crime where IncidentType = 'Homicide'and not exists (select * from Crime where IncidentType not in ('Homicide', 'Robbery'));
-- 19);
Select c.CrimeID, c.IncidentType, c.IncidentDate, c.Status, s.Name as SuspectName from Crime C left join Suspect s on c.CrimeID = s.CrimeID;
-- 20);
select distinct s.Name from Suspect s join Crime c on s.CrimeID = c.CrimeID where c.IncidentType in ('Robbery', 'Assault');
