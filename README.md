# database-design-birthing-center

This is a JDBC program that helps to manage the Midwifery services (in a simplified real-world context).

The project consists of three phases:

design a model;
create a schema and implement a database using DB2, insert/maintain/update data;
develop application programs and implement User Interface
In this repo, there are:
Proj_Intro.pdf: a detailed description / requirements of this project, including the techniques I used.

(Phase 1 - design)

ER_model.pdf: an Entity-Relationship Model, which is an pictorially description of the data, illustrating the relationship between different entities, including Key/Participation Constraints, ISA hierarchies, Weak Entities, ternary relationship etc.

Assum_Restr.pdf: several points of Assumptions and Restrictions that I made/found during the process, as well as a Relational Translation of the ER model.

(Phase 2 - create database & run sql queries)

createtbl.sql / loaddata.sql / droptbl.sql: sql codes of manipulating tables and inserting data in database.

createtbl.log / loaddata.log / droptbl.log: showing successful execution of corresponding .sql files.

sql_queries.pdf: a series of sql queries to retrieve various data.

(Phase 3 - build app)

GoBabbyApp.java: java code of this application

About
This is an individual project of COMP 421, McGill University, Winter 2022.
