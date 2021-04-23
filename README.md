# QAC SFIA2 Project - Cara Prestwich and Emily Nixon

This application is a simple [Flask application](https://flask.palletsprojects.com/en/1.1.x/quickstart/#a-minimal-application), that we had to deploy as our SFIA2 project. 

The brief for the project can be found at the end of this README. 

The following information covers everything you need to start it up.

## Prerequisites

- Terraform must be installed on your local machine

## Terraform Environment Variables

Before you start using Terraform, there are a few variables that need to be set. These have been set locally in SystemPropertiesAdvanced. 

To set the variables, use Windows Key + R, to bring up Run, and type in "SystemPropertiesAdvanced". From here, you want to click "Environment Variables" at the bottom of the
pop-up. Next, in the box at the bottom, System Variables, you want to click New, and then enter "TF_VAR_access_key" into the "Variable Name" box, and then enter your AWS Access
Key into the "Variable Value" box. You will need to do the same with "TF_VAR_secret_key" and "TF_VAR_db_password". The DB password is what will be set at the Database Password
when you run Terraform apply, so you can set this to be whatever you want it to be. 

## Terraform 

Once you've cloned down the application, and set the environment variables, cd into the Terraform folder, and perform the following commands.

- Terraform init

This initialises Terraform

- Terraform plan

This prints out all the changes that will be made if you run terraform apply

- Terraform Apply

this applies those changes, and builds the Terraform infrastructure. 

When you're done with everything, you can perform "Terraform Destroy" to tear down all your Terraform infrastructure. 

## SSH-ing and Ansible. 







## Brief

The application must:

- Be deployed to a **Virtual Machine for testing**
- Be deployed in a **Docker Stack Using compose**
- Make use of a **managed Database solution**

## Application

The application is a Flask application running in **2 micro-services** (*frontend* and *backend*).  

The database directory is available should you: 
  - want to use a MySQL container for your database at any point, *or*
  - want to make use of the `Create.sql` file to **set up and pre-populate your database**.

The application works by:
1. The frontend service making a GET request to the backend service. 
2. The backend service using a database connection to query the database and return a result.
3. The frontend service serving up a simple HTML (`index.html`) to display the result.

### Database Connection

The database connection is handled in the `./backend/application/__init__.py` file.

A typical Database URI follows the form:

```
mysql+pymysql://[db-user]:[db-password]@[db-host]/[db-name]
```

An example of this would be:

```
mysql+pymysql://root:password@mysql:3306/orders
```

### Environment Variables

The application makes use of **2 environment variables**:

- `DATABASE_URI`: as described above
- `SECRET_KEY`: any *random string* will work here

### Running a Flask Application

Typically, to run a Flask application, you would:

1. Install the pip dependencies:

```
pip install -r requirements.txt
```

2. Run the application:

```
python3 app.py
```

![app-diagram](https://i.imgur.com/wnbDazy.png)

## Testing

Unit Tests have been included for both the frontend and backend services.

To test the backend service, you will need two things:

1. A database called `testdb`
2. A `TEST_DATABASE_URI` environment variable, which contains the database connection for the `testdb` database.

You can run the tests using the command:

```
pytest
```

To generate a coverage report, you will need to run:

```
pytest --cov application
```

## Infrastructure

The **Minimum Viable Product** for this project should at least demonstrate the following infrastructure diagram:

![mvp-diagram](https://i.imgur.com/i5qfOas.png)

**Stretch goals** for this project include:

- Using **Terraform to configure the Production VM**
- Using **Terraform and Ansible to configure the Test VM**

Completing the stretch goals should yield an infrastructure diagram similar to the following:

![stretch-digram](https://i.imgur.com/Q5zljVl.png)

**Good luck!**
