/*
Group B6
Team Leader: Yinan Guo
Team Member: Saurav Sawansukha, Jordan Auerbach, Haoyang Chen
*/

/*
This is a comprehensive file of our database.
Section 1 have the code we use to create the database
Section 2 are our buissness rules, views, etc. Seperated by Group members
Section 3 are conprehensive code we use to populate the database
*/

-----------------SECTION 1-------------------
CREATE DATABASE Proj_B6;

USE Proj_B6

CREATE TABLE SPECIALITY(
    SpecialityID Integer IDENTITY(1,1) NOT NULL,
    SpecialityName varchar(20) NOT NULL,
    SpecialityDescr varchar(300),
	CONSTRAINT SpecialPK PRIMARY KEY(SpecialityID) 
);
CREATE TABLE DOCTOR(
    DoctorID Integer IDENTITY(1,1) NOT NULL,
	SpecialityID Integer NOT NULL,
    DoctorFName varchar(50) NOT NULL,
    DoctorLName varchar(50) NOT NULL,
	DoctorNetID Integer NOT NULL,
	DOB Date NOT NULL,
	Rating INT NOt NULL,
	CONSTRAINT DoctorPK PRIMARY KEY(DoctorID),
	CONSTRAINT SpecialFK FOREIGN KEY(SpecialityID) REFERENCES SPECIALITY(SpecialityID)

);
CREATE TABLE PATIENT(
    PatientID Integer IDENTITY(1,1) NOT NULL,
    PatientFName varchar(50) NOT NULL,
    PatientLName varchar(50) NOT NULL,
	PatientNetID Integer NOT NULL,
	DOB Date NOT NULL,
	Address varchar(50) NOT NULL,
	pat_long numeric(9,6) NOT NULL,
	pat_lat numeric(9,6) NOT NULL,
	CONSTRAINT PatientPK PRIMARY KEY(PatientID),
);

CREATE TABLE DOCTOR_DIAGNOSIS(
    DoctorDiagnosisID Integer IDENTITY(1,1) NOT NULL,
    DoctorID Integer NOT NULL,
    PatientID Integer NOT NULL,
	DoctorDiagnosisDescr varchar(300) NOT NULL,
	DocDiagDate Date Not Null,
	CONSTRAINT DocDiagPK PRIMARY KEY(DoctorDiagnosisID),
	CONSTRAINT DoctorFK FOREIGN KEY(DoctorID) REFERENCES DOCTOR(DoctorID),
	CONSTRAINT PatientFK FOREIGN KEY(PatientID) REFERENCES PATIENT(PatientID)

);
CREATE TABLE SYMPTOM_TYPE(
    SymptomTypeID Integer IDENTITY(1,1) NOT NULL,
    SymptomTypeName varchar(20) NOT NULL,
    SymptomTypeDescr varchar(300),
	CONSTRAINT SymptomTypePK PRIMARY KEY(SymptomTypeID) 
);
CREATE TABLE SYMPTOM(
    SymptomID Integer IDENTITY(1,1) NOT NULL,
	SymptomTypeID Integer NOT NULL,
    SymptomName varchar(20) NOT NULL,
    SymptomDescr varchar(300),
	CONSTRAINT SymptomPK PRIMARY KEY(SymptomID),
	CONSTRAINT SymptomTypeFK FOREIGN KEY(SymptomTypeID) REFERENCES SYMPTOM_TYPE(SymptomTypeID)
);
CREATE TABLE DOCTOR_DIAGNOSIS_SYMPTOM(
    DDSID Integer IDENTITY(1,1) NOT NULL,
    DoctorDiagnosisID Integer NOT NULL,
    SymptomID Integer NOT NULL,
	CONSTRAINT DDSPK PRIMARY KEY(DDSID),
	CONSTRAINT DocDiagFK2 FOREIGN KEY(DoctorDiagnosisID) REFERENCES DOCTOR_DIAGNOSIS(DoctorDiagnosisID),
	CONSTRAINT SymptomFK FOREIGN KEY(SymptomID) REFERENCES SYMPTOM(SymptomID)
);
CREATE TABLE PRESCRIPTION(
    PrescriptionID Integer IDENTITY(1,1) NOT NULL,
	PrescriptionDate Date NOT NULL,
    PrescriptionDescr varchar(300),
    DoctorID Integer NOT NULL,
    PatientID Integer NOT NULL,
	Dosage varchar(300) NOT NULL,
	RefillNum Integer NOT NULL,
	CONSTRAINT PrescriptionPK PRIMARY KEY(PrescriptionID),
	CONSTRAINT DoctorFK2 FOREIGN KEY(DoctorID) REFERENCES DOCTOR(DoctorID),
	CONSTRAINT PatientFK2 FOREIGN KEY(PatientID) REFERENCES PATIENT(PatientID)
);
CREATE TABLE PATIENT_MEASURABLE(
    PatMeasID Integer IDENTITY(1,1) NOT NULL,
    PatientID Integer NOT NULL,
    MeasurableID Integer NOT NULL,
	MeasurableValue Numeric(7,2) NOT NULL,
	CONSTRAINT PatMeasPK PRIMARY KEY(PatMeasID),
	CONSTRAINT PatientFK3 FOREIGN KEY(PatientID) REFERENCES PATIENT(PatientID),
	CONSTRAINT MeasurableFK FOREIGN KEY(MeasurableID) REFERENCES MEASURABLE(MeasurableID)
	
);
CREATE TABLE MEASURABLE(
    MeasurableID Integer IDENTITY(1,1) NOT NULL,
	MeasurableName varchar(20) NOT Null,
	MeasurableDescr varchar(300),
	CONSTRAINT MeasurablePK PRIMARY KEY(MeasurableID) 
);


CREATE TABLE SEVERITY
(SeverityID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
SeverityName varchar(20) not null,
SeverityDescr varchar(300) not null);

CREATE TABLE SIDE_EFFECT
(SideEffectID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
SideEffectName varchar(20) not null,
SizeEffectDescr varchar(300) not null);

CREATE TABLE BRAND
(BrandID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
BrandName varchar(20) not null,
BrandDescr varchar(300) not null);

CREATE TABLE DRUG_TYPE
(DrugTypeID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
DrugTypeName varchar(40) not null,
DrugTypeDescr varchar(300) not null);

CREATE TABLE PHARMACY
(PharmacyID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
PharmacyName varchar(20) not null,
PharmacyDescr varchar(300) not null);

CREATE TABLE PHARM_LOCATION
(PharmLocID INTEGER IDENTITY (1, 1) primary key not null,
PharmacyID INT FOREIGN KEY REFERENCES PHARMACY (PharmacyID) not null,
PharmLocationDescr varchar(300) not null,
Address varchar(50) not null,
Longitude Numeric(9,6) not null,
Latitude Numeric(9,6) not null,
Review INT not null);

CREATE TABLE PAT_PHARM_LOC
(PPLID INTEGER IDENTITY (1, 1) primary key not null,
PharmLocID INT FOREIGN KEY REFERENCES PHARM_LOCATION (PharmLocID) not null,
PatientID INT FOREIGN KEY REFERENCES PATIENT (PatientID) not null);

CREATE TABLE PAT_PHARM_LOC
(PPLID INTEGER IDENTITY (1, 1) primary key not null,
PharmLocID INT FOREIGN KEY REFERENCES PHARM_LOCATION (PharmLocID) not null,
PatientID INT FOREIGN KEY REFERENCES PATIENT (PatientID) not null);

CREATE TABLE DRUG_SIDE_EFFECT
(DrugSideEffectID INTEGER IDENTITY (1, 1) primary key not null,
SeverityID INT FOREIGN KEY REFERENCES SEVERITY (SeverityID) not null,
DrugID INT FOREIGN KEY REFERENCES DRUG (DrugID) not null,
SideEffectID INT FOREIGN KEY REFERENCES SIDE_EFFECT (SideEffectID) not null);


