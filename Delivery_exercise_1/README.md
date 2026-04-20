# DevOps Excercise: Docker & Ansible

## What's inside

A simple php script (html/index.php) in order to:

- connect to a MySQL DB using environment variables:

  - MYSQL_HOST: hostname of database server
  - MYSQL_DATABASE: database name
  - MYSQL_USER: user that can connect to db
  - MYSQL_PASSWORD: password for MYSQL_USER

- creates a table named "hits"
- insert current client ip with timestamp inside this table
- show last 2 record in hits table

## Exercise

Please complete the following steps:

1. create a docker compose with two services:
    - db: mysql/mariadb
    - web: webserver of your choice to serve the php script

2. create a jenkins pipeline that achieve the following tasks:
    - build docker image that contains the web application
    - push the image to a container registry

3. create an ansible playbook that runs following tasks:
    - ensure target machine has prerequisites
    - pull compose from git repository on target
    - run services on target machine

4. create public git repository to push your work
