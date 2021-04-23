from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from os import getenv

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = str(getenv('DATABASE_URI'))
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False   
#app.config['TEST_DATABASE_URI'] = 'mysql+pymysql://admin:R00tP4ssw0rd!@testdb.cyfbo9c0392o.eu-west-2.rds.amazonaws.com:3306/testdb'
app.config['SECRET_KEY'] = str(getenv('SECRET_KEY'))
db = SQLAlchemy(app)

from application import routes