CREATE TABLE DRUG
(DrugID INTEGER IDENTITY (1, 1) primary key not null,
DrugTypeID INT FOREIGN KEY REFERENCES DRUG_TYPE (DrugTypeID) not null,
BrandID INT FOREIGN KEY REFERENCES BRAND (BrandID) not null,
GenericName varchar (50) not null,
DrugDescr varchar (300) not null,
Strength varchar (10) not null);


CREATE TABLE PHARMACY_DRUG
(PharmacyDrugID INTEGER IDENTITY (1, 1) primary key not null,
PharmacyID INT FOREIGN KEY REFERENCES PHARMACY (PharmacyID) not null,
DrugID INT FOREIGN KEY REFERENCES DRUG (DrugID) not null,
PharmacyDrugName varchar (30) not null,
PharmacyDrugDescr varchar (300) not null,
Price Numeric(7,2) not null);


-----------------SECTION 2-------------------
/*
Yinan Guo
*/
--Stored Procedure 1. The code to insert a new prescription to an existing user
 
CREATE PROCEDURE rxToPatient
@PreDate date,
@PreDescr varchar(300),
@pUserNetID INT,
@DoctorNetID INT,
@Dosage varchar(300),
@Refill INT,
@DrugName varchar(50)
AS
DECLARE @PatientID INT = (Select PatientID FROM PATIENT where PatientNetID = @pUserNetID)
DECLARE @DoctorID INT = (Select DoctorID FROM DOCTOR where DoctorNetID = @DoctorNetID)
DECLARE @DrugID INT = (Select DrugID From DRUG Where GenericName = @DrugName)
Begin Transaction rtp1
INSERT INTO PRESCRIPTION (PrescriptionDate,PrescriptionDescr, patientID,DoctorID, DrugID,Dosage,RefillNum)
VALUES( @PreDate,@PreDescr,@PatientID,@DoctorID,@DrugID,@Dosage,@Refill)
Commit Transaction rtp1
GO

--EXEC rxToPatient @PreDate = '2019-11-12', @PreDescr = 'This is for Russell wart treatment' ,@pUserNetID = 6, @DoctorNetID = 13,@DrugName = 'Fluorouracil',@Dosage = 'Once perday',@Refill = 2
--GO

--Store Procedure 2. The code to create a new pharmacy with a new location 
CREATE PROCEDURE NewPharmLoc
@PName varchar(20),
@PDescr varchar(300),
@LDescr varchar(300),
@Address varchar(50),
@LongitudePharm numeric(9,6),
@LatitudePharm numeric(9,6),
@Review int
AS
DECLARE @PharmacyID INT 
Begin Transaction npl1
INSERT INTO PHARMACY(PharmacyName,PharmacyDescr)
VALUES(@PName,@PDescr)
Set @PharmacyID = SCOPE_IDENTITY()
insert into PHARM_LOCATION(PharmacyID,[Address], PharmLocationDescr,Longitude,Latitude,Review) 
Values(@PharmacyID,@Address,@LDescr,@LongitudePharm,@LatitudePharm,@Review)
Commit Transaction npl1
GO

/*
EXEC NewPharmLoc @PName = 'Handom Pharmacy', @PDescr = 'a Handom pharmacy in Seaaatle Area',
@Address = '3390 Terra Street, Seattle, WA 98109', @LDescr = 'a Handom pharmacie on terra street',
@LongitudePharm = -122.325066 ,@LatitudePharm = 47.545376, @Review = 8
GO
*/
--BuissnessRule1: No Doctor Under 18 are allowed
DROP FUNCTION FN_NoDoctorUnder18;  
select*from DOCTOR

Create function FN_NoDoctorUnder18()
RETURNS INT AS
BEGIN  
    DECLARE @Ret INT 
    SET @Ret = (
	SELECT count(d.DoctorID)   
    FROM Doctor as d   
    WHERE (SELECT DATEDIFF(year,d.DOB,GetDate())) < 18
	)
    RETURN @Ret 
END
GO

Alter table dbo.DOCTOR
ADD constraint NoUnder18Doc
Check(dbo.FN_NoDoctorUnder18() = 0)

--BuissnessRule2: No Patient birth after the SYSTEM DATE
Create function FN_NoPatientTooYoung()
RETURNS INT AS
BEGIN  
    DECLARE @Ret INT 
    SET @Ret = (
	SELECT count(p.PatientID)   
    FROM PATIENT as p 
    WHERE (SELECT DATEDIFF(year,p.DOB,GetDate())) < 0
	)
    RETURN @Ret 
END
GO
Alter table dbo.PATIENT
ADD constraint NoPatientNoBorn
Check(dbo.FN_NoPatientTooYoung() = 0)


--Computed column1: The amount of doctor for each specialty
CREATE FUNCTION FN_getNumDoc(@pk INT)
RETURNS INT
AS
Begin
Declare @ret Int
Set @ret= (Select count(*)
			from DOCTOR as d Join SPECIALITY as s on d.SpecialityID = s.SpecialityID
			Where s.SpecialityID = @pk)
Return @ret
END
Alter table SPECIALITY
Add TotNumDoc as  dbo.FN_getNumDoc(SpecialityID)
select * from SPECIALITY

--Computed column2: total amount of diagnose each Doctor see that is on the record

CREATE FUNCTION FN_getNumDiag(@pk INT)
RETURNS INT
AS
Begin
Declare @ret Int
Set @ret= (Select count(*)
			from DOCTOR as d Join DOCTOR_DIAGNOSIS as dd on d.DoctorID = dd.DoctorID
			Where d.DoctorID = @pk)
Return @ret
END
Alter table DOCTOR
Add totNumDocDiag as  dbo.FN_getNumDiag(DoctorID)

--View1: A view to find the Doctor Diagnosis that have more than two symptoms in each diagnose
--and are diagnosed by experienced doctors who are older than 30 years old£¬ and have prescriped at least 10 time
CREATE VIEW ExperiencedDoctorDiagnoseWithManySymptoms
AS
SELECT dd.DoctorDiagnosisID, d.DoctorFName,d.DoctorLName,dd.DoctorDiagnosisDescr,dd.DocDiagDate
from DOCTOR as d
Join SPECIALITY as s on s.SpecialityID = d.SpecialityID
Join DOCTOR_DIAGNOSIS as dd on dd.DoctorID = d.DoctorID
Join DOCTOR_DIAGNOSIS_SYMPTOM as dds on dds.DoctorDiagnosisID = dd.DoctorDiagnosisID
Join SYMPTOM as sym on sym.SymptomID = dds.SymptomID
Join (Select d.DoctorID
	from DOCTOR as d
	Join SPECIALITY as s on s.SpecialityID = d.SpecialityID
	Join PRESCRIPTION as pre on pre.DoctorID = d.DoctorID 
	where (SELECT Datediff(year, d.DOB, getDate()))>30
	Group by d.DoctorID
	having count(pre.PrescriptionID)>10) as t On t.DoctorID = d.DoctorID
group by dd.DoctorDiagnosisID, d.DoctorFName,d.DoctorLName,dd.DoctorDiagnosisDescr,dd.DocDiagDate
having count(sym.SymptomID)> 2
--SELECT * FROM ExperiencedDoctorDiagnoseWithManySymptoms


--View2: a view to find the list of Family Doctor who have diagnosed at least 5 paitents and also
--prescripted 'Fluorouracil' in their prescription before in the last 5 year
CREATE VIEW DoctorDiagnosed5PatientAndPrescriptedFluorouracil
AS
SELECT DoctorFName,DoctorLName,t.SpecialityName,PrescriptionDate,PrescriptionDescr,GenericName,t.NumDiag
from DOCTOR as d
Join PRESCRIPTION as pre on pre.DoctorID = d.DoctorID
JOIN PATIENT as p on p.PatientID = pre.PatientID
JOIN DRUG as drug on pre.DrugID = drug.DrugID
JOIN (SELECT d.DoctorID, count(dd.DoctorDiagnosisID) as NumDiag,s.SpecialityName
		from DOCTOR as d
		Join SPECIALITY as s on s.SpecialityID = d.SpecialityID
		Join DOCTOR_DIAGNOSIS as dd on dd.DoctorID = d.DoctorID
		where s.SpecialityName = 'Family Physicians'
		group by d.DoctorID,s.SpecialityName
		Having count(dd.DoctorDiagnosisID)>=5) as t on t.DoctorID = d.DoctorID
