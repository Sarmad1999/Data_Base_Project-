# Pandemic Management System

This project is a Database Management System designed to track and manage various aspects of a pandemic, including patient information, clinical trials, care centers, and more. The database schema is implemented using MySQL.

## Table of Contents

- [Installation](#installation)
- [Database Schema](#database-schema)
- [Tables and Their Purpose](#tables-and-their-purpose)
- [Indexes and Constraints](#indexes-and-constraints)
- [Contributing](#contributing)
- [License](#license)

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/pandemic-management-system.git
   cd pandemic-management-system



2. **Set Up the Database:**

Ensure you have MySQL installed on your system.

Create a new database.
```CREATE DATABASE pandemic_management;

Use the created database.
```USE pandemic_management;

Run the SQL script to create tables.
```SOURCE pandemic_management.sql;



**Database Schema**
The database schema consists of the following tables:

**Tables and Their Purpose**

- login_detail: Stores user login information including ID, password, and authorization level.
- access_detail: Logs access details such as user ID and access date/time.
- address: Stores address details including street, area, city, longitude, and latitude.
- care_center: Information about care centers including name, address, and capacity.
- vaccine_type: Details about different vaccine types including name, mechanism, and creator.
- clinical_trial: Information on clinical trials including type, number of participants, recoveries, and fatalities.
- family: Stores family information with family ID and number of members.
- person: Personal details of individuals including first name, last name, age, address, and family ID.
- infected: Details about infected individuals including symptoms, date of infection, and care center.
- close_contact: Records of individuals who were in close contact with infected persons.
- daily_stat: Daily statistics including new cases, recoveries, and deaths.
- dead: Information about deceased individuals including date of passing.
- department: Information about different departments.
- doctor: Details about doctors including shift, department, and care center.
- locked_down_area: Information about areas under lockdown including start and end dates, and threat level.
- recovered: Details about recovered individuals including date of recovery and risk of reinfection.
- storage_center: Information about storage centers including address and storage space.
- test_center: Details about test centers including address, capacity, and name.
- test: Records of tests conducted including date, result, person ID, and test center.
- vaccine: Information about vaccines including production and expiry dates, storage location, and type.
- vaccination_record: Records of vaccinations administered including vaccine ID, person ID, dosage number, and vaccination center.
- Indexes and Constraints
- Indexes and constraints have been applied to ensure data integrity and optimize query performance. Key constraints include foreign keys to maintain relationships between tables, and primary keys to ensure uniqueness.



**Contributing**
Contributions are welcome! Please fork the repository and create a pull request with your changes. Ensure your code follows the project's coding standards and includes appropriate tests.
