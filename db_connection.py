import psycopg2
import json

config_file = open('db_config.json', 'r')
config = json.load(config_file)

#####################################################
##  Database Connection
#####################################################
'''
Connect to the database using the connection string
'''
def openConnection():
    # connection parameters - ENTER YOUR LOGIN AND PASSWORD HERE
    database = config["database"]
    userid = config["userid"]
    passwd = config["passwd"]
    myHost = config["myHost"]


    # Create a connection to the database
    conn = None
    try:
        # Parses the config file and connects using the connect string
        conn = psycopg2.connect(database=database,
                                    user=userid,
                                    password=passwd,
                                    host=myHost)

    except psycopg2.Error as sqle:
        print("psycopg2.Error : " + sqle.pgerror)
    
    # return the connection to use
    return conn