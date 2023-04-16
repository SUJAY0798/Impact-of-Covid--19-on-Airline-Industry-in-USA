#create database AITFinalProject;
#use AITFinalProject;

create table air_passengers(ID int,
							Sum_PASSENGERS int,
							Airline_ID varchar(20),
							Carrier_NAME varchar(100),
                            Origin varchar(20),
                            Origin_City_NAME varchar(50),
                            Origin_State_ABR varchar(20),
                            Origin_State_NM varchar(50),
                            Origin_COUNTRY varchar(10),
                            Origin_COUNTRY_NAME varchar(50),
                            Dest varchar(50),
                            Dest_City_NAME varchar(50),
                            Dest_State_ABR varchar(50),
                            Dest_State_NM varchar(50),
                            Dest_Country varchar(50),
                            Dest_Country_NAME varchar(50),
                            TYear int,
                            TMonth int);
LOAD DATA INFILE 'E:/George Mason/AIT580/Project4Final/USMAP2014.csv'
 INTO TABLE air_passengers
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
LINES TERMINATED BY '\n'
 IGNORE 1 ROWS;
 
select * from air_passengers;

select TYear,sum(Sum_PASSENGERS) from air_passengers group by TYear;

select TYear,count(*) from air_passengers where Origin_COUNTRY != Dest_Country and Origin_COUNTRY = 'US' group by Tyear;

select TYear,count(*) from air_passengers where Origin_COUNTRY != Dest_Country group by Tyear;