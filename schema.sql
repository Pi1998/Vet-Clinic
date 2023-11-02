CREATE TABLE animals (
	id int,
    name varchar(100),
	date_of_birth date,
	escape_attempts int,
	neutered boolean,
	weight_kg real,
	PRIMARY KEY(id)
);

Alter Table animals 
Add species varchar(100);