where drug.GenericName = 'Fluorouracil'
and (SELECT Datediff(year,  getDate(),pre.PrescriptionDate)) <5

--select*from DoctorDiagnosed5PatientAndPrescriptedFluorouracil



/*
Haoyang Chen / Eric
*/

--Stored Procedure 1: Write the code to add a new drug to an existing drug side effect. 
CREATE PROCEDURE NewDrugExistingDrugType
@DrugTypeName varchar(20),
@GenericName varchar(60),
@BrandName varchar(20),
@DrugDescr varchar(20),
@SideEffectName varchar(20),
@SeverityName varchar(20),
@Strength varchar(10)
AS
 
DECLARE @S_ID INT, @D_ID INT, @SE_ID INT, @DT_ID INT, @B_ID INT -- SeverityID, DrugID, DrugEffectID, --DrugTypeID, BrandID
 
SET @DT_ID = (SELECT DrugTypeID FROM DRUG_TYPE WHERE DrugTypeName = @DrugTypeName)
SET @B_ID = (SELECT BrandID FROM BRAND WHERE BrandName = @BrandName)
SET @SE_ID = (SELECT SideEffectID FROM SIDE_EFFECT WHERE SideEffectName = @SideEffectName)
SET @S_ID = (SELECT SeverityID FROM SEVERITY WHERE SeverityName = @SeverityName)
 
BEGIN TRANSACTION D1
INSERT INTO DRUG (DrugTypeID, BrandID, GenericName, DrugDescr,Strength)
VALUES (@DT_ID, @B_ID, @GenericName, @DrugDescr,@Strength)
 
SET @D_ID = (SELECT SCOPE_IDENTITY())
INSERT INTO DRUG_SIDE_EFFECT (SeverityID, DrugID, SideEffectID)
VALUES (@S_ID, @D_ID, @SE_ID)
 
COMMIT TRANSACTION D1

 /*
EXEC NewDrugExistingDrugType
@DrugTypeName ='antibiotics',
@GenericName = 'Penicillins',
@BrandName ='Neosporin',
@DrugDescr ='Helps prevent infection and provides pain relief',
@SideEffectName= 'Unknow',
@SeverityName ='Low',
@Strength ='1 OZ'
*/


--Stored Procedure 2: Write the code to add an existing drug to an existing pharmacy
CREATE PROCEDURE ExistingDrugToExistingPharmacy
@PharmacyName varchar(40),
@GenericName varchar(60),
@PharmacyDrugName varchar(30),
@PharmacyDrugDescr varchar(500),
@Price numeric(4,2)
AS
DECLARE @Pharmacy_ID INT, @Drug_ID INT
 
SET @Pharmacy_ID = (SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = @PharmacyName)
SET @Drug_ID = (SELECT D.DrugID FROM DRUG  as D WHERE GenericName = @GenericName)

BEGIN TRANSACTION D1
INSERT INTO PHARMACY_DRUG (PharmacyDrugName, PharmacyDrugDescr, PharmacyID, DrugID,Price)
VALUES (@PharmacyDrugName, @PharmacyDrugDescr, @Pharmacy_ID, @Drug_ID, @Price)
COMMIT TRANSACTION D1


/*
EXEC ExistingDrugToExistingPharmacy
@PharmacyName ='Hall Health Center',
@GenericName='Fluorouracil',
@PharmacyDrugName ='Fluoroplex',
@PharmacyDrugDescr = 'Cream for warts and abnormal skin',
@Price = 10.00
*/

/*
 Definition of two business rules
 Business rule 1:
 No patient over 65 years old with 'sweating' may purchase the medication with generic name
 called "Alprazolam".
 */

CREATE FUNCTION noPatient65SweatingPurchaseAlprazolam1()
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = 0
   IF EXISTS (
       SELECT *
       FROM PATIENT P
       JOIN DOCTOR_DIAGNOSIS DD ON P.PatientID = DD.PatientID
       JOIN DOCTOR_DIAGNOSIS_SYMPTOM DDS ON DD.DoctorDiagnosisID = DDS.DoctorDiagnosisID
       JOIN SYMPTOM S ON DDS.SymptomID = S.SymptomID
       JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
       JOIN DRUG D ON PR.DrugID = D.DrugID
       WHERE P.DOB < (SELECT GETDATE() - (365.25 * 65))
       AND S.SymptomName = 'sweating'
       AND D.GenericName = 'Alprazolam'
       )
    BEGIN
        SET @RET = 1
    END
RETURN @RET
END
GO

ALTER TABLE PRESCRIPTION
ADD CONSTRAINT CK_No65PatientAlprazolam
CHECK (dbo.noPatient65SweatingPurchaseAlprazolam1() = 0)

/*
    Business Rule 2: No patient between the age of 22 and 55 with the symptom 'Dizzy' may
    purchase Morphine with side effect of Nausea.
 */

CREATE FUNCTION noPatient2255DizzyPurchaseMorphine2()
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = 0
    IF EXISTS(
            SELECT *
            FROM PATIENT P
                 JOIN DOCTOR_DIAGNOSIS DD ON P.PatientID = DD.PatientID
                 JOIN DOCTOR_DIAGNOSIS_SYMPTOM DDS ON DD.DoctorDiagnosisID = DDS.DoctorDiagnosisID
                 JOIN SYMPTOM S ON DDS.SymptomID = S.SymptomID
                 JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
                 JOIN DRUG D ON PR.DrugID = PR.DrugID
                JOIN DRUG_SIDE_EFFECT DSE ON D.DrugID = DSE.DrugID
                JOIN SIDE_EFFECT SE ON DSE.SideEffectID = SE.SideEffectID
                WHERE P.DOB BETWEEN (SELECT GETDATE() - (365.25 * 55)) AND (SELECT GETDATE() - (365.25 * 22))
                    AND S.SymptomName = 'Dizzy'
                    AND D.GenericName = 'Morphine'
                    AND SE.SideEffectName = 'Nausea'
        )
    BEGIN
       SET @RET = 1
    END
RETURN @RET
END
GO

ALTER TABLE PRESCRIPTION
ADD CONSTRAINT CK_NoDizzyPurchaseMorphine2
CHECK (dbo.noPatient2255DizzyPurchaseMorphine2() = 0)

/*
 Two (2) user-defined function to enable a computed column
 User-defined function to enable a computer column 1:
 "Write all the code to create a computed column to track total amount of money spent
 on antibiotics medications in the past 2 years for each patient."
 */
CREATE FUNCTION calcTotolAntibiotics2Years(@PK INT)
RETURNS NUMERIC(9,2)
AS
BEGIN
      DECLARE @RET NUMERIC(9, 2) = (
          SELECT SUM(D.Price)
          FROM PHARMACY_DRUG PD
          JOIN DRUG D ON PD.DrugID = D.DrugID
          JOIN DRUG_TYPE DT ON D.DrugTypeID = DT.DrugTypeID
          JOIN PRESCRIPTION P ON D.DrugID = P.DrugID
          JOIN PATIENT PA ON P.PatientID = PA.PatientID
          WHERE PA.PatientID = @PK
          AND P.PrescriptionDate > (SELECT GETDATE() - (365.25 * 2))
		  And DT.DrugTypeName = 'antibiotics'
          )
RETURN @RET
END
GO

ALTER TABLE PATIENT
ADD TotalSpent2yrsOnAntibiotics AS (dbo.calcTotolAntibiotics2Years(PatientID))

