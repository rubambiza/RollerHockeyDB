-- Team 1
-- Bekah Suttner, Gloire Rubambiza, Wesley Guthrie, David Brown
--
-- File: RollerHockeyDB.sql
--
-- Drop the tables (in case they already exist)
--
DROP TABLE university CASCADE CONSTRAINTS;
DROP TABLE team CASCADE CONSTRAINTS;
DROP TABLE player CASCADE CONSTRAINTS;
DROP TABLE game CASCADE CONSTRAINTS;
DROP TABLE team_stats CASCADE CONSTRAINTS;
DROP TABLE locations CASCADE CONSTRAINTS;
DROP TABLE games_played CASCADE CONSTRAINTS;
--
-- Create the tables
--
-- University(*uName*, uSize, yearFounded)
--
CREATE TABLE university (
  uName         varchar2(50) PRIMARY KEY,
  uSize         number(6),
  yearFounded   number(4)
);
--
-- Team(*teamID*, jerseyColor, mascot, univName)
--
CREATE TABLE team (
  teamID        number(5) PRIMARY KEY,
  jerseyColor   varchar2(20),
  mascot        varchar2(30),
  univName      varchar2(50),
  CONSTRAINT ICunivNameForeignKey FOREIGN KEY (univName) REFERENCES university(uName)
);
--
-- Player(*playerID*, fname, lname, height, weight, num, position, tID)
--
CREATE TABLE player (
  playerID    	number(6) PRIMARY KEY,
  fname     	varchar2(30),
  lname    		varchar2(30),
  height     	number(3),
  weight  		number(3),
  num       	number(2),
  position    	char(1),
  tID     		number(5),
  CONSTRAINT ICteamIdForeignKey FOREIGN KEY (tID) REFERENCES team(teamID),
  CONSTRAINT ICnumber CHECK (num > 0 OR num <= 99),
  CONSTRAINT ICnumbergoalie CHECK (NOT (num < 30 AND position = 'G'))
);
--
-- Games(*gameID*, gDate, hscore, ascore, hTID, aTID)
--
CREATE TABLE game (
  gameID    	number(6) PRIMARY KEY,
  gDate       	date, /* standard date format is DD-MON-YYYY */
  hscore    	number(2),
  ascore    	number(2),
  hTID			number(5),
  aTID			number(5),
  CONSTRAINT IChTIDForeignKey FOREIGN KEY (hTID) REFERENCES team(teamID),
  CONSTRAINT ICaTIDForeignKey FOREIGN KEY (aTID) REFERENCES team(teamID)
);
--
-- TeamStats(*year, tmID*, wins, losses, points)
--
CREATE TABLE team_stats (
  year        	number(4),
  tmID          number(5),
  wins         	number(2),
  losses     	number(2),
  points        number(2),
  PRIMARY KEY (year,tmID),
  CONSTRAINT ICtmIDForeignKey FOREIGN KEY (tmID) REFERENCES team(teamID)
);
--
-- Locations(*uniName , location*)
--
CREATE TABLE locations (
  uniName    	varchar2(50),
  location      varchar2(30),
  primary key (uniName,location),
  CONSTRAINT ICuniNameForeignKey FOREIGN KEY(uniName) REFERENCES university(uName)
);
--
-- GamesPlayed(pID, gID, goalsScored)
--
CREATE TABLE games_played (
  pID    		number(6),
  gID       	number(6),
  goalsScored 	number(2),
  primary key (pID,gID),
  CONSTRAINT ICpIDForeignKey FOREIGN KEY(pID) REFERENCES player(playerID),
  CONSTRAINT ICgIDForeignKey FOREIGN KEY(gID) REFERENCES game(gameID)
);
--
-- ----------------------------------------------------------
-- Populate the database
-- ----------------------------------------------------------
--
-- Universities
insert into university values('Robert Morris University', 5000, 1921);
insert into university values('Farmingdale State College', 9000, 1912);
insert into university values('West Chester University of Pennsylvania', 16000, 1871);
insert into university values('University of Massachusetts', 79000 , 1863);
insert into university values('University of Rhode Island', 16000, 1892);
insert into university values('Rowan University', 13000, 1923 );
insert into university values('Hofstra University', 11000, 1935);
insert into university values('Temple University', 40000, 1884 );
insert into university values('State University of New York at Cortland', 7000, 1868 );
insert into university values('Neumann University', 3000, 1965);
--
-- Teams
insert into team values(57984, 'Navy', 'Knights', 'Neumann University');
insert into team values(57950, 'Green', 'Rams', 'Farmingdale State College');
insert into team values(57946, 'Purple', 'Golden Rams', 'West Chester University of Pennsylvania');
insert into team values(57966, 'Maroon', 'Minuteman', 'University of Massachusetts');
insert into team values(57958, 'Dark Blue', 'Rams', 'University of Rhode Island');
insert into team values(57937, 'Black', 'Owls', 'Rowan University');
insert into team values(57959, 'Navy', 'Colonials', 'Robert Morris University');
insert into team values(57953, 'Blue', 'Pride', 'Hofstra University');
insert into team values(57964, 'Cherry', 'Owls', 'Temple University');
insert into team values(57941, 'Red', 'Dragons', 'State University of New York at Cortland');
--
-- Players
insert into player values (	138942,	'Tyler',	'Kraft',	70,	185,	16,	'F',	57984	);
insert into player values (	138970,	'Sean',	'Phelan',	72,	200,	96,	'F',	57984	);
insert into player values (	138962,	'Nicholas',	'DeSalvo',	66,	145,	11,	'F',	57984	);
insert into player values (	141568,	'Gregory',	'Saklad',	67,	160,	97,	'F',	57984	);
insert into player values (	138965,	'Michael',	'Strofe',	70,	225,	26,	'F',	57984	);
insert into player values (	141565,	'Derek',	'Schultz',	73,	170,	98,	'F',	57984	);
insert into player values (	138969,	'Shane',	'Fox',	70,	170,	13,	'D',	57984	);
insert into player values (	138966,	'Ryan',	'Carr',	74,	190,	23,	'D',	57984	);
insert into player values (	139026,	'Andy',	'Zubak',	71,	174,	28,	'D',	57984	);
insert into player values (	139009,	'Adam',	'Goggio',	76,	175,	37,	'G',	57984	);
insert into player values (	139715,	'Luc',	'Corso',	70,	175,	11,	'F',	57950	);
insert into player values (	140701,	'Matthew',	'O~Shaughnessy',	69,	160,	91,	'F',	57950	);
insert into player values (	141874,	'PJ',	'DiMartino',	68,	160,	6,	'F',	57950	);
insert into player values (	139717,	'Chris',	'Russolello',	68,	175,	55,	'F',	57950	);
insert into player values (	139760,	'Nick',	'Tarasco',	70,	165,	97,	'F',	57950	);
insert into player values (	139441,	'Josh',	'Weger',	72,	190,	98,	'F',	57950	);
insert into player values (	139576,	'Matthew',	'Cicchetti',	70,	170,	81,	'D',	57950	);
insert into player values (	139438,	'Matthew',	'Catania',	69,	150,	14,	'D',	57950	);
insert into player values (	139663,	'Jonathan',	'Krumholz',	65,	140,	8,	'D',	57950	);
insert into player values (	139573,	'Nicholas',	'Walker',	71,	195,	88,	'D',	57950	);
insert into player values (	139547,	'Timothy',	'Janke',	72,	160,	24,	'D',	57950	);
insert into player values (	139719,	'Michael',	'Gonzalez',	69,	175,	86,	'D',	57950	);
insert into player values (	139425,	'Bobby',	'Litras',	69,	155,	9,	'D',	57950	);
insert into player values (	139651,	'Dustin',	'Muccio-Schrimpe',	72,	180,	70,	'G',	57950	);
insert into player values (	140061,	'Daniel',	'Perepezko',	72,	130,	37,	'G',	57950	);
insert into player values (	139682,	'Tim',	'Bowen',	73,	190,	92,	'F',	57946	);
insert into player values (	139674,	'David',	'Delseni',	69,	195,	17,	'F',	57946	);
insert into player values (	139677,	'Steve',	'Brown',	66,	160,	12,	'F',	57946	);
insert into player values (	139683,	'Nicholas',	'Hirsh',	69,	175,	27,	'F',	57946	);
insert into player values (	139684,	'Nick',	'Foster',	71,	185,	97,	'F',	57946	);
insert into player values (	139687,	'Justin',	'Giannantonio',	69,	150,	29,	'F',	57946	);
insert into player values (	139676,	'Jason',	'Kichline',	67,	150,	23,	'D',	57946	);
insert into player values (	139675,	'Lucas',	'Denczi',	70,	195,	20,	'D',	57946	);
insert into player values (	139681,	'Kyle',	'Green',	81,	190,	69,	'D',	57946	);
insert into player values (	139698,	'Derek',	'Hoffman',	67,	135,	8,	'D',	57946	);
insert into player values (	139686,	'Mike',	'Sabol',	73,	180,	21,	'D',	57946	);
insert into player values (	141205,	'Ryan',	'Hollingshead',	69,	169,	7,	'D',	57946	);
insert into player values (	139678,	'John',	'Whitman',	75,	225,	30,	'G',	57946	);
insert into player values (	139707,	'Brandon',	'McComsey',	72,	200,	35,	'G',	57946	);
insert into player values (	141555,	'Aaron',	'Marcel',	72,	195,	22,	'F',	57966	);
insert into player values (	139284,	'Joseph',	'Petruzziello',	68,	165,	13,	'F',	57966	);
insert into player values (	140014,	'Ryan',	'Dougherty',	74,	205,	97,	'F',	57966	);
insert into player values (	139797,	'Ronan',	'Carrier',	68,	160,	15,	'F',	57966	);
insert into player values (	139458,	'Rhys',	'Marcel',	71,	180,	2,	'F',	57966	);
insert into player values (	139635,	'Kurt',	'Leavitt',	73,	180,	77,	'F',	57966	);
insert into player values (	139742,	'Nicholas',	'Boccelli',	71,	160,	19,	'F',	57966	);
insert into player values (	139743,	'John',	'Carroll',	70,	175,	14,	'F',	57966	);
insert into player values (	139540,	'Nickolas',	'Chappell',	70,	170,	6,	'D',	57966	);
insert into player values (	138987,	'Ryan',	'Wolsiefer',	70,	165,	5,	'D',	57966	);
insert into player values (	139321,	'Shawn',	'Lapp',	69,	160,	3,	'D',	57966	);
insert into player values (	139537,	'Donald',	'Brodd',	69,	165,	21,	'D',	57966	);
insert into player values (	139315,	'Justin',	'O~Connell',	74,	185,	12,	'D',	57966	);
insert into player values (	139641,	'Christopher',	'Duffy',	67,	150,	10,	'D',	57966	);
insert into player values (	139314,	'Jordan',	'Davis',	67,	150,	91,	'G',	57966	);
insert into player values (	139633,	'Will',	'Lalor',	70,	175,	47,	'F',	57958	);
insert into player values (	139756,	'DJ',	'Davis',	72,	190,	91,	'F',	57958	);
insert into player values (	139602,	'Ryan',	'O~Regan',	69,	150,	5,	'F',	57958	);
insert into player values (	139653,	'Robert',	'Pratt',	72,	155,	8,	'F',	57958	);
insert into player values (	139434,	'Daniel',	'Harrison',	73,	180,	4,	'F',	57958	);
insert into player values (	139630,	'Brendan',	'Winne',	66,	150,	26,	'F',	57958	);
insert into player values (	139739,	'Dylan',	'Narodowy',	71,	175,	15,	'F',	57958	);
insert into player values (	139740,	'Ben',	'Pawlak',	66,	125,	16,	'F',	57958	);
insert into player values (	139757,	'Stephen',	'Falkowski',	72,	160,	97,	'D',	57958	);
insert into player values (	139758,	'Kyle',	'Alvanas',	69,	160,	6,	'D',	57958	);
insert into player values (	139657,	'Christopher',	'Malanga',	70,	230,	77,	'D',	57958	);
insert into player values (	140053,	'Matt',	'Cyrus',	73,	190,	22,	'D',	57958	);
insert into player values (	139613,	'Evan',	'Hosney',	70,	160,	1,	'G',	57958	);
insert into player values (	139925,	'Michael',	'Macchia',	71,	140,	31,	'G',	57958	);
--
-- Locations
insert into locations values('Robert Morris University', 'Moon, PA');
insert into locations values('Farmingdale State College', 'Farmingdale, NY');
insert into locations values('West Chester University of Pennsylvania', 'West Chester, PA');
insert into locations values('University of Massachusetts', 'Amherst, MA' );
insert into locations values('University of Massachusetts', 'Boston, MA' );
insert into locations values('University of Massachusetts', 'North Dartmouth, MA' );
insert into locations values('University of Massachusetts', 'Lowell, MA');
insert into locations values('University of Massachusetts', 'Worcester, MA' );
insert into locations values('University of Rhode Island', 'Kingston, RI' );
insert into locations values('University of Rhode Island', 'Providence, RI');
insert into locations values('University of Rhode Island', 'Narragansett, RI');
insert into locations values('University of Rhode Island', 'West Greenwich, RI');
insert into locations values('Rowan University', 'Glassboro, NJ');
insert into locations values('Rowan University', 'Camden, NJ' );
insert into locations values('Hofstra University', 'Hempstead, NY' );
insert into locations values('Temple University', 'Philadelphia, PA' );
insert into locations values('State University of New York at Cortland', 'Cortland' );
insert into locations values('Neumann University', 'Aston, PA' );
--
-- Team Stats
insert into team_stats values(2017, 57984, 16, 2, 32 );
insert into team_stats values(2017, 57950, 15, 3, 30 );
insert into team_stats values(2017, 57946, 14, 3, 29 );
insert into team_stats values(2017, 57966, 13, 5, 26 );
insert into team_stats values(2017, 57958, 11, 6, 23 );
insert into team_stats values(2017, 57937, 9, 8, 19 );
insert into team_stats values(2017, 57959, 4, 13, 9 );
insert into team_stats values(2017, 57953, 4, 14, 8 );
insert into team_stats values(2017, 57964, 3, 14, 7 );
insert into team_stats values(2017, 57941, 1, 16, 3);
--
-- Games
insert into game values(511, '22-Nov-2016', 3, 0, 57984, 57966);
insert into game values(512, '28-Nov-2016', 2, 3, 57958, 57984);
insert into game values(513, '30-Nov-2016', 5, 1, 57984, 57946);
--
-- Games Played
insert into games_played values(138969, 511, 3);
insert into games_played values(138966, 511, 0);
insert into games_played values(138970, 511, 0);
insert into games_played values(138942, 511, 0);
insert into games_played values(138962, 511, 0);
  -- Skipping Ryan
insert into games_played values(138969, 512, 1);
insert into games_played values(138970, 512, 0);
insert into games_played values(138942, 512, 0);
insert into games_played values(138962, 512, 2);
insert into games_played values(139026, 512, 0);
  -- Skipping Sean
insert into games_played values(138969, 513, 2);
insert into games_played values(138966, 513, 0);
insert into games_played values(139009, 513, 0);
insert into games_played values(138965, 513, 3);
insert into games_played values(139026, 513, 0);
--
--
insert into player values (	123456,	'Gloire',	'Rubambiza',	71,	140,	100,	'G',	57958	);
COMMIT;
