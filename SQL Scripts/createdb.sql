-- Database: Gym Management

-- Drop DATABASE "Gym Management";

-- Todo: Triggers for checking, types(enum), change serial to integer for foreign key(https://stackoverflow.com/questions/28558920/postgresql-foreign-key-syntax)
CREATE DATABASE "Gym Management"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE "Gym Management"
    IS 'Dev Database';

DROP IF EXISTS TABLE public.Access_Level;
DROP IF EXISTS TABLE public.Gym;
DROP IF EXISTS TABLE public.Staff_Type;
DROP IF EXISTS TABLE public.Staff_Contact;
DROP IF EXISTS TABLE public."Login";
DROP IF EXISTS TABLE public.Fob;
DROP IF EXISTS TABLE public.Member;
DROP IF EXISTS TABLE public.MemberFob;
DROP IF EXISTS TABLE public.Agreements;
DROP IF EXISTS TABLE public.AgreementType;
DROP IF EXISTS TABLE public.Contact_Info;
DROP IF EXISTS TABLE public.Payment_Options;
DROP IF EXISTS TABLE public.Credit_Card;
DROP IF EXISTS TABLE public.Bank_Account;


CREATE Table public.Access_Level(
	id serial not primary key,
	level serial not null check(level >=1 and level <=3)
	);

Create Table public.Gym(
	id serial primary key,
	apt# smallint,
	street varchar(50),
	city varchar(50),
	province varchar(50),
	postalCode varchar(50),
	phone varchar(20),
	Email varchar(50),
	club# char(4),
	);

Create Table public.Staff_Type(
	id serial primary key,
	description varchar(50),
	AccessLevel serial references Access_Level (level),
	GymID serial references Gym (id)
	);

Create Table public.Staff_Contact(
	id serial primary key,
	FName varchar(50),
	LName varchar(50),
	StaffType serial references Staff_Type(id),
	);

Create Table public."Login"(
	id serial references Staff_Contact(id),
	loginid varchar(50),
	pass varchar(50),
	Active bool,
	created date,
	);

Create table public.Fob(
	id serial primary key,
	number integer(10),
	GymID serial references Gym (id),
	);

Create table public.Member(
	id serial primary key,
	FName varchar(50),
	LName varchar(50),
	MemberID varchar(50)
	GymID serial references Gym (id));

Create Table public.MemberFob(
	MemberID serial references Member(id),
	FobID serial references Fob (id),
	Active boolean,
	AgreementID serial references Agreements (id));

Create Table public.Contact_Info(
	MemberID serial references Member(id),
	Apt varchar(10),
	StreetAddress varchar(50),
	Province varchar(50),
	PostalCode varchar(50),
	Cell varchar(50),
	Email varchar(50),
	Gender varchar(50),
	DOB datee,
	EmergencyContact varchar(50),
	Relationship varchar(50),
	EConPhone varchar(50),
	);

Create Table public.AgreementType(
	id serial Primary Key,
	Type varchar(20));

Create Table public.Agreements(
	id serial Primary Key,
	MemberID serial references Member(id),
	"Path" varchar(50),
	AgreementType serial references AgreementType (id),
	);

Create Table public.Payment_Options(
	id serial Primary Key,
	Option varchar(50), # create type option
);

Create Table public.Credit_Card(
	id serial references Payment_Options (id),
 	CardNumber varchar(20),
 	Expiration varchar(4),
 	Name varchar(50),
);

Create Table public.Bank_Account(
	id serial references Payment_Options(id),
	TransitNumber varchar(5),
	BankNumber varchar(7),
	Name varchar(50),
	AccountType varchar(20), #create type account type
	);