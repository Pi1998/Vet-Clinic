Select * from animals where name like '%mon';
Select name from animals where date_of_birth BETWEEN '2016-1-1' and '2019-1-1';
Select name from animals where neutered = true And escape_attempts < 3;
Select date_of_birth from animals where name in ('Agumon', 'Pikachu');
Select name, escape_attempts from animals where weight_kg > 10.5;
Select * from animals where neutered = true;
Select * from animals where name != 'Gabumon';
select * from animals where weight_kg <= 17.3 and weight_kg >=10.4;

-- Unspecified species
Begin
	Update animals 
	Set species = 'unspecified';
	Select * from animals;
	Rollback;
	
Select * from animals;

-- Commit
Begin;
	Update animals
	Set species = 'digimon'
	Where name like '%mon';

	Update animals
	Set species = 'pokemon'
	Where name not like '%mon';

	Select * from animals;
	Commit;
	
Select * from animals;

-- Rollback
Begin;
	Delete from animals;
	Select * from animals;
	Rollback;
	
Select * from animals;

-- Savepoint
Begin;
	Delete from animals
	Where date_of_birth > '2022-1-1';
	Select * from animals;
	Savepoint sp1;
	
	Update animals
	Set weight_kg = weight_kg * -1;
	Select * from animals;
	Rollback to sp1;
	
	Select * from animals;
	
	Update animals
	Set weight_kg = weight_kg * -1
	Where weight_kg < 0;
	
	Select * from animals;
Commit;

Select * from animals;

-- Aggregate, Group By
Select count(id) from animals;
Select count(*) as Home_owner from animals
Where escape_attempts = 0;

Select Avg(weight_kg) from animals;

Select neutered, 
	Max(escape_attempts) 
From animals
Group By neutered;

Select species,
	Min(weight_kg) as minimal_weight, 
	Max(weight_kg) as maximal_weight
From animals
Group by species;

Select species, 
	Avg(escape_attempts) as avg_escape_attempts
From animals
Where date_of_birth Between '1990-1-1' and '2000-1-1'
Group by species;

Select * from animals;


---------------------------Join------------------------------

Select * from animals;
Select * from owners;
Select * from species;


Select o.full_name as owner, a.name as animal_name
From owners o
Join animals a On o.id = a.owner_id
Where o.full_name = 'Melody Pond';

Select a.name, s.name
From species s
Join animals a On s.id = a.species_id
Where s.name = 'Pokemon';

Select o.full_name as owner, a.name as their_pet
From owners o
Left Join animals a On o.id = a.owner_id;

Select s.name as species, Count(*) as animal_count
From species s
Left Join animals a On s.id = a.species_id
Group By s.name
Order By s.name;

Select o.full_name as owner, a.name as digimon_name
From owners o
Join animals a On o.id = a.owner_id
Join species s On a.species_id = s.id
Where o.full_name = 'Jennifer Orwell' And s.name = 'Digimon';

SELECT o.full_name As owner, 
       COALESCE(a.name, '0') As pet_who_loves_home
From owners o
Left Join animals a On o.id = a.owner_id And a.escape_attempts = 0
Where o.full_name = 'Dean Winchester';

SELECT o.full_name AS owner_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(a.id) DESC
LIMIT 1;

---------------------------------------------------

Select a.name As last_animal_seen
From vets v
Join visits vt On v.id = vt.vet_id
Join animals a On vt.animal_id = a.id
Where v.name = 'William Tatcher'
Order By vt.visit_date DESC
Limit 1;

Select Count(Distinct vt.animal_id) As animals_seen
From vets v
Join visits vt On v.id = vt.vet_id
Where v.name = 'Stephanie Mendez';

Select v.name As vet_name, s.name As specialty
From vets v
Left Join specializations sp On v.id = sp.vet_id
Left Join species s On sp.species_id = s.id;

Select a.name As animal_name
From vets v
Join visits vt On v.id = vt.vet_id
Join animals a On vt.animal_id = a.id
Where v.name = 'Stephanie Mendez'
And vt.visit_date Between '2020-04-01' And '2020-08-30';

Select a.name As animal_name, Count(vt.vet_id) As visit_count
From visits vt
Join animals a On vt.animal_id = a.id
Group By a.name
Order By visit_count DESC
Limit 1;

Select a.name As first_visit_animal
From vets v
Join visits vt On v.id = vt.vet_id
Join animals a On vt.animal_id = a.id
Where v.name = 'Maisy Smith'
Order By vt.visit_date
Limit 1;

Select a.name As animal_name, v.name As vet_name, vt.visit_date As last_visit_date
From visits vt
Join animals a On vt.animal_id = a.id
Join vets v On vt.vet_id = v.id
Order By vt.visit_date DESC
Limit 1;

Select Count(*) As mismatched_specialties
From visits vt
Join animals a On vt.animal_id = a.id
Join vets v On vt.vet_id = v.id
Left Join specializations sp On v.id = sp.vet_id And a.species_id = sp.species_id
Where sp.vet_id Is Null;

Select a.species_id As suggested_specialty_id, s.name As suggested_specialty, Count(*) As suggested_specialty_count
From visits v
Join vets m On v.vet_id = m.id
Join animals a On v.animal_id = a.id
Join species s On a.species_id = s.id
Where m.name = 'Maisy Smith'
Group By a.species_id, s.name
Order By suggested_specialty_count Desc
Limit 1;
