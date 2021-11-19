Welcome to NuoDB 4.2.1.vee "SQL Quickstart"

INTRODUCTION

The SQL QuickStart lets you quickly load and explore a sample database. The
database contains all kinds of hockey-related data (paying homage to Boston's 
beloved Bruins). 

After the QuickStart database is created, you'll be able to access the data in
the database in a number of different ways.

There are three  ways to run the demo: 
- SHELL SCRIPT: Run a shell script that creates the database for you, OR
- INTERACTIVE: Use the SQL QuickStart tool in NuoDB Home page to build
  the database, OR
- MANUAL: You can enter the commands yourself, following instructions below

Either way, you'll end up with a database containing sample data that you can 
interactively query and explore.

DETAILED INSTRUCTIONS

SHELL SCRIPT: 
Enter the following in a shell in the NuoDB installation directory:

  ./samples/quickstart/sql/run-qs <database name> <domain user> <domain password> 

Specify any database name.

The domain user and domain password settings determine how the SQL QuickStart 
connects to the NuoDB domain. If you specified a password during installation 
then enter "domain" for domain user and for domain password enter the password 
you entered during installation. If you have forgotten this password then you 
can obtain it from the NUODB_HOME/etc/default.properties file. In that file, 
the setting of the domainPassword property is the password you need to enter for 
domain password.  If you already created an administrative user account then you
can enter the username and password for that account. See 
http://doc.nuodb.com/Latest/Default.htm#About-Domain-Credentials.htm for information about 
creating a domain administrator account. 

The script will create the database, populate it with sample data, and
end at a nuosql command prompt, where you can enter SQL commands.

INTERACTIVE VIA SQL Quickstart:
Visit 

  http://doc.nuodb.com/Latest/Default.htm#Running-the-SQL-QuickStart.htm

and follow the instructions there.

MANUAL: 
Follow these directions in a shell in the NuoDB installation
directory:

1: Start NuoDB services

       OSX: 

          launchctl start com.nuodb.agent

       Windows:     

          net start "NuoDB Agent"

      Linux:

          sudo service nuoagent start

       (For details, see: http://doc.nuodb.com/Latest/Default.htm#Starting-and-Stopping-NuoDB-Services.htm.)

2: Start the sample database

    First, start the Storage Manager (SM).

    nuodbmgr --user "$DOMAIN_USER" --password "$DOMAIN_PWD" --broker localhost --command "start process sm host localhost database $DBNAME archive $ARCHIVE initialize true"`

    See notes above under SHELL SCRIPT, about what to use for DOMAIN_USER and DOMAIN_PWD.

    Replace $DBNAME with the database name and replace $ARCHIVE with a full path to where you want the archive to be created.
    If this is a brand new archive, use "initialize true", else use "initialize false".

    Second, start the Transaction Engine (TE)

    nuodbmgr --user "$DOMAIN_USER" --password "$DOMAIN_PWD" --broker localhost --command "start process te host localhost database $DBNAME options '--dba-user $DBA_USER --dba-password $DBA_PWD'"

    Again, replace $DOMAIN_PWD, $DBNAME with the appropriate values.

    Replace $DBA_USER and $DBA_PWD with the name and password of the initial DBA.  This is only required the very first
    time the TE is started.

    Third, verify the database is running.

    nuodbmgr --user "$DOMAIN_USER" --password "$DOMAIN_PWD" --broker localhost --command "show domain summary"

    Sample output:

    Database: test, (unmanaged), processes [1 TE, 1 SM], ACTIVE
    [SM] mynotebook/127.0.0.1:59731 (DEFAULT_REGION) [ pid = 43592 ] [ nodeId = 1 ] RUNNING
    [TE] mynotebook/127.0.0.1:59741 (DEFAULT_REGION) [ pid = 43609 ] [ nodeId = 2 ] RUNNING



3: Create the schema and some initial data:
   
    nuosql test --user dba --password goalie < ./samples/quickstart/sql/create-db.sql

4: Load the sample data. Note that these commands will emit a lot of output!

    nuosql test --user dba --password goalie < ./samples/quickstart/sql/Players.sql
    nuosql test --user dba --password goalie < ./samples/quickstart/sql/Scoring.sql
    nuosql test --user dba --password goalie < ./samples/quickstart/sql/Teams.sql

5: Explore your new database!

    nuosql test --user dba --password goalie 

FOR MORE INFORMATION

--- See the online documentation:

       http://doc.nuodb.com/Latest/Default.htm

--- Run the "NuoDB Tour". This 20-minute* tour runs in Docker containers on your
    Linux-based machine or on Amazon Web Services EC2. See:

       http://doc.nuodb.com/Latest/Default.htm#Quick-Tour-of-NuoDB.htm

--- Click the menu on the upper-right corner of Admin Home and select "Docs".

--- Type 'help' in "nuosql" for quick reference information.

Contact Customer Support: support@nuodb.com

Community Center: http://www.nuodb.com/community
      
Follow us on Twitter: @nuodb

----------------------------------------------
Copyright Notice

The information used herein was obtained free of charge from and is copyrighted
by the Hockey Databank project.  For more information about the Hockey Databank
project please visit:

https://groups.yahoo.com/neo/groups/hockey-databank/info
