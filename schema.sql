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

-- ------------------- Multiple Tables --------------------------

Create Table owners(
	id Serial Primary Key,
	full_name Varchar(100),
	age Int
);

Create Table species(
	id Serial Primary Key,
	name Varchar(100)
);


-- Modify Animal Table

Select * from animals;

Begin;
	Create Sequence animals_id_seq;
	Savepoint sp1_seq;
	
	Create Table new_animals (
    id Serial Primary Key,
    name varchar(100),
	date_of_birth date,
	escape_attempts int,
	neutered boolean,
	weight_kg real,
    species_id Int,
		Constraint fk_species
			Foreign Key (species_id)
				References species(id),
    owner_id Int,
		Constraint fk_owner
			Foreign Key (owner_id)
				References owners(id)
		
	);
	Savepoint sp2_newAnimal;
	
	Select * from new_animals;
	
	Insert into new_animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
	Select name, date_of_birth, escape_attempts, neutered, weight_kg
	From animals;
	Savepoint sp3_newAnimalData;
	
	Drop Table animals;
	Savepoint sp4_deleteOldAnimal;
	
	Alter Table new_animals Rename To animals;
	Savepoint sp4_nameChange;
	
	Select * from animals;
Commit;