/*
  User-defined function to enable a computer column 2:
  "Write all the code to create a computed column to track total drug purchased in past 3 years for each patient
 */
CREATE FUNCTION calcTotalDrugPurchasedPatient(@PK INT)
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = (
        SELECT COUNT(D.DrugID) AS TotalDrug
        FROM DRUG D
                 JOIN PRESCRIPTION P on D.DrugID = P.DrugID
                 JOIN PHARMACY_DRUG PD on D.DrugID = PD.DrugID
        WHERE P.PatientID = @PK
          AND P.PrescriptionDate > (SELECT GETDATE() - (365.25 * 3))
    )
RETURN @RET
END
GO
select * from patient
ALTER TABLE PATIENT
ADD TotalDrugPurchasedLast3Yrs AS (dbo.calcTotalDrugPurchasedPatient(PatientID))


/*
 Two (2) view generating a 'complex' query (includes multiple JOINs, GROUP BY/HAVING statements, and aggregate function.

 A view to find the drugs with total price above 10 dollars that are assigned by doctors whose ratings
 are above average which also are sold by pharmacies with above average ratings.
 */
CREATE VIEW [above average doctor assigned drugs price] AS
SELECT D.DrugID, D.GenericName, DO.DoctorFName, DO.DoctorLName, SUM(D.Price) AS drugTotalPrice
FROM DRUG as D
JOIN DRUG_SIDE_EFFECT DSE ON D.DrugID = DSE.DrugID
JOIN SIDE_EFFECT SE ON DSE.SideEffectID = SE.SideEffectID
JOIN PRESCRIPTION P ON D.DrugID = P.DrugID
JOIN DOCTOR DO ON P.DoctorID = DO.DoctorID
JOIN (SELECT D2.DrugID
        FROM DRUG D2
        JOIN PHARMACY_DRUG PD on D2.DrugID = PD.DrugID
        JOIN PHARMACY P2 on PD.PharmacyID = P2.PharmacyID
        JOIN PHARM_LOCATION PL on P2.PharmacyID = PL.PharmacyID
        WHERE PL.Review > 5
    ) AS Q on Q.DrugID = D.DrugID
WHERE Rating > (SELECT AVG(Rating) FROM DOCTOR)
GROUP BY D.DrugID, D.GenericName, DO.DoctorFName, DO.DoctorLName
HAVING SUM(D.Price) > 10
--SELECT* from [above average doctor assigned drugs price]

/*
 Second View generating a 'complex' query

 A view to find the patients who are diagnosed by doctors with below average ratings who have diagnosed at
 least 2 patients and also have prescriptions with at least 2 drugs in the past 2 years.
 */
CREATE VIEW [patient diagnosed by below average rating doctor] AS
SELECT P.PatientID, P.PatientFName, P.PatientLName, COUNT(D.DrugID) AS totalDrugPurchased2Years
FROM PATIENT P
JOIN PRESCRIPTION P2 on P.PatientID = P2.PatientID
JOIN DRUG D on P2.DrugID = D.DrugID
JOIN (SELECT P2.PatientID, COUNT(DD.DoctorDiagnosisID) as TotalPatients
        FROM PATIENT P2
        JOIN DOCTOR_DIAGNOSIS DD on P2.PatientID = DD.PatientID
        JOIN DOCTOR D2 on DD.DoctorID = D2.DoctorID
        WHERE Rating > (SELECT AVG(Rating) FROM DOCTOR)
        GROUP BY P2.PatientID
        HAVING COUNT(DD.DoctorDiagnosisID) >= 2
    ) AS Q ON Q.PatientID = P.PatientID
WHERE (SELECT DATEDIFF(YEAR, GETDATE(), P2.PrescriptionDate)) < 2
GROUP BY P.PatientID, P.PatientFName, P.PatientLName
HAVING COUNT(D.DrugID) >= 2
--SELECT* from [patient diagnosed by below average rating doctor]






/* Jordan Auerbach*/

/*  *** STORED PROCEDURE ***
    The code to insert a new doctor to an existing doctor diagnosis
 */

CREATE PROCEDURE jauerbachNewDoctorNewDiagnosis
@SpecialityName varchar(20),
@DoctorFName varchar(50),
@DoctorLName varchar(50),
@Birth Date,
@PatientNetID varchar(20),
@DoctorNetID varchar(20),
@DoctorDiagnosisDescr varchar(300),
@Rating INT,
@DDDate DATE
AS

DECLARE @S_ID INT, @D_ID INT, @P_ID INT -- SpecialityID, DoctorID, PatientID

SET @S_ID = (SELECT SpecialityID FROM SPECIALITY WHERE SpecialityName = @SpecialityName)
SET @P_ID = (SELECT PatientID FROM PATIENT WHERE PatientNetID = @PatientNetID)


BEGIN TRANSACTION D1

INSERT INTO DOCTOR (SpecialityID, DoctorFName, DoctorLName, DoctorNetID, DOB, Rating)
VALUES (@S_ID, @DoctorFName , @DoctorLName, @DoctorNetID, @Birth, @Rating)

SET @D_ID = (SELECT SCOPE_IDENTITY())

INSERT INTO DOCTOR_DIAGNOSIS (DoctorID, PatientID, DoctorDiagnosisDescr, DocDiagDate)
VALUES (@D_ID, @P_ID, @DoctorDiagnosisDescr, @DDDate)

COMMIT TRANSACTION D1


 /* *** STORED PROCEDURE ***
    The code to insert an existing drug to a new prescription
  */

CREATE PROCEDURE jauerbachExistingDrugNewPrescription
@GenericName varchar(50),
@DoctorNetID varchar(20),
@PatientNetID varchar(20),
@PDate Date,
@PrescriptionDescr varchar(300),
@Dosage varchar(300),
@RefillNum INT
AS

DECLARE @D_ID INT, @DR_ID INT, @P_ID INT -- DrugID, DoctorID, PatientID

SET @DR_ID = (SELECT DoctorID FROM DOCTOR WHERE DoctorNetID  = @DoctorNetID)
SET @P_ID = (SELECT PatientID FROM PATIENT WHERE PatientNetID = @PatientNetID)
SET @D_ID = (SELECT DrugID FROM DRUG WHERE GenericName  = @GenericName)

BEGIN TRANSACTION P1

INSERT INTO PRESCRIPTION (PrescriptionDate, PrescriptionDescr, DoctorID, PatientID, Dosage, RefillNum, DrugID)
VALUES (@PDate, @PrescriptionDescr, @DR_ID, @P_ID, @Dosage, @RefillNum, @D_ID)

COMMIT TRANSACTION P1


/* *** BUSINESS RULE ***
   No Patient under 25 can have more than 5 prescriptions of Drug Type 'Opioid' from
   Safeway Pharmacy in a single calendar year.
*/

CREATE FUNCTION jauerbachNoPatient2510PrescriptionsInYear()
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = 0
    IF EXISTS(SELECT P.PatientID, COUNT(PR.PrescriptionID) AS TotalPrescriptions
        FROM PATIENT P
            JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
            JOIN DRUG D ON PR.DrugID = D.DrugID
            JOIN DRUG_TYPE DT ON D.DrugTypeID = DT.DrugTypeID
            JOIN PHARMACY_DRUG PD ON D.DrugID = PD.DrugID
            JOIN PHARMACY PH ON PD.PharmacyID = PH.PharmacyID
        WHERE YEAR(PR.PrescriptionDate) = YEAR(GetDate())
            AND DT.DrugTypeName = 'Opioid'
            AND PH.PharmacyName = 'Safeway Pharmacy'
            AND P.DOB > (SELECT GetDate() - (365.25 * 25))
        GROUP BY P.PatientID
        HAVING COUNT(PR.PrescriptionID) > 5)
    BEGIN
        SET @RET = 1
    END

RETURN @RET
END


ALTER TABLE PRESCRIPTION
ADD CONSTRAINT CK_NoPatient2510PrescriptionsInYear
CHECK (dbo.jauerbachNoPatient2510PrescriptionsInYear() = 0)


