Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
values (1, 'Agumon', '2020-2-3', 0, true, 10.23);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
values (2, 'Gabumon', '2018-11-15', 2, true, 8);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
values (3, 'Pikachu', '2021-1-7', 1, false, 15.04);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
values (4, 'Devimon', '2017-5-12', 5, true, 11);

Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (5, 'Charmander', '2020-2-8', 0, false, -11, null);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (6, 'Plantmon', '2021-11-15', 2, true, -5.7, null);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (7, 'Squirtle', '1993-4-2', 3, false, -12.13, null);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (8, 'Angemon', '2005-1-12', 1, true, -45, null);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (9, 'Boarmon', '2005-1-7', 7, true, 20.4, null);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (10, 'Blossom', '1998-10-13', 3, true, 17, null);
Insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
values (11, 'Ditto', '2022-10-13', 4, true, 22, null);


-- Owners Data
Begin;
	Insert into owners(full_name, age)
		Values ('Sam Smith', 34),
		('Jennifer', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38);
	Select * from owners;
	Update owners
	Set full_name = 'Jennifer Orwell'
	Where id = 2;
Commit;


-- Species Data
Begin;
	Insert into species(name) Values ('Pokemon');
	Insert into species(name) Values ('Digimon');
	Select * from species;
	Select * from animals;
Commit;


-- Include species_id
Begin;
	Select * from species;
	Update animals
	Set species_id = 2
	Where name like '%mon';
	Select * from animals;
	
	Update animals
	Set species_id = 1
	Where name not like '%mon';
	Select * from animals;
Commit;


-- Include owner_id

Begin;
	Delete from animals 
	Where owner_id In (1,2,3,4,5);
	Select * from animals;
Commit;

Begin;
	Select * from owners;
	Update animals
	Set owner_id = 1 Where name = 'Agumon';
	
	Update animals
	Set owner_id =2 Where name in ('Gabumon', 'Pikachu');
	
	Update animals
	Set owner_id = 3 Where name in ('Devimon', 'Plantmon');
	
	Update animals
	Set owner_id = 4 Where name in ('Charmander', 'Squirtle', 'Blossom');
	
	Update animals
	Set owner_id = 5 Where name in ('Angemon', 'Boarmon');
	Select * from animals;
Commit;

Insert Into vets (name, age, date_of_graduation)
Values
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');
Select * from vets;

INSERT INTO specializations (vet_id, species_id)
VALUES
    ((Select id From vets Where name = 'William Tatcher'), (Select id From species Where name = 'Pokemon')),
    ((Select id From vets Where name = 'Stephanie Mendez'), (Select id From species Where name = 'Digimon')),
    ((Select id From vets Where name = 'Stephanie Mendez'), (Select id From species Where name = 'Pokemon')),
    ((Select id From vets Where name = 'Jack Harkness'), (Select id From species Where name = 'Digimon'));
Select * from specializations;

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
    ((SELECT id FROM animals WHERE name = 'Agumon'), 
	 (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Agumon'), 
	 (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'), 
	 (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
    ((SELECT id FROM animals WHERE name = 'Devimon'), 
	 (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
    ((SELECT id FROM animals WHERE name = 'Charmander'), 
	 (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), 
	 (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'), 
	 (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), 
	 (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), 
	 (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), 
	 (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), 
	 (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), 
	 (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');
Select * from visits;
