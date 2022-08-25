# Bytes of China project

PostgreSQL and Postbird back-end project to get familiar with SQL server and SQL client.

## Table of Contents 
* [Introduction](#introduction)
* [Technologies](#technologies)
* [Set Up](#set-up)
* [Sources](#sources)

## Intruduction 

This back-end project was created with the intention to learn how to Create Database, Table, manipulate, read and extract data,
and establish relationship between tables.

It provides the reader with some information about the command used, data added, data extracted and relationships between tables.

## Technologies 

* `SQL` 
* `PostgreSQL` 
* `Postbird` 

## Set Up

1. Create a database inside the _psql_ prompt
```console
postgres=# CREATE DATABASE database_name
```
2.  Switch to the new database
```console
postgres=# \c database_name
```
3. Import the script.sql file
```console
database_name=#\i <path_to_script.sql>


## Sources

This PostgreSQL relational database was designed as part of [Codecademy's Fullstack Engineer](https://www.codecademy.com/learn) curriculum. 