/* *** BUSINESS RULE ***
   No negative input for MeasurableValue
*/

CREATE FUNCTION jauerbachNoNegativeMeasurableValues()
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = 0
    IF EXISTS(SELECT *
        FROM PATIENT_MEASURABLE
        WHERE MeasurableValue < 0)
    BEGIN
        SET @RET = 1
    END

RETURN @RET
END


ALTER TABLE PATIENT_MEASURABLE
ADD CONSTRAINT CK_NoNegativeMeasurableValues
CHECK (dbo.jauerbachNoNegativeMeasurableValues() = 0)


/* *** COMPUTED COLUMN ***
   Total amount of money spent on drugs in the calendar year

*/

CREATE FUNCTION jauerbachTotalMoneySpentOnDrugsInCalendarYear(@PK INT)
RETURNS Numeric(9,2)
AS
BEGIN
    DECLARE @RET Numeric(9,2)
    SET @RET = (SELECT SUM(PD.Price)
                FROM PATIENT P
                    JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
                    JOIN DRUG D ON PR.DrugID = D.DrugID
                    JOIN PHARMACY_DRUG PD ON D.DrugID = PD.DrugID
                WHERE YEAR(PrescriptionDate) = YEAR(GetDate())
                    AND P.PatientID = @PK)

    IF @RET IS NULL
    BEGIN
        SET @RET = 0
    END

RETURN @RET
END

ALTER TABLE PATIENT
ADD TotalMoneySpentOnDrugsThisYear AS (dbo.jauerbachTotalMoneySpentOnDrugsInCalendarYear(PatientID))


/* *** COMPUTED COLUMN ***
   Count the total number of prescriptions for each patient
*/

CREATE FUNCTION jauerbachCountNumPrescriptions(@PK INT)
RETURNS INT
AS
BEGIN
    DECLARE @RET INT
    SET @RET = (SELECT COUNT(*) AS TotalPrescriptions
                FROM PATIENT P
                    JOIN PRESCRIPTION PR on P.PatientID = PR.PatientID
                WHERE P.PatientID = @PK)

RETURN @RET
END

ALTER TABLE PATIENT
ADD NumOfPrescriptions AS (dbo.jauerbachCountNumPrescriptions(PatientID))


/* *** COMPUTED COLUMN ***
   Distance between patient and pharmacy location
   Got formula from https://stackoverflow.com/questions/13026675/calculating-distance-between-two-points-latitude-longitude
*/

CREATE FUNCTION jauerbachCalcDistanceBetweenPharmacyAndPatient(@PK1 INT, @PK2 INT)
RETURNS Numeric(8,3)
AS
BEGIN
    DECLARE @RET1 Numeric(10,9)
    DECLARE @RET2 Numeric(8,3)
    DECLARE @Lat1 Numeric(9,6)
    DECLARE @Long1 Numeric (9,6)
    DECLARE @Lat2 Numeric(9,6)
    DECLARE @Long2 Numeric (9,6)
    -- Convert to radians
    SET @Lat1 = (SELECT pat_lat FROM PATIENT P WHERE P.PatientID = @PK1) / 57.2958
    SET @Long1 = (SELECT pat_long FROM PATIENT P WHERE P.PatientID = @PK1) / 57.2958
    SET @Lat2 = (SELECT Latitude FROM PHARM_LOCATION P WHERE P.PharmLocID = @PK2) / 57.2958
    SET @Long2 = (SELECT Longitude FROM PHARM_LOCATION P WHERE P.PharmLocID = @PK2) / 57.2958
    -- Calculate distance
    SET @RET1 = ((Sin(@Lat1) * Sin(@Lat2)) + (Cos(@Lat1) * Cos(@Lat2) * Cos(ABS(@Long2 - @Long1))))

    SET @RET2 = (3958.75 * Atan(Sqrt(1 - power(@RET1, 2))) / @RET1)

RETURN @RET2
END

ALTER TABLE PAT_PHARM_LOC
ADD DistanceBetweenPharmacyAndPatient AS (dbo.jauerbachCalcDistanceBetweenPharmacyAndPatient(PatientID, PharmLocID))


/* *** VIEW ***
   Find the average age of patients who have had at least 2 prescriptions of drug type Opioid in the past 10 years,
   who also have had at least 3 doctor diagnoses from a doctor who is a Cardiologists in the past 5 years.
*/

CREATE VIEW AverageAgeOfPatient2PrescrOpioidPast10YearsAnd3DoctDiagFromCardiologistPast5Years AS
SELECT DT.DrugTypeName, SubQ1.SpecialityName, SubQ1.NumDocDiags, AVG(DISTINCT DATEDIFF(Day, P.DOB, GetDate()) / 365.25) AS AverageAgeOfPatient
FROM PATIENT P
    JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
    JOIN DRUG DR ON PR.DrugID = DR.DrugID
    JOIN DRUG_TYPE DT ON DR.DrugTypeID = DT.DrugTypeID
    JOIN (SELECT P2.PatientID, S2.SpecialityName, COUNT(DD2.DoctorDiagnosisID) AS NumDocDiags
        FROM PATIENT P2
            JOIN DOCTOR_DIAGNOSIS DD2 ON P2.PatientID = DD2.PatientID
            JOIN DOCTOR D2 ON DD2.DoctorID = D2.DoctorID
            JOIN SPECIALITY S2 ON D2.SpecialityID = S2.SpecialityID
        WHERE S2.SpecialityName = 'Cardiologists'
            AND DD2.DocDiagDate > (SELECT GetDate() - (365.25 * 5))
        GROUP BY P2.PatientID, S2.SpecialityName
        HAVING COUNT(DD2.DoctorDiagnosisID) > 2) AS SubQ1 ON P.PatientID = SubQ1.PatientID
WHERE DT.DrugTypeName = 'Opioid'
    AND PR.PrescriptionDate > (SELECT GetDate() - (365.25 * 10))
GROUP BY DT.DrugTypeName, SubQ1.SpecialityName, SubQ1.NumDocDiags
--select*from AverageAgeOfPatient2PrescrOpioidPast10YearsAnd3DoctDiagFromCardiologistPast5Years


/* *** VIEW ***
   Find the pharmacies that have sold more than $20 worth of prescription drugs in the past 10 years
   that were prescribed from a doctor with speciality 'Family Physicians'
   that have also sold more than $30 of the drug with the generic name 'Alprazolam' in the past 3 years
*/

CREATE VIEW PharmaciesSoldMore$20Past10YearsPrescribedByFamPhysAndSoldMore$30OfAlprazolamPast3Years AS
SELECT P.PharmacyID, P.PharmacyName, P.PharmacyDescr
FROM PHARMACY P
    JOIN PHARMACY_DRUG PD ON P.PharmacyID = PD.PharmacyID
    JOIN DRUG D ON PD.DrugID = D.DrugID
    JOIN PRESCRIPTION PR ON D.DrugID = PR.DrugID
    JOIN DOCTOR DR ON PR.DoctorID = DR.DoctorID
    JOIN SPECIALITY S ON DR.SpecialityID = S.SpecialityID
    JOIN (SELECT P2.PharmacyID
        FROM PHARMACY P2
            JOIN PHARMACY_DRUG PD2 on P2.PharmacyID = PD2.PharmacyID
            JOIN DRUG D2 on PD2.DrugID = D2.DrugID
            JOIN PRESCRIPTION PR2 on D2.DrugID = PR2.DrugID
        WHERE D2.GenericName = 'Alprazolam'
            AND PR2.PrescriptionDate > (SELECT GetDate() - (365.25 * 3))
        GROUP BY P2.PharmacyID
        HAVING SUM(PD2.Price) > 30) AS SubQ1 ON P.PharmacyID = SubQ1.PharmacyID
WHERE PR.PrescriptionDate > (SELECT GetDate() - (365.25 * 10))
    AND S.SpecialityName = 'Family Physicians'
