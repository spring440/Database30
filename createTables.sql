create table People
(
	person_id int identity
		primary key,
	firstname varchar(100) not null,
	lastname varchar(100) not null
)
go

create table Address
(
	addr_id int identity
		primary key,
	street varchar(200) not null,
	city varchar(200) not null,
	state varchar(200) not null,
	zip varchar(100) not null
)
go

create table Attendee
(
	attendee_id int identity
		primary key,
	people_id int
		references People,
	email varchar(200) not null,
	addr_id int
		references Address
)
go

create table Presenter
(
	presenter_id int identity
		primary key,
	person_id int not null
		references People
)
go

create table Event_Location
(
	event_loc_id int identity
		primary key,
	city varchar(100) not null,
	region varchar(100) not null
)
go

create table Events
(
	event_id int not null
		primary key,
	event_name varchar(100) not null,
	event_date date not null,
	event_loc_id int not null
		references Event_Location
)
go

create table Presentation
(
	presentation_id int identity
		primary key,
	title varchar(400) not null,
	person_id int not null
		references People,
	level varchar(100) not null,
	event_loc_id int
		references Event_Location
)
go

create table Organizer
(
	organizer_id int identity
		primary key,
	people_id int not null
		references People,
	event_id int not null
)
go

create table Classroom
(
	class_id int identity
		primary key,
	event_id int not null,
	room_number int not null,
	capacity int not null
)
go

create table Volunteer
(
	volunteer_id int identity
		primary key,
	people_id int not null
		references People,
	event_id int not null
)
go

create table Schedule
(
	schedule_id int identity
		primary key,
	presentation_id int not null
		references Presentation,
	class_id int not null
		references Classroom,
	start_time varchar(100) not null,
	end_time varchar(100) not null,
	track_id int not null
)
go

create table Track
(
	track_id int identity
		primary key,
	topic varchar(200) not null
)
go

create table Sponsor
(
	sponsor_id int identity
		primary key,
	name varchar(200) not null,
	sponsor_grade varchar(200) not null
)
go

create table Tables
(
	table_num int identity
		primary key,
	table_number int not null,
	event_id int not null
		references Events,
	sponsor_id int not null
		references Sponsor
)
go

