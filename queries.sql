Select * from animals where name like '%mon';
Select name from animals where date_of_birth BETWEEN '2016-1-1' and '2019-1-1';
Select name from animals where neutered = true And escape_attempts < 3;
Select date_of_birth from animals where name in ('Agumon', 'Pikachu');
Select name, escape_attempts from animals where weight_kg > 10.5;
Select * from animals where neutered = true;
Select * from animals where name != 'Gabumon';
select * from animals where weight_kg <= 17.3 and weight_kg >=10.4;