GROUP BY P.PharmacyID, P.PharmacyName, P.PharmacyDescr, D.GenericName
HAVING SUM(PD.Price) > 20
--select*from PharmaciesSoldMore$20Past10YearsPrescribedByFamPhysAndSoldMore$30OfAlprazolamPast3Years



/* Saurav Sawansukha*/
--Stored Procedure 1: Write the code to add a new patient
CREATE PROCEDURE addNewUser
@Address VARCHAR(50),
@PatientNetID VARCHAR(20),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@DOB DATE,
@pat_long NUMERIC(9,6),
@pat_lat NUMERIC(9,6)
AS
BEGIN TRANSACTION G1
INSERT INTO PATIENT(PatientFName, PatientLName, PatientNetID, DOB, Address, pat_long, pat_lat)
VALUES(@FirstName, @LastName, @PatientNetID, @DOB, @Address, @pat_long, @pat_lat)
COMMIT TRANSACTION G1

/*EXECUTE addNewUser
@Address = '4535 NE',
@PatientNetID = 'ss299',
@FirstName = 'Saurav',
@LastName = 'Sawansukha',
@DOB = '2000-12-19',
@pat_long = 122.390000,
@pat_lat = 47.700000
*/

SELECT * FROM PATIENT
--Stored Procedure 2: Write the code to add a new symptom to an existing Doctor Diagnosis

CREATE PROCEDURE newSymptomToExistingDocDiagnosis
@SymptomName VARCHAR(20),
@SymptomDescr VARCHAR(300),
@SymtomTypeName VARCHAR(20),
@DoctorDiagnosisDescr VARCHAR(300),
@DocDate DATE

AS

DECLARE @SType_ID INT
DECLARE @DD_ID INT
DECLARE @S_ID INT


SET @SType_ID = (SELECT SymptomTypeID FROM SYMPTOM_TYPE WHERE SymptomTypeName = @SymtomTypeName)
SET @DD_ID = (SELECT DoctorDiagnosisID FROM DOCTOR_DIAGNOSIS WHERE DoctorDiagnosisDescr = @DoctorDiagnosisDescr
    AND DocDiagDate = @DocDate)

BEGIN TRANSACTION D1
INSERT INTO SYMPTOM(SymptomTypeID, SymptomName, SymptomDescr)
VALUES(@SType_ID, @SymptomName, @SymptomDescr)

Set @S_ID = (SELECT SCOPE_IDENTITY())

INSERT INTO DOCTOR_DIAGNOSIS_SYMPTOM(DoctorDiagnosisID, SymptomID)
VALUES(@DD_ID, @S_ID)

COMMIT TRANSACTION D1

/*EXECUTE newSymptomToExistingDocDiagnosis
    @SymptomName = 'Cough',
    @SymptomDescr = 'Coughing all day',
    @SymtomTypeName = 'Common',
    @DoctorDiagnosisDescr = 'Cold and fever',
    @DocDate = '2017/04/19'
*/

--1. Business Rules - If the age of a person is older than 60 years old, he/she should not be allowed
--to take a drug with the description including 'Anxiety'

CREATE FUNCTION noEldersOver60()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0
IF EXISTS(
SELECT *
FROM PATIENT P
    JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
    JOIN DRUG D ON PR.DrugID = D.DrugID
    JOIN DRUG_TYPE DT ON D.DrugTypeID = DT.DrugTypeID
WHERE P.DOB < (SELECT GETDATE() - (365.25 * 60))
AND DT.DrugTypeDescr LIKE '%Anxiety%'
)
BEGIN
SET @Ret = 1
END
RETURN @Ret
END
GO

ALTER TABLE PRESCRIPTION
ADD CONSTRAINT CK_NoElderAnxiety
CHECK(dbo.noEldersOver60() = 0)

--2. Business Rules - A patient cannot buy a drug type that contains marijuana if they are below 21 

CREATE FUNCTION noBuyWeed()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0
IF EXISTS(
SELECT *
FROM PATIENT P
    JOIN PRESCRIPTION P2 on P.PatientID = P2.PatientID
    JOIN DRUG D on P2.DrugID = D.DrugID
    JOIN DRUG_TYPE DT on D.DrugTypeID = DT.DrugTypeID
WHERE DT.DrugTypeDescr LIKE '%marijuana%'
    AND P.DOB > (SELECT GETDATE() - (365.25 * 21))
)
BEGIN
SET @Ret = 1
END
RETURN @Ret
END
GO

ALTER TABLE PRESCRIPTION
ADD CONSTRAINT CK_NoUnder21ShouldBeAbleToBuyWeed
CHECK(dbo.noBuyWeed() = 0)

--1. Computed Column : Count the number of unique brands the user has bought for its medication purposes


CREATE FUNCTION CountUniqueBrands(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
SELECT COUNT(DISTINCT B.BrandID)
FROM PATIENT P
    JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
    JOIN DRUG D ON PR.DrugID = D.DrugID
    JOIN BRAND B ON B.BrandID = B.BrandID
WHERE P.PatientID = @PK
)
RETURN @RET
END
GO

ALTER TABLE PATIENT
ADD CountUniqueBrands AS (dbo.CountUniqueBrands(PatientID))

--2. Computed Column : Count the specific number of Specialist the client sees in the past 7 days

CREATE FUNCTION CountMySpecialistVisitedInPastWeek(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
SELECT COUNT(DISTINCT S.SpecialityID)
FROM PATIENT P
    JOIN DOCTOR_DIAGNOSIS DD ON P.PatientID = DD.PatientID
    JOIN DOCTOR D ON DD.DoctorID = D.DoctorID
    JOIN SPECIALITY S ON D.SpecialityID = S.SpecialityID
WHERE P.PatientID = @PK
  AND DD.DocDiagDate >= (SELECT GETDATE() - 7)
)
RETURN @RET
END
GO

ALTER TABLE PATIENT
ADD CountMySpecialistVisitedInPastWeek AS (dbo.CountMySpecialistVisitedInPastWeek(PatientID))

--1. View Function - How many people has a 'Family Physicians' diagnosed as obese and prescribed
-- vitamins to patients who have an average height that is more than 1.3m

CREATE VIEW commonWeightObesity AS
SELECT COUNT(P.PatientID) AS totalPatient, P.PatientFname, P.PatientLName
FROM DOCTOR_DIAGNOSIS DD
    JOIN PATIENT P ON DD.PatientID = P.PatientID
    JOIN PRESCRIPTION PR ON P.PatientID = PR.PatientID
    JOIN DOCTOR DO ON DO.DoctorID = PR.DoctorID
    JOIN SPECIALITY SPE ON DO.SpecialityID = SPE.SpecialityID
    JOIN(SELECT DDI.DoctorDiagnosisID
    FROM DOCTOR_DIAGNOSIS DDI
        JOIN PATIENT PA ON DDI.PatientID = PA.PatientID
        JOIN PRESCRIPTION PRE ON PA.PatientID = PRE.PatientID
        JOIN PATIENT_MEASURABLE PM on PA.PatientID = PM.PatientID
        JOIN MEASURABLE M on PM.MeasurableID = M.MeasurableID
        WHERE PRE.PrescriptionDescr LIKE '%Vitamin%'
            AND M.MeasurableName = 'Height'
        GROUP BY DDI.DoctorDiagnosisID
        HAVING AVG(PM.MeasurableValue) > 1.3) AS subQ1 ON DD.DoctorDiagnosisID = subQ1.DoctorDiagnosisID

WHERE SPE.SpecialityName = 'Family Physicians' AND DD.DoctorDiagnosisDescr LIKE '%Obese%'
GROUP BY P.PatientFname, P.PatientLName


--2. View Function - doctors that have written more than 3 prescriptions for minors who have also
--  written more than 5 prescription for an adult for a drug of brand name 'Xanax'


