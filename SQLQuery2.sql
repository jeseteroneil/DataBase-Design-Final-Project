/*
Final Project
Jeseter O'Neil 
Comp 440
I.S.D 5/6/20
*/


DROP TABLE IF EXISTS dbo.employee;
DROP TABLE IF EXISTS dbo.bug;
DROP TABLE IF EXISTS dbo.employeeTask;
DROP TABLE IF EXISTS dbo.task;
DROP TABLE IF EXISTS dbo.role;
DROP TABLE IF EXISTS dbo.employee;
DROP TABLE IF EXISTS dbo.compatibility;
DROP TABLE IF EXISTS dbo.feature
DROP TABLE IF EXISTS dbo.version;
DROP TABLE IF EXISTS dbo.product



DECLARE @SQL VARCHAR(MAX)=''
SELECT @SQL = @SQL + 'ALTER TABLE ' + QUOTENAME(FK.TABLE_SCHEMA) + '.' + QUOTENAME(FK.TABLE_NAME) + ' DROP CONSTRAINT [' + RTRIM(C.CONSTRAINT_NAME) +'];' + CHAR(13)
--SELECT K_Table = FK.TABLE_NAME, FK_Column = CU.COLUMN_NAME, PK_Table = PK.TABLE_NAME, PK_Column = PT.COLUMN_NAME, Constraint_Name = C.CONSTRAINT_NAME
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
 INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK
    ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
 INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK
    ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
 INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU
    ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
 INNER JOIN (
            SELECT i1.TABLE_NAME, i2.COLUMN_NAME
              FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1
             INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2
                ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME
            WHERE i1.CONSTRAINT_TYPE = 'PRIMARY KEY'
           ) PT
    ON PT.TABLE_NAME = PK.TABLE_NAME

EXEC (@SQL)

PRINT @SQL

------------Product Table


CREATE TABLE dbo.product
(productID int NOT NULL identity PRIMARY KEY, productName nvarchar(100) NOT NULL,
productDescription nvarchar(1000));


--------------


--------Version Table


CREATE TABLE dbo.version 
(versionID int NOT NULL PRIMARY KEY Identity, versionNumber varchar(15) NOT NULL,
productID int NOT NULL CONSTRAINT FK_productID FOREIGN KEY REFERENCES dbo.product(productID), 
dateStart DATE NOT NULL, dateEnd DATE, releaseDate DATE NOT NULL);

-----------------


-------Feature table

CREATE TABLE dbo.feature
(featureID int NOT NULL PRIMARY KEY IDENTITY, featureNumber varchar(15) NOT NULL, featureDescription varchar(MAX),
versionID int NOT NULL CONSTRAINT FK_version FOREIGN KEY REFERENCES	dbo.version(versionID));

---------------------


-----------Compatibilty Table
 
CREATE TABLE dbo.compatibility
(versionID int NOT NULL CONSTRAINT FK_versionID FOREIGN KEY REFERENCES dbo.version(versionID),
compatibileVersionID int NOT NULL CONSTRAINT FK_compatibieVersionID FOREIGN KEY REFERENCES dbo.version(versionID),
PRIMARY KEY (versionID,compatibileVersionID));
------------


----------Role Table
CREATE TABLE dbo.role
(roleID INT NOT NULL IDENTITY PRIMARY KEY, roleName varchar(25));
--------------------

---------Employee Table
CREATE TABLE dbo.employee
(employeeID int NOT NULL IDENTITY PRIMARY KEY, firstName varchar(35) NOT NULL, lastName varchar(35), 
companyEmail varchar(100) UNIQUE , preferedEmail varchar(200) NOT NULL UNIQUE ,CONTACT varchar(15),
companyRole INT CONSTRAINT FK_employeeRole REFERENCES dbo.role(roleID));
----------------------





---------Task Table

CREATE TABLE dbo.task
(taskID int NOT NULL IDENTITY PRIMARY KEY, workItemType varchar(200), taskTitle varchar(200),
 taskState varchar(10), taskDescription varchar(MAX), taskPriority int, taskActivity varchar(15), 
taskCreateDate DATE NOT NULL, createdBy varchar(20), recordedDate DATE, releaseNumber varchar(10),
releaseDate DATE, notificationDate DATE) 

SET IDENTITY_INSERT dbo.task ON
INSERT INTO	dbo.task (taskID, workItemType, taskTitle ,taskState , taskDescription , taskPriority,
taskActivity ,taskCreateDate,createdBy , recordedDate,releaseNumber , releaseDate,
notificationDate) VALUES
(4, 'user story','Current layout needs change to the new look', 'Closed',
'orem ipsum dolor sit amet, consectetur adipiscing elit. Etiam condimentum odio sed mi vehicula consequat. Nulla condimentum neque id convallis bibendum. Aliquam porttitor efficitur tristique. Donec fringilla vehicula auctor. Morbi mattis, tortor in rutrum faucibus, felis quam interdum ipsum, eu molestie ante dolor et leo. Nullam fringilla vel nisi non tincidunt. Praesent commodo, nunc ac venenatis consectetur, nunc massa tristique risus, ut ultrices tellus nunc at augue. Suspendisse potenti. Suspendisse potenti. Quisque ac nisi finibus, volutpat lacus eget, faucibus nisl. Quisque sed nunc risus. Etiam ultrices varius interdum.

Mauris sed commodo orci. Nunc nulla turpis, lobortis sed tortor vitae, mollis fermentum eros. Ut laoreet facilisis purus non commodo. Vivamus mattis eros sodales rhoncus scelerisque. Fusce laoreet sapien sed nibh ornare blandit. Aliquam vulputate vulputate mauris id molestie. Pellentesque eget risus pulvinar, iaculis nisl aliquet, ornare nisi. Mauris porttitor ipsum a turpis fringilla, sit amet interdum nisl gravida. Nam cursus elementum tellus, nec rutrum dui malesuada id. Vestibulum interdum gravida eros, sed vestibulum diam convallis accumsan. Nullam porttitor nibh id est congue, sit amet mattis ex porta.',
1, 'development', '1/1/2018', 'HH','1/1/2018', '1.1.18', '2/2/2018', '2/2/2018')


---------------

-------------EmployeeTask Table 
Create table dbo.employeeTask
(assignedTo int NOT NULL CONSTRAINT FK_assignedTo FOREIGN KEY REFERENCES dbo.employee(employeeID), 
taskID int NOT NULL CONSTRAINT FK_employeeTask FOREIGN KEY REFERENCES dbo.task(taskID), PRIMARY KEY (assignedTo, taskID));
---------------------

-------------Bug Table 
Create table dbo.bug (bugID int NOT NULL PRIMARY KEY, bugDescription varchar(MAX),
bugPriority int, dateFound DATE NOT NULL, bugState varchar(10));

---------------






















