#!/usr/bin/env python3
from db_connection import *
from psycopg2.extras import DictCursor

'''
Validate staff based on username and password
'''
def checkLogin(login, password):
    conn = openConnection()
    # fetch cursor prepare to query the database
    curs = conn.cursor()
    # execute a SQL query
    if login is not None and password is not None:
        curs.execute("select username,firstname,lastname,email from Administrator where upper(username) = upper(trim(%s)) and password = %s", (login,password))
    result = curs.fetchone()
    curs.close
    conn.close
    return result


'''
List all the associated admissions records in the database by staff
'''
def findAdmissionsByAdmin(login):
    conn = openConnection()
    # fetch cursor prepare to query the database
    curs = conn.cursor(cursor_factory=DictCursor)
    if login is not None:
        curs.execute(("SELECT ad.admissionid admission_id, adt.admissiontypename admission_type,dept.deptname admission_department," 
                        " COALESCE(to_char(dischargedate,'DD-MM-YYYY'),'') discharge_date,pa.firstname||' '||pa.lastname patient,COALESCE(ad.fee::text,'') fee,COALESCE(ad.condition,'') condition" 
                        " FROM admission ad,admissiontype adt,department dept,patient pa"
                        " WHERE ad.admissiontype = adt.admissiontypeid"
                        " AND ad.department = dept.deptid"
                        " AND ad.patient = pa.patientid"
                        " AND upper(ad.administrator) = upper(%s)"
                        " ORDER BY ad.dischargedate DESC NULLS LAST, pa.firstname, pa.lastname, adt.admissiontypename DESC"), (login,))
    result = curs.fetchall()
    curs.close
    conn.close
    return result

'''
Find a list of admissions based on the searchString provided as parameter
See assignment description for search specification
'''
def findAdmissionsByCriteria(searchString):
    conn = openConnection()
    # fetch cursor prepare to query the database
    curs = conn.cursor(cursor_factory=DictCursor)
    searchString = "%"+searchString+"%"
    query = '''
    SELECT admission_id, admission_type, admission_department, discharge_date, fee, patient, condition 
    FROM 
        (SELECT ad.admissionid admission_id, adt.admissiontypename admission_type,
        dept.deptname admission_department,COALESCE(to_char(ad.dischargedate,'DD-MM-YYYY'),'') discharge_date, 
        COALESCE(ad.fee::text,'') fee, concat(pnt.firstname ,' ', pnt.lastname) patient, 
        COALESCE(ad.condition,'') condition
        FROM admissiontype adt, admission ad, department dept, patient pnt
        WHERE 
        adt.admissiontypeid = ad.admissiontype AND ad.department = dept.deptid AND ad.patient = pnt.patientid 
        AND ad.dischargedate > current_date - 730
        ORDER BY discharge_date ASC)
    WHERE 
    LOWER(patient) like LOWER(%s) OR LOWER(admission_type) LIKE LOWER(%s) OR LOWER(admission_department) LIKE LOWER(%s) OR LOWER(condition) LIKE LOWER(%s)
    '''
    curs.execute(query,(searchString,searchString,searchString,searchString))
    result = curs.fetchall()
    curs.close
    conn.close
    return result
    

'''
Add a new addmission 
'''
def addAdmission(type, department, patient, condition, admin):
    conn = openConnection()
    # fetch cursor prepare to query the database
    curs = conn.cursor()
    # execute a SQL query
    try:
        if type is not None and department is not None and patient is not None and condition is not None and admin is not None:
            query = """
            INSERT INTO Admission 
            (AdmissionType, Department, Fee, Patient, Administrator, DischargeDate, Condition) Values
            ((Select AdmissionTypeID from AdmissionType where admissiontypename = TRIM(INITCAP(%s))),
            (Select DeptId from Department where DeptName = TRIM(INITCAP(%s))), 
            %s,
            (Select PatientID from Patient where PatientID = TRIM(LOWER(%s))),
            (Select UserName from Administrator where UserName = TRIM(LOWER(%s))),
            %s, 
            %s)
            """
            values = (type,department,None,patient,admin,None,condition)
            curs.execute(query,values)
            conn.commit()
            result = True
        else:
            result = False
    except Exception as e:
        print(f"Error in updateAdmission: {e}")
        conn.rollback()
        result = False
    finally:
        curs.close()
        conn.close()
    
    return result


'''
Update an existing admission
'''
def updateAdmission(id, type, department, dischargeDate, fee, patient, condition):
    conn = openConnection()
    # fetch cursor prepare to query the database
    curs = conn.cursor()
    
    try:
        if id is not None and type is not None and department is not None and patient is not None and condition is not None:
            curs.execute("""
                UPDATE Admission 
                SET AdmissionType = (SELECT AdmissionTypeID FROM AdmissionType WHERE AdmissionTypeName = %s),
                    Department = (SELECT DeptId FROM Department WHERE DeptName = %s),
                    DischargeDate = %s,
                    Fee = %s,
                    Patient = (SELECT PatientID FROM Patient WHERE PatientID = %s),
                    Condition = %s
                WHERE AdmissionID = %s
            """, (type, department, dischargeDate, fee, patient, condition, id))
            
            conn.commit()
            result = True
        else:
            result = False
    except Exception as e:
        print(f"Error in updateAdmission: {e}")
        conn.rollback()
        result = False
    finally:
        curs.close()
        conn.close()
    
    return result