CREATE VIEW prescriptionOfaMinorAndNotMinor AS
SELECT D.DoctorID, D.DoctorFName, D.DoctorLName
FROM DOCTOR D
    JOIN PRESCRIPTION PE ON D.DoctorID = PE.DoctorID
    JOIN PATIENT P ON P.PatientID = PE.PatientID
    JOIN(
        SELECT DD.DoctorID
        FROM DOCTOR DD
        JOIN PRESCRIPTION P2 on DD.DoctorID = P2.DoctorID
        JOIN PATIENT PA ON P2.PatientID = PA.PatientID
        JOIN DRUG D2 on P2.DrugID = D2.DrugID
        JOIN BRAND B on D2.BrandID = B.BrandID
        WHERE PA.DOB <= (SELECT GETDATE() - (365.25 * 18)) AND B.BrandName  = 'Xanax'
        GROUP BY DD.DoctorID
        HAVING COUNT(P2.PrescriptionID) > 5
    ) AS subQ2 ON D.DoctorID = subQ2.DoctorID
WHERE P.DOB > (SELECT GETDATE() - (365.25 * 18))
GROUP BY D.DoctorID, D.DoctorFName, D.DoctorLName
HAVING COUNT(PE.PrescriptionID) > 3


-----------------SECTION 3-------------------

/*Stored procedures*/
EXEC rxToPatient
@PreDate = '2019-11-12', 
@PreDescr = 'This is for Russell wart treatment' ,
@pUserNetID = 6,
@DoctorNetID = 13,
@DrugName = 'Fluorouracil',
@Dosage = 'Once perday',
@Refill = 2
GO

EXEC NewPharmLoc 
@PName = 'Handom Pharmacy', 
@PDescr = 'a Handom pharmacy in Seaaatle Area',
@Address = '3390 Terra Street, Seattle, WA 98109',
@LDescr = 'a Handom pharmacie on terra street',
@LongitudePharm = -122.325066 ,
@LatitudePharm = 47.545376,
@Review = 8
GO

EXEC NewDrugExistingDrugType
@DrugTypeName ='antibiotics',
@GenericName = 'Penicillins',
@BrandName ='Neosporin',
@DrugDescr ='Helps prevent infection and provides pain relief',
@SideEffectName= 'Unknow',
@SeverityName ='Low',
@Strength ='1 OZ'


EXEC ExistingDrugToExistingPharmacy
@PharmacyName ='Hall Health Center',
@GenericName='Fluorouracil',
@PharmacyDrugName ='Fluoroplex',
@PharmacyDrugDescr = 'Cream for warts and abnormal skin',
@Price = 10.00

EXECUTE addNewUser
@Address = '4535 NE',
@PatientNetID = 'ss299',
@FirstName = 'Saurav',
@LastName = 'Sawansukha',
@DOB = '2000-12-19',
@pat_long = -122.390000,
@pat_lat = 47.700000

EXECUTE newSymptomToExistingDocDiagnosis
@SymptomName = 'Cough',
@SymptomDescr = 'Coughing all day',
@SymtomTypeName = 'Common',
@DoctorDiagnosisDescr = 'Cold and fever',
@DocDate = '2017/04/19'


EXECUTE jauerbachNewDoctorNewDiagnosis
@SpecialityName = 'Family Physicians',
@DoctorFName = 'Lebron',
@DoctorLName = 'Kobe',
@Birth = 'April 19, 1984',
@PatientNetID = 'RGiles32',
@DoctorNetID = 'Goat23',
@DoctorDiagnosisDescr = 'This guy is obese',
@Rating = 10,
@DDDate = 'December 6, 2017'


EXECUTE jauerbachExistingDrugNewPrescription
@GenericName = 'Morphine', -- Morphine, Fluorouracil, Abacavir, Alprazolam
@DoctorNetID = '15', -- 12, 13, 14, 15
@PatientNetID = '650', -- 2 Jamal, 6 Russell, 5 Myles, 3 Tommy
@PDate = 'February 26, 2019',
@PrescriptionDescr = 'This is to treat Rogers''s pain for his arm',
@Dosage = 'Take 60 mg orally every 4 hours as needed to manage pain',
@RefillNum = 65

/*Straight Adding Data*/

insert into MEASURABLE(BloodPressure,Height,Weight)
VALUES(50,1.65,78)

insert into SPECIALITY(SpecialityName,SpecialityDescr)
VALUES('Dermatologists','Have problems with your skin, hair, nails? Do you have moles, scars, acne, or skin allergies? Dermatologists can help.')

insert into DOCTOR_DIAGNOSIS (DocDiagDate,DoctorID,PatientID,DoctorDiagnosisDescr)
values ('2012-02-02',8,1,'Common cold')

Insert into DOCTOR_DIAGNOSIS_SYMPTOM (DoctorDiagnosisID,SymptomID)
Values(1011,3)

Insert into DOCTOR_DIAGNOSIS_MEASURABLE(DoctorDiagnosisID,MeasurableID)
values(1,1)

insert into SYMPTOM(SymptomTypeID,SymptomName,SymptomDescr)
values(11,'Dizzy','A loss of consciousness and muscle strength characterized by a fast onset, short duration, and spontaneous recovery.')

insert into SYMPTOM_TYPE(SymptomTypeName,SymptomTypeDescr)
values('Very common','More than millions of cases per year')

insert into DOCTOR(DoctorFName,DoctorLName,DoctorNetID,SpecialityID,DOB,Rating)
values('Glenn','Weaver',011,2,'1973-04-12',7)

insert into PATIENT(PatientFName,PatientLName,DOB,PatientNetID,[Address],pat_lat,pat_long)
VALUES('Harold','Olsen','2000-07-12','HOlsen7','4008 Raccoon Run, Seattle,WA 98105',-122.200000,47.610000)

insert into SPECIALITY(SpecialityName,SpecialityDescr)
VALUES('Dermatologists','Have problems with your skin, hair, nails? Do you have moles, scars, acne, or skin allergies? Dermatologists can help.')


INSERT INTO SEVERITY(SeverityName, SeverityDescr)
VALUES ('Low', 'Very minor and cause minimal irritation to patient'),
       ('Mild', 'Mild reactions usually described as of minor significance include headaches and fatigue'),
       ('Moderate', 'Reactions that are distinctly annoying, distressing, or intolerable'),
       ('Severe', 'Severe reactions include those that may be life threatening, that result in persistent or significant disability or hospitalization, and that cause a birth defect'),
       ('Lethal', 'Lethal reactions are those in which a drug reaction directly or indirectly caused death')




INSERT INTO SIDE_EFFECT(SideEffectName, SizeEffectDescr)
VALUES ('Nausea', 'A feeling of sickness with an inclination to vomit'),
       ('Seizure', 'A sudden attack of illness, especially a stroke or an epileptic fit'),
       ('Headache', 'a continuous pain in the head'),
       ('Fever', 'An abnormally high body temperature'),
       ('Constipation', 'A condition in which there is difficulty in emptying the bowels')



INSERT INTO BRAND(BrandName, BrandDescr)
VALUES ('TYLENOL', 'Brand of pain relief and fever reducing drugs'),
       ('Fluoroplex', 'Brand of Fluorouracil'),
       ('Oramorph SR', 'Brand of morphine'),
       ('Ziagen', 'Brand of abacavir'),
       ('Xanax', 'Brand of alprazolam')



INSERT INTO DRUG_TYPE(DrugTypeName, DrugTypeDescr)
VALUES ('Opioid', 'Opioids are substances that act on opioid receptors to produce morphine-like effects. Medically they are primarily used for pain relief, including anesthesia.'),
       ('Antipyretics', 'Fever reducer'),
       ('Antimetabolite', 'Interfere with one or more enzymes or their reactions that are necessary for DNA synthesis'),
       ('NRTI', 'Nucleoside Reverse Transcriptase Inhibitors block an HIV enzyme called reverse transcriptase'),
       ('Benzodiazepine', 'Class of agents that work in the central nervous system and are used for a variety of medical conditions. They act on specific receptors in the brain, called gamma-aminobutyric acid-A (GABA-A) receptors')
INSERT INTO DRUG_TYPE(DrugTypeName, DrugTypeDescr)
VALUES ('Analgesics', 'Pain reliever')




INSERT INTO PHARMACY(PharmacyName, PharmacyDescr)
VALUES ('Safeway Pharmacy', 'Pharmacy in Safeway'),
       ('Walgreens Pharmacy', 'Pharmacy in Walgreens'),
       ('Park''s Pharmacy', 'A pharmacy in Ravenna'),
       ('CVS Pharmacy', 'Pharmacy in CVS'),
       ('QFC Pharmacy', 'Pharmacy in QFC')




INSERT INTO PHARM_LOCATION(PharmacyID, PharmLocationDescr, Address, Longitude, Latitude, Review)
VALUES ((SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = 'Safeway Pharmacy'), 'Safeway in the U District next to University Village', '3020 NE 45th St Seattle, WA 98105',
        -122.295039, 47.664376, 3)




INSERT INTO PAT_PHARM_LOC(PharmLocID, PatientID)
VALUES ((SELECT PharmLocID FROM PHARM_LOCATION WHERE Address = '3020 NE 45th St Seattle, WA 98105'), (SELECT PatientID FROM PATIENT WHERE PatientNetID = 'HOlsen7')),
       ((SELECT PharmLocID FROM PHARM_LOCATION WHERE Address = '3020 NE 45th St Seattle, WA 98105'), (SELECT PatientID FROM PATIENT WHERE PatientNetID = 'WallyJ22')),
       ((SELECT PharmLocID FROM PHARM_LOCATION WHERE Address = '401 NE Ravenna Boulevard Seattle, Washington 98115'), (SELECT PatientID FROM PATIENT WHERE PatientNetID = 'Tweiss')),
       ((SELECT PharmLocID FROM PHARM_LOCATION WHERE Address = '4315 University Way NE Seattle, WA 98105'), (SELECT PatientID FROM PATIENT WHERE PatientNetID = 'MN12')),
       ((SELECT PharmLocID FROM PHARM_LOCATION WHERE Address = '417 Broadway E Box 2 Seattle, WA 98102'), (SELECT PatientID FROM PATIENT WHERE PatientNetID = 'RGiles32')),
       ((SELECT PharmLocID FROM PHARM_LOCATION WHERE Address = '1205 NE 50th St Seattle, WA 98105'), (SELECT PatientID FROM PATIENT WHERE PatientNetID = 'Dguerra'))






INSERT INTO DRUG(DrugTypeID, BrandID, GenericName, DrugDescr, Strength)
VALUES ((SELECT DrugTypeID FROM DRUG_TYPE WHERE DrugTypeName = 'Analgesics'), (SELECT BrandID FROM BRAND WHERE BrandName = 'TYLENOL'),
        'Acetaminophen', 'Pain reliever pill for mild to moderate pain', '325 mg'),

       ((SELECT DrugTypeID FROM DRUG_TYPE WHERE DrugTypeName = 'Opioid'), (SELECT BrandID FROM BRAND WHERE BrandName = 'Oramorph SR'),
        'Morphine', 'Treats moderate to severe pain', '60 mg'),

       ((SELECT DrugTypeID FROM DRUG_TYPE WHERE DrugTypeName = 'Antimetabolite'), (SELECT BrandID FROM BRAND WHERE BrandName = 'Fluoroplex'),
        'Fluorouracil', 'Cream for warts and abnormal skin', '5%'),

       ((SELECT DrugTypeID FROM DRUG_TYPE WHERE DrugTypeName = 'NRTI'), (SELECT BrandID FROM BRAND WHERE BrandName = 'Ziagen'),
        'Abacavir', 'Pill used to treat HIV and AIDS', '300 mg'),

       ((SELECT DrugTypeID FROM DRUG_TYPE WHERE DrugTypeName = 'Benzodiazepine'), (SELECT BrandID FROM BRAND WHERE BrandName = 'Xanax'),
        'Alprazolam', 'Pill used to treat anxiety disorders, panic disorders, and anxiety caused by depression', '1 mg')





INSERT INTO DRUG_SIDE_EFFECT(SeverityID, DrugID, SideEffectID)
VALUES ((SELECT SeverityID FROM SEVERITY WHERE SeverityName = 'Mild'), (SELECT DrugID FROM DRUG WHERE GenericName = 'Acetaminophen'),
        (SELECT SideEffectID FROM SIDE_EFFECT WHERE SideEffectName = 'Nausea')),
       ((SELECT SeverityID FROM SEVERITY WHERE SeverityName = 'Severe'), (SELECT DrugID FROM DRUG WHERE GenericName = 'Morphine'),
        (SELECT SideEffectID FROM SIDE_EFFECT WHERE SideEffectName = 'Seizure')),
       ((SELECT SeverityID FROM SEVERITY WHERE SeverityName = 'Mild'), (SELECT DrugID FROM DRUG WHERE GenericName = 'Fluorouracil'),
        (SELECT SideEffectID FROM SIDE_EFFECT WHERE SideEffectName = 'Headache')),
       ((SELECT SeverityID FROM SEVERITY WHERE SeverityName = 'Moderate'), (SELECT DrugID FROM DRUG WHERE GenericName = 'Abacavir'),
        (SELECT SideEffectID FROM SIDE_EFFECT WHERE SideEffectName = 'Fever')),
       ((SELECT SeverityID FROM SEVERITY WHERE SeverityName = 'Moderate'), (SELECT DrugID FROM DRUG WHERE GenericName = 'Alprazolam'),
        (SELECT SideEffectID FROM SIDE_EFFECT WHERE SideEffectName = 'Constipation'))




INSERT INTO PHARMACY_DRUG(PharmacyID, DrugID, PharmacyDrugName, PharmacyDrugDescr)
VALUES ((SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = 'QFC Pharmacy'),
        (SELECT DrugID FROM DRUG WHERE GenericName = 'Fluorouracil'), 'Fluoroplex', 'Cream for warts and abnormal skin'),
       ((SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = 'Safeway Pharmacy'),
        (SELECT DrugID FROM DRUG WHERE GenericName = 'Morphine'), 'Oramorph SR', 'Treats moderate to severe pain'),
       ((SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = 'Walgreens Pharmacy'),
        (SELECT DrugID FROM DRUG WHERE GenericName = 'Acetaminophen'), 'TYLENOL', 'Pain reliever pill for mild to moderate pain'),
       ((SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = 'Park''s Pharmacy'),
        (SELECT DrugID FROM DRUG WHERE GenericName = 'Abacavir'), 'Ziagen', 'Pill used to treat HIV and AIDS'),
       ((SELECT PharmacyID FROM PHARMACY WHERE PharmacyName = 'CVS Pharmacy'),
        (SELECT DrugID FROM DRUG WHERE GenericName = 'Alprazolam'), 'Xanax', 'Pill used to treat anxiety disorders, panic disorders, and anxiety caused by depression')



-- 1 is height, 2 is weight, 3 is heart rate
INSERT INTO PATIENT_MEASURABLE(PatientID, MeasurableID, MeasurableValue)
VALUES(1, 1, 1.6), (1, 2, 70), (1, 3, 80),
       (2, 1, 1.5), (2, 2, 68), (2, 3, 90),
       (3, 1, 1.8), (3, 2, 80), (3, 3, 79),
       (4, 1, 2), (4, 2, 90), (4, 3, 67),
       (5, 1, 1.75), (5, 2, 86), (5, 3, 74)


INSERT INTO MEASURABLE(MeasurableName, MeasurableDescr)
VALUES('Height', 'Height of patient in  meters'),
       ('Weight', 'Weight of patient in kilograms'),
       ('Heart Rate', 'Heartbeats per minute of patient'),
       ('Temperature', 'Temperature of patient in degrees Fahrenheit'),
       ('Cholesterol Level', 'Level of patient''s cholesterol in milligrams per deciliter (mg/dL)')

