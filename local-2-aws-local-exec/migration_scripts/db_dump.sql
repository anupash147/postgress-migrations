PGDMP      :                }           adventureworks    17.4 (Debian 17.4-1.pgdg120+2)    17.4 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16389    adventureworks    DATABASE     y   CREATE DATABASE adventureworks WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE adventureworks;
                     example    false                        2615    18190    hr    SCHEMA        CREATE SCHEMA hr;
    DROP SCHEMA hr;
                     example    false            	            2615    16531    humanresources    SCHEMA        CREATE SCHEMA humanresources;
    DROP SCHEMA humanresources;
                     example    false            �           0    0    SCHEMA humanresources    COMMENT     ^   COMMENT ON SCHEMA humanresources IS 'Contains objects related to employees and departments.';
                        example    false    9                        2615    18137    pe    SCHEMA        CREATE SCHEMA pe;
    DROP SCHEMA pe;
                     example    false                        2615    16436    person    SCHEMA        CREATE SCHEMA person;
    DROP SCHEMA person;
                     example    false            �           0    0    SCHEMA person    COMMENT     t   COMMENT ON SCHEMA person IS 'Contains objects related to names and addresses of customers, vendors, and employees';
                        example    false    8                        2615    18215    pr    SCHEMA        CREATE SCHEMA pr;
    DROP SCHEMA pr;
                     example    false            
            2615    16588 
   production    SCHEMA        CREATE SCHEMA production;
    DROP SCHEMA production;
                     example    false            �           0    0    SCHEMA production    COMMENT     g   COMMENT ON SCHEMA production IS 'Contains objects related to products, inventory, and manufacturing.';
                        example    false    10                        2615    18317    pu    SCHEMA        CREATE SCHEMA pu;
    DROP SCHEMA pu;
                     example    false                        2615    16818 
   purchasing    SCHEMA        CREATE SCHEMA purchasing;
    DROP SCHEMA purchasing;
                     example    false            �           0    0    SCHEMA purchasing    COMMENT     \   COMMENT ON SCHEMA purchasing IS 'Contains objects related to vendors and purchase orders.';
                        example    false    11                        2615    18338    sa    SCHEMA        CREATE SCHEMA sa;
    DROP SCHEMA sa;
                     example    false                        2615    16884    sales    SCHEMA        CREATE SCHEMA sales;
    DROP SCHEMA sales;
                     example    false            �           0    0    SCHEMA sales    COMMENT     j   COMMENT ON SCHEMA sales IS 'Contains objects related to customers, sales orders, and sales territories.';
                        example    false    12                        3079    16401 	   tablefunc 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
    DROP EXTENSION tablefunc;
                        false            �           0    0    EXTENSION tablefunc    COMMENT     `   COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
                             false    3                        3079    16390 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                        false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                             false    2            >           1247    16425    AccountNumber    DOMAIN     ?   CREATE DOMAIN public."AccountNumber" AS character varying(15);
 $   DROP DOMAIN public."AccountNumber";
       public               example    false            A           1247    16427    Flag    DOMAIN     1   CREATE DOMAIN public."Flag" AS boolean NOT NULL;
    DROP DOMAIN public."Flag";
       public               example    false            G           1247    16433    Name    DOMAIN     6   CREATE DOMAIN public."Name" AS character varying(50);
    DROP DOMAIN public."Name";
       public               example    false            D           1247    16430 	   NameStyle    DOMAIN     6   CREATE DOMAIN public."NameStyle" AS boolean NOT NULL;
     DROP DOMAIN public."NameStyle";
       public               example    false            ;           1247    16423    OrderNumber    DOMAIN     =   CREATE DOMAIN public."OrderNumber" AS character varying(25);
 "   DROP DOMAIN public."OrderNumber";
       public               example    false            J           1247    16435    Phone    DOMAIN     7   CREATE DOMAIN public."Phone" AS character varying(25);
    DROP DOMAIN public."Phone";
       public               example    false            �            1259    16533 
   department    TABLE     �   CREATE TABLE humanresources.department (
    departmentid integer NOT NULL,
    name public."Name" NOT NULL,
    groupname public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 &   DROP TABLE humanresources.department;
       humanresources         heap r       example    false    1095    1095    9            �           0    0    TABLE department    COMMENT     �   COMMENT ON TABLE humanresources.department IS 'Lookup table containing the departments within the Adventure Works Cycles company.';
          humanresources               example    false    253            �           0    0    COLUMN department.departmentid    COMMENT     c   COMMENT ON COLUMN humanresources.department.departmentid IS 'Primary key for Department records.';
          humanresources               example    false    253            �           0    0    COLUMN department.name    COMMENT     O   COMMENT ON COLUMN humanresources.department.name IS 'Name of the department.';
          humanresources               example    false    253            �           0    0    COLUMN department.groupname    COMMENT     o   COMMENT ON COLUMN humanresources.department.groupname IS 'Name of the group to which the department belongs.';
          humanresources               example    false    253            r           1259    18191    d    VIEW     �   CREATE VIEW hr.d AS
 SELECT departmentid AS id,
    departmentid,
    name,
    groupname,
    modifieddate
   FROM humanresources.department;
    DROP VIEW hr.d;
       hr       v       example    false    253    253    253    253    1095    1095    14            �            1259    16540    employee    TABLE     �  CREATE TABLE humanresources.employee (
    businessentityid integer NOT NULL,
    nationalidnumber character varying(15) NOT NULL,
    loginid character varying(256) NOT NULL,
    jobtitle character varying(50) NOT NULL,
    birthdate date NOT NULL,
    maritalstatus character(1) NOT NULL,
    gender character(1) NOT NULL,
    hiredate date NOT NULL,
    salariedflag public."Flag" DEFAULT true NOT NULL,
    vacationhours smallint DEFAULT 0 NOT NULL,
    sickleavehours smallint DEFAULT 0 NOT NULL,
    currentflag public."Flag" DEFAULT true NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    organizationnode character varying DEFAULT '/'::character varying,
    CONSTRAINT "CK_Employee_BirthDate" CHECK (((birthdate >= '1930-01-01'::date) AND (birthdate <= (now() - '18 years'::interval)))),
    CONSTRAINT "CK_Employee_Gender" CHECK ((upper((gender)::text) = ANY (ARRAY['M'::text, 'F'::text]))),
    CONSTRAINT "CK_Employee_HireDate" CHECK (((hiredate >= '1996-07-01'::date) AND (hiredate <= (now() + '1 day'::interval)))),
    CONSTRAINT "CK_Employee_MaritalStatus" CHECK ((upper((maritalstatus)::text) = ANY (ARRAY['M'::text, 'S'::text]))),
    CONSTRAINT "CK_Employee_SickLeaveHours" CHECK (((sickleavehours >= 0) AND (sickleavehours <= 120))),
    CONSTRAINT "CK_Employee_VacationHours" CHECK (((vacationhours >= '-40'::integer) AND (vacationhours <= 240)))
);
 $   DROP TABLE humanresources.employee;
       humanresources         heap r       example    false    1089    1089    2    9    1089    1089            �           0    0    TABLE employee    COMMENT     k   COMMENT ON TABLE humanresources.employee IS 'Employee information such as salary, department, and title.';
          humanresources               example    false    254            �           0    0     COLUMN employee.businessentityid    COMMENT     �   COMMENT ON COLUMN humanresources.employee.businessentityid IS 'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.';
          humanresources               example    false    254            �           0    0     COLUMN employee.nationalidnumber    COMMENT     �   COMMENT ON COLUMN humanresources.employee.nationalidnumber IS 'Unique national identification number such as a social security number.';
          humanresources               example    false    254            �           0    0    COLUMN employee.loginid    COMMENT     G   COMMENT ON COLUMN humanresources.employee.loginid IS 'Network login.';
          humanresources               example    false    254            �           0    0    COLUMN employee.jobtitle    COMMENT     k   COMMENT ON COLUMN humanresources.employee.jobtitle IS 'Work title such as Buyer or Sales Representative.';
          humanresources               example    false    254            �           0    0    COLUMN employee.birthdate    COMMENT     I   COMMENT ON COLUMN humanresources.employee.birthdate IS 'Date of birth.';
          humanresources               example    false    254            �           0    0    COLUMN employee.maritalstatus    COMMENT     V   COMMENT ON COLUMN humanresources.employee.maritalstatus IS 'M = Married, S = Single';
          humanresources               example    false    254            �           0    0    COLUMN employee.gender    COMMENT     L   COMMENT ON COLUMN humanresources.employee.gender IS 'M = Male, F = Female';
          humanresources               example    false    254            �           0    0    COLUMN employee.hiredate    COMMENT     V   COMMENT ON COLUMN humanresources.employee.hiredate IS 'Employee hired on this date.';
          humanresources               example    false    254            �           0    0    COLUMN employee.salariedflag    COMMENT     �   COMMENT ON COLUMN humanresources.employee.salariedflag IS 'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.';
          humanresources               example    false    254            �           0    0    COLUMN employee.vacationhours    COMMENT     b   COMMENT ON COLUMN humanresources.employee.vacationhours IS 'Number of available vacation hours.';
          humanresources               example    false    254            �           0    0    COLUMN employee.sickleavehours    COMMENT     e   COMMENT ON COLUMN humanresources.employee.sickleavehours IS 'Number of available sick leave hours.';
          humanresources               example    false    254            �           0    0    COLUMN employee.currentflag    COMMENT     U   COMMENT ON COLUMN humanresources.employee.currentflag IS '0 = Inactive, 1 = Active';
          humanresources               example    false    254            �           0    0     COLUMN employee.organizationnode    COMMENT     w   COMMENT ON COLUMN humanresources.employee.organizationnode IS 'Where the employee is located in corporate hierarchy.';
          humanresources               example    false    254            s           1259    18195    e    VIEW     V  CREATE VIEW hr.e AS
 SELECT businessentityid AS id,
    businessentityid,
    nationalidnumber,
    loginid,
    jobtitle,
    birthdate,
    maritalstatus,
    gender,
    hiredate,
    salariedflag,
    vacationhours,
    sickleavehours,
    currentflag,
    rowguid,
    modifieddate,
    organizationnode
   FROM humanresources.employee;
    DROP VIEW hr.e;
       hr       v       example    false    254    254    254    254    254    254    254    254    254    254    254    254    254    254    254    1089    1089    14            �            1259    16557    employeedepartmenthistory    TABLE     �  CREATE TABLE humanresources.employeedepartmenthistory (
    businessentityid integer NOT NULL,
    departmentid integer NOT NULL,
    shiftid integer NOT NULL,
    startdate date NOT NULL,
    enddate date,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);
 5   DROP TABLE humanresources.employeedepartmenthistory;
       humanresources         heap r       example    false    9            �           0    0    TABLE employeedepartmenthistory    COMMENT     _   COMMENT ON TABLE humanresources.employeedepartmenthistory IS 'Employee department transfers.';
          humanresources               example    false    255            �           0    0 1   COLUMN employeedepartmenthistory.businessentityid    COMMENT     �   COMMENT ON COLUMN humanresources.employeedepartmenthistory.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';
          humanresources               example    false    255            �           0    0 -   COLUMN employeedepartmenthistory.departmentid    COMMENT     �   COMMENT ON COLUMN humanresources.employeedepartmenthistory.departmentid IS 'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.';
          humanresources               example    false    255            �           0    0 (   COLUMN employeedepartmenthistory.shiftid    COMMENT     �   COMMENT ON COLUMN humanresources.employeedepartmenthistory.shiftid IS 'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.';
          humanresources               example    false    255            �           0    0 *   COLUMN employeedepartmenthistory.startdate    COMMENT     }   COMMENT ON COLUMN humanresources.employeedepartmenthistory.startdate IS 'Date the employee started work in the department.';
          humanresources               example    false    255            �           0    0 (   COLUMN employeedepartmenthistory.enddate    COMMENT     �   COMMENT ON COLUMN humanresources.employeedepartmenthistory.enddate IS 'Date the employee left the department. NULL = Current department.';
          humanresources               example    false    255            t           1259    18199    edh    VIEW     �   CREATE VIEW hr.edh AS
 SELECT businessentityid AS id,
    businessentityid,
    departmentid,
    shiftid,
    startdate,
    enddate,
    modifieddate
   FROM humanresources.employeedepartmenthistory;
    DROP VIEW hr.edh;
       hr       v       example    false    255    255    255    255    255    255    14                        1259    16562    employeepayhistory    TABLE     �  CREATE TABLE humanresources.employeepayhistory (
    businessentityid integer NOT NULL,
    ratechangedate timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    payfrequency smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((payfrequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);
 .   DROP TABLE humanresources.employeepayhistory;
       humanresources         heap r       example    false    9            �           0    0    TABLE employeepayhistory    COMMENT     O   COMMENT ON TABLE humanresources.employeepayhistory IS 'Employee pay history.';
          humanresources               example    false    256            �           0    0 *   COLUMN employeepayhistory.businessentityid    COMMENT     �   COMMENT ON COLUMN humanresources.employeepayhistory.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';
          humanresources               example    false    256            �           0    0 (   COLUMN employeepayhistory.ratechangedate    COMMENT     m   COMMENT ON COLUMN humanresources.employeepayhistory.ratechangedate IS 'Date the change in pay is effective';
          humanresources               example    false    256            �           0    0    COLUMN employeepayhistory.rate    COMMENT     S   COMMENT ON COLUMN humanresources.employeepayhistory.rate IS 'Salary hourly rate.';
          humanresources               example    false    256            �           0    0 &   COLUMN employeepayhistory.payfrequency    COMMENT     �   COMMENT ON COLUMN humanresources.employeepayhistory.payfrequency IS '1 = Salary received monthly, 2 = Salary received biweekly';
          humanresources               example    false    256            u           1259    18203    eph    VIEW     �   CREATE VIEW hr.eph AS
 SELECT businessentityid AS id,
    businessentityid,
    ratechangedate,
    rate,
    payfrequency,
    modifieddate
   FROM humanresources.employeepayhistory;
    DROP VIEW hr.eph;
       hr       v       example    false    256    256    256    256    256    14                       1259    16571    jobcandidate    TABLE     �   CREATE TABLE humanresources.jobcandidate (
    jobcandidateid integer NOT NULL,
    businessentityid integer,
    resume xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 (   DROP TABLE humanresources.jobcandidate;
       humanresources         heap r       example    false    9            �           0    0    TABLE jobcandidate    COMMENT     q   COMMENT ON TABLE humanresources.jobcandidate IS 'RÃ©sumÃ©s submitted to Human Resources by job applicants.';
          humanresources               example    false    258            �           0    0 "   COLUMN jobcandidate.jobcandidateid    COMMENT     i   COMMENT ON COLUMN humanresources.jobcandidate.jobcandidateid IS 'Primary key for JobCandidate records.';
          humanresources               example    false    258            �           0    0 $   COLUMN jobcandidate.businessentityid    COMMENT     �   COMMENT ON COLUMN humanresources.jobcandidate.businessentityid IS 'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.';
          humanresources               example    false    258            �           0    0    COLUMN jobcandidate.resume    COMMENT     W   COMMENT ON COLUMN humanresources.jobcandidate.resume IS 'RÃ©sumÃ© in XML format.';
          humanresources               example    false    258            v           1259    18207    jc    VIEW     �   CREATE VIEW hr.jc AS
 SELECT jobcandidateid AS id,
    jobcandidateid,
    businessentityid,
    resume,
    modifieddate
   FROM humanresources.jobcandidate;
    DROP VIEW hr.jc;
       hr       v       example    false    258    258    258    258    14                       1259    16579    shift    TABLE       CREATE TABLE humanresources.shift (
    shiftid integer NOT NULL,
    name public."Name" NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE humanresources.shift;
       humanresources         heap r       example    false    1095    9            �           0    0    TABLE shift    COMMENT     E   COMMENT ON TABLE humanresources.shift IS 'Work shift lookup table.';
          humanresources               example    false    260            �           0    0    COLUMN shift.shiftid    COMMENT     T   COMMENT ON COLUMN humanresources.shift.shiftid IS 'Primary key for Shift records.';
          humanresources               example    false    260            �           0    0    COLUMN shift.name    COMMENT     E   COMMENT ON COLUMN humanresources.shift.name IS 'Shift description.';
          humanresources               example    false    260            �           0    0    COLUMN shift.starttime    COMMENT     I   COMMENT ON COLUMN humanresources.shift.starttime IS 'Shift start time.';
          humanresources               example    false    260            �           0    0    COLUMN shift.endtime    COMMENT     E   COMMENT ON COLUMN humanresources.shift.endtime IS 'Shift end time.';
          humanresources               example    false    260            w           1259    18211    s    VIEW     �   CREATE VIEW hr.s AS
 SELECT shiftid AS id,
    shiftid,
    name,
    starttime,
    endtime,
    modifieddate
   FROM humanresources.shift;
    DROP VIEW hr.s;
       hr       v       example    false    260    260    260    260    260    1095    14            �            1259    16532    department_departmentid_seq    SEQUENCE     �   CREATE SEQUENCE humanresources.department_departmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE humanresources.department_departmentid_seq;
       humanresources               example    false    9    253            �           0    0    department_departmentid_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE humanresources.department_departmentid_seq OWNED BY humanresources.department.departmentid;
          humanresources               example    false    252                       1259    16570    jobcandidate_jobcandidateid_seq    SEQUENCE     �   CREATE SEQUENCE humanresources.jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE humanresources.jobcandidate_jobcandidateid_seq;
       humanresources               example    false    9    258            �           0    0    jobcandidate_jobcandidateid_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE humanresources.jobcandidate_jobcandidateid_seq OWNED BY humanresources.jobcandidate.jobcandidateid;
          humanresources               example    false    257                       1259    16578    shift_shiftid_seq    SEQUENCE     �   CREATE SEQUENCE humanresources.shift_shiftid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE humanresources.shift_shiftid_seq;
       humanresources               example    false    9    260            �           0    0    shift_shiftid_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE humanresources.shift_shiftid_seq OWNED BY humanresources.shift.shiftid;
          humanresources               example    false    259            �            1259    16466    address    TABLE     �  CREATE TABLE person.address (
    addressid integer NOT NULL,
    addressline1 character varying(60) NOT NULL,
    addressline2 character varying(60),
    city character varying(30) NOT NULL,
    stateprovinceid integer NOT NULL,
    postalcode character varying(15) NOT NULL,
    spatiallocation character varying(44),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE person.address;
       person         heap r       example    false    2    8            �           0    0    TABLE address    COMMENT     h   COMMENT ON TABLE person.address IS 'Street address information for customers, employees, and vendors.';
          person               example    false    238            �           0    0    COLUMN address.addressid    COMMENT     R   COMMENT ON COLUMN person.address.addressid IS 'Primary key for Address records.';
          person               example    false    238            �           0    0    COLUMN address.addressline1    COMMENT     O   COMMENT ON COLUMN person.address.addressline1 IS 'First street address line.';
          person               example    false    238            �           0    0    COLUMN address.addressline2    COMMENT     P   COMMENT ON COLUMN person.address.addressline2 IS 'Second street address line.';
          person               example    false    238            �           0    0    COLUMN address.city    COMMENT     >   COMMENT ON COLUMN person.address.city IS 'Name of the city.';
          person               example    false    238            �           0    0    COLUMN address.stateprovinceid    COMMENT     �   COMMENT ON COLUMN person.address.stateprovinceid IS 'Unique identification number for the state or province. Foreign key to StateProvince table.';
          person               example    false    238            �           0    0    COLUMN address.postalcode    COMMENT     V   COMMENT ON COLUMN person.address.postalcode IS 'Postal code for the street address.';
          person               example    false    238            �           0    0    COLUMN address.spatiallocation    COMMENT     _   COMMENT ON COLUMN person.address.spatiallocation IS 'Latitude and longitude of this address.';
          person               example    false    238            �            1259    16481    businessentityaddress    TABLE       CREATE TABLE person.businessentityaddress (
    businessentityid integer NOT NULL,
    addressid integer NOT NULL,
    addresstypeid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 )   DROP TABLE person.businessentityaddress;
       person         heap r       example    false    2    8            �           0    0    TABLE businessentityaddress    COMMENT     �   COMMENT ON TABLE person.businessentityaddress IS 'Cross-reference table mapping customers, vendors, and employees to their addresses.';
          person               example    false    241            �           0    0 -   COLUMN businessentityaddress.businessentityid    COMMENT     �   COMMENT ON COLUMN person.businessentityaddress.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';
          person               example    false    241                        0    0 &   COLUMN businessentityaddress.addressid    COMMENT     n   COMMENT ON COLUMN person.businessentityaddress.addressid IS 'Primary key. Foreign key to Address.AddressID.';
          person               example    false    241                       0    0 *   COLUMN businessentityaddress.addresstypeid    COMMENT     z   COMMENT ON COLUMN person.businessentityaddress.addresstypeid IS 'Primary key. Foreign key to AddressType.AddressTypeID.';
          person               example    false    241            �            1259    16525    countryregion    TABLE     �   CREATE TABLE person.countryregion (
    countryregioncode character varying(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE person.countryregion;
       person         heap r       example    false    1095    8                       0    0    TABLE countryregion    COMMENT     v   COMMENT ON TABLE person.countryregion IS 'Lookup table containing the ISO standard codes for countries and regions.';
          person               example    false    251                       0    0 &   COLUMN countryregion.countryregioncode    COMMENT     l   COMMENT ON COLUMN person.countryregion.countryregioncode IS 'ISO standard code for countries and regions.';
          person               example    false    251                       0    0    COLUMN countryregion.name    COMMENT     J   COMMENT ON COLUMN person.countryregion.name IS 'Country or region name.';
          person               example    false    251            �            1259    16500    emailaddress    TABLE       CREATE TABLE person.emailaddress (
    businessentityid integer NOT NULL,
    emailaddressid integer NOT NULL,
    emailaddress character varying(50),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
     DROP TABLE person.emailaddress;
       person         heap r       example    false    2    8                       0    0    TABLE emailaddress    COMMENT     I   COMMENT ON TABLE person.emailaddress IS 'Where to send a person email.';
          person               example    false    246                       0    0 $   COLUMN emailaddress.businessentityid    COMMENT     �   COMMENT ON COLUMN person.emailaddress.businessentityid IS 'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID';
          person               example    false    246                       0    0 "   COLUMN emailaddress.emailaddressid    COMMENT     b   COMMENT ON COLUMN person.emailaddress.emailaddressid IS 'Primary key. ID of this email address.';
          person               example    false    246                       0    0     COLUMN emailaddress.emailaddress    COMMENT     X   COMMENT ON COLUMN person.emailaddress.emailaddress IS 'E-mail address for the person.';
          person               example    false    246            �            1259    16444    person    TABLE     V  CREATE TABLE person.person (
    businessentityid integer NOT NULL,
    persontype character(2) NOT NULL,
    namestyle public."NameStyle" DEFAULT false NOT NULL,
    title character varying(8),
    firstname public."Name" NOT NULL,
    middlename public."Name",
    lastname public."Name" NOT NULL,
    suffix character varying(10),
    emailpromotion integer DEFAULT 0 NOT NULL,
    additionalcontactinfo xml,
    demographics xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (((emailpromotion >= 0) AND (emailpromotion <= 2))),
    CONSTRAINT "CK_Person_PersonType" CHECK (((persontype IS NULL) OR (upper((persontype)::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text]))))
);
    DROP TABLE person.person;
       person         heap r       example    false    1092    2    1095    8    1095    1095    1092            	           0    0    TABLE person    COMMENT     �   COMMENT ON TABLE person.person IS 'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.';
          person               example    false    234            
           0    0    COLUMN person.businessentityid    COMMENT     W   COMMENT ON COLUMN person.person.businessentityid IS 'Primary key for Person records.';
          person               example    false    234                       0    0    COLUMN person.persontype    COMMENT     �   COMMENT ON COLUMN person.person.persontype IS 'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact';
          person               example    false    234                       0    0    COLUMN person.namestyle    COMMENT     �   COMMENT ON COLUMN person.person.namestyle IS '0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.';
          person               example    false    234                       0    0    COLUMN person.title    COMMENT     V   COMMENT ON COLUMN person.person.title IS 'A courtesy title. For example, Mr. or Ms.';
          person               example    false    234                       0    0    COLUMN person.firstname    COMMENT     J   COMMENT ON COLUMN person.person.firstname IS 'First name of the person.';
          person               example    false    234                       0    0    COLUMN person.middlename    COMMENT     ^   COMMENT ON COLUMN person.person.middlename IS 'Middle name or middle initial of the person.';
          person               example    false    234                       0    0    COLUMN person.lastname    COMMENT     H   COMMENT ON COLUMN person.person.lastname IS 'Last name of the person.';
          person               example    false    234                       0    0    COLUMN person.suffix    COMMENT     U   COMMENT ON COLUMN person.person.suffix IS 'Surname suffix. For example, Sr. or Jr.';
          person               example    false    234                       0    0    COLUMN person.emailpromotion    COMMENT       COMMENT ON COLUMN person.person.emailpromotion IS '0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners.';
          person               example    false    234                       0    0 #   COLUMN person.additionalcontactinfo    COMMENT     �   COMMENT ON COLUMN person.person.additionalcontactinfo IS 'Additional contact information about the person stored in xml format.';
          person               example    false    234                       0    0    COLUMN person.demographics    COMMENT     �   COMMENT ON COLUMN person.person.demographics IS 'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.';
          person               example    false    234            �            1259    16519    personphone    TABLE     �   CREATE TABLE person.personphone (
    businessentityid integer NOT NULL,
    phonenumber public."Phone" NOT NULL,
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE person.personphone;
       person         heap r       example    false    1098    8                       0    0    TABLE personphone    COMMENT     Q   COMMENT ON TABLE person.personphone IS 'Telephone number and type of a person.';
          person               example    false    250                       0    0 #   COLUMN personphone.businessentityid    COMMENT     �   COMMENT ON COLUMN person.personphone.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';
          person               example    false    250                       0    0    COLUMN personphone.phonenumber    COMMENT     _   COMMENT ON COLUMN person.personphone.phonenumber IS 'Telephone number identification number.';
          person               example    false    250                       0    0 $   COLUMN personphone.phonenumbertypeid    COMMENT     �   COMMENT ON COLUMN person.personphone.phonenumbertypeid IS 'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.';
          person               example    false    250            �            1259    16512    phonenumbertype    TABLE     �   CREATE TABLE person.phonenumbertype (
    phonenumbertypeid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 #   DROP TABLE person.phonenumbertype;
       person         heap r       example    false    8    1095                       0    0    TABLE phonenumbertype    COMMENT     P   COMMENT ON TABLE person.phonenumbertype IS 'Type of phone number of a person.';
          person               example    false    249                       0    0 (   COLUMN phonenumbertype.phonenumbertypeid    COMMENT     p   COMMENT ON COLUMN person.phonenumbertype.phonenumbertypeid IS 'Primary key for telephone number type records.';
          person               example    false    249                       0    0    COLUMN phonenumbertype.name    COMMENT     V   COMMENT ON COLUMN person.phonenumbertype.name IS 'Name of the telephone number type';
          person               example    false    249            �            1259    16456    stateprovince    TABLE     �  CREATE TABLE person.stateprovince (
    stateprovinceid integer NOT NULL,
    stateprovincecode character(3) NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    isonlystateprovinceflag public."Flag" DEFAULT true NOT NULL,
    name public."Name" NOT NULL,
    territoryid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE person.stateprovince;
       person         heap r       example    false    1089    2    1095    8    1089                       0    0    TABLE stateprovince    COMMENT     M   COMMENT ON TABLE person.stateprovince IS 'State and province lookup table.';
          person               example    false    236                       0    0 $   COLUMN stateprovince.stateprovinceid    COMMENT     d   COMMENT ON COLUMN person.stateprovince.stateprovinceid IS 'Primary key for StateProvince records.';
          person               example    false    236                       0    0 &   COLUMN stateprovince.stateprovincecode    COMMENT     d   COMMENT ON COLUMN person.stateprovince.stateprovincecode IS 'ISO standard state or province code.';
          person               example    false    236                       0    0 &   COLUMN stateprovince.countryregioncode    COMMENT     �   COMMENT ON COLUMN person.stateprovince.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';
          person               example    false    236                        0    0 ,   COLUMN stateprovince.isonlystateprovinceflag    COMMENT     �   COMMENT ON COLUMN person.stateprovince.isonlystateprovinceflag IS '0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.';
          person               example    false    236            !           0    0    COLUMN stateprovince.name    COMMENT     Q   COMMENT ON COLUMN person.stateprovince.name IS 'State or province description.';
          person               example    false    236            "           0    0     COLUMN stateprovince.territoryid    COMMENT     �   COMMENT ON COLUMN person.stateprovince.territoryid IS 'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.';
          person               example    false    236            Q           1259    18011 	   vemployee    VIEW     |  CREATE VIEW humanresources.vemployee AS
 SELECT e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    p.additionalcontactinfo
   FROM ((((((((humanresources.employee e
     JOIN person.person p ON ((p.businessentityid = e.businessentityid)))
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = e.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pp.phonenumbertypeid = pnt.phonenumbertypeid)))
     LEFT JOIN person.emailaddress ea ON ((p.businessentityid = ea.businessentityid)));
 $   DROP VIEW humanresources.vemployee;
       humanresources       v       example    false    234    238    238    238    238    238    238    236    236    236    234    234    234    234    234    234    234    254    254    251    251    250    250    250    249    249    246    246    241    241    1095    1095    1098    1095    1095    1095    1095    9            R           1259    18016    vemployeedepartment    VIEW     0  CREATE VIEW humanresources.vemployeedepartment AS
 SELECT e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    d.name AS department,
    d.groupname,
    edh.startdate
   FROM (((humanresources.employee e
     JOIN person.person p ON ((p.businessentityid = e.businessentityid)))
     JOIN humanresources.employeedepartmenthistory edh ON ((e.businessentityid = edh.businessentityid)))
     JOIN humanresources.department d ON ((edh.departmentid = d.departmentid)))
  WHERE (edh.enddate IS NULL);
 .   DROP VIEW humanresources.vemployeedepartment;
       humanresources       v       example    false    234    234    234    234    234    234    253    253    253    254    254    255    255    255    255    9    1095    1095    1095    1095    1095            S           1259    18021    vemployeedepartmenthistory    VIEW     q  CREATE VIEW humanresources.vemployeedepartmenthistory AS
 SELECT e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    s.name AS shift,
    d.name AS department,
    d.groupname,
    edh.startdate,
    edh.enddate
   FROM ((((humanresources.employee e
     JOIN person.person p ON ((p.businessentityid = e.businessentityid)))
     JOIN humanresources.employeedepartmenthistory edh ON ((e.businessentityid = edh.businessentityid)))
     JOIN humanresources.department d ON ((edh.departmentid = d.departmentid)))
     JOIN humanresources.shift s ON ((s.shiftid = edh.shiftid)));
 5   DROP VIEW humanresources.vemployeedepartmenthistory;
       humanresources       v       example    false    260    260    255    255    255    255    255    254    253    253    253    234    234    234    234    234    234    1095    1095    1095    1095    1095    9    1095            V           1259    18036    vjobcandidate    VIEW     �
  CREATE VIEW humanresources.vjobcandidate AS
 SELECT jobcandidateid,
    businessentityid,
    ((xpath('/n:Resume/n:Name/n:Name.Prefix/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Prefix",
    ((xpath('/n:Resume/n:Name/n:Name.First/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.First",
    ((xpath('/n:Resume/n:Name/n:Name.Middle/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Middle",
    ((xpath('/n:Resume/n:Name/n:Name.Last/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Last",
    ((xpath('/n:Resume/n:Name/n:Name.Suffix/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Suffix",
    ((xpath('/n:Resume/n:Skills/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "Skills",
    ((xpath('n:Address/n:Addr.Type/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Addr.Type",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.CountryRegion/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.CountryRegion",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.State/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.State",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.City/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.City",
    ((xpath('n:Address/n:Addr.PostalCode/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(20) AS "Addr.PostalCode",
    ((xpath('/n:Resume/n:EMail/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "EMail",
    ((xpath('/n:Resume/n:WebSite/text()'::text, resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "WebSite",
    modifieddate
   FROM humanresources.jobcandidate;
 (   DROP VIEW humanresources.vjobcandidate;
       humanresources       v       example    false    258    258    258    258    9            X           1259    18046    vjobcandidateeducation    VIEW     
  CREATE VIEW humanresources.vjobcandidateeducation AS
 SELECT jobcandidateid,
    ((xpath('/root/ns:Education/ns:Edu.Level/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Level",
    (((xpath('/root/ns:Education/ns:Edu.StartDate/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(20))::date AS "Edu.StartDate",
    (((xpath('/root/ns:Education/ns:Edu.EndDate/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(20))::date AS "Edu.EndDate",
    ((xpath('/root/ns:Education/ns:Edu.Degree/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Degree",
    ((xpath('/root/ns:Education/ns:Edu.Major/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Major",
    ((xpath('/root/ns:Education/ns:Edu.Minor/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Minor",
    ((xpath('/root/ns:Education/ns:Edu.GPA/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(5) AS "Edu.GPA",
    ((xpath('/root/ns:Education/ns:Edu.GPAScale/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(5) AS "Edu.GPAScale",
    ((xpath('/root/ns:Education/ns:Edu.School/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.School",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.CountryRegion",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.State/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.State",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.City/text()'::text, doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.City"
   FROM ( SELECT unnesting.jobcandidateid,
            ((('<root xmlns:ns="http://adventureworks.com">'::text || ((unnesting.education)::character varying)::text) || '</root>'::text))::xml AS doc
           FROM ( SELECT jobcandidate.jobcandidateid,
                    unnest(xpath('/ns:Resume/ns:Education'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])) AS education
                   FROM humanresources.jobcandidate) unnesting) jc;
 1   DROP VIEW humanresources.vjobcandidateeducation;
       humanresources       v       example    false    258    258    9            W           1259    18041    vjobcandidateemployment    VIEW     X	  CREATE VIEW humanresources.vjobcandidateemployment AS
 SELECT jobcandidateid,
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.StartDate/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.StartDate",
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.EndDate/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.EndDate",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.OrgName/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.OrgName",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.JobTitle/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.JobTitle",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Responsibility/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Responsibility",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.FunctionCategory/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.FunctionCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.IndustryCategory/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.IndustryCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.CountryRegion",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.State/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.State",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.City/text()'::text, resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.City"
   FROM humanresources.jobcandidate;
 2   DROP VIEW humanresources.vjobcandidateemployment;
       humanresources       v       example    false    258    258    9            e           1259    18138    a    VIEW     �   CREATE VIEW pe.a AS
 SELECT addressid AS id,
    addressid,
    addressline1,
    addressline2,
    city,
    stateprovinceid,
    postalcode,
    spatiallocation,
    rowguid,
    modifieddate
   FROM person.address;
    DROP VIEW pe.a;
       pe       v       example    false    238    238    238    238    238    238    238    238    238    13            �            1259    16473    addresstype    TABLE     �   CREATE TABLE person.addresstype (
    addresstypeid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE person.addresstype;
       person         heap r       example    false    2    8    1095            #           0    0    TABLE addresstype    COMMENT     Z   COMMENT ON TABLE person.addresstype IS 'Types of addresses stored in the Address table.';
          person               example    false    240            $           0    0     COLUMN addresstype.addresstypeid    COMMENT     ^   COMMENT ON COLUMN person.addresstype.addresstypeid IS 'Primary key for AddressType records.';
          person               example    false    240            %           0    0    COLUMN addresstype.name    COMMENT     s   COMMENT ON COLUMN person.addresstype.name IS 'Address type description. For example, Billing, Home, or Shipping.';
          person               example    false    240            f           1259    18142    at    VIEW     �   CREATE VIEW pe.at AS
 SELECT addresstypeid AS id,
    addresstypeid,
    name,
    rowguid,
    modifieddate
   FROM person.addresstype;
    DROP VIEW pe.at;
       pe       v       example    false    240    240    240    240    13    1095            �            1259    16438    businessentity    TABLE     �   CREATE TABLE person.businessentity (
    businessentityid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 "   DROP TABLE person.businessentity;
       person         heap r       example    false    2    8            &           0    0    TABLE businessentity    COMMENT     �   COMMENT ON TABLE person.businessentity IS 'Source of the ID that connects vendors, customers, and employees with address and contact information.';
          person               example    false    233            '           0    0 &   COLUMN businessentity.businessentityid    COMMENT     v   COMMENT ON COLUMN person.businessentity.businessentityid IS 'Primary key for all customers, vendors, and employees.';
          person               example    false    233            g           1259    18146    be    VIEW     �   CREATE VIEW pe.be AS
 SELECT businessentityid AS id,
    businessentityid,
    rowguid,
    modifieddate
   FROM person.businessentity;
    DROP VIEW pe.be;
       pe       v       example    false    233    233    233    13            h           1259    18150    bea    VIEW     �   CREATE VIEW pe.bea AS
 SELECT businessentityid AS id,
    businessentityid,
    addressid,
    addresstypeid,
    rowguid,
    modifieddate
   FROM person.businessentityaddress;
    DROP VIEW pe.bea;
       pe       v       example    false    241    241    241    241    241    13            �            1259    16494    businessentitycontact    TABLE       CREATE TABLE person.businessentitycontact (
    businessentityid integer NOT NULL,
    personid integer NOT NULL,
    contacttypeid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 )   DROP TABLE person.businessentitycontact;
       person         heap r       example    false    2    8            (           0    0    TABLE businessentitycontact    COMMENT     {   COMMENT ON TABLE person.businessentitycontact IS 'Cross-reference table mapping stores, vendors, and employees to people';
          person               example    false    244            )           0    0 -   COLUMN businessentitycontact.businessentityid    COMMENT     �   COMMENT ON COLUMN person.businessentitycontact.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';
          person               example    false    244            *           0    0 %   COLUMN businessentitycontact.personid    COMMENT     s   COMMENT ON COLUMN person.businessentitycontact.personid IS 'Primary key. Foreign key to Person.BusinessEntityID.';
          person               example    false    244            +           0    0 *   COLUMN businessentitycontact.contacttypeid    COMMENT     {   COMMENT ON COLUMN person.businessentitycontact.contacttypeid IS 'Primary key.  Foreign key to ContactType.ContactTypeID.';
          person               example    false    244            i           1259    18154    bec    VIEW     �   CREATE VIEW pe.bec AS
 SELECT businessentityid AS id,
    businessentityid,
    personid,
    contacttypeid,
    rowguid,
    modifieddate
   FROM person.businessentitycontact;
    DROP VIEW pe.bec;
       pe       v       example    false    244    244    244    244    244    13            k           1259    18162    cr    VIEW     i   CREATE VIEW pe.cr AS
 SELECT countryregioncode,
    name,
    modifieddate
   FROM person.countryregion;
    DROP VIEW pe.cr;
       pe       v       example    false    251    251    251    1095    13            �            1259    16487    contacttype    TABLE     �   CREATE TABLE person.contacttype (
    contacttypeid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE person.contacttype;
       person         heap r       example    false    8    1095            ,           0    0    TABLE contacttype    COMMENT     i   COMMENT ON TABLE person.contacttype IS 'Lookup table containing the types of business entity contacts.';
          person               example    false    243            -           0    0     COLUMN contacttype.contacttypeid    COMMENT     ^   COMMENT ON COLUMN person.contacttype.contacttypeid IS 'Primary key for ContactType records.';
          person               example    false    243            .           0    0    COLUMN contacttype.name    COMMENT     J   COMMENT ON COLUMN person.contacttype.name IS 'Contact type description.';
          person               example    false    243            j           1259    18158    ct    VIEW     |   CREATE VIEW pe.ct AS
 SELECT contacttypeid AS id,
    contacttypeid,
    name,
    modifieddate
   FROM person.contacttype;
    DROP VIEW pe.ct;
       pe       v       example    false    243    243    243    13    1095            l           1259    18166    e    VIEW     �   CREATE VIEW pe.e AS
 SELECT emailaddressid AS id,
    businessentityid,
    emailaddressid,
    emailaddress,
    rowguid,
    modifieddate
   FROM person.emailaddress;
    DROP VIEW pe.e;
       pe       v       example    false    246    246    246    246    246    13            n           1259    18174    p    VIEW     #  CREATE VIEW pe.p AS
 SELECT businessentityid AS id,
    businessentityid,
    persontype,
    namestyle,
    title,
    firstname,
    middlename,
    lastname,
    suffix,
    emailpromotion,
    additionalcontactinfo,
    demographics,
    rowguid,
    modifieddate
   FROM person.person;
    DROP VIEW pe.p;
       pe       v       example    false    234    234    234    234    234    234    234    234    234    234    234    234    234    1095    1092    1095    1095    13            �            1259    16506    password    TABLE     -  CREATE TABLE person.password (
    businessentityid integer NOT NULL,
    passwordhash character varying(128) NOT NULL,
    passwordsalt character varying(10) NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE person.password;
       person         heap r       example    false    2    8            /           0    0    TABLE password    COMMENT     Q   COMMENT ON TABLE person.password IS 'One way hashed authentication information';
          person               example    false    247            0           0    0    COLUMN password.passwordhash    COMMENT     V   COMMENT ON COLUMN person.password.passwordhash IS 'Password for the e-mail account.';
          person               example    false    247            1           0    0    COLUMN password.passwordsalt    COMMENT     �   COMMENT ON COLUMN person.password.passwordsalt IS 'Random value concatenated with the password string before the password is hashed.';
          person               example    false    247            m           1259    18170    pa    VIEW     �   CREATE VIEW pe.pa AS
 SELECT businessentityid AS id,
    businessentityid,
    passwordhash,
    passwordsalt,
    rowguid,
    modifieddate
   FROM person.password;
    DROP VIEW pe.pa;
       pe       v       example    false    247    247    247    247    247    13            p           1259    18182    pnt    VIEW     �   CREATE VIEW pe.pnt AS
 SELECT phonenumbertypeid AS id,
    phonenumbertypeid,
    name,
    modifieddate
   FROM person.phonenumbertype;
    DROP VIEW pe.pnt;
       pe       v       example    false    249    249    249    1095    13            o           1259    18178    pp    VIEW     �   CREATE VIEW pe.pp AS
 SELECT businessentityid AS id,
    businessentityid,
    phonenumber,
    phonenumbertypeid,
    modifieddate
   FROM person.personphone;
    DROP VIEW pe.pp;
       pe       v       example    false    250    250    250    250    1098    13            q           1259    18186    sp    VIEW     �   CREATE VIEW pe.sp AS
 SELECT stateprovinceid AS id,
    stateprovinceid,
    stateprovincecode,
    countryregioncode,
    isonlystateprovinceflag,
    name,
    territoryid,
    rowguid,
    modifieddate
   FROM person.stateprovince;
    DROP VIEW pe.sp;
       pe       v       example    false    236    236    236    236    236    236    236    236    1089    1095    13            �            1259    16465    address_addressid_seq    SEQUENCE     �   CREATE SEQUENCE person.address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE person.address_addressid_seq;
       person               example    false    8    238            2           0    0    address_addressid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE person.address_addressid_seq OWNED BY person.address.addressid;
          person               example    false    237            �            1259    16472    addresstype_addresstypeid_seq    SEQUENCE     �   CREATE SEQUENCE person.addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE person.addresstype_addresstypeid_seq;
       person               example    false    240    8            3           0    0    addresstype_addresstypeid_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE person.addresstype_addresstypeid_seq OWNED BY person.addresstype.addresstypeid;
          person               example    false    239            �            1259    16437 #   businessentity_businessentityid_seq    SEQUENCE     �   CREATE SEQUENCE person.businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE person.businessentity_businessentityid_seq;
       person               example    false    8    233            4           0    0 #   businessentity_businessentityid_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE person.businessentity_businessentityid_seq OWNED BY person.businessentity.businessentityid;
          person               example    false    232            �            1259    16486    contacttype_contacttypeid_seq    SEQUENCE     �   CREATE SEQUENCE person.contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE person.contacttype_contacttypeid_seq;
       person               example    false    8    243            5           0    0    contacttype_contacttypeid_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE person.contacttype_contacttypeid_seq OWNED BY person.contacttype.contacttypeid;
          person               example    false    242            �            1259    16499    emailaddress_emailaddressid_seq    SEQUENCE     �   CREATE SEQUENCE person.emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE person.emailaddress_emailaddressid_seq;
       person               example    false    246    8            6           0    0    emailaddress_emailaddressid_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE person.emailaddress_emailaddressid_seq OWNED BY person.emailaddress.emailaddressid;
          person               example    false    245            �            1259    16511 %   phonenumbertype_phonenumbertypeid_seq    SEQUENCE     �   CREATE SEQUENCE person.phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE person.phonenumbertype_phonenumbertypeid_seq;
       person               example    false    8    249            7           0    0 %   phonenumbertype_phonenumbertypeid_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE person.phonenumbertype_phonenumbertypeid_seq OWNED BY person.phonenumbertype.phonenumbertypeid;
          person               example    false    248            �            1259    16455 !   stateprovince_stateprovinceid_seq    SEQUENCE     �   CREATE SEQUENCE person.stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE person.stateprovince_stateprovinceid_seq;
       person               example    false    236    8            8           0    0 !   stateprovince_stateprovinceid_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE person.stateprovince_stateprovinceid_seq OWNED BY person.stateprovince.stateprovinceid;
          person               example    false    235            P           1259    18006    vadditionalcontactinfo    VIEW     �  CREATE VIEW person.vadditionalcontactinfo AS
 SELECT p.businessentityid,
    p.firstname,
    p.middlename,
    p.lastname,
    (xpath('(act:telephoneNumber)[1]/act:number/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS telephonenumber,
    btrim((((xpath('(act:telephoneNumber)[1]/act:SpecialInstructions/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1])::character varying)::text) AS telephonespecialinstructions,
    (xpath('(act:homePostalAddress)[1]/act:Street/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS street,
    (xpath('(act:homePostalAddress)[1]/act:City/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS city,
    (xpath('(act:homePostalAddress)[1]/act:StateProvince/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS stateprovince,
    (xpath('(act:homePostalAddress)[1]/act:PostalCode/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS postalcode,
    (xpath('(act:homePostalAddress)[1]/act:CountryRegion/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS countryregion,
    (xpath('(act:homePostalAddress)[1]/act:SpecialInstructions/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS homeaddressspecialinstructions,
    (xpath('(act:eMail)[1]/act:eMailAddress/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS emailaddress,
    btrim((((xpath('(act:eMail)[1]/act:SpecialInstructions/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1])::character varying)::text) AS emailspecialinstructions,
    (xpath('((act:eMail)[1]/act:SpecialInstructions/act:telephoneNumber)[1]/act:number/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS emailtelephonenumber,
    p.rowguid,
    p.modifieddate
   FROM (person.person p
     LEFT JOIN ( SELECT person.businessentityid,
            unnest(xpath('/ci:AdditionalContactInfo'::text, person.additionalcontactinfo, '{{ci,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo}}'::text[])) AS node
           FROM person.person
          WHERE (person.additionalcontactinfo IS NOT NULL)) additional ON ((p.businessentityid = additional.businessentityid)));
 )   DROP VIEW person.vadditionalcontactinfo;
       person       v       example    false    234    234    234    234    234    234    234    1095    1095    1095    8            _           1259    18094    vstateprovincecountryregion    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW person.vstateprovincecountryregion AS
 SELECT sp.stateprovinceid,
    sp.stateprovincecode,
    sp.isonlystateprovinceflag,
    sp.name AS stateprovincename,
    sp.territoryid,
    cr.countryregioncode,
    cr.name AS countryregionname
   FROM (person.stateprovince sp
     JOIN person.countryregion cr ON (((sp.countryregioncode)::text = (cr.countryregioncode)::text)))
  WITH NO DATA;
 ;   DROP MATERIALIZED VIEW person.vstateprovincecountryregion;
       person         heap m       example    false    251    251    236    236    236    236    236    236    1095    8    1095    1089                       1259    16590    billofmaterials    TABLE     �  CREATE TABLE production.billofmaterials (
    billofmaterialsid integer NOT NULL,
    productassemblyid integer,
    componentid integer NOT NULL,
    startdate timestamp without time zone DEFAULT now() NOT NULL,
    enddate timestamp without time zone,
    unitmeasurecode character(3) NOT NULL,
    bomlevel smallint NOT NULL,
    perassemblyqty numeric(8,2) DEFAULT 1.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK ((((productassemblyid IS NULL) AND (bomlevel = 0) AND (perassemblyqty = 1.00)) OR ((productassemblyid IS NOT NULL) AND (bomlevel >= 1)))),
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (((enddate > startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK ((perassemblyqty >= 1.00)),
    CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK ((productassemblyid <> componentid))
);
 '   DROP TABLE production.billofmaterials;
    
   production         heap r       example    false    10            9           0    0    TABLE billofmaterials    COMMENT     �   COMMENT ON TABLE production.billofmaterials IS 'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.';
       
   production               example    false    262            :           0    0 (   COLUMN billofmaterials.billofmaterialsid    COMMENT     n   COMMENT ON COLUMN production.billofmaterials.billofmaterialsid IS 'Primary key for BillOfMaterials records.';
       
   production               example    false    262            ;           0    0 (   COLUMN billofmaterials.productassemblyid    COMMENT     �   COMMENT ON COLUMN production.billofmaterials.productassemblyid IS 'Parent product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    262            <           0    0 "   COLUMN billofmaterials.componentid    COMMENT     �   COMMENT ON COLUMN production.billofmaterials.componentid IS 'Component identification number. Foreign key to Product.ProductID.';
       
   production               example    false    262            =           0    0     COLUMN billofmaterials.startdate    COMMENT     y   COMMENT ON COLUMN production.billofmaterials.startdate IS 'Date the component started being used in the assembly item.';
       
   production               example    false    262            >           0    0    COLUMN billofmaterials.enddate    COMMENT     w   COMMENT ON COLUMN production.billofmaterials.enddate IS 'Date the component stopped being used in the assembly item.';
       
   production               example    false    262            ?           0    0 &   COLUMN billofmaterials.unitmeasurecode    COMMENT     �   COMMENT ON COLUMN production.billofmaterials.unitmeasurecode IS 'Standard code identifying the unit of measure for the quantity.';
       
   production               example    false    262            @           0    0    COLUMN billofmaterials.bomlevel    COMMENT        COMMENT ON COLUMN production.billofmaterials.bomlevel IS 'Indicates the depth the component is from its parent (AssemblyID).';
       
   production               example    false    262            A           0    0 %   COLUMN billofmaterials.perassemblyqty    COMMENT     {   COMMENT ON COLUMN production.billofmaterials.perassemblyqty IS 'Quantity of the component needed to create the assembly.';
       
   production               example    false    262            x           1259    18216    bom    VIEW     �   CREATE VIEW pr.bom AS
 SELECT billofmaterialsid AS id,
    billofmaterialsid,
    productassemblyid,
    componentid,
    startdate,
    enddate,
    unitmeasurecode,
    bomlevel,
    perassemblyqty,
    modifieddate
   FROM production.billofmaterials;
    DROP VIEW pr.bom;
       pr       v       example    false    262    262    262    262    262    262    262    262    262    15                       1259    16601    culture    TABLE     �   CREATE TABLE production.culture (
    cultureid character(6) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE production.culture;
    
   production         heap r       example    false    10    1095            B           0    0    TABLE culture    COMMENT     }   COMMENT ON TABLE production.culture IS 'Lookup table containing the languages in which some AdventureWorks data is stored.';
       
   production               example    false    263            C           0    0    COLUMN culture.cultureid    COMMENT     V   COMMENT ON COLUMN production.culture.cultureid IS 'Primary key for Culture records.';
       
   production               example    false    263            D           0    0    COLUMN culture.name    COMMENT     E   COMMENT ON COLUMN production.culture.name IS 'Culture description.';
       
   production               example    false    263            y           1259    18220    c    VIEW     s   CREATE VIEW pr.c AS
 SELECT cultureid AS id,
    cultureid,
    name,
    modifieddate
   FROM production.culture;
    DROP VIEW pr.c;
       pr       v       example    false    263    263    263    1095    15                       1259    16607    document    TABLE     �  CREATE TABLE production.document (
    title character varying(50) NOT NULL,
    owner integer NOT NULL,
    folderflag public."Flag" DEFAULT false NOT NULL,
    filename character varying(400) NOT NULL,
    fileextension character varying(8),
    revision character(5) NOT NULL,
    changenumber integer DEFAULT 0 NOT NULL,
    status smallint NOT NULL,
    documentsummary text,
    document bytea,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL,
    CONSTRAINT "CK_Document_Status" CHECK (((status >= 1) AND (status <= 3)))
);
     DROP TABLE production.document;
    
   production         heap r       example    false    1089    2    10    1089            E           0    0    TABLE document    COMMENT     J   COMMENT ON TABLE production.document IS 'Product maintenance documents.';
       
   production               example    false    264            F           0    0    COLUMN document.title    COMMENT     I   COMMENT ON COLUMN production.document.title IS 'Title of the document.';
       
   production               example    false    264            G           0    0    COLUMN document.owner    COMMENT     �   COMMENT ON COLUMN production.document.owner IS 'Employee who controls the document.  Foreign key to Employee.BusinessEntityID';
       
   production               example    false    264            H           0    0    COLUMN document.folderflag    COMMENT     e   COMMENT ON COLUMN production.document.folderflag IS '0 = This is a folder, 1 = This is a document.';
       
   production               example    false    264            I           0    0    COLUMN document.filename    COMMENT     O   COMMENT ON COLUMN production.document.filename IS 'File name of the document';
       
   production               example    false    264            J           0    0    COLUMN document.fileextension    COMMENT     �   COMMENT ON COLUMN production.document.fileextension IS 'File extension indicating the document type. For example, .doc or .txt.';
       
   production               example    false    264            K           0    0    COLUMN document.revision    COMMENT     V   COMMENT ON COLUMN production.document.revision IS 'Revision number of the document.';
       
   production               example    false    264            L           0    0    COLUMN document.changenumber    COMMENT     ]   COMMENT ON COLUMN production.document.changenumber IS 'Engineering change approval number.';
       
   production               example    false    264            M           0    0    COLUMN document.status    COMMENT     d   COMMENT ON COLUMN production.document.status IS '1 = Pending approval, 2 = Approved, 3 = Obsolete';
       
   production               example    false    264            N           0    0    COLUMN document.documentsummary    COMMENT     O   COMMENT ON COLUMN production.document.documentsummary IS 'Document abstract.';
       
   production               example    false    264            O           0    0    COLUMN document.document    COMMENT     H   COMMENT ON COLUMN production.document.document IS 'Complete document.';
       
   production               example    false    264            P           0    0    COLUMN document.rowguid    COMMENT     �   COMMENT ON COLUMN production.document.rowguid IS 'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.';
       
   production               example    false    264            Q           0    0    COLUMN document.documentnode    COMMENT     [   COMMENT ON COLUMN production.document.documentnode IS 'Primary key for Document records.';
       
   production               example    false    264            z           1259    18224    d    VIEW     �   CREATE VIEW pr.d AS
 SELECT title,
    owner,
    folderflag,
    filename,
    fileextension,
    revision,
    changenumber,
    status,
    documentsummary,
    document,
    rowguid,
    modifieddate,
    documentnode
   FROM production.document;
    DROP VIEW pr.d;
       pr       v       example    false    264    264    264    264    264    264    264    264    264    264    264    264    264    1089    15                       1259    16716    illustration    TABLE     �   CREATE TABLE production.illustration (
    illustrationid integer NOT NULL,
    diagram xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 $   DROP TABLE production.illustration;
    
   production         heap r       example    false    10            R           0    0    TABLE illustration    COMMENT     J   COMMENT ON TABLE production.illustration IS 'Bicycle assembly diagrams.';
       
   production               example    false    282            S           0    0 "   COLUMN illustration.illustrationid    COMMENT     e   COMMENT ON COLUMN production.illustration.illustrationid IS 'Primary key for Illustration records.';
       
   production               example    false    282            T           0    0    COLUMN illustration.diagram    COMMENT     y   COMMENT ON COLUMN production.illustration.diagram IS 'Illustrations used in manufacturing instructions. Stored as XML.';
       
   production               example    false    282            {           1259    18228    i    VIEW     �   CREATE VIEW pr.i AS
 SELECT illustrationid AS id,
    illustrationid,
    diagram,
    modifieddate
   FROM production.illustration;
    DROP VIEW pr.i;
       pr       v       example    false    282    282    282    15                       1259    16689    location    TABLE     �  CREATE TABLE production.location (
    locationid integer NOT NULL,
    name public."Name" NOT NULL,
    costrate numeric DEFAULT 0.00 NOT NULL,
    availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((costrate >= 0.00))
);
     DROP TABLE production.location;
    
   production         heap r       example    false    10    1095            U           0    0    TABLE location    COMMENT     Z   COMMENT ON TABLE production.location IS 'Product inventory and manufacturing locations.';
       
   production               example    false    278            V           0    0    COLUMN location.locationid    COMMENT     Y   COMMENT ON COLUMN production.location.locationid IS 'Primary key for Location records.';
       
   production               example    false    278            W           0    0    COLUMN location.name    COMMENT     G   COMMENT ON COLUMN production.location.name IS 'Location description.';
       
   production               example    false    278            X           0    0    COLUMN location.costrate    COMMENT     i   COMMENT ON COLUMN production.location.costrate IS 'Standard hourly cost of the manufacturing location.';
       
   production               example    false    278            Y           0    0    COLUMN location.availability    COMMENT     q   COMMENT ON COLUMN production.location.availability IS 'Work capacity (in hours) of the manufacturing location.';
       
   production               example    false    278            |           1259    18232    l    VIEW     �   CREATE VIEW pr.l AS
 SELECT locationid AS id,
    locationid,
    name,
    costrate,
    availability,
    modifieddate
   FROM production.location;
    DROP VIEW pr.l;
       pr       v       example    false    278    278    278    278    278    1095    15                       1259    16647    product    TABLE     �  CREATE TABLE production.product (
    productid integer NOT NULL,
    name public."Name" NOT NULL,
    productnumber character varying(25) NOT NULL,
    makeflag public."Flag" DEFAULT true NOT NULL,
    finishedgoodsflag public."Flag" DEFAULT true NOT NULL,
    color character varying(15),
    safetystocklevel smallint NOT NULL,
    reorderpoint smallint NOT NULL,
    standardcost numeric NOT NULL,
    listprice numeric NOT NULL,
    size character varying(5),
    sizeunitmeasurecode character(3),
    weightunitmeasurecode character(3),
    weight numeric(8,2),
    daystomanufacture integer NOT NULL,
    productline character(2),
    class character(2),
    style character(2),
    productsubcategoryid integer,
    productmodelid integer,
    sellstartdate timestamp without time zone NOT NULL,
    sellenddate timestamp without time zone,
    discontinueddate timestamp without time zone,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Product_Class" CHECK (((upper((class)::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR (class IS NULL))),
    CONSTRAINT "CK_Product_DaysToManufacture" CHECK ((daystomanufacture >= 0)),
    CONSTRAINT "CK_Product_ListPrice" CHECK ((listprice >= 0.00)),
    CONSTRAINT "CK_Product_ProductLine" CHECK (((upper((productline)::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR (productline IS NULL))),
    CONSTRAINT "CK_Product_ReorderPoint" CHECK ((reorderpoint > 0)),
    CONSTRAINT "CK_Product_SafetyStockLevel" CHECK ((safetystocklevel > 0)),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (((sellenddate >= sellstartdate) OR (sellenddate IS NULL))),
    CONSTRAINT "CK_Product_StandardCost" CHECK ((standardcost >= 0.00)),
    CONSTRAINT "CK_Product_Style" CHECK (((upper((style)::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR (style IS NULL))),
    CONSTRAINT "CK_Product_Weight" CHECK ((weight > 0.00))
);
    DROP TABLE production.product;
    
   production         heap r       example    false    1089    1089    2    1089    1095    1089    10            Z           0    0    TABLE product    COMMENT     f   COMMENT ON TABLE production.product IS 'Products sold or used in the manfacturing of sold products.';
       
   production               example    false    272            [           0    0    COLUMN product.productid    COMMENT     V   COMMENT ON COLUMN production.product.productid IS 'Primary key for Product records.';
       
   production               example    false    272            \           0    0    COLUMN product.name    COMMENT     E   COMMENT ON COLUMN production.product.name IS 'Name of the product.';
       
   production               example    false    272            ]           0    0    COLUMN product.productnumber    COMMENT     _   COMMENT ON COLUMN production.product.productnumber IS 'Unique product identification number.';
       
   production               example    false    272            ^           0    0    COLUMN product.makeflag    COMMENT     t   COMMENT ON COLUMN production.product.makeflag IS '0 = Product is purchased, 1 = Product is manufactured in-house.';
       
   production               example    false    272            _           0    0     COLUMN product.finishedgoodsflag    COMMENT     x   COMMENT ON COLUMN production.product.finishedgoodsflag IS '0 = Product is not a salable item. 1 = Product is salable.';
       
   production               example    false    272            `           0    0    COLUMN product.color    COMMENT     @   COMMENT ON COLUMN production.product.color IS 'Product color.';
       
   production               example    false    272            a           0    0    COLUMN product.safetystocklevel    COMMENT     X   COMMENT ON COLUMN production.product.safetystocklevel IS 'Minimum inventory quantity.';
       
   production               example    false    272            b           0    0    COLUMN product.reorderpoint    COMMENT     v   COMMENT ON COLUMN production.product.reorderpoint IS 'Inventory level that triggers a purchase order or work order.';
       
   production               example    false    272            c           0    0    COLUMN product.standardcost    COMMENT     V   COMMENT ON COLUMN production.product.standardcost IS 'Standard cost of the product.';
       
   production               example    false    272            d           0    0    COLUMN product.listprice    COMMENT     D   COMMENT ON COLUMN production.product.listprice IS 'Selling price.';
       
   production               example    false    272            e           0    0    COLUMN product.size    COMMENT     >   COMMENT ON COLUMN production.product.size IS 'Product size.';
       
   production               example    false    272            f           0    0 "   COLUMN product.sizeunitmeasurecode    COMMENT     `   COMMENT ON COLUMN production.product.sizeunitmeasurecode IS 'Unit of measure for Size column.';
       
   production               example    false    272            g           0    0 $   COLUMN product.weightunitmeasurecode    COMMENT     d   COMMENT ON COLUMN production.product.weightunitmeasurecode IS 'Unit of measure for Weight column.';
       
   production               example    false    272            h           0    0    COLUMN product.weight    COMMENT     B   COMMENT ON COLUMN production.product.weight IS 'Product weight.';
       
   production               example    false    272            i           0    0     COLUMN product.daystomanufacture    COMMENT     q   COMMENT ON COLUMN production.product.daystomanufacture IS 'Number of days required to manufacture the product.';
       
   production               example    false    272            j           0    0    COLUMN product.productline    COMMENT     i   COMMENT ON COLUMN production.product.productline IS 'R = Road, M = Mountain, T = Touring, S = Standard';
       
   production               example    false    272            k           0    0    COLUMN product.class    COMMENT     O   COMMENT ON COLUMN production.product.class IS 'H = High, M = Medium, L = Low';
       
   production               example    false    272            l           0    0    COLUMN product.style    COMMENT     U   COMMENT ON COLUMN production.product.style IS 'W = Womens, M = Mens, U = Universal';
       
   production               example    false    272            m           0    0 #   COLUMN product.productsubcategoryid    COMMENT     �   COMMENT ON COLUMN production.product.productsubcategoryid IS 'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID.';
       
   production               example    false    272            n           0    0    COLUMN product.productmodelid    COMMENT     �   COMMENT ON COLUMN production.product.productmodelid IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';
       
   production               example    false    272            o           0    0    COLUMN product.sellstartdate    COMMENT     b   COMMENT ON COLUMN production.product.sellstartdate IS 'Date the product was available for sale.';
       
   production               example    false    272            p           0    0    COLUMN product.sellenddate    COMMENT     j   COMMENT ON COLUMN production.product.sellenddate IS 'Date the product was no longer available for sale.';
       
   production               example    false    272            q           0    0    COLUMN product.discontinueddate    COMMENT     _   COMMENT ON COLUMN production.product.discontinueddate IS 'Date the product was discontinued.';
       
   production               example    false    272            }           1259    18236    p    VIEW     �  CREATE VIEW pr.p AS
 SELECT productid AS id,
    productid,
    name,
    productnumber,
    makeflag,
    finishedgoodsflag,
    color,
    safetystocklevel,
    reorderpoint,
    standardcost,
    listprice,
    size,
    sizeunitmeasurecode,
    weightunitmeasurecode,
    weight,
    daystomanufacture,
    productline,
    class,
    style,
    productsubcategoryid,
    productmodelid,
    sellstartdate,
    sellenddate,
    discontinueddate,
    rowguid,
    modifieddate
   FROM production.product;
    DROP VIEW pr.p;
       pr       v       example    false    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    272    1095    1089    1089    15            
           1259    16620    productcategory    TABLE     �   CREATE TABLE production.productcategory (
    productcategoryid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 '   DROP TABLE production.productcategory;
    
   production         heap r       example    false    2    1095    10            r           0    0    TABLE productcategory    COMMENT     U   COMMENT ON TABLE production.productcategory IS 'High-level product categorization.';
       
   production               example    false    266            s           0    0 (   COLUMN productcategory.productcategoryid    COMMENT     n   COMMENT ON COLUMN production.productcategory.productcategoryid IS 'Primary key for ProductCategory records.';
       
   production               example    false    266            t           0    0    COLUMN productcategory.name    COMMENT     N   COMMENT ON COLUMN production.productcategory.name IS 'Category description.';
       
   production               example    false    266            ~           1259    18241    pc    VIEW     �   CREATE VIEW pr.pc AS
 SELECT productcategoryid AS id,
    productcategoryid,
    name,
    rowguid,
    modifieddate
   FROM production.productcategory;
    DROP VIEW pr.pc;
       pr       v       example    false    266    266    266    266    1095    15                       1259    16667    productcosthistory    TABLE     �  CREATE TABLE production.productcosthistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    standardcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standardcost >= 0.00))
);
 *   DROP TABLE production.productcosthistory;
    
   production         heap r       example    false    10            u           0    0    TABLE productcosthistory    COMMENT     a   COMMENT ON TABLE production.productcosthistory IS 'Changes in the cost of a product over time.';
       
   production               example    false    273            v           0    0 #   COLUMN productcosthistory.productid    COMMENT     �   COMMENT ON COLUMN production.productcosthistory.productid IS 'Product identification number. Foreign key to Product.ProductID';
       
   production               example    false    273            w           0    0 #   COLUMN productcosthistory.startdate    COMMENT     Y   COMMENT ON COLUMN production.productcosthistory.startdate IS 'Product cost start date.';
       
   production               example    false    273            x           0    0 !   COLUMN productcosthistory.enddate    COMMENT     U   COMMENT ON COLUMN production.productcosthistory.enddate IS 'Product cost end date.';
       
   production               example    false    273            y           0    0 &   COLUMN productcosthistory.standardcost    COMMENT     a   COMMENT ON COLUMN production.productcosthistory.standardcost IS 'Standard cost of the product.';
       
   production               example    false    273                       1259    18245    pch    VIEW     �   CREATE VIEW pr.pch AS
 SELECT productid AS id,
    productid,
    startdate,
    enddate,
    standardcost,
    modifieddate
   FROM production.productcosthistory;
    DROP VIEW pr.pch;
       pr       v       example    false    273    273    273    273    273    15                       1259    16676    productdescription    TABLE       CREATE TABLE production.productdescription (
    productdescriptionid integer NOT NULL,
    description character varying(400) NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 *   DROP TABLE production.productdescription;
    
   production         heap r       example    false    2    10            z           0    0    TABLE productdescription    COMMENT     `   COMMENT ON TABLE production.productdescription IS 'Product descriptions in several languages.';
       
   production               example    false    275            {           0    0 .   COLUMN productdescription.productdescriptionid    COMMENT     w   COMMENT ON COLUMN production.productdescription.productdescriptionid IS 'Primary key for ProductDescription records.';
       
   production               example    false    275            |           0    0 %   COLUMN productdescription.description    COMMENT     ^   COMMENT ON COLUMN production.productdescription.description IS 'Description of the product.';
       
   production               example    false    275            �           1259    18249    pd    VIEW     �   CREATE VIEW pr.pd AS
 SELECT productdescriptionid AS id,
    productdescriptionid,
    description,
    rowguid,
    modifieddate
   FROM production.productdescription;
    DROP VIEW pr.pd;
       pr       v       example    false    275    275    275    275    15                       1259    16682    productdocument    TABLE     �   CREATE TABLE production.productdocument (
    productid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL
);
 '   DROP TABLE production.productdocument;
    
   production         heap r       example    false    10            }           0    0    TABLE productdocument    COMMENT     w   COMMENT ON TABLE production.productdocument IS 'Cross-reference table mapping products to related product documents.';
       
   production               example    false    276            ~           0    0     COLUMN productdocument.productid    COMMENT     ~   COMMENT ON COLUMN production.productdocument.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    276                       0    0 #   COLUMN productdocument.documentnode    COMMENT     �   COMMENT ON COLUMN production.productdocument.documentnode IS 'Document identification number. Foreign key to Document.DocumentNode.';
       
   production               example    false    276            �           1259    18253    pdoc    VIEW     �   CREATE VIEW pr.pdoc AS
 SELECT productid AS id,
    productid,
    modifieddate,
    documentnode
   FROM production.productdocument;
    DROP VIEW pr.pdoc;
       pr       v       example    false    276    276    276    15                       1259    16700    productinventory    TABLE     �  CREATE TABLE production.productinventory (
    productid integer NOT NULL,
    locationid integer NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);
 (   DROP TABLE production.productinventory;
    
   production         heap r       example    false    2    10            �           0    0    TABLE productinventory    COMMENT     R   COMMENT ON TABLE production.productinventory IS 'Product inventory information.';
       
   production               example    false    279            �           0    0 !   COLUMN productinventory.productid    COMMENT        COMMENT ON COLUMN production.productinventory.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    279            �           0    0 "   COLUMN productinventory.locationid    COMMENT     �   COMMENT ON COLUMN production.productinventory.locationid IS 'Inventory location identification number. Foreign key to Location.LocationID.';
       
   production               example    false    279            �           0    0    COLUMN productinventory.shelf    COMMENT     l   COMMENT ON COLUMN production.productinventory.shelf IS 'Storage compartment within an inventory location.';
       
   production               example    false    279            �           0    0    COLUMN productinventory.bin    COMMENT     o   COMMENT ON COLUMN production.productinventory.bin IS 'Storage container on a shelf in an inventory location.';
       
   production               example    false    279            �           0    0     COLUMN productinventory.quantity    COMMENT     m   COMMENT ON COLUMN production.productinventory.quantity IS 'Quantity of products in the inventory location.';
       
   production               example    false    279            �           1259    18257    pi    VIEW     �   CREATE VIEW pr.pi AS
 SELECT productid AS id,
    productid,
    locationid,
    shelf,
    bin,
    quantity,
    rowguid,
    modifieddate
   FROM production.productinventory;
    DROP VIEW pr.pi;
       pr       v       example    false    279    279    279    279    279    279    279    15                       1259    16707    productlistpricehistory    TABLE     �  CREATE TABLE production.productlistpricehistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    listprice numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((listprice > 0.00))
);
 /   DROP TABLE production.productlistpricehistory;
    
   production         heap r       example    false    10            �           0    0    TABLE productlistpricehistory    COMMENT     l   COMMENT ON TABLE production.productlistpricehistory IS 'Changes in the list price of a product over time.';
       
   production               example    false    280            �           0    0 (   COLUMN productlistpricehistory.productid    COMMENT     �   COMMENT ON COLUMN production.productlistpricehistory.productid IS 'Product identification number. Foreign key to Product.ProductID';
       
   production               example    false    280            �           0    0 (   COLUMN productlistpricehistory.startdate    COMMENT     \   COMMENT ON COLUMN production.productlistpricehistory.startdate IS 'List price start date.';
       
   production               example    false    280            �           0    0 &   COLUMN productlistpricehistory.enddate    COMMENT     W   COMMENT ON COLUMN production.productlistpricehistory.enddate IS 'List price end date';
       
   production               example    false    280            �           0    0 (   COLUMN productlistpricehistory.listprice    COMMENT     Y   COMMENT ON COLUMN production.productlistpricehistory.listprice IS 'Product list price.';
       
   production               example    false    280            �           1259    18261    plph    VIEW     �   CREATE VIEW pr.plph AS
 SELECT productid AS id,
    productid,
    startdate,
    enddate,
    listprice,
    modifieddate
   FROM production.productlistpricehistory;
    DROP VIEW pr.plph;
       pr       v       example    false    280    280    280    280    280    15                       1259    16638    productmodel    TABLE     #  CREATE TABLE production.productmodel (
    productmodelid integer NOT NULL,
    name public."Name" NOT NULL,
    catalogdescription xml,
    instructions xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 $   DROP TABLE production.productmodel;
    
   production         heap r       example    false    2    10    1095            �           0    0    TABLE productmodel    COMMENT     M   COMMENT ON TABLE production.productmodel IS 'Product model classification.';
       
   production               example    false    270            �           0    0 "   COLUMN productmodel.productmodelid    COMMENT     e   COMMENT ON COLUMN production.productmodel.productmodelid IS 'Primary key for ProductModel records.';
       
   production               example    false    270            �           0    0    COLUMN productmodel.name    COMMENT     P   COMMENT ON COLUMN production.productmodel.name IS 'Product model description.';
       
   production               example    false    270            �           0    0 &   COLUMN productmodel.catalogdescription    COMMENT     w   COMMENT ON COLUMN production.productmodel.catalogdescription IS 'Detailed product catalog information in xml format.';
       
   production               example    false    270            �           0    0     COLUMN productmodel.instructions    COMMENT     g   COMMENT ON COLUMN production.productmodel.instructions IS 'Manufacturing instructions in xml format.';
       
   production               example    false    270            �           1259    18265    pm    VIEW     �   CREATE VIEW pr.pm AS
 SELECT productmodelid AS id,
    productmodelid,
    name,
    catalogdescription,
    instructions,
    rowguid,
    modifieddate
   FROM production.productmodel;
    DROP VIEW pr.pm;
       pr       v       example    false    270    270    270    270    270    270    1095    15                       1259    16723    productmodelillustration    TABLE     �   CREATE TABLE production.productmodelillustration (
    productmodelid integer NOT NULL,
    illustrationid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 0   DROP TABLE production.productmodelillustration;
    
   production         heap r       example    false    10            �           0    0    TABLE productmodelillustration    COMMENT     {   COMMENT ON TABLE production.productmodelillustration IS 'Cross-reference table mapping product models and illustrations.';
       
   production               example    false    283            �           0    0 .   COLUMN productmodelillustration.productmodelid    COMMENT     �   COMMENT ON COLUMN production.productmodelillustration.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';
       
   production               example    false    283            �           0    0 .   COLUMN productmodelillustration.illustrationid    COMMENT     �   COMMENT ON COLUMN production.productmodelillustration.illustrationid IS 'Primary key. Foreign key to Illustration.IllustrationID.';
       
   production               example    false    283            �           1259    18269    pmi    VIEW     �   CREATE VIEW pr.pmi AS
 SELECT productmodelid,
    illustrationid,
    modifieddate
   FROM production.productmodelillustration;
    DROP VIEW pr.pmi;
       pr       v       example    false    283    283    283    15                       1259    16727 %   productmodelproductdescriptionculture    TABLE     �   CREATE TABLE production.productmodelproductdescriptionculture (
    productmodelid integer NOT NULL,
    productdescriptionid integer NOT NULL,
    cultureid character(6) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 =   DROP TABLE production.productmodelproductdescriptionculture;
    
   production         heap r       example    false    10            �           0    0 +   TABLE productmodelproductdescriptionculture    COMMENT     �   COMMENT ON TABLE production.productmodelproductdescriptionculture IS 'Cross-reference table mapping product descriptions and the language the description is written in.';
       
   production               example    false    284            �           0    0 ;   COLUMN productmodelproductdescriptionculture.productmodelid    COMMENT     �   COMMENT ON COLUMN production.productmodelproductdescriptionculture.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';
       
   production               example    false    284            �           0    0 A   COLUMN productmodelproductdescriptionculture.productdescriptionid    COMMENT     �   COMMENT ON COLUMN production.productmodelproductdescriptionculture.productdescriptionid IS 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';
       
   production               example    false    284            �           0    0 6   COLUMN productmodelproductdescriptionculture.cultureid    COMMENT     �   COMMENT ON COLUMN production.productmodelproductdescriptionculture.cultureid IS 'Culture identification number. Foreign key to Culture.CultureID.';
       
   production               example    false    284            �           1259    18273    pmpdc    VIEW     �   CREATE VIEW pr.pmpdc AS
 SELECT productmodelid,
    productdescriptionid,
    cultureid,
    modifieddate
   FROM production.productmodelproductdescriptionculture;
    DROP VIEW pr.pmpdc;
       pr       v       example    false    284    284    284    284    15                       1259    16732    productphoto    TABLE     #  CREATE TABLE production.productphoto (
    productphotoid integer NOT NULL,
    thumbnailphoto bytea,
    thumbnailphotofilename character varying(50),
    largephoto bytea,
    largephotofilename character varying(50),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 $   DROP TABLE production.productphoto;
    
   production         heap r       example    false    10            �           0    0    TABLE productphoto    COMMENT     ?   COMMENT ON TABLE production.productphoto IS 'Product images.';
       
   production               example    false    286            �           0    0 "   COLUMN productphoto.productphotoid    COMMENT     e   COMMENT ON COLUMN production.productphoto.productphotoid IS 'Primary key for ProductPhoto records.';
       
   production               example    false    286            �           0    0 "   COLUMN productphoto.thumbnailphoto    COMMENT     [   COMMENT ON COLUMN production.productphoto.thumbnailphoto IS 'Small image of the product.';
       
   production               example    false    286            �           0    0 *   COLUMN productphoto.thumbnailphotofilename    COMMENT     ^   COMMENT ON COLUMN production.productphoto.thumbnailphotofilename IS 'Small image file name.';
       
   production               example    false    286            �           0    0    COLUMN productphoto.largephoto    COMMENT     W   COMMENT ON COLUMN production.productphoto.largephoto IS 'Large image of the product.';
       
   production               example    false    286            �           0    0 &   COLUMN productphoto.largephotofilename    COMMENT     Z   COMMENT ON COLUMN production.productphoto.largephotofilename IS 'Large image file name.';
       
   production               example    false    286            �           1259    18277    pp    VIEW     �   CREATE VIEW pr.pp AS
 SELECT productphotoid AS id,
    productphotoid,
    thumbnailphoto,
    thumbnailphotofilename,
    largephoto,
    largephotofilename,
    modifieddate
   FROM production.productphoto;
    DROP VIEW pr.pp;
       pr       v       example    false    286    286    286    286    286    286    15                       1259    16739    productproductphoto    TABLE     �   CREATE TABLE production.productproductphoto (
    productid integer NOT NULL,
    productphotoid integer NOT NULL,
    "primary" public."Flag" DEFAULT false NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 +   DROP TABLE production.productproductphoto;
    
   production         heap r       example    false    1089    1089    10            �           0    0    TABLE productproductphoto    COMMENT     q   COMMENT ON TABLE production.productproductphoto IS 'Cross-reference table mapping products and product photos.';
       
   production               example    false    287            �           0    0 $   COLUMN productproductphoto.productid    COMMENT     �   COMMENT ON COLUMN production.productproductphoto.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    287            �           0    0 )   COLUMN productproductphoto.productphotoid    COMMENT     �   COMMENT ON COLUMN production.productproductphoto.productphotoid IS 'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';
       
   production               example    false    287            �           0    0 $   COLUMN productproductphoto."primary"    COMMENT     �   COMMENT ON COLUMN production.productproductphoto."primary" IS '0 = Photo is not the principal image. 1 = Photo is the principal image.';
       
   production               example    false    287            �           1259    18281    ppp    VIEW     �   CREATE VIEW pr.ppp AS
 SELECT productid,
    productphotoid,
    "primary",
    modifieddate
   FROM production.productproductphoto;
    DROP VIEW pr.ppp;
       pr       v       example    false    287    287    287    287    1089    15            !           1259    16745    productreview    TABLE     �  CREATE TABLE production.productreview (
    productreviewid integer NOT NULL,
    productid integer NOT NULL,
    reviewername public."Name" NOT NULL,
    reviewdate timestamp without time zone DEFAULT now() NOT NULL,
    emailaddress character varying(50) NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);
 %   DROP TABLE production.productreview;
    
   production         heap r       example    false    10    1095            �           0    0    TABLE productreview    COMMENT     b   COMMENT ON TABLE production.productreview IS 'Customer reviews of products they have purchased.';
       
   production               example    false    289            �           0    0 $   COLUMN productreview.productreviewid    COMMENT     h   COMMENT ON COLUMN production.productreview.productreviewid IS 'Primary key for ProductReview records.';
       
   production               example    false    289            �           0    0    COLUMN productreview.productid    COMMENT     |   COMMENT ON COLUMN production.productreview.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    289            �           0    0 !   COLUMN productreview.reviewername    COMMENT     T   COMMENT ON COLUMN production.productreview.reviewername IS 'Name of the reviewer.';
       
   production               example    false    289            �           0    0    COLUMN productreview.reviewdate    COMMENT     W   COMMENT ON COLUMN production.productreview.reviewdate IS 'Date review was submitted.';
       
   production               example    false    289            �           0    0 !   COLUMN productreview.emailaddress    COMMENT     Z   COMMENT ON COLUMN production.productreview.emailaddress IS 'Reviewer''s e-mail address.';
       
   production               example    false    289            �           0    0    COLUMN productreview.rating    COMMENT     �   COMMENT ON COLUMN production.productreview.rating IS 'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.';
       
   production               example    false    289            �           0    0    COLUMN productreview.comments    COMMENT     O   COMMENT ON COLUMN production.productreview.comments IS 'Reviewer''s comments';
       
   production               example    false    289            �           1259    18285    pr    VIEW     �   CREATE VIEW pr.pr AS
 SELECT productreviewid AS id,
    productreviewid,
    productid,
    reviewername,
    reviewdate,
    emailaddress,
    rating,
    comments,
    modifieddate
   FROM production.productreview;
    DROP VIEW pr.pr;
       pr       v       example    false    289    289    289    289    289    289    289    289    1095    15                       1259    16629    productsubcategory    TABLE     %  CREATE TABLE production.productsubcategory (
    productsubcategoryid integer NOT NULL,
    productcategoryid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 *   DROP TABLE production.productsubcategory;
    
   production         heap r       example    false    2    1095    10            �           0    0    TABLE productsubcategory    COMMENT     g   COMMENT ON TABLE production.productsubcategory IS 'Product subcategories. See ProductCategory table.';
       
   production               example    false    268            �           0    0 .   COLUMN productsubcategory.productsubcategoryid    COMMENT     w   COMMENT ON COLUMN production.productsubcategory.productsubcategoryid IS 'Primary key for ProductSubcategory records.';
       
   production               example    false    268            �           0    0 +   COLUMN productsubcategory.productcategoryid    COMMENT     �   COMMENT ON COLUMN production.productsubcategory.productcategoryid IS 'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';
       
   production               example    false    268            �           0    0    COLUMN productsubcategory.name    COMMENT     T   COMMENT ON COLUMN production.productsubcategory.name IS 'Subcategory description.';
       
   production               example    false    268            �           1259    18289    psc    VIEW     �   CREATE VIEW pr.psc AS
 SELECT productsubcategoryid AS id,
    productsubcategoryid,
    productcategoryid,
    name,
    rowguid,
    modifieddate
   FROM production.productsubcategory;
    DROP VIEW pr.psc;
       pr       v       example    false    268    268    268    268    268    1095    15            #           1259    16755    scrapreason    TABLE     �   CREATE TABLE production.scrapreason (
    scrapreasonid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 #   DROP TABLE production.scrapreason;
    
   production         heap r       example    false    10    1095            �           0    0    TABLE scrapreason    COMMENT     Z   COMMENT ON TABLE production.scrapreason IS 'Manufacturing failure reasons lookup table.';
       
   production               example    false    291            �           0    0     COLUMN scrapreason.scrapreasonid    COMMENT     b   COMMENT ON COLUMN production.scrapreason.scrapreasonid IS 'Primary key for ScrapReason records.';
       
   production               example    false    291            �           0    0    COLUMN scrapreason.name    COMMENT     I   COMMENT ON COLUMN production.scrapreason.name IS 'Failure description.';
       
   production               example    false    291            �           1259    18293    sr    VIEW     �   CREATE VIEW pr.sr AS
 SELECT scrapreasonid AS id,
    scrapreasonid,
    name,
    modifieddate
   FROM production.scrapreason;
    DROP VIEW pr.sr;
       pr       v       example    false    291    291    291    1095    15            %           1259    16763    transactionhistory    TABLE     W  CREATE TABLE production.transactionhistory (
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer DEFAULT 0 NOT NULL,
    transactiondate timestamp without time zone DEFAULT now() NOT NULL,
    transactiontype character(1) NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK ((upper((transactiontype)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);
 *   DROP TABLE production.transactionhistory;
    
   production         heap r       example    false    10            �           0    0    TABLE transactionhistory    COMMENT     �   COMMENT ON TABLE production.transactionhistory IS 'Record of each purchase order, sales order, or work order transaction year to date.';
       
   production               example    false    293            �           0    0 '   COLUMN transactionhistory.transactionid    COMMENT     p   COMMENT ON COLUMN production.transactionhistory.transactionid IS 'Primary key for TransactionHistory records.';
       
   production               example    false    293            �           0    0 #   COLUMN transactionhistory.productid    COMMENT     �   COMMENT ON COLUMN production.transactionhistory.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    293            �           0    0 *   COLUMN transactionhistory.referenceorderid    COMMENT     �   COMMENT ON COLUMN production.transactionhistory.referenceorderid IS 'Purchase order, sales order, or work order identification number.';
       
   production               example    false    293            �           0    0 .   COLUMN transactionhistory.referenceorderlineid    COMMENT     �   COMMENT ON COLUMN production.transactionhistory.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';
       
   production               example    false    293            �           0    0 )   COLUMN transactionhistory.transactiondate    COMMENT     h   COMMENT ON COLUMN production.transactionhistory.transactiondate IS 'Date and time of the transaction.';
       
   production               example    false    293            �           0    0 )   COLUMN transactionhistory.transactiontype    COMMENT     w   COMMENT ON COLUMN production.transactionhistory.transactiontype IS 'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';
       
   production               example    false    293            �           0    0 "   COLUMN transactionhistory.quantity    COMMENT     Q   COMMENT ON COLUMN production.transactionhistory.quantity IS 'Product quantity.';
       
   production               example    false    293            �           0    0 $   COLUMN transactionhistory.actualcost    COMMENT     O   COMMENT ON COLUMN production.transactionhistory.actualcost IS 'Product cost.';
       
   production               example    false    293            �           1259    18297    th    VIEW       CREATE VIEW pr.th AS
 SELECT transactionid AS id,
    transactionid,
    productid,
    referenceorderid,
    referenceorderlineid,
    transactiondate,
    transactiontype,
    quantity,
    actualcost,
    modifieddate
   FROM production.transactionhistory;
    DROP VIEW pr.th;
       pr       v       example    false    293    293    293    293    293    293    293    293    293    15            &           1259    16773    transactionhistoryarchive    TABLE     e  CREATE TABLE production.transactionhistoryarchive (
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer DEFAULT 0 NOT NULL,
    transactiondate timestamp without time zone DEFAULT now() NOT NULL,
    transactiontype character(1) NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK ((upper((transactiontype)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);
 1   DROP TABLE production.transactionhistoryarchive;
    
   production         heap r       example    false    10            �           0    0    TABLE transactionhistoryarchive    COMMENT     ]   COMMENT ON TABLE production.transactionhistoryarchive IS 'Transactions for previous years.';
       
   production               example    false    294            �           0    0 .   COLUMN transactionhistoryarchive.transactionid    COMMENT     ~   COMMENT ON COLUMN production.transactionhistoryarchive.transactionid IS 'Primary key for TransactionHistoryArchive records.';
       
   production               example    false    294            �           0    0 *   COLUMN transactionhistoryarchive.productid    COMMENT     �   COMMENT ON COLUMN production.transactionhistoryarchive.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    294            �           0    0 1   COLUMN transactionhistoryarchive.referenceorderid    COMMENT     �   COMMENT ON COLUMN production.transactionhistoryarchive.referenceorderid IS 'Purchase order, sales order, or work order identification number.';
       
   production               example    false    294            �           0    0 5   COLUMN transactionhistoryarchive.referenceorderlineid    COMMENT     �   COMMENT ON COLUMN production.transactionhistoryarchive.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';
       
   production               example    false    294            �           0    0 0   COLUMN transactionhistoryarchive.transactiondate    COMMENT     o   COMMENT ON COLUMN production.transactionhistoryarchive.transactiondate IS 'Date and time of the transaction.';
       
   production               example    false    294            �           0    0 0   COLUMN transactionhistoryarchive.transactiontype    COMMENT     �   COMMENT ON COLUMN production.transactionhistoryarchive.transactiontype IS 'W = Work Order, S = Sales Order, P = Purchase Order';
       
   production               example    false    294            �           0    0 )   COLUMN transactionhistoryarchive.quantity    COMMENT     X   COMMENT ON COLUMN production.transactionhistoryarchive.quantity IS 'Product quantity.';
       
   production               example    false    294            �           0    0 +   COLUMN transactionhistoryarchive.actualcost    COMMENT     V   COMMENT ON COLUMN production.transactionhistoryarchive.actualcost IS 'Product cost.';
       
   production               example    false    294            �           1259    18301    tha    VIEW       CREATE VIEW pr.tha AS
 SELECT transactionid AS id,
    transactionid,
    productid,
    referenceorderid,
    referenceorderlineid,
    transactiondate,
    transactiontype,
    quantity,
    actualcost,
    modifieddate
   FROM production.transactionhistoryarchive;
    DROP VIEW pr.tha;
       pr       v       example    false    294    294    294    294    294    294    294    294    294    15            '           1259    16782    unitmeasure    TABLE     �   CREATE TABLE production.unitmeasure (
    unitmeasurecode character(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 #   DROP TABLE production.unitmeasure;
    
   production         heap r       example    false    1095    10            �           0    0    TABLE unitmeasure    COMMENT     L   COMMENT ON TABLE production.unitmeasure IS 'Unit of measure lookup table.';
       
   production               example    false    295            �           0    0 "   COLUMN unitmeasure.unitmeasurecode    COMMENT     L   COMMENT ON COLUMN production.unitmeasure.unitmeasurecode IS 'Primary key.';
       
   production               example    false    295            �           0    0    COLUMN unitmeasure.name    COMMENT     Q   COMMENT ON COLUMN production.unitmeasure.name IS 'Unit of measure description.';
       
   production               example    false    295            �           1259    18305    um    VIEW     �   CREATE VIEW pr.um AS
 SELECT unitmeasurecode AS id,
    unitmeasurecode,
    name,
    modifieddate
   FROM production.unitmeasure;
    DROP VIEW pr.um;
       pr       v       example    false    295    295    295    1095    15            )           1259    16789 	   workorder    TABLE     {  CREATE TABLE production.workorder (
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    orderqty integer NOT NULL,
    scrappedqty smallint NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    duedate timestamp without time zone NOT NULL,
    scrapreasonid integer,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrder_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_WorkOrder_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK ((scrappedqty >= 0))
);
 !   DROP TABLE production.workorder;
    
   production         heap r       example    false    10            �           0    0    TABLE workorder    COMMENT     G   COMMENT ON TABLE production.workorder IS 'Manufacturing work orders.';
       
   production               example    false    297            �           0    0    COLUMN workorder.workorderid    COMMENT     \   COMMENT ON COLUMN production.workorder.workorderid IS 'Primary key for WorkOrder records.';
       
   production               example    false    297            �           0    0    COLUMN workorder.productid    COMMENT     x   COMMENT ON COLUMN production.workorder.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   production               example    false    297            �           0    0    COLUMN workorder.orderqty    COMMENT     Q   COMMENT ON COLUMN production.workorder.orderqty IS 'Product quantity to build.';
       
   production               example    false    297            �           0    0    COLUMN workorder.scrappedqty    COMMENT     Z   COMMENT ON COLUMN production.workorder.scrappedqty IS 'Quantity that failed inspection.';
       
   production               example    false    297            �           0    0    COLUMN workorder.startdate    COMMENT     N   COMMENT ON COLUMN production.workorder.startdate IS 'Work order start date.';
       
   production               example    false    297            �           0    0    COLUMN workorder.enddate    COMMENT     J   COMMENT ON COLUMN production.workorder.enddate IS 'Work order end date.';
       
   production               example    false    297            �           0    0    COLUMN workorder.duedate    COMMENT     J   COMMENT ON COLUMN production.workorder.duedate IS 'Work order due date.';
       
   production               example    false    297            �           0    0    COLUMN workorder.scrapreasonid    COMMENT     Z   COMMENT ON COLUMN production.workorder.scrapreasonid IS 'Reason for inspection failure.';
       
   production               example    false    297            �           1259    18309    w    VIEW     �   CREATE VIEW pr.w AS
 SELECT workorderid AS id,
    workorderid,
    productid,
    orderqty,
    scrappedqty,
    startdate,
    enddate,
    duedate,
    scrapreasonid,
    modifieddate
   FROM production.workorder;
    DROP VIEW pr.w;
       pr       v       example    false    297    297    297    297    297    297    297    297    297    15            *           1259    16797    workorderrouting    TABLE     /  CREATE TABLE production.workorderrouting (
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    operationsequence smallint NOT NULL,
    locationid integer NOT NULL,
    scheduledstartdate timestamp without time zone NOT NULL,
    scheduledenddate timestamp without time zone NOT NULL,
    actualstartdate timestamp without time zone,
    actualenddate timestamp without time zone,
    actualresourcehrs numeric(9,4),
    plannedcost numeric NOT NULL,
    actualcost numeric,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK ((actualcost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK (((actualenddate >= actualstartdate) OR (actualenddate IS NULL) OR (actualstartdate IS NULL))),
    CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK ((actualresourcehrs >= 0.0000)),
    CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK ((plannedcost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK ((scheduledenddate >= scheduledstartdate))
);
 (   DROP TABLE production.workorderrouting;
    
   production         heap r       example    false    10            �           0    0    TABLE workorderrouting    COMMENT     G   COMMENT ON TABLE production.workorderrouting IS 'Work order details.';
       
   production               example    false    298            �           0    0 #   COLUMN workorderrouting.workorderid    COMMENT     s   COMMENT ON COLUMN production.workorderrouting.workorderid IS 'Primary key. Foreign key to WorkOrder.WorkOrderID.';
       
   production               example    false    298            �           0    0 !   COLUMN workorderrouting.productid    COMMENT     m   COMMENT ON COLUMN production.workorderrouting.productid IS 'Primary key. Foreign key to Product.ProductID.';
       
   production               example    false    298            �           0    0 )   COLUMN workorderrouting.operationsequence    COMMENT     �   COMMENT ON COLUMN production.workorderrouting.operationsequence IS 'Primary key. Indicates the manufacturing process sequence.';
       
   production               example    false    298            �           0    0 "   COLUMN workorderrouting.locationid    COMMENT     �   COMMENT ON COLUMN production.workorderrouting.locationid IS 'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';
       
   production               example    false    298            �           0    0 *   COLUMN workorderrouting.scheduledstartdate    COMMENT     i   COMMENT ON COLUMN production.workorderrouting.scheduledstartdate IS 'Planned manufacturing start date.';
       
   production               example    false    298            �           0    0 (   COLUMN workorderrouting.scheduledenddate    COMMENT     e   COMMENT ON COLUMN production.workorderrouting.scheduledenddate IS 'Planned manufacturing end date.';
       
   production               example    false    298            �           0    0 '   COLUMN workorderrouting.actualstartdate    COMMENT     W   COMMENT ON COLUMN production.workorderrouting.actualstartdate IS 'Actual start date.';
       
   production               example    false    298            �           0    0 %   COLUMN workorderrouting.actualenddate    COMMENT     S   COMMENT ON COLUMN production.workorderrouting.actualenddate IS 'Actual end date.';
       
   production               example    false    298            �           0    0 )   COLUMN workorderrouting.actualresourcehrs    COMMENT     j   COMMENT ON COLUMN production.workorderrouting.actualresourcehrs IS 'Number of manufacturing hours used.';
       
   production               example    false    298            �           0    0 #   COLUMN workorderrouting.plannedcost    COMMENT     ^   COMMENT ON COLUMN production.workorderrouting.plannedcost IS 'Estimated manufacturing cost.';
       
   production               example    false    298            �           0    0 "   COLUMN workorderrouting.actualcost    COMMENT     Z   COMMENT ON COLUMN production.workorderrouting.actualcost IS 'Actual manufacturing cost.';
       
   production               example    false    298            �           1259    18313    wr    VIEW     ;  CREATE VIEW pr.wr AS
 SELECT workorderid AS id,
    workorderid,
    productid,
    operationsequence,
    locationid,
    scheduledstartdate,
    scheduledenddate,
    actualstartdate,
    actualenddate,
    actualresourcehrs,
    plannedcost,
    actualcost,
    modifieddate
   FROM production.workorderrouting;
    DROP VIEW pr.wr;
       pr       v       example    false    298    298    298    298    298    298    298    298    298    298    298    298    15                       1259    16589 %   billofmaterials_billofmaterialsid_seq    SEQUENCE     �   CREATE SEQUENCE production.billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE production.billofmaterials_billofmaterialsid_seq;
    
   production               example    false    262    10            �           0    0 %   billofmaterials_billofmaterialsid_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE production.billofmaterials_billofmaterialsid_seq OWNED BY production.billofmaterials.billofmaterialsid;
       
   production               example    false    261                       1259    16715    illustration_illustrationid_seq    SEQUENCE     �   CREATE SEQUENCE production.illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE production.illustration_illustrationid_seq;
    
   production               example    false    10    282            �           0    0    illustration_illustrationid_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE production.illustration_illustrationid_seq OWNED BY production.illustration.illustrationid;
       
   production               example    false    281                       1259    16688    location_locationid_seq    SEQUENCE     �   CREATE SEQUENCE production.location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE production.location_locationid_seq;
    
   production               example    false    10    278            �           0    0    location_locationid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE production.location_locationid_seq OWNED BY production.location.locationid;
       
   production               example    false    277                       1259    16646    product_productid_seq    SEQUENCE     �   CREATE SEQUENCE production.product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE production.product_productid_seq;
    
   production               example    false    272    10            �           0    0    product_productid_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE production.product_productid_seq OWNED BY production.product.productid;
       
   production               example    false    271            	           1259    16619 %   productcategory_productcategoryid_seq    SEQUENCE     �   CREATE SEQUENCE production.productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE production.productcategory_productcategoryid_seq;
    
   production               example    false    266    10            �           0    0 %   productcategory_productcategoryid_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE production.productcategory_productcategoryid_seq OWNED BY production.productcategory.productcategoryid;
       
   production               example    false    265                       1259    16675 +   productdescription_productdescriptionid_seq    SEQUENCE     �   CREATE SEQUENCE production.productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 F   DROP SEQUENCE production.productdescription_productdescriptionid_seq;
    
   production               example    false    275    10            �           0    0 +   productdescription_productdescriptionid_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE production.productdescription_productdescriptionid_seq OWNED BY production.productdescription.productdescriptionid;
       
   production               example    false    274                       1259    16637    productmodel_productmodelid_seq    SEQUENCE     �   CREATE SEQUENCE production.productmodel_productmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE production.productmodel_productmodelid_seq;
    
   production               example    false    270    10            �           0    0    productmodel_productmodelid_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE production.productmodel_productmodelid_seq OWNED BY production.productmodel.productmodelid;
       
   production               example    false    269                       1259    16731    productphoto_productphotoid_seq    SEQUENCE     �   CREATE SEQUENCE production.productphoto_productphotoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE production.productphoto_productphotoid_seq;
    
   production               example    false    286    10            �           0    0    productphoto_productphotoid_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE production.productphoto_productphotoid_seq OWNED BY production.productphoto.productphotoid;
       
   production               example    false    285                        1259    16744 !   productreview_productreviewid_seq    SEQUENCE     �   CREATE SEQUENCE production.productreview_productreviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE production.productreview_productreviewid_seq;
    
   production               example    false    10    289            �           0    0 !   productreview_productreviewid_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE production.productreview_productreviewid_seq OWNED BY production.productreview.productreviewid;
       
   production               example    false    288                       1259    16628 +   productsubcategory_productsubcategoryid_seq    SEQUENCE     �   CREATE SEQUENCE production.productsubcategory_productsubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 F   DROP SEQUENCE production.productsubcategory_productsubcategoryid_seq;
    
   production               example    false    268    10            �           0    0 +   productsubcategory_productsubcategoryid_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE production.productsubcategory_productsubcategoryid_seq OWNED BY production.productsubcategory.productsubcategoryid;
       
   production               example    false    267            "           1259    16754    scrapreason_scrapreasonid_seq    SEQUENCE     �   CREATE SEQUENCE production.scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE production.scrapreason_scrapreasonid_seq;
    
   production               example    false    10    291            �           0    0    scrapreason_scrapreasonid_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE production.scrapreason_scrapreasonid_seq OWNED BY production.scrapreason.scrapreasonid;
       
   production               example    false    290            $           1259    16762 $   transactionhistory_transactionid_seq    SEQUENCE     �   CREATE SEQUENCE production.transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE production.transactionhistory_transactionid_seq;
    
   production               example    false    293    10            �           0    0 $   transactionhistory_transactionid_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE production.transactionhistory_transactionid_seq OWNED BY production.transactionhistory.transactionid;
       
   production               example    false    292            Y           1259    18051    vproductanddescription    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW production.vproductanddescription AS
 SELECT p.productid,
    p.name,
    pm.name AS productmodel,
    pmx.cultureid,
    pd.description
   FROM (((production.product p
     JOIN production.productmodel pm ON ((p.productmodelid = pm.productmodelid)))
     JOIN production.productmodelproductdescriptionculture pmx ON ((pm.productmodelid = pmx.productmodelid)))
     JOIN production.productdescription pd ON ((pmx.productdescriptionid = pd.productdescriptionid)))
  WITH NO DATA;
 :   DROP MATERIALIZED VIEW production.vproductanddescription;
    
   production         heap m       example    false    284    284    284    275    275    272    272    272    270    270    1095    10    1095            Z           1259    18070    vproductmodelcatalogdescription    VIEW     �  CREATE VIEW production.vproductmodelcatalogdescription AS
 SELECT productmodelid,
    name,
    ((xpath('/p1:ProductDescription/p1:Summary/html:p/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{html,http://www.w3.org/1999/xhtml}}'::text[]))[1])::character varying AS "Summary",
    ((xpath('/p1:ProductDescription/p1:Manufacturer/p1:Name/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying AS manufacturer,
    ((xpath('/p1:ProductDescription/p1:Manufacturer/p1:Copyright/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(30) AS copyright,
    ((xpath('/p1:ProductDescription/p1:Manufacturer/p1:ProductURL/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS producturl,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS warrantyperiod,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS warrantydescription,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS noofyears,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS maintenancedescription,
    ((xpath('/p1:ProductDescription/p1:Features/wf:wheel/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS wheel,
    ((xpath('/p1:ProductDescription/p1:Features/wf:saddle/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS saddle,
    ((xpath('/p1:ProductDescription/p1:Features/wf:pedal/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS pedal,
    ((xpath('/p1:ProductDescription/p1:Features/wf:BikeFrame/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying AS bikeframe,
    ((xpath('/p1:ProductDescription/p1:Features/wf:crankset/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS crankset,
    ((xpath('/p1:ProductDescription/p1:Picture/p1:Angle/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS pictureangle,
    ((xpath('/p1:ProductDescription/p1:Picture/p1:Size/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS picturesize,
    ((xpath('/p1:ProductDescription/p1:Picture/p1:ProductPhotoID/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS productphotoid,
    ((xpath('/p1:ProductDescription/p1:Specifications/Material/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS material,
    ((xpath('/p1:ProductDescription/p1:Specifications/Color/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS color,
    ((xpath('/p1:ProductDescription/p1:Specifications/ProductLine/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS productline,
    ((xpath('/p1:ProductDescription/p1:Specifications/Style/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS style,
    ((xpath('/p1:ProductDescription/p1:Specifications/RiderExperience/text()'::text, catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(1024) AS riderexperience,
    rowguid,
    modifieddate
   FROM production.productmodel
  WHERE (catalogdescription IS NOT NULL);
 6   DROP VIEW production.vproductmodelcatalogdescription;
    
   production       v       example    false    270    270    270    270    270    1095    10            [           1259    18075    vproductmodelinstructions    VIEW     �  CREATE VIEW production.vproductmodelinstructions AS
 SELECT productmodelid,
    name,
    ((xpath('/ns:root/text()'::text, instructions, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions}}'::text[]))[1])::character varying AS instructions,
    (((xpath('@LocationID'::text, mfginstructions))[1])::character varying)::integer AS "LocationID",
    (((xpath('@SetupHours'::text, mfginstructions))[1])::character varying)::numeric(9,4) AS "SetupHours",
    (((xpath('@MachineHours'::text, mfginstructions))[1])::character varying)::numeric(9,4) AS "MachineHours",
    (((xpath('@LaborHours'::text, mfginstructions))[1])::character varying)::numeric(9,4) AS "LaborHours",
    (((xpath('@LotSize'::text, mfginstructions))[1])::character varying)::integer AS "LotSize",
    ((xpath('/step/text()'::text, step))[1])::character varying(1024) AS "Step",
    rowguid,
    modifieddate
   FROM ( SELECT locations.productmodelid,
            locations.name,
            locations.rowguid,
            locations.modifieddate,
            locations.instructions,
            locations.mfginstructions,
            unnest(xpath('step'::text, locations.mfginstructions)) AS step
           FROM ( SELECT productmodel.productmodelid,
                    productmodel.name,
                    productmodel.rowguid,
                    productmodel.modifieddate,
                    productmodel.instructions,
                    unnest(xpath('/ns:root/ns:Location'::text, productmodel.instructions, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions}}'::text[])) AS mfginstructions
                   FROM production.productmodel) locations) pm;
 0   DROP VIEW production.vproductmodelinstructions;
    
   production       v       example    false    270    270    270    270    270    10    1095            (           1259    16788    workorder_workorderid_seq    SEQUENCE     �   CREATE SEQUENCE production.workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE production.workorder_workorderid_seq;
    
   production               example    false    10    297            �           0    0    workorder_workorderid_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE production.workorder_workorderid_seq OWNED BY production.workorder.workorderid;
       
   production               example    false    296            -           1259    16832    purchaseorderdetail    TABLE     �  CREATE TABLE purchasing.purchaseorderdetail (
    purchaseorderid integer NOT NULL,
    purchaseorderdetailid integer NOT NULL,
    duedate timestamp without time zone NOT NULL,
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    unitprice numeric NOT NULL,
    receivedqty numeric(8,2) NOT NULL,
    rejectedqty numeric(8,2) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK ((receivedqty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK ((rejectedqty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK ((unitprice >= 0.00))
);
 +   DROP TABLE purchasing.purchaseorderdetail;
    
   purchasing         heap r       example    false    11            �           0    0    TABLE purchaseorderdetail    COMMENT     �   COMMENT ON TABLE purchasing.purchaseorderdetail IS 'Individual products associated with a specific purchase order. See PurchaseOrderHeader.';
       
   purchasing               example    false    301            �           0    0 *   COLUMN purchaseorderdetail.purchaseorderid    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderdetail.purchaseorderid IS 'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.';
       
   purchasing               example    false    301            �           0    0 0   COLUMN purchaseorderdetail.purchaseorderdetailid    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderdetail.purchaseorderdetailid IS 'Primary key. One line number per purchased product.';
       
   purchasing               example    false    301            �           0    0 "   COLUMN purchaseorderdetail.duedate    COMMENT     l   COMMENT ON COLUMN purchasing.purchaseorderdetail.duedate IS 'Date the product is expected to be received.';
       
   purchasing               example    false    301            �           0    0 #   COLUMN purchaseorderdetail.orderqty    COMMENT     R   COMMENT ON COLUMN purchasing.purchaseorderdetail.orderqty IS 'Quantity ordered.';
       
   purchasing               example    false    301            �           0    0 $   COLUMN purchaseorderdetail.productid    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderdetail.productid IS 'Product identification number. Foreign key to Product.ProductID.';
       
   purchasing               example    false    301            �           0    0 $   COLUMN purchaseorderdetail.unitprice    COMMENT     n   COMMENT ON COLUMN purchasing.purchaseorderdetail.unitprice IS 'Vendor''s selling price of a single product.';
       
   purchasing               example    false    301            �           0    0 &   COLUMN purchaseorderdetail.receivedqty    COMMENT     o   COMMENT ON COLUMN purchasing.purchaseorderdetail.receivedqty IS 'Quantity actually received from the vendor.';
       
   purchasing               example    false    301            �           0    0 &   COLUMN purchaseorderdetail.rejectedqty    COMMENT     h   COMMENT ON COLUMN purchasing.purchaseorderdetail.rejectedqty IS 'Quantity rejected during inspection.';
       
   purchasing               example    false    301            �           1259    18322    pod    VIEW     �   CREATE VIEW pu.pod AS
 SELECT purchaseorderdetailid AS id,
    purchaseorderid,
    purchaseorderdetailid,
    duedate,
    orderqty,
    productid,
    unitprice,
    receivedqty,
    rejectedqty,
    modifieddate
   FROM purchasing.purchaseorderdetail;
    DROP VIEW pu.pod;
       pu       v       example    false    301    301    301    301    301    301    301    301    301    16            /           1259    16844    purchaseorderheader    TABLE     �  CREATE TABLE purchasing.purchaseorderheader (
    purchaseorderid integer NOT NULL,
    revisionnumber smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    employeeid integer NOT NULL,
    vendorid integer NOT NULL,
    shipmethodid integer NOT NULL,
    orderdate timestamp without time zone DEFAULT now() NOT NULL,
    shipdate timestamp without time zone,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    taxamt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_PurchaseOrderHeader_Status" CHECK (((status >= 1) AND (status <= 4))),
    CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);
 +   DROP TABLE purchasing.purchaseorderheader;
    
   purchasing         heap r       example    false    11            �           0    0    TABLE purchaseorderheader    COMMENT     s   COMMENT ON TABLE purchasing.purchaseorderheader IS 'General purchase order information. See PurchaseOrderDetail.';
       
   purchasing               example    false    303            �           0    0 *   COLUMN purchaseorderheader.purchaseorderid    COMMENT     T   COMMENT ON COLUMN purchasing.purchaseorderheader.purchaseorderid IS 'Primary key.';
       
   purchasing               example    false    303            �           0    0 )   COLUMN purchaseorderheader.revisionnumber    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderheader.revisionnumber IS 'Incremental number to track changes to the purchase order over time.';
       
   purchasing               example    false    303            �           0    0 !   COLUMN purchaseorderheader.status    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderheader.status IS 'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';
       
   purchasing               example    false    303            �           0    0 %   COLUMN purchaseorderheader.employeeid    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderheader.employeeid IS 'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';
       
   purchasing               example    false    303            �           0    0 #   COLUMN purchaseorderheader.vendorid    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderheader.vendorid IS 'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';
       
   purchasing               example    false    303            �           0    0 '   COLUMN purchaseorderheader.shipmethodid    COMMENT     }   COMMENT ON COLUMN purchasing.purchaseorderheader.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';
       
   purchasing               example    false    303            �           0    0 $   COLUMN purchaseorderheader.orderdate    COMMENT     _   COMMENT ON COLUMN purchasing.purchaseorderheader.orderdate IS 'Purchase order creation date.';
       
   purchasing               example    false    303            �           0    0 #   COLUMN purchaseorderheader.shipdate    COMMENT     i   COMMENT ON COLUMN purchasing.purchaseorderheader.shipdate IS 'Estimated shipment date from the vendor.';
       
   purchasing               example    false    303            �           0    0 #   COLUMN purchaseorderheader.subtotal    COMMENT     �   COMMENT ON COLUMN purchasing.purchaseorderheader.subtotal IS 'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';
       
   purchasing               example    false    303            �           0    0 !   COLUMN purchaseorderheader.taxamt    COMMENT     J   COMMENT ON COLUMN purchasing.purchaseorderheader.taxamt IS 'Tax amount.';
       
   purchasing               example    false    303            �           0    0 "   COLUMN purchaseorderheader.freight    COMMENT     N   COMMENT ON COLUMN purchasing.purchaseorderheader.freight IS 'Shipping cost.';
       
   purchasing               example    false    303            �           1259    18326    poh    VIEW       CREATE VIEW pu.poh AS
 SELECT purchaseorderid AS id,
    purchaseorderid,
    revisionnumber,
    status,
    employeeid,
    vendorid,
    shipmethodid,
    orderdate,
    shipdate,
    subtotal,
    taxamt,
    freight,
    modifieddate
   FROM purchasing.purchaseorderheader;
    DROP VIEW pu.poh;
       pu       v       example    false    303    303    303    303    303    303    303    303    303    303    303    303    16            +           1259    16819    productvendor    TABLE     �  CREATE TABLE purchasing.productvendor (
    productid integer NOT NULL,
    businessentityid integer NOT NULL,
    averageleadtime integer NOT NULL,
    standardprice numeric NOT NULL,
    lastreceiptcost numeric,
    lastreceiptdate timestamp without time zone,
    minorderqty integer NOT NULL,
    maxorderqty integer NOT NULL,
    onorderqty integer,
    unitmeasurecode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK ((averageleadtime >= 1)),
    CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK ((lastreceiptcost > 0.00)),
    CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK ((maxorderqty >= 1)),
    CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK ((minorderqty >= 1)),
    CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK ((onorderqty >= 0)),
    CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK ((standardprice > 0.00))
);
 %   DROP TABLE purchasing.productvendor;
    
   purchasing         heap r       example    false    11            �           0    0    TABLE productvendor    COMMENT     u   COMMENT ON TABLE purchasing.productvendor IS 'Cross-reference table mapping vendors with the products they supply.';
       
   purchasing               example    false    299            �           0    0    COLUMN productvendor.productid    COMMENT     j   COMMENT ON COLUMN purchasing.productvendor.productid IS 'Primary key. Foreign key to Product.ProductID.';
       
   purchasing               example    false    299            �           0    0 %   COLUMN productvendor.businessentityid    COMMENT     w   COMMENT ON COLUMN purchasing.productvendor.businessentityid IS 'Primary key. Foreign key to Vendor.BusinessEntityID.';
       
   purchasing               example    false    299            �           0    0 $   COLUMN productvendor.averageleadtime    COMMENT     �   COMMENT ON COLUMN purchasing.productvendor.averageleadtime IS 'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.';
       
   purchasing               example    false    299                        0    0 "   COLUMN productvendor.standardprice    COMMENT     b   COMMENT ON COLUMN purchasing.productvendor.standardprice IS 'The vendor''s usual selling price.';
       
   purchasing               example    false    299                       0    0 $   COLUMN productvendor.lastreceiptcost    COMMENT     h   COMMENT ON COLUMN purchasing.productvendor.lastreceiptcost IS 'The selling price when last purchased.';
       
   purchasing               example    false    299                       0    0 $   COLUMN productvendor.lastreceiptdate    COMMENT     s   COMMENT ON COLUMN purchasing.productvendor.lastreceiptdate IS 'Date the product was last received by the vendor.';
       
   purchasing               example    false    299                       0    0     COLUMN productvendor.minorderqty    COMMENT     j   COMMENT ON COLUMN purchasing.productvendor.minorderqty IS 'The maximum quantity that should be ordered.';
       
   purchasing               example    false    299                       0    0     COLUMN productvendor.maxorderqty    COMMENT     j   COMMENT ON COLUMN purchasing.productvendor.maxorderqty IS 'The minimum quantity that should be ordered.';
       
   purchasing               example    false    299                       0    0    COLUMN productvendor.onorderqty    COMMENT     ]   COMMENT ON COLUMN purchasing.productvendor.onorderqty IS 'The quantity currently on order.';
       
   purchasing               example    false    299                       0    0 $   COLUMN productvendor.unitmeasurecode    COMMENT     a   COMMENT ON COLUMN purchasing.productvendor.unitmeasurecode IS 'The product''s unit of measure.';
       
   purchasing               example    false    299            �           1259    18318    pv    VIEW       CREATE VIEW pu.pv AS
 SELECT productid AS id,
    productid,
    businessentityid,
    averageleadtime,
    standardprice,
    lastreceiptcost,
    lastreceiptdate,
    minorderqty,
    maxorderqty,
    onorderqty,
    unitmeasurecode,
    modifieddate
   FROM purchasing.productvendor;
    DROP VIEW pu.pv;
       pu       v       example    false    299    299    299    299    299    299    299    299    299    299    299    16            1           1259    16863 
   shipmethod    TABLE     �  CREATE TABLE purchasing.shipmethod (
    shipmethodid integer NOT NULL,
    name public."Name" NOT NULL,
    shipbase numeric DEFAULT 0.00 NOT NULL,
    shiprate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((shipbase > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shiprate > 0.00))
);
 "   DROP TABLE purchasing.shipmethod;
    
   purchasing         heap r       example    false    2    11    1095                       0    0    TABLE shipmethod    COMMENT     L   COMMENT ON TABLE purchasing.shipmethod IS 'Shipping company lookup table.';
       
   purchasing               example    false    305                       0    0    COLUMN shipmethod.shipmethodid    COMMENT     _   COMMENT ON COLUMN purchasing.shipmethod.shipmethodid IS 'Primary key for ShipMethod records.';
       
   purchasing               example    false    305            	           0    0    COLUMN shipmethod.name    COMMENT     J   COMMENT ON COLUMN purchasing.shipmethod.name IS 'Shipping company name.';
       
   purchasing               example    false    305            
           0    0    COLUMN shipmethod.shipbase    COMMENT     P   COMMENT ON COLUMN purchasing.shipmethod.shipbase IS 'Minimum shipping charge.';
       
   purchasing               example    false    305                       0    0    COLUMN shipmethod.shiprate    COMMENT     R   COMMENT ON COLUMN purchasing.shipmethod.shiprate IS 'Shipping charge per pound.';
       
   purchasing               example    false    305            �           1259    18330    sm    VIEW     �   CREATE VIEW pu.sm AS
 SELECT shipmethodid AS id,
    shipmethodid,
    name,
    shipbase,
    shiprate,
    rowguid,
    modifieddate
   FROM purchasing.shipmethod;
    DROP VIEW pu.sm;
       pu       v       example    false    305    305    305    305    305    305    1095    16            2           1259    16875    vendor    TABLE       CREATE TABLE purchasing.vendor (
    businessentityid integer NOT NULL,
    accountnumber public."AccountNumber" NOT NULL,
    name public."Name" NOT NULL,
    creditrating smallint NOT NULL,
    preferredvendorstatus public."Flag" DEFAULT true NOT NULL,
    activeflag public."Flag" DEFAULT true NOT NULL,
    purchasingwebserviceurl character varying(1024),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((creditrating >= 1) AND (creditrating <= 5)))
);
    DROP TABLE purchasing.vendor;
    
   purchasing         heap r       example    false    1089    1089    1089    1095    1086    1089    11                       0    0    TABLE vendor    COMMENT     t   COMMENT ON TABLE purchasing.vendor IS 'Companies from whom Adventure Works Cycles purchases parts or other goods.';
       
   purchasing               example    false    306                       0    0    COLUMN vendor.businessentityid    COMMENT     �   COMMENT ON COLUMN purchasing.vendor.businessentityid IS 'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID';
       
   purchasing               example    false    306                       0    0    COLUMN vendor.accountnumber    COMMENT     `   COMMENT ON COLUMN purchasing.vendor.accountnumber IS 'Vendor account (identification) number.';
       
   purchasing               example    false    306                       0    0    COLUMN vendor.name    COMMENT     =   COMMENT ON COLUMN purchasing.vendor.name IS 'Company name.';
       
   purchasing               example    false    306                       0    0    COLUMN vendor.creditrating    COMMENT     �   COMMENT ON COLUMN purchasing.vendor.creditrating IS '1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';
       
   purchasing               example    false    306                       0    0 #   COLUMN vendor.preferredvendorstatus    COMMENT     �   COMMENT ON COLUMN purchasing.vendor.preferredvendorstatus IS '0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.';
       
   purchasing               example    false    306                       0    0    COLUMN vendor.activeflag    COMMENT     m   COMMENT ON COLUMN purchasing.vendor.activeflag IS '0 = Vendor no longer used. 1 = Vendor is actively used.';
       
   purchasing               example    false    306                       0    0 %   COLUMN vendor.purchasingwebserviceurl    COMMENT     N   COMMENT ON COLUMN purchasing.vendor.purchasingwebserviceurl IS 'Vendor URL.';
       
   purchasing               example    false    306            �           1259    18334    v    VIEW     �   CREATE VIEW pu.v AS
 SELECT businessentityid AS id,
    businessentityid,
    accountnumber,
    name,
    creditrating,
    preferredvendorstatus,
    activeflag,
    purchasingwebserviceurl,
    modifieddate
   FROM purchasing.vendor;
    DROP VIEW pu.v;
       pu       v       example    false    306    306    306    306    306    306    306    306    1086    1095    1089    1089    16            �           1259    18799    city    TABLE     �   CREATE TABLE public.city (
    id integer NOT NULL,
    name text NOT NULL,
    countrycode character(3) NOT NULL,
    district text NOT NULL,
    population integer NOT NULL
);
    DROP TABLE public.city;
       public         heap r       example    false            �           1259    18804    country    TABLE     �  CREATE TABLE public.country (
    code character(3) NOT NULL,
    name text NOT NULL,
    continent text NOT NULL,
    region text NOT NULL,
    surfacearea real NOT NULL,
    indepyear smallint,
    population integer NOT NULL,
    lifeexpectancy real,
    gnp numeric(10,2),
    gnpold numeric(10,2),
    localname text NOT NULL,
    governmentform text NOT NULL,
    headofstate text,
    capital integer,
    code2 character(2) NOT NULL,
    CONSTRAINT country_continent_check CHECK (((continent = 'Asia'::text) OR (continent = 'Europe'::text) OR (continent = 'North America'::text) OR (continent = 'Africa'::text) OR (continent = 'Oceania'::text) OR (continent = 'Antarctica'::text) OR (continent = 'South America'::text)))
);
    DROP TABLE public.country;
       public         heap r       example    false            �           1259    18810    countrylanguage    TABLE     �   CREATE TABLE public.countrylanguage (
    countrycode character(3) NOT NULL,
    language text NOT NULL,
    isofficial boolean NOT NULL,
    percentage real NOT NULL
);
 #   DROP TABLE public.countrylanguage;
       public         heap r       example    false            ,           1259    16831 -   purchaseorderdetail_purchaseorderdetailid_seq    SEQUENCE     �   CREATE SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 H   DROP SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq;
    
   purchasing               example    false    301    11                       0    0 -   purchaseorderdetail_purchaseorderdetailid_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq OWNED BY purchasing.purchaseorderdetail.purchaseorderdetailid;
       
   purchasing               example    false    300            .           1259    16843 '   purchaseorderheader_purchaseorderid_seq    SEQUENCE     �   CREATE SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq;
    
   purchasing               example    false    11    303                       0    0 '   purchaseorderheader_purchaseorderid_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq OWNED BY purchasing.purchaseorderheader.purchaseorderid;
       
   purchasing               example    false    302            0           1259    16862    shipmethod_shipmethodid_seq    SEQUENCE     �   CREATE SEQUENCE purchasing.shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE purchasing.shipmethod_shipmethodid_seq;
    
   purchasing               example    false    305    11                       0    0    shipmethod_shipmethodid_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE purchasing.shipmethod_shipmethodid_seq OWNED BY purchasing.shipmethod.shipmethodid;
       
   purchasing               example    false    304            d           1259    18132    vvendorwithaddresses    VIEW     �  CREATE VIEW purchasing.vvendorwithaddresses AS
 SELECT v.businessentityid,
    v.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
   FROM (((((purchasing.vendor v
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = v.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN person.addresstype at ON ((at.addresstypeid = bea.addresstypeid)));
 +   DROP VIEW purchasing.vvendorwithaddresses;
    
   purchasing       v       example    false    241    236    236    236    238    238    238    238    238    238    240    240    306    306    241    241    251    251    1095    1095    1095    1095    11            c           1259    18127    vvendorwithcontacts    VIEW     <  CREATE VIEW purchasing.vvendorwithcontacts AS
 SELECT v.businessentityid,
    v.name,
    ct.name AS contacttype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion
   FROM ((((((purchasing.vendor v
     JOIN person.businessentitycontact bec ON ((bec.businessentityid = v.businessentityid)))
     JOIN person.contacttype ct ON ((ct.contacttypeid = bec.contacttypeid)))
     JOIN person.person p ON ((p.businessentityid = bec.personid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));
 *   DROP VIEW purchasing.vvendorwithcontacts;
    
   purchasing       v       example    false    244    243    243    234    234    234    234    234    234    234    306    306    250    250    250    249    249    246    246    244    244    1098    1095    11    1095    1095    1095    1095    1095            :           1259    16910    customer    TABLE       CREATE TABLE sales.customer (
    customerid integer NOT NULL,
    personid integer,
    storeid integer,
    territoryid integer,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE sales.customer;
       sales         heap r       example    false    2    12                       0    0    TABLE customer    COMMENT     j   COMMENT ON TABLE sales.customer IS 'Current customer information. Also see the Person and Store tables.';
          sales               example    false    314                       0    0    COLUMN customer.customerid    COMMENT     ?   COMMENT ON COLUMN sales.customer.customerid IS 'Primary key.';
          sales               example    false    314                       0    0    COLUMN customer.personid    COMMENT     W   COMMENT ON COLUMN sales.customer.personid IS 'Foreign key to Person.BusinessEntityID';
          sales               example    false    314                       0    0    COLUMN customer.storeid    COMMENT     U   COMMENT ON COLUMN sales.customer.storeid IS 'Foreign key to Store.BusinessEntityID';
          sales               example    false    314                       0    0    COLUMN customer.territoryid    COMMENT     �   COMMENT ON COLUMN sales.customer.territoryid IS 'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.';
          sales               example    false    314            �           1259    18355    c    VIEW     �   CREATE VIEW sa.c AS
 SELECT customerid AS id,
    customerid,
    personid,
    storeid,
    territoryid,
    rowguid,
    modifieddate
   FROM sales.customer;
    DROP VIEW sa.c;
       sa       v       example    false    314    314    314    314    314    314    17            5           1259    16890 
   creditcard    TABLE     %  CREATE TABLE sales.creditcard (
    creditcardid integer NOT NULL,
    cardtype character varying(50) NOT NULL,
    cardnumber character varying(25) NOT NULL,
    expmonth smallint NOT NULL,
    expyear smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE sales.creditcard;
       sales         heap r       example    false    12                       0    0    TABLE creditcard    COMMENT     J   COMMENT ON TABLE sales.creditcard IS 'Customer credit card information.';
          sales               example    false    309                       0    0    COLUMN creditcard.creditcardid    COMMENT     Z   COMMENT ON COLUMN sales.creditcard.creditcardid IS 'Primary key for CreditCard records.';
          sales               example    false    309                       0    0    COLUMN creditcard.cardtype    COMMENT     D   COMMENT ON COLUMN sales.creditcard.cardtype IS 'Credit card name.';
          sales               example    false    309                       0    0    COLUMN creditcard.cardnumber    COMMENT     H   COMMENT ON COLUMN sales.creditcard.cardnumber IS 'Credit card number.';
          sales               example    false    309                        0    0    COLUMN creditcard.expmonth    COMMENT     P   COMMENT ON COLUMN sales.creditcard.expmonth IS 'Credit card expiration month.';
          sales               example    false    309            !           0    0    COLUMN creditcard.expyear    COMMENT     N   COMMENT ON COLUMN sales.creditcard.expyear IS 'Credit card expiration year.';
          sales               example    false    309            �           1259    18343    cc    VIEW     �   CREATE VIEW sa.cc AS
 SELECT creditcardid AS id,
    creditcardid,
    cardtype,
    cardnumber,
    expmonth,
    expyear,
    modifieddate
   FROM sales.creditcard;
    DROP VIEW sa.cc;
       sa       v       example    false    309    309    309    309    309    309    17            8           1259    16902    currencyrate    TABLE     d  CREATE TABLE sales.currencyrate (
    currencyrateid integer NOT NULL,
    currencyratedate timestamp without time zone NOT NULL,
    fromcurrencycode character(3) NOT NULL,
    tocurrencycode character(3) NOT NULL,
    averagerate numeric NOT NULL,
    endofdayrate numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE sales.currencyrate;
       sales         heap r       example    false    12            "           0    0    TABLE currencyrate    COMMENT     C   COMMENT ON TABLE sales.currencyrate IS 'Currency exchange rates.';
          sales               example    false    312            #           0    0 "   COLUMN currencyrate.currencyrateid    COMMENT     `   COMMENT ON COLUMN sales.currencyrate.currencyrateid IS 'Primary key for CurrencyRate records.';
          sales               example    false    312            $           0    0 $   COLUMN currencyrate.currencyratedate    COMMENT     j   COMMENT ON COLUMN sales.currencyrate.currencyratedate IS 'Date and time the exchange rate was obtained.';
          sales               example    false    312            %           0    0 $   COLUMN currencyrate.fromcurrencycode    COMMENT     q   COMMENT ON COLUMN sales.currencyrate.fromcurrencycode IS 'Exchange rate was converted from this currency code.';
          sales               example    false    312            &           0    0 "   COLUMN currencyrate.tocurrencycode    COMMENT     m   COMMENT ON COLUMN sales.currencyrate.tocurrencycode IS 'Exchange rate was converted to this currency code.';
          sales               example    false    312            '           0    0    COLUMN currencyrate.averagerate    COMMENT     Z   COMMENT ON COLUMN sales.currencyrate.averagerate IS 'Average exchange rate for the day.';
          sales               example    false    312            (           0    0     COLUMN currencyrate.endofdayrate    COMMENT     Y   COMMENT ON COLUMN sales.currencyrate.endofdayrate IS 'Final exchange rate for the day.';
          sales               example    false    312            �           1259    18351    cr    VIEW     �   CREATE VIEW sa.cr AS
 SELECT currencyrateid,
    currencyratedate,
    fromcurrencycode,
    tocurrencycode,
    averagerate,
    endofdayrate,
    modifieddate
   FROM sales.currencyrate;
    DROP VIEW sa.cr;
       sa       v       example    false    312    312    312    312    312    312    312    17            3           1259    16885    countryregioncurrency    TABLE     �   CREATE TABLE sales.countryregioncurrency (
    countryregioncode character varying(3) NOT NULL,
    currencycode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 (   DROP TABLE sales.countryregioncurrency;
       sales         heap r       example    false    12            )           0    0    TABLE countryregioncurrency    COMMENT     |   COMMENT ON TABLE sales.countryregioncurrency IS 'Cross-reference table mapping ISO currency codes to a country or region.';
          sales               example    false    307            *           0    0 .   COLUMN countryregioncurrency.countryregioncode    COMMENT     �   COMMENT ON COLUMN sales.countryregioncurrency.countryregioncode IS 'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';
          sales               example    false    307            +           0    0 )   COLUMN countryregioncurrency.currencycode    COMMENT     �   COMMENT ON COLUMN sales.countryregioncurrency.currencycode IS 'ISO standard currency code. Foreign key to Currency.CurrencyCode.';
          sales               example    false    307            �           1259    18339    crc    VIEW     y   CREATE VIEW sa.crc AS
 SELECT countryregioncode,
    currencycode,
    modifieddate
   FROM sales.countryregioncurrency;
    DROP VIEW sa.crc;
       sa       v       example    false    307    307    307    17            6           1259    16895    currency    TABLE     �   CREATE TABLE sales.currency (
    currencycode character(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE sales.currency;
       sales         heap r       example    false    12    1095            ,           0    0    TABLE currency    COMMENT     W   COMMENT ON TABLE sales.currency IS 'Lookup table containing standard ISO currencies.';
          sales               example    false    310            -           0    0    COLUMN currency.currencycode    COMMENT     S   COMMENT ON COLUMN sales.currency.currencycode IS 'The ISO code for the Currency.';
          sales               example    false    310            .           0    0    COLUMN currency.name    COMMENT     ;   COMMENT ON COLUMN sales.currency.name IS 'Currency name.';
          sales               example    false    310            �           1259    18347    cu    VIEW     v   CREATE VIEW sa.cu AS
 SELECT currencycode AS id,
    currencycode,
    name,
    modifieddate
   FROM sales.currency;
    DROP VIEW sa.cu;
       sa       v       example    false    310    310    310    1095    17            ;           1259    16918    personcreditcard    TABLE     �   CREATE TABLE sales.personcreditcard (
    businessentityid integer NOT NULL,
    creditcardid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 #   DROP TABLE sales.personcreditcard;
       sales         heap r       example    false    12            /           0    0    TABLE personcreditcard    COMMENT     �   COMMENT ON TABLE sales.personcreditcard IS 'Cross-reference table mapping people to their credit card information in the CreditCard table.';
          sales               example    false    315            0           0    0 (   COLUMN personcreditcard.businessentityid    COMMENT     �   COMMENT ON COLUMN sales.personcreditcard.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';
          sales               example    false    315            1           0    0 $   COLUMN personcreditcard.creditcardid    COMMENT     �   COMMENT ON COLUMN sales.personcreditcard.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';
          sales               example    false    315            �           1259    18359    pcc    VIEW     �   CREATE VIEW sa.pcc AS
 SELECT businessentityid AS id,
    businessentityid,
    creditcardid,
    modifieddate
   FROM sales.personcreditcard;
    DROP VIEW sa.pcc;
       sa       v       example    false    315    315    315    17            O           1259    17056    store    TABLE       CREATE TABLE sales.store (
    businessentityid integer NOT NULL,
    name public."Name" NOT NULL,
    salespersonid integer,
    demographics xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE sales.store;
       sales         heap r       example    false    2    1095    12            2           0    0    TABLE store    COMMENT     V   COMMENT ON TABLE sales.store IS 'Customers (resellers) of Adventure Works products.';
          sales               example    false    335            3           0    0    COLUMN store.businessentityid    COMMENT     l   COMMENT ON COLUMN sales.store.businessentityid IS 'Primary key. Foreign key to Customer.BusinessEntityID.';
          sales               example    false    335            4           0    0    COLUMN store.name    COMMENT     <   COMMENT ON COLUMN sales.store.name IS 'Name of the store.';
          sales               example    false    335            5           0    0    COLUMN store.salespersonid    COMMENT     �   COMMENT ON COLUMN sales.store.salespersonid IS 'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.';
          sales               example    false    335            6           0    0    COLUMN store.demographics    COMMENT     �   COMMENT ON COLUMN sales.store.demographics IS 'Demographic informationg about the store such as the number of employees, annual sales and store type.';
          sales               example    false    335            �           1259    18412    s    VIEW     �   CREATE VIEW sa.s AS
 SELECT businessentityid AS id,
    businessentityid,
    name,
    salespersonid,
    demographics,
    rowguid,
    modifieddate
   FROM sales.store;
    DROP VIEW sa.s;
       sa       v       example    false    335    335    335    335    335    335    17    1095            K           1259    17028    shoppingcartitem    TABLE     �  CREATE TABLE sales.shoppingcartitem (
    shoppingcartitemid integer NOT NULL,
    shoppingcartid character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    productid integer NOT NULL,
    datecreated timestamp without time zone DEFAULT now() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);
 #   DROP TABLE sales.shoppingcartitem;
       sales         heap r       example    false    12            7           0    0    TABLE shoppingcartitem    COMMENT     y   COMMENT ON TABLE sales.shoppingcartitem IS 'Contains online customer orders until the order is submitted or cancelled.';
          sales               example    false    331            8           0    0 *   COLUMN shoppingcartitem.shoppingcartitemid    COMMENT     l   COMMENT ON COLUMN sales.shoppingcartitem.shoppingcartitemid IS 'Primary key for ShoppingCartItem records.';
          sales               example    false    331            9           0    0 &   COLUMN shoppingcartitem.shoppingcartid    COMMENT     c   COMMENT ON COLUMN sales.shoppingcartitem.shoppingcartid IS 'Shopping cart identification number.';
          sales               example    false    331            :           0    0     COLUMN shoppingcartitem.quantity    COMMENT     R   COMMENT ON COLUMN sales.shoppingcartitem.quantity IS 'Product quantity ordered.';
          sales               example    false    331            ;           0    0 !   COLUMN shoppingcartitem.productid    COMMENT     l   COMMENT ON COLUMN sales.shoppingcartitem.productid IS 'Product ordered. Foreign key to Product.ProductID.';
          sales               example    false    331            <           0    0 #   COLUMN shoppingcartitem.datecreated    COMMENT     a   COMMENT ON COLUMN sales.shoppingcartitem.datecreated IS 'Date the time the record was created.';
          sales               example    false    331            �           1259    18400    sci    VIEW     �   CREATE VIEW sa.sci AS
 SELECT shoppingcartitemid AS id,
    shoppingcartitemid,
    shoppingcartid,
    quantity,
    productid,
    datecreated,
    modifieddate
   FROM sales.shoppingcartitem;
    DROP VIEW sa.sci;
       sa       v       example    false    331    331    331    331    331    331    17            M           1259    17037    specialoffer    TABLE     5  CREATE TABLE sales.specialoffer (
    specialofferid integer NOT NULL,
    description character varying(255) NOT NULL,
    discountpct numeric DEFAULT 0.00 NOT NULL,
    type character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone NOT NULL,
    minqty integer DEFAULT 0 NOT NULL,
    maxqty integer,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK ((discountpct >= 0.00)),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK ((enddate >= startdate)),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK ((maxqty >= 0)),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK ((minqty >= 0))
);
    DROP TABLE sales.specialoffer;
       sales         heap r       example    false    2    12            =           0    0    TABLE specialoffer    COMMENT     G   COMMENT ON TABLE sales.specialoffer IS 'Sale discounts lookup table.';
          sales               example    false    333            >           0    0 "   COLUMN specialoffer.specialofferid    COMMENT     `   COMMENT ON COLUMN sales.specialoffer.specialofferid IS 'Primary key for SpecialOffer records.';
          sales               example    false    333            ?           0    0    COLUMN specialoffer.description    COMMENT     M   COMMENT ON COLUMN sales.specialoffer.description IS 'Discount description.';
          sales               example    false    333            @           0    0    COLUMN specialoffer.discountpct    COMMENT     L   COMMENT ON COLUMN sales.specialoffer.discountpct IS 'Discount precentage.';
          sales               example    false    333            A           0    0    COLUMN specialoffer.type    COMMENT     H   COMMENT ON COLUMN sales.specialoffer.type IS 'Discount type category.';
          sales               example    false    333            B           0    0    COLUMN specialoffer.category    COMMENT     p   COMMENT ON COLUMN sales.specialoffer.category IS 'Group the discount applies to such as Reseller or Customer.';
          sales               example    false    333            C           0    0    COLUMN specialoffer.startdate    COMMENT     J   COMMENT ON COLUMN sales.specialoffer.startdate IS 'Discount start date.';
          sales               example    false    333            D           0    0    COLUMN specialoffer.enddate    COMMENT     F   COMMENT ON COLUMN sales.specialoffer.enddate IS 'Discount end date.';
          sales               example    false    333            E           0    0    COLUMN specialoffer.minqty    COMMENT     T   COMMENT ON COLUMN sales.specialoffer.minqty IS 'Minimum discount percent allowed.';
          sales               example    false    333            F           0    0    COLUMN specialoffer.maxqty    COMMENT     T   COMMENT ON COLUMN sales.specialoffer.maxqty IS 'Maximum discount percent allowed.';
          sales               example    false    333            �           1259    18404    so    VIEW     �   CREATE VIEW sa.so AS
 SELECT specialofferid AS id,
    specialofferid,
    description,
    discountpct,
    type,
    category,
    startdate,
    enddate,
    minqty,
    maxqty,
    rowguid,
    modifieddate
   FROM sales.specialoffer;
    DROP VIEW sa.so;
       sa       v       example    false    333    333    333    333    333    333    333    333    333    333    333    17            =           1259    16923    salesorderdetail    TABLE     �  CREATE TABLE sales.salesorderdetail (
    salesorderid integer NOT NULL,
    salesorderdetailid integer NOT NULL,
    carriertrackingnumber character varying(25),
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    specialofferid integer NOT NULL,
    unitprice numeric NOT NULL,
    unitpricediscount numeric DEFAULT 0.0 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unitprice >= 0.00)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unitpricediscount >= 0.00))
);
 #   DROP TABLE sales.salesorderdetail;
       sales         heap r       example    false    2    12            G           0    0    TABLE salesorderdetail    COMMENT     �   COMMENT ON TABLE sales.salesorderdetail IS 'Individual products associated with a specific sales order. See SalesOrderHeader.';
          sales               example    false    317            H           0    0 $   COLUMN salesorderdetail.salesorderid    COMMENT     w   COMMENT ON COLUMN sales.salesorderdetail.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';
          sales               example    false    317            I           0    0 *   COLUMN salesorderdetail.salesorderdetailid    COMMENT        COMMENT ON COLUMN sales.salesorderdetail.salesorderdetailid IS 'Primary key. One incremental unique number per product sold.';
          sales               example    false    317            J           0    0 -   COLUMN salesorderdetail.carriertrackingnumber    COMMENT     w   COMMENT ON COLUMN sales.salesorderdetail.carriertrackingnumber IS 'Shipment tracking number supplied by the shipper.';
          sales               example    false    317            K           0    0     COLUMN salesorderdetail.orderqty    COMMENT     V   COMMENT ON COLUMN sales.salesorderdetail.orderqty IS 'Quantity ordered per product.';
          sales               example    false    317            L           0    0 !   COLUMN salesorderdetail.productid    COMMENT     u   COMMENT ON COLUMN sales.salesorderdetail.productid IS 'Product sold to customer. Foreign key to Product.ProductID.';
          sales               example    false    317            M           0    0 &   COLUMN salesorderdetail.specialofferid    COMMENT     |   COMMENT ON COLUMN sales.salesorderdetail.specialofferid IS 'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.';
          sales               example    false    317            N           0    0 !   COLUMN salesorderdetail.unitprice    COMMENT     \   COMMENT ON COLUMN sales.salesorderdetail.unitprice IS 'Selling price of a single product.';
          sales               example    false    317            O           0    0 )   COLUMN salesorderdetail.unitpricediscount    COMMENT     R   COMMENT ON COLUMN sales.salesorderdetail.unitpricediscount IS 'Discount amount.';
          sales               example    false    317            �           1259    18363    sod    VIEW       CREATE VIEW sa.sod AS
 SELECT salesorderdetailid AS id,
    salesorderid,
    salesorderdetailid,
    carriertrackingnumber,
    orderqty,
    productid,
    specialofferid,
    unitprice,
    unitpricediscount,
    rowguid,
    modifieddate
   FROM sales.salesorderdetail;
    DROP VIEW sa.sod;
       sa       v       example    false    317    317    317    317    317    317    317    317    317    317    17            ?           1259    16936    salesorderheader    TABLE       CREATE TABLE sales.salesorderheader (
    salesorderid integer NOT NULL,
    revisionnumber smallint DEFAULT 0 NOT NULL,
    orderdate timestamp without time zone DEFAULT now() NOT NULL,
    duedate timestamp without time zone NOT NULL,
    shipdate timestamp without time zone,
    status smallint DEFAULT 1 NOT NULL,
    onlineorderflag public."Flag" DEFAULT true NOT NULL,
    purchaseordernumber public."OrderNumber",
    accountnumber public."AccountNumber",
    customerid integer NOT NULL,
    salespersonid integer,
    territoryid integer,
    billtoaddressid integer NOT NULL,
    shiptoaddressid integer NOT NULL,
    shipmethodid integer NOT NULL,
    creditcardid integer,
    creditcardapprovalcode character varying(15),
    currencyrateid integer,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    taxamt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    totaldue numeric,
    comment character varying(128),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ((duedate >= orderdate)),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (((status >= 0) AND (status <= 8))),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);
 #   DROP TABLE sales.salesorderheader;
       sales         heap r       example    false    1089    2    1083    12    1086    1089            P           0    0    TABLE salesorderheader    COMMENT     O   COMMENT ON TABLE sales.salesorderheader IS 'General sales order information.';
          sales               example    false    319            Q           0    0 $   COLUMN salesorderheader.salesorderid    COMMENT     I   COMMENT ON COLUMN sales.salesorderheader.salesorderid IS 'Primary key.';
          sales               example    false    319            R           0    0 &   COLUMN salesorderheader.revisionnumber    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.revisionnumber IS 'Incremental number to track changes to the sales order over time.';
          sales               example    false    319            S           0    0 !   COLUMN salesorderheader.orderdate    COMMENT     \   COMMENT ON COLUMN sales.salesorderheader.orderdate IS 'Dates the sales order was created.';
          sales               example    false    319            T           0    0    COLUMN salesorderheader.duedate    COMMENT     ^   COMMENT ON COLUMN sales.salesorderheader.duedate IS 'Date the order is due to the customer.';
          sales               example    false    319            U           0    0     COLUMN salesorderheader.shipdate    COMMENT     d   COMMENT ON COLUMN sales.salesorderheader.shipdate IS 'Date the order was shipped to the customer.';
          sales               example    false    319            V           0    0    COLUMN salesorderheader.status    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.status IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';
          sales               example    false    319            W           0    0 '   COLUMN salesorderheader.onlineorderflag    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.onlineorderflag IS '0 = Order placed by sales person. 1 = Order placed online by customer.';
          sales               example    false    319            X           0    0 +   COLUMN salesorderheader.purchaseordernumber    COMMENT     m   COMMENT ON COLUMN sales.salesorderheader.purchaseordernumber IS 'Customer purchase order number reference.';
          sales               example    false    319            Y           0    0 %   COLUMN salesorderheader.accountnumber    COMMENT     d   COMMENT ON COLUMN sales.salesorderheader.accountnumber IS 'Financial accounting number reference.';
          sales               example    false    319            Z           0    0 "   COLUMN salesorderheader.customerid    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.customerid IS 'Customer identification number. Foreign key to Customer.BusinessEntityID.';
          sales               example    false    319            [           0    0 %   COLUMN salesorderheader.salespersonid    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.salespersonid IS 'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';
          sales               example    false    319            \           0    0 #   COLUMN salesorderheader.territoryid    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.territoryid IS 'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';
          sales               example    false    319            ]           0    0 '   COLUMN salesorderheader.billtoaddressid    COMMENT     {   COMMENT ON COLUMN sales.salesorderheader.billtoaddressid IS 'Customer billing address. Foreign key to Address.AddressID.';
          sales               example    false    319            ^           0    0 '   COLUMN salesorderheader.shiptoaddressid    COMMENT     |   COMMENT ON COLUMN sales.salesorderheader.shiptoaddressid IS 'Customer shipping address. Foreign key to Address.AddressID.';
          sales               example    false    319            _           0    0 $   COLUMN salesorderheader.shipmethodid    COMMENT     u   COMMENT ON COLUMN sales.salesorderheader.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';
          sales               example    false    319            `           0    0 $   COLUMN salesorderheader.creditcardid    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';
          sales               example    false    319            a           0    0 .   COLUMN salesorderheader.creditcardapprovalcode    COMMENT     y   COMMENT ON COLUMN sales.salesorderheader.creditcardapprovalcode IS 'Approval code provided by the credit card company.';
          sales               example    false    319            b           0    0 &   COLUMN salesorderheader.currencyrateid    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.currencyrateid IS 'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';
          sales               example    false    319            c           0    0     COLUMN salesorderheader.subtotal    COMMENT     �   COMMENT ON COLUMN sales.salesorderheader.subtotal IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';
          sales               example    false    319            d           0    0    COLUMN salesorderheader.taxamt    COMMENT     B   COMMENT ON COLUMN sales.salesorderheader.taxamt IS 'Tax amount.';
          sales               example    false    319            e           0    0    COLUMN salesorderheader.freight    COMMENT     F   COMMENT ON COLUMN sales.salesorderheader.freight IS 'Shipping cost.';
          sales               example    false    319            f           0    0     COLUMN salesorderheader.totaldue    COMMENT     z   COMMENT ON COLUMN sales.salesorderheader.totaldue IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';
          sales               example    false    319            g           0    0    COLUMN salesorderheader.comment    COMMENT     V   COMMENT ON COLUMN sales.salesorderheader.comment IS 'Sales representative comments.';
          sales               example    false    319            �           1259    18367    soh    VIEW       CREATE VIEW sa.soh AS
 SELECT salesorderid AS id,
    salesorderid,
    revisionnumber,
    orderdate,
    duedate,
    shipdate,
    status,
    onlineorderflag,
    purchaseordernumber,
    accountnumber,
    customerid,
    salespersonid,
    territoryid,
    billtoaddressid,
    shiptoaddressid,
    shipmethodid,
    creditcardid,
    creditcardapprovalcode,
    currencyrateid,
    subtotal,
    taxamt,
    freight,
    totaldue,
    comment,
    rowguid,
    modifieddate
   FROM sales.salesorderheader;
    DROP VIEW sa.soh;
       sa       v       example    false    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    319    1089    1083    1086    17            @           1259    16957    salesorderheadersalesreason    TABLE     �   CREATE TABLE sales.salesorderheadersalesreason (
    salesorderid integer NOT NULL,
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 .   DROP TABLE sales.salesorderheadersalesreason;
       sales         heap r       example    false    12            h           0    0 !   TABLE salesorderheadersalesreason    COMMENT     {   COMMENT ON TABLE sales.salesorderheadersalesreason IS 'Cross-reference table mapping sales orders to sales reason codes.';
          sales               example    false    320            i           0    0 /   COLUMN salesorderheadersalesreason.salesorderid    COMMENT     �   COMMENT ON COLUMN sales.salesorderheadersalesreason.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';
          sales               example    false    320            j           0    0 0   COLUMN salesorderheadersalesreason.salesreasonid    COMMENT        COMMENT ON COLUMN sales.salesorderheadersalesreason.salesreasonid IS 'Primary key. Foreign key to SalesReason.SalesReasonID.';
          sales               example    false    320            �           1259    18372    sohsr    VIEW     }   CREATE VIEW sa.sohsr AS
 SELECT salesorderid,
    salesreasonid,
    modifieddate
   FROM sales.salesorderheadersalesreason;
    DROP VIEW sa.sohsr;
       sa       v       example    false    320    320    320    17            N           1259    17051    specialofferproduct    TABLE     �   CREATE TABLE sales.specialofferproduct (
    specialofferid integer NOT NULL,
    productid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
 &   DROP TABLE sales.specialofferproduct;
       sales         heap r       example    false    2    12            k           0    0    TABLE specialofferproduct    COMMENT     t   COMMENT ON TABLE sales.specialofferproduct IS 'Cross-reference table mapping products to special offer discounts.';
          sales               example    false    334            l           0    0 )   COLUMN specialofferproduct.specialofferid    COMMENT     n   COMMENT ON COLUMN sales.specialofferproduct.specialofferid IS 'Primary key for SpecialOfferProduct records.';
          sales               example    false    334            m           0    0 $   COLUMN specialofferproduct.productid    COMMENT     }   COMMENT ON COLUMN sales.specialofferproduct.productid IS 'Product identification number. Foreign key to Product.ProductID.';
          sales               example    false    334            �           1259    18408    sop    VIEW     �   CREATE VIEW sa.sop AS
 SELECT specialofferid AS id,
    specialofferid,
    productid,
    rowguid,
    modifieddate
   FROM sales.specialofferproduct;
    DROP VIEW sa.sop;
       sa       v       example    false    334    334    334    334    17            A           1259    16961    salesperson    TABLE       CREATE TABLE sales.salesperson (
    businessentityid integer NOT NULL,
    territoryid integer,
    salesquota numeric,
    bonus numeric DEFAULT 0.00 NOT NULL,
    commissionpct numeric DEFAULT 0.00 NOT NULL,
    salesytd numeric DEFAULT 0.00 NOT NULL,
    saleslastyear numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commissionpct >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK ((saleslastyear >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK ((salesquota > 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((salesytd >= 0.00))
);
    DROP TABLE sales.salesperson;
       sales         heap r       example    false    2    12            n           0    0    TABLE salesperson    COMMENT     S   COMMENT ON TABLE sales.salesperson IS 'Sales representative current information.';
          sales               example    false    321            o           0    0 #   COLUMN salesperson.businessentityid    COMMENT     �   COMMENT ON COLUMN sales.salesperson.businessentityid IS 'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';
          sales               example    false    321            p           0    0    COLUMN salesperson.territoryid    COMMENT     �   COMMENT ON COLUMN sales.salesperson.territoryid IS 'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';
          sales               example    false    321            q           0    0    COLUMN salesperson.salesquota    COMMENT     M   COMMENT ON COLUMN sales.salesperson.salesquota IS 'Projected yearly sales.';
          sales               example    false    321            r           0    0    COLUMN salesperson.bonus    COMMENT     K   COMMENT ON COLUMN sales.salesperson.bonus IS 'Bonus due if quota is met.';
          sales               example    false    321            s           0    0     COLUMN salesperson.commissionpct    COMMENT     ]   COMMENT ON COLUMN sales.salesperson.commissionpct IS 'Commision percent received per sale.';
          sales               example    false    321            t           0    0    COLUMN salesperson.salesytd    COMMENT     M   COMMENT ON COLUMN sales.salesperson.salesytd IS 'Sales total year to date.';
          sales               example    false    321            u           0    0     COLUMN salesperson.saleslastyear    COMMENT     V   COMMENT ON COLUMN sales.salesperson.saleslastyear IS 'Sales total of previous year.';
          sales               example    false    321            �           1259    18376    sp    VIEW     �   CREATE VIEW sa.sp AS
 SELECT businessentityid AS id,
    businessentityid,
    territoryid,
    salesquota,
    bonus,
    commissionpct,
    salesytd,
    saleslastyear,
    rowguid,
    modifieddate
   FROM sales.salesperson;
    DROP VIEW sa.sp;
       sa       v       example    false    321    321    321    321    321    321    321    321    321    17            B           1259    16977    salespersonquotahistory    TABLE     �  CREATE TABLE sales.salespersonquotahistory (
    businessentityid integer NOT NULL,
    quotadate timestamp without time zone NOT NULL,
    salesquota numeric NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((salesquota > 0.00))
);
 *   DROP TABLE sales.salespersonquotahistory;
       sales         heap r       example    false    2    12            v           0    0    TABLE salespersonquotahistory    COMMENT     Q   COMMENT ON TABLE sales.salespersonquotahistory IS 'Sales performance tracking.';
          sales               example    false    322            w           0    0 /   COLUMN salespersonquotahistory.businessentityid    COMMENT     �   COMMENT ON COLUMN sales.salespersonquotahistory.businessentityid IS 'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';
          sales               example    false    322            x           0    0 (   COLUMN salespersonquotahistory.quotadate    COMMENT     R   COMMENT ON COLUMN sales.salespersonquotahistory.quotadate IS 'Sales quota date.';
          sales               example    false    322            y           0    0 )   COLUMN salespersonquotahistory.salesquota    COMMENT     U   COMMENT ON COLUMN sales.salespersonquotahistory.salesquota IS 'Sales quota amount.';
          sales               example    false    322            �           1259    18380    spqh    VIEW     �   CREATE VIEW sa.spqh AS
 SELECT businessentityid AS id,
    businessentityid,
    quotadate,
    salesquota,
    rowguid,
    modifieddate
   FROM sales.salespersonquotahistory;
    DROP VIEW sa.spqh;
       sa       v       example    false    322    322    322    322    322    17            D           1259    16986    salesreason    TABLE     �   CREATE TABLE sales.salesreason (
    salesreasonid integer NOT NULL,
    name public."Name" NOT NULL,
    reasontype public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE sales.salesreason;
       sales         heap r       example    false    12    1095    1095            z           0    0    TABLE salesreason    COMMENT     T   COMMENT ON TABLE sales.salesreason IS 'Lookup table of customer purchase reasons.';
          sales               example    false    324            {           0    0     COLUMN salesreason.salesreasonid    COMMENT     ]   COMMENT ON COLUMN sales.salesreason.salesreasonid IS 'Primary key for SalesReason records.';
          sales               example    false    324            |           0    0    COLUMN salesreason.name    COMMENT     I   COMMENT ON COLUMN sales.salesreason.name IS 'Sales reason description.';
          sales               example    false    324            }           0    0    COLUMN salesreason.reasontype    COMMENT     [   COMMENT ON COLUMN sales.salesreason.reasontype IS 'Category the sales reason belongs to.';
          sales               example    false    324            �           1259    18384    sr    VIEW     �   CREATE VIEW sa.sr AS
 SELECT salesreasonid AS id,
    salesreasonid,
    name,
    reasontype,
    modifieddate
   FROM sales.salesreason;
    DROP VIEW sa.sr;
       sa       v       example    false    324    324    324    324    1095    1095    17            H           1259    17005    salesterritory    TABLE     4  CREATE TABLE sales.salesterritory (
    territoryid integer NOT NULL,
    name public."Name" NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    "group" character varying(50) NOT NULL,
    salesytd numeric DEFAULT 0.00 NOT NULL,
    saleslastyear numeric DEFAULT 0.00 NOT NULL,
    costytd numeric DEFAULT 0.00 NOT NULL,
    costlastyear numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK ((costlastyear >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK ((costytd >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK ((saleslastyear >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK ((salesytd >= 0.00))
);
 !   DROP TABLE sales.salesterritory;
       sales         heap r       example    false    2    12    1095            ~           0    0    TABLE salesterritory    COMMENT     J   COMMENT ON TABLE sales.salesterritory IS 'Sales territory lookup table.';
          sales               example    false    328                       0    0 !   COLUMN salesterritory.territoryid    COMMENT     a   COMMENT ON COLUMN sales.salesterritory.territoryid IS 'Primary key for SalesTerritory records.';
          sales               example    false    328            �           0    0    COLUMN salesterritory.name    COMMENT     N   COMMENT ON COLUMN sales.salesterritory.name IS 'Sales territory description';
          sales               example    false    328            �           0    0 '   COLUMN salesterritory.countryregioncode    COMMENT     �   COMMENT ON COLUMN sales.salesterritory.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';
          sales               example    false    328            �           0    0    COLUMN salesterritory."group"    COMMENT     j   COMMENT ON COLUMN sales.salesterritory."group" IS 'Geographic area to which the sales territory belong.';
          sales               example    false    328            �           0    0    COLUMN salesterritory.salesytd    COMMENT     [   COMMENT ON COLUMN sales.salesterritory.salesytd IS 'Sales in the territory year to date.';
          sales               example    false    328            �           0    0 #   COLUMN salesterritory.saleslastyear    COMMENT     e   COMMENT ON COLUMN sales.salesterritory.saleslastyear IS 'Sales in the territory the previous year.';
          sales               example    false    328            �           0    0    COLUMN salesterritory.costytd    COMMENT     c   COMMENT ON COLUMN sales.salesterritory.costytd IS 'Business costs in the territory year to date.';
          sales               example    false    328            �           0    0 "   COLUMN salesterritory.costlastyear    COMMENT     m   COMMENT ON COLUMN sales.salesterritory.costlastyear IS 'Business costs in the territory the previous year.';
          sales               example    false    328            �           1259    18392    st    VIEW     �   CREATE VIEW sa.st AS
 SELECT territoryid AS id,
    territoryid,
    name,
    countryregioncode,
    "group",
    salesytd,
    saleslastyear,
    costytd,
    costlastyear,
    rowguid,
    modifieddate
   FROM sales.salesterritory;
    DROP VIEW sa.st;
       sa       v       example    false    328    328    328    328    328    328    328    328    328    328    17    1095            I           1259    17021    salesterritoryhistory    TABLE     �  CREATE TABLE sales.salesterritoryhistory (
    businessentityid integer NOT NULL,
    territoryid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);
 (   DROP TABLE sales.salesterritoryhistory;
       sales         heap r       example    false    2    12            �           0    0    TABLE salesterritoryhistory    COMMENT     n   COMMENT ON TABLE sales.salesterritoryhistory IS 'Sales representative transfers to other sales territories.';
          sales               example    false    329            �           0    0 -   COLUMN salesterritoryhistory.businessentityid    COMMENT     �   COMMENT ON COLUMN sales.salesterritoryhistory.businessentityid IS 'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';
          sales               example    false    329            �           0    0 (   COLUMN salesterritoryhistory.territoryid    COMMENT     �   COMMENT ON COLUMN sales.salesterritoryhistory.territoryid IS 'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';
          sales               example    false    329            �           0    0 &   COLUMN salesterritoryhistory.startdate    COMMENT     �   COMMENT ON COLUMN sales.salesterritoryhistory.startdate IS 'Primary key. Date the sales representive started work in the territory.';
          sales               example    false    329            �           0    0 $   COLUMN salesterritoryhistory.enddate    COMMENT     v   COMMENT ON COLUMN sales.salesterritoryhistory.enddate IS 'Date the sales representative left work in the territory.';
          sales               example    false    329            �           1259    18396    sth    VIEW     �   CREATE VIEW sa.sth AS
 SELECT territoryid AS id,
    businessentityid,
    territoryid,
    startdate,
    enddate,
    rowguid,
    modifieddate
   FROM sales.salesterritoryhistory;
    DROP VIEW sa.sth;
       sa       v       example    false    329    329    329    329    329    329    17            F           1259    16994    salestaxrate    TABLE     �  CREATE TABLE sales.salestaxrate (
    salestaxrateid integer NOT NULL,
    stateprovinceid integer NOT NULL,
    taxtype smallint NOT NULL,
    taxrate numeric DEFAULT 0.00 NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((taxtype >= 1) AND (taxtype <= 3)))
);
    DROP TABLE sales.salestaxrate;
       sales         heap r       example    false    2    12    1095            �           0    0    TABLE salestaxrate    COMMENT     A   COMMENT ON TABLE sales.salestaxrate IS 'Tax rate lookup table.';
          sales               example    false    326            �           0    0 "   COLUMN salestaxrate.salestaxrateid    COMMENT     `   COMMENT ON COLUMN sales.salestaxrate.salestaxrateid IS 'Primary key for SalesTaxRate records.';
          sales               example    false    326            �           0    0 #   COLUMN salestaxrate.stateprovinceid    COMMENT     x   COMMENT ON COLUMN sales.salestaxrate.stateprovinceid IS 'State, province, or country/region the sales tax applies to.';
          sales               example    false    326            �           0    0    COLUMN salestaxrate.taxtype    COMMENT     �   COMMENT ON COLUMN sales.salestaxrate.taxtype IS '1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.';
          sales               example    false    326            �           0    0    COLUMN salestaxrate.taxrate    COMMENT     D   COMMENT ON COLUMN sales.salestaxrate.taxrate IS 'Tax rate amount.';
          sales               example    false    326            �           0    0    COLUMN salestaxrate.name    COMMENT     F   COMMENT ON COLUMN sales.salestaxrate.name IS 'Tax rate description.';
          sales               example    false    326            �           1259    18388    tr    VIEW     �   CREATE VIEW sa.tr AS
 SELECT salestaxrateid AS id,
    salestaxrateid,
    stateprovinceid,
    taxtype,
    taxrate,
    name,
    rowguid,
    modifieddate
   FROM sales.salestaxrate;
    DROP VIEW sa.tr;
       sa       v       example    false    326    326    326    326    326    326    326    17    1095            4           1259    16889    creditcard_creditcardid_seq    SEQUENCE     �   CREATE SEQUENCE sales.creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE sales.creditcard_creditcardid_seq;
       sales               example    false    12    309            �           0    0    creditcard_creditcardid_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE sales.creditcard_creditcardid_seq OWNED BY sales.creditcard.creditcardid;
          sales               example    false    308            7           1259    16901    currencyrate_currencyrateid_seq    SEQUENCE     �   CREATE SEQUENCE sales.currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE sales.currencyrate_currencyrateid_seq;
       sales               example    false    312    12            �           0    0    currencyrate_currencyrateid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE sales.currencyrate_currencyrateid_seq OWNED BY sales.currencyrate.currencyrateid;
          sales               example    false    311            9           1259    16909    customer_customerid_seq    SEQUENCE     �   CREATE SEQUENCE sales.customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE sales.customer_customerid_seq;
       sales               example    false    314    12            �           0    0    customer_customerid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE sales.customer_customerid_seq OWNED BY sales.customer.customerid;
          sales               example    false    313            <           1259    16922 '   salesorderdetail_salesorderdetailid_seq    SEQUENCE     �   CREATE SEQUENCE sales.salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE sales.salesorderdetail_salesorderdetailid_seq;
       sales               example    false    12    317            �           0    0 '   salesorderdetail_salesorderdetailid_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE sales.salesorderdetail_salesorderdetailid_seq OWNED BY sales.salesorderdetail.salesorderdetailid;
          sales               example    false    316            >           1259    16935 !   salesorderheader_salesorderid_seq    SEQUENCE     �   CREATE SEQUENCE sales.salesorderheader_salesorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE sales.salesorderheader_salesorderid_seq;
       sales               example    false    319    12            �           0    0 !   salesorderheader_salesorderid_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE sales.salesorderheader_salesorderid_seq OWNED BY sales.salesorderheader.salesorderid;
          sales               example    false    318            C           1259    16985    salesreason_salesreasonid_seq    SEQUENCE     �   CREATE SEQUENCE sales.salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE sales.salesreason_salesreasonid_seq;
       sales               example    false    324    12            �           0    0    salesreason_salesreasonid_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE sales.salesreason_salesreasonid_seq OWNED BY sales.salesreason.salesreasonid;
          sales               example    false    323            E           1259    16993    salestaxrate_salestaxrateid_seq    SEQUENCE     �   CREATE SEQUENCE sales.salestaxrate_salestaxrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE sales.salestaxrate_salestaxrateid_seq;
       sales               example    false    12    326            �           0    0    salestaxrate_salestaxrateid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE sales.salestaxrate_salestaxrateid_seq OWNED BY sales.salestaxrate.salestaxrateid;
          sales               example    false    325            G           1259    17004    salesterritory_territoryid_seq    SEQUENCE     �   CREATE SEQUENCE sales.salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE sales.salesterritory_territoryid_seq;
       sales               example    false    12    328            �           0    0    salesterritory_territoryid_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE sales.salesterritory_territoryid_seq OWNED BY sales.salesterritory.territoryid;
          sales               example    false    327            J           1259    17027 '   shoppingcartitem_shoppingcartitemid_seq    SEQUENCE     �   CREATE SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq;
       sales               example    false    12    331            �           0    0 '   shoppingcartitem_shoppingcartitemid_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq OWNED BY sales.shoppingcartitem.shoppingcartitemid;
          sales               example    false    330            L           1259    17036    specialoffer_specialofferid_seq    SEQUENCE     �   CREATE SEQUENCE sales.specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE sales.specialoffer_specialofferid_seq;
       sales               example    false    12    333            �           0    0    specialoffer_specialofferid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE sales.specialoffer_specialofferid_seq OWNED BY sales.specialoffer.specialofferid;
          sales               example    false    332            T           1259    18026    vindividualcustomer    VIEW     �  CREATE VIEW sales.vindividualcustomer AS
 SELECT p.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    p.demographics
   FROM (((((((((person.person p
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = p.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN person.addresstype at ON ((at.addresstypeid = bea.addresstypeid)))
     JOIN sales.customer c ON ((c.personid = p.businessentityid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)))
  WHERE (c.storeid IS NULL);
 %   DROP VIEW sales.vindividualcustomer;
       sales       v       example    false    234    241    241    246    246    249    249    238    238    238    240    240    241    234    234    236    234    234    234    234    234    250    250    250    251    236    236    238    251    314    314    238    238    1095    12    1095    1095    1095    1095    1098    1095    1095            U           1259    18031    vpersondemographics    VIEW     	
  CREATE VIEW sales.vpersondemographics AS
 SELECT businessentityid,
    (((xpath('n:TotalPurchaseYTD/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::money AS totalpurchaseytd,
    (((xpath('n:DateFirstPurchase/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS datefirstpurchase,
    (((xpath('n:BirthDate/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS birthdate,
    ((xpath('n:MaritalStatus/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS maritalstatus,
    ((xpath('n:YearlyIncome/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS yearlyincome,
    ((xpath('n:Gender/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS gender,
    (((xpath('n:TotalChildren/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS totalchildren,
    (((xpath('n:NumberChildrenAtHome/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numberchildrenathome,
    ((xpath('n:Education/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS education,
    ((xpath('n:Occupation/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS occupation,
    (((xpath('n:HomeOwnerFlag/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::boolean AS homeownerflag,
    (((xpath('n:NumberCarsOwned/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numbercarsowned
   FROM person.person
  WHERE (demographics IS NOT NULL);
 %   DROP VIEW sales.vpersondemographics;
       sales       v       example    false    234    234    12            \           1259    18080    vsalesperson    VIEW     n  CREATE VIEW sales.vsalesperson AS
 SELECT s.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    st.name AS territoryname,
    st."group" AS territorygroup,
    s.salesquota,
    s.salesytd,
    s.saleslastyear
   FROM ((((((((((sales.salesperson s
     JOIN humanresources.employee e ON ((e.businessentityid = s.businessentityid)))
     JOIN person.person p ON ((p.businessentityid = s.businessentityid)))
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = s.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     LEFT JOIN sales.salesterritory st ON ((st.territoryid = s.territoryid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));
    DROP VIEW sales.vsalesperson;
       sales       v       example    false    241    241    238    238    321    321    238    234    234    321    321    234    234    234    234    234    236    236    236    328    328    328    238    238    321    238    254    254    251    251    250    250    250    249    249    246    246    1095    1095    1095    1095    1098    1095    1095    1095    12            ^           1259    18090    vsalespersonsalesbyfiscalyears    VIEW     @  CREATE VIEW sales.vsalespersonsalesbyfiscalyears AS
 SELECT "SalesPersonID",
    "FullName",
    "JobTitle",
    "SalesTerritory",
    "2012",
    "2013",
    "2014"
   FROM public.crosstab('SELECT
    SalesPersonID
    ,FullName
    ,JobTitle
    ,SalesTerritory
    ,FiscalYear
    ,SalesTotal
FROM Sales.vSalesPersonSalesByFiscalYearsData
ORDER BY 2,4'::text, 'SELECT unnest(''{2012,2013,2014}''::text[])'::text) salestotal("SalesPersonID" integer, "FullName" text, "JobTitle" text, "SalesTerritory" text, "2012" numeric(12,4), "2013" numeric(12,4), "2014" numeric(12,4));
 0   DROP VIEW sales.vsalespersonsalesbyfiscalyears;
       sales       v       example    false    3    12            ]           1259    18085 "   vsalespersonsalesbyfiscalyearsdata    VIEW     �  CREATE VIEW sales.vsalespersonsalesbyfiscalyearsdata AS
 SELECT salespersonid,
    fullname,
    jobtitle,
    salesterritory,
    sum(subtotal) AS salestotal,
    fiscalyear
   FROM ( SELECT soh.salespersonid,
            ((((p.firstname)::text || ' '::text) || COALESCE(((p.middlename)::text || ' '::text), ''::text)) || (p.lastname)::text) AS fullname,
            e.jobtitle,
            st.name AS salesterritory,
            soh.subtotal,
            EXTRACT(year FROM (soh.orderdate + '6 mons'::interval)) AS fiscalyear
           FROM ((((sales.salesperson sp
             JOIN sales.salesorderheader soh ON ((sp.businessentityid = soh.salespersonid)))
             JOIN sales.salesterritory st ON ((sp.territoryid = st.territoryid)))
             JOIN humanresources.employee e ON ((soh.salespersonid = e.businessentityid)))
             JOIN person.person p ON ((p.businessentityid = sp.businessentityid)))) granular
  GROUP BY salespersonid, fullname, jobtitle, salesterritory, fiscalyear;
 4   DROP VIEW sales.vsalespersonsalesbyfiscalyearsdata;
       sales       v       example    false    321    328    328    321    319    319    319    254    254    234    234    234    234    12    1095            b           1259    18122    vstorewithaddresses    VIEW     �  CREATE VIEW sales.vstorewithaddresses AS
 SELECT s.businessentityid,
    s.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
   FROM (((((sales.store s
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = s.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN person.addresstype at ON ((at.addresstypeid = bea.addresstypeid)));
 %   DROP VIEW sales.vstorewithaddresses;
       sales       v       example    false    236    236    238    238    241    238    236    238    238    238    240    335    335    251    251    240    241    241    1095    1095    1095    1095    12            a           1259    18117    vstorewithcontacts    VIEW     0  CREATE VIEW sales.vstorewithcontacts AS
 SELECT s.businessentityid,
    s.name,
    ct.name AS contacttype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion
   FROM ((((((sales.store s
     JOIN person.businessentitycontact bec ON ((bec.businessentityid = s.businessentityid)))
     JOIN person.contacttype ct ON ((ct.contacttypeid = bec.contacttypeid)))
     JOIN person.person p ON ((p.businessentityid = bec.personid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));
 $   DROP VIEW sales.vstorewithcontacts;
       sales       v       example    false    249    250    250    250    335    335    244    234    234    234    234    234    234    234    243    243    244    244    246    246    249    1095    12    1095    1098    1095    1095    1095    1095            `           1259    18112    vstorewithdemographics    VIEW     �  CREATE VIEW sales.vstorewithdemographics AS
 SELECT businessentityid,
    name,
    ((unnest(xpath('/ns:StoreSurvey/ns:AnnualSales/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::money AS "AnnualSales",
    ((unnest(xpath('/ns:StoreSurvey/ns:AnnualRevenue/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::money AS "AnnualRevenue",
    (unnest(xpath('/ns:StoreSurvey/ns:BankName/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(50) AS "BankName",
    (unnest(xpath('/ns:StoreSurvey/ns:BusinessType/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(5) AS "BusinessType",
    ((unnest(xpath('/ns:StoreSurvey/ns:YearOpened/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::integer AS "YearOpened",
    (unnest(xpath('/ns:StoreSurvey/ns:Specialty/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(50) AS "Specialty",
    ((unnest(xpath('/ns:StoreSurvey/ns:SquareFeet/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::integer AS "SquareFeet",
    (unnest(xpath('/ns:StoreSurvey/ns:Brands/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(30) AS "Brands",
    (unnest(xpath('/ns:StoreSurvey/ns:Internet/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(30) AS "Internet",
    ((unnest(xpath('/ns:StoreSurvey/ns:NumberEmployees/text()'::text, demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::integer AS "NumberEmployees"
   FROM sales.store;
 (   DROP VIEW sales.vstorewithdemographics;
       sales       v       example    false    335    335    335    1095    12            �           2604    16536    department departmentid    DEFAULT     �   ALTER TABLE ONLY humanresources.department ALTER COLUMN departmentid SET DEFAULT nextval('humanresources.department_departmentid_seq'::regclass);
 N   ALTER TABLE humanresources.department ALTER COLUMN departmentid DROP DEFAULT;
       humanresources               example    false    252    253    253            �           2604    16574    jobcandidate jobcandidateid    DEFAULT     �   ALTER TABLE ONLY humanresources.jobcandidate ALTER COLUMN jobcandidateid SET DEFAULT nextval('humanresources.jobcandidate_jobcandidateid_seq'::regclass);
 R   ALTER TABLE humanresources.jobcandidate ALTER COLUMN jobcandidateid DROP DEFAULT;
       humanresources               example    false    258    257    258            �           2604    16582    shift shiftid    DEFAULT     ~   ALTER TABLE ONLY humanresources.shift ALTER COLUMN shiftid SET DEFAULT nextval('humanresources.shift_shiftid_seq'::regclass);
 D   ALTER TABLE humanresources.shift ALTER COLUMN shiftid DROP DEFAULT;
       humanresources               example    false    259    260    260            p           2604    16469    address addressid    DEFAULT     v   ALTER TABLE ONLY person.address ALTER COLUMN addressid SET DEFAULT nextval('person.address_addressid_seq'::regclass);
 @   ALTER TABLE person.address ALTER COLUMN addressid DROP DEFAULT;
       person               example    false    237    238    238            s           2604    16476    addresstype addresstypeid    DEFAULT     �   ALTER TABLE ONLY person.addresstype ALTER COLUMN addresstypeid SET DEFAULT nextval('person.addresstype_addresstypeid_seq'::regclass);
 H   ALTER TABLE person.addresstype ALTER COLUMN addresstypeid DROP DEFAULT;
       person               example    false    240    239    240            e           2604    16441    businessentity businessentityid    DEFAULT     �   ALTER TABLE ONLY person.businessentity ALTER COLUMN businessentityid SET DEFAULT nextval('person.businessentity_businessentityid_seq'::regclass);
 N   ALTER TABLE person.businessentity ALTER COLUMN businessentityid DROP DEFAULT;
       person               example    false    232    233    233            x           2604    16490    contacttype contacttypeid    DEFAULT     �   ALTER TABLE ONLY person.contacttype ALTER COLUMN contacttypeid SET DEFAULT nextval('person.contacttype_contacttypeid_seq'::regclass);
 H   ALTER TABLE person.contacttype ALTER COLUMN contacttypeid DROP DEFAULT;
       person               example    false    242    243    243            |           2604    16503    emailaddress emailaddressid    DEFAULT     �   ALTER TABLE ONLY person.emailaddress ALTER COLUMN emailaddressid SET DEFAULT nextval('person.emailaddress_emailaddressid_seq'::regclass);
 J   ALTER TABLE person.emailaddress ALTER COLUMN emailaddressid DROP DEFAULT;
       person               example    false    246    245    246            �           2604    16515 !   phonenumbertype phonenumbertypeid    DEFAULT     �   ALTER TABLE ONLY person.phonenumbertype ALTER COLUMN phonenumbertypeid SET DEFAULT nextval('person.phonenumbertype_phonenumbertypeid_seq'::regclass);
 P   ALTER TABLE person.phonenumbertype ALTER COLUMN phonenumbertypeid DROP DEFAULT;
       person               example    false    248    249    249            l           2604    16459    stateprovince stateprovinceid    DEFAULT     �   ALTER TABLE ONLY person.stateprovince ALTER COLUMN stateprovinceid SET DEFAULT nextval('person.stateprovince_stateprovinceid_seq'::regclass);
 L   ALTER TABLE person.stateprovince ALTER COLUMN stateprovinceid DROP DEFAULT;
       person               example    false    236    235    236            �           2604    16593 !   billofmaterials billofmaterialsid    DEFAULT     �   ALTER TABLE ONLY production.billofmaterials ALTER COLUMN billofmaterialsid SET DEFAULT nextval('production.billofmaterials_billofmaterialsid_seq'::regclass);
 T   ALTER TABLE production.billofmaterials ALTER COLUMN billofmaterialsid DROP DEFAULT;
    
   production               example    false    261    262    262            �           2604    16719    illustration illustrationid    DEFAULT     �   ALTER TABLE ONLY production.illustration ALTER COLUMN illustrationid SET DEFAULT nextval('production.illustration_illustrationid_seq'::regclass);
 N   ALTER TABLE production.illustration ALTER COLUMN illustrationid DROP DEFAULT;
    
   production               example    false    282    281    282            �           2604    16692    location locationid    DEFAULT     �   ALTER TABLE ONLY production.location ALTER COLUMN locationid SET DEFAULT nextval('production.location_locationid_seq'::regclass);
 F   ALTER TABLE production.location ALTER COLUMN locationid DROP DEFAULT;
    
   production               example    false    278    277    278            �           2604    16650    product productid    DEFAULT     ~   ALTER TABLE ONLY production.product ALTER COLUMN productid SET DEFAULT nextval('production.product_productid_seq'::regclass);
 D   ALTER TABLE production.product ALTER COLUMN productid DROP DEFAULT;
    
   production               example    false    271    272    272            �           2604    16623 !   productcategory productcategoryid    DEFAULT     �   ALTER TABLE ONLY production.productcategory ALTER COLUMN productcategoryid SET DEFAULT nextval('production.productcategory_productcategoryid_seq'::regclass);
 T   ALTER TABLE production.productcategory ALTER COLUMN productcategoryid DROP DEFAULT;
    
   production               example    false    266    265    266            �           2604    16679 '   productdescription productdescriptionid    DEFAULT     �   ALTER TABLE ONLY production.productdescription ALTER COLUMN productdescriptionid SET DEFAULT nextval('production.productdescription_productdescriptionid_seq'::regclass);
 Z   ALTER TABLE production.productdescription ALTER COLUMN productdescriptionid DROP DEFAULT;
    
   production               example    false    275    274    275            �           2604    16641    productmodel productmodelid    DEFAULT     �   ALTER TABLE ONLY production.productmodel ALTER COLUMN productmodelid SET DEFAULT nextval('production.productmodel_productmodelid_seq'::regclass);
 N   ALTER TABLE production.productmodel ALTER COLUMN productmodelid DROP DEFAULT;
    
   production               example    false    270    269    270            �           2604    16735    productphoto productphotoid    DEFAULT     �   ALTER TABLE ONLY production.productphoto ALTER COLUMN productphotoid SET DEFAULT nextval('production.productphoto_productphotoid_seq'::regclass);
 N   ALTER TABLE production.productphoto ALTER COLUMN productphotoid DROP DEFAULT;
    
   production               example    false    286    285    286            �           2604    16748    productreview productreviewid    DEFAULT     �   ALTER TABLE ONLY production.productreview ALTER COLUMN productreviewid SET DEFAULT nextval('production.productreview_productreviewid_seq'::regclass);
 P   ALTER TABLE production.productreview ALTER COLUMN productreviewid DROP DEFAULT;
    
   production               example    false    289    288    289            �           2604    16632 '   productsubcategory productsubcategoryid    DEFAULT     �   ALTER TABLE ONLY production.productsubcategory ALTER COLUMN productsubcategoryid SET DEFAULT nextval('production.productsubcategory_productsubcategoryid_seq'::regclass);
 Z   ALTER TABLE production.productsubcategory ALTER COLUMN productsubcategoryid DROP DEFAULT;
    
   production               example    false    267    268    268            �           2604    16758    scrapreason scrapreasonid    DEFAULT     �   ALTER TABLE ONLY production.scrapreason ALTER COLUMN scrapreasonid SET DEFAULT nextval('production.scrapreason_scrapreasonid_seq'::regclass);
 L   ALTER TABLE production.scrapreason ALTER COLUMN scrapreasonid DROP DEFAULT;
    
   production               example    false    290    291    291            �           2604    16766     transactionhistory transactionid    DEFAULT     �   ALTER TABLE ONLY production.transactionhistory ALTER COLUMN transactionid SET DEFAULT nextval('production.transactionhistory_transactionid_seq'::regclass);
 S   ALTER TABLE production.transactionhistory ALTER COLUMN transactionid DROP DEFAULT;
    
   production               example    false    293    292    293            �           2604    16792    workorder workorderid    DEFAULT     �   ALTER TABLE ONLY production.workorder ALTER COLUMN workorderid SET DEFAULT nextval('production.workorder_workorderid_seq'::regclass);
 H   ALTER TABLE production.workorder ALTER COLUMN workorderid DROP DEFAULT;
    
   production               example    false    297    296    297            �           2604    16835 )   purchaseorderdetail purchaseorderdetailid    DEFAULT     �   ALTER TABLE ONLY purchasing.purchaseorderdetail ALTER COLUMN purchaseorderdetailid SET DEFAULT nextval('purchasing.purchaseorderdetail_purchaseorderdetailid_seq'::regclass);
 \   ALTER TABLE purchasing.purchaseorderdetail ALTER COLUMN purchaseorderdetailid DROP DEFAULT;
    
   purchasing               example    false    301    300    301            �           2604    16847 #   purchaseorderheader purchaseorderid    DEFAULT     �   ALTER TABLE ONLY purchasing.purchaseorderheader ALTER COLUMN purchaseorderid SET DEFAULT nextval('purchasing.purchaseorderheader_purchaseorderid_seq'::regclass);
 V   ALTER TABLE purchasing.purchaseorderheader ALTER COLUMN purchaseorderid DROP DEFAULT;
    
   purchasing               example    false    303    302    303            �           2604    16866    shipmethod shipmethodid    DEFAULT     �   ALTER TABLE ONLY purchasing.shipmethod ALTER COLUMN shipmethodid SET DEFAULT nextval('purchasing.shipmethod_shipmethodid_seq'::regclass);
 J   ALTER TABLE purchasing.shipmethod ALTER COLUMN shipmethodid DROP DEFAULT;
    
   purchasing               example    false    305    304    305            �           2604    16893    creditcard creditcardid    DEFAULT     �   ALTER TABLE ONLY sales.creditcard ALTER COLUMN creditcardid SET DEFAULT nextval('sales.creditcard_creditcardid_seq'::regclass);
 E   ALTER TABLE sales.creditcard ALTER COLUMN creditcardid DROP DEFAULT;
       sales               example    false    309    308    309            �           2604    16905    currencyrate currencyrateid    DEFAULT     �   ALTER TABLE ONLY sales.currencyrate ALTER COLUMN currencyrateid SET DEFAULT nextval('sales.currencyrate_currencyrateid_seq'::regclass);
 I   ALTER TABLE sales.currencyrate ALTER COLUMN currencyrateid DROP DEFAULT;
       sales               example    false    312    311    312            �           2604    16913    customer customerid    DEFAULT     x   ALTER TABLE ONLY sales.customer ALTER COLUMN customerid SET DEFAULT nextval('sales.customer_customerid_seq'::regclass);
 A   ALTER TABLE sales.customer ALTER COLUMN customerid DROP DEFAULT;
       sales               example    false    313    314    314            �           2604    16926 #   salesorderdetail salesorderdetailid    DEFAULT     �   ALTER TABLE ONLY sales.salesorderdetail ALTER COLUMN salesorderdetailid SET DEFAULT nextval('sales.salesorderdetail_salesorderdetailid_seq'::regclass);
 Q   ALTER TABLE sales.salesorderdetail ALTER COLUMN salesorderdetailid DROP DEFAULT;
       sales               example    false    317    316    317            �           2604    16939    salesorderheader salesorderid    DEFAULT     �   ALTER TABLE ONLY sales.salesorderheader ALTER COLUMN salesorderid SET DEFAULT nextval('sales.salesorderheader_salesorderid_seq'::regclass);
 K   ALTER TABLE sales.salesorderheader ALTER COLUMN salesorderid DROP DEFAULT;
       sales               example    false    319    318    319                       2604    16989    salesreason salesreasonid    DEFAULT     �   ALTER TABLE ONLY sales.salesreason ALTER COLUMN salesreasonid SET DEFAULT nextval('sales.salesreason_salesreasonid_seq'::regclass);
 G   ALTER TABLE sales.salesreason ALTER COLUMN salesreasonid DROP DEFAULT;
       sales               example    false    324    323    324                       2604    16997    salestaxrate salestaxrateid    DEFAULT     �   ALTER TABLE ONLY sales.salestaxrate ALTER COLUMN salestaxrateid SET DEFAULT nextval('sales.salestaxrate_salestaxrateid_seq'::regclass);
 I   ALTER TABLE sales.salestaxrate ALTER COLUMN salestaxrateid DROP DEFAULT;
       sales               example    false    326    325    326                       2604    17008    salesterritory territoryid    DEFAULT     �   ALTER TABLE ONLY sales.salesterritory ALTER COLUMN territoryid SET DEFAULT nextval('sales.salesterritory_territoryid_seq'::regclass);
 H   ALTER TABLE sales.salesterritory ALTER COLUMN territoryid DROP DEFAULT;
       sales               example    false    327    328    328                       2604    17031 #   shoppingcartitem shoppingcartitemid    DEFAULT     �   ALTER TABLE ONLY sales.shoppingcartitem ALTER COLUMN shoppingcartitemid SET DEFAULT nextval('sales.shoppingcartitem_shoppingcartitemid_seq'::regclass);
 Q   ALTER TABLE sales.shoppingcartitem ALTER COLUMN shoppingcartitemid DROP DEFAULT;
       sales               example    false    331    330    331                       2604    17040    specialoffer specialofferid    DEFAULT     �   ALTER TABLE ONLY sales.specialoffer ALTER COLUMN specialofferid SET DEFAULT nextval('sales.specialoffer_specialofferid_seq'::regclass);
 I   ALTER TABLE sales.specialoffer ALTER COLUMN specialofferid DROP DEFAULT;
       sales               example    false    332    333    333            h          0    16533 
   department 
   TABLE DATA           Y   COPY humanresources.department (departmentid, name, groupname, modifieddate) FROM stdin;
    humanresources               example    false    253   ��      i          0    16540    employee 
   TABLE DATA           �   COPY humanresources.employee (businessentityid, nationalidnumber, loginid, jobtitle, birthdate, maritalstatus, gender, hiredate, salariedflag, vacationhours, sickleavehours, currentflag, rowguid, modifieddate, organizationnode) FROM stdin;
    humanresources               example    false    254   ��      j          0    16557    employeedepartmenthistory 
   TABLE DATA           �   COPY humanresources.employeedepartmenthistory (businessentityid, departmentid, shiftid, startdate, enddate, modifieddate) FROM stdin;
    humanresources               example    false    255   ��      k          0    16562    employeepayhistory 
   TABLE DATA           x   COPY humanresources.employeepayhistory (businessentityid, ratechangedate, rate, payfrequency, modifieddate) FROM stdin;
    humanresources               example    false    256   �      m          0    16571    jobcandidate 
   TABLE DATA           f   COPY humanresources.jobcandidate (jobcandidateid, businessentityid, resume, modifieddate) FROM stdin;
    humanresources               example    false    258   �      o          0    16579    shift 
   TABLE DATA           X   COPY humanresources.shift (shiftid, name, starttime, endtime, modifieddate) FROM stdin;
    humanresources               example    false    260   <�      Y          0    16466    address 
   TABLE DATA           �   COPY person.address (addressid, addressline1, addressline2, city, stateprovinceid, postalcode, spatiallocation, rowguid, modifieddate) FROM stdin;
    person               example    false    238   Y�      [          0    16473    addresstype 
   TABLE DATA           Q   COPY person.addresstype (addresstypeid, name, rowguid, modifieddate) FROM stdin;
    person               example    false    240   v�      T          0    16438    businessentity 
   TABLE DATA           Q   COPY person.businessentity (businessentityid, rowguid, modifieddate) FROM stdin;
    person               example    false    233   ��      \          0    16481    businessentityaddress 
   TABLE DATA           r   COPY person.businessentityaddress (businessentityid, addressid, addresstypeid, rowguid, modifieddate) FROM stdin;
    person               example    false    241   ��      _          0    16494    businessentitycontact 
   TABLE DATA           q   COPY person.businessentitycontact (businessentityid, personid, contacttypeid, rowguid, modifieddate) FROM stdin;
    person               example    false    244   ��      ^          0    16487    contacttype 
   TABLE DATA           H   COPY person.contacttype (contacttypeid, name, modifieddate) FROM stdin;
    person               example    false    243   ��      f          0    16525    countryregion 
   TABLE DATA           N   COPY person.countryregion (countryregioncode, name, modifieddate) FROM stdin;
    person               example    false    251   �      a          0    16500    emailaddress 
   TABLE DATA           m   COPY person.emailaddress (businessentityid, emailaddressid, emailaddress, rowguid, modifieddate) FROM stdin;
    person               example    false    246   $�      b          0    16506    password 
   TABLE DATA           g   COPY person.password (businessentityid, passwordhash, passwordsalt, rowguid, modifieddate) FROM stdin;
    person               example    false    247   A�      U          0    16444    person 
   TABLE DATA           �   COPY person.person (businessentityid, persontype, namestyle, title, firstname, middlename, lastname, suffix, emailpromotion, additionalcontactinfo, demographics, rowguid, modifieddate) FROM stdin;
    person               example    false    234   ^�      e          0    16519    personphone 
   TABLE DATA           e   COPY person.personphone (businessentityid, phonenumber, phonenumbertypeid, modifieddate) FROM stdin;
    person               example    false    250   {�      d          0    16512    phonenumbertype 
   TABLE DATA           P   COPY person.phonenumbertype (phonenumbertypeid, name, modifieddate) FROM stdin;
    person               example    false    249   ��      W          0    16456    stateprovince 
   TABLE DATA           �   COPY person.stateprovince (stateprovinceid, stateprovincecode, countryregioncode, isonlystateprovinceflag, name, territoryid, rowguid, modifieddate) FROM stdin;
    person               example    false    236   ��      q          0    16590    billofmaterials 
   TABLE DATA           �   COPY production.billofmaterials (billofmaterialsid, productassemblyid, componentid, startdate, enddate, unitmeasurecode, bomlevel, perassemblyqty, modifieddate) FROM stdin;
 
   production               example    false    262   ��      r          0    16601    culture 
   TABLE DATA           D   COPY production.culture (cultureid, name, modifieddate) FROM stdin;
 
   production               example    false    263   ��      s          0    16607    document 
   TABLE DATA           �   COPY production.document (title, owner, folderflag, filename, fileextension, revision, changenumber, status, documentsummary, document, rowguid, modifieddate, documentnode) FROM stdin;
 
   production               example    false    264   �      �          0    16716    illustration 
   TABLE DATA           Q   COPY production.illustration (illustrationid, diagram, modifieddate) FROM stdin;
 
   production               example    false    282   )�      �          0    16689    location 
   TABLE DATA           ^   COPY production.location (locationid, name, costrate, availability, modifieddate) FROM stdin;
 
   production               example    false    278   F�      {          0    16647    product 
   TABLE DATA           u  COPY production.product (productid, name, productnumber, makeflag, finishedgoodsflag, color, safetystocklevel, reorderpoint, standardcost, listprice, size, sizeunitmeasurecode, weightunitmeasurecode, weight, daystomanufacture, productline, class, style, productsubcategoryid, productmodelid, sellstartdate, sellenddate, discontinueddate, rowguid, modifieddate) FROM stdin;
 
   production               example    false    272   c�      u          0    16620    productcategory 
   TABLE DATA           ]   COPY production.productcategory (productcategoryid, name, rowguid, modifieddate) FROM stdin;
 
   production               example    false    266   ��      |          0    16667    productcosthistory 
   TABLE DATA           k   COPY production.productcosthistory (productid, startdate, enddate, standardcost, modifieddate) FROM stdin;
 
   production               example    false    273   ��      ~          0    16676    productdescription 
   TABLE DATA           j   COPY production.productdescription (productdescriptionid, description, rowguid, modifieddate) FROM stdin;
 
   production               example    false    275   ��                0    16682    productdocument 
   TABLE DATA           T   COPY production.productdocument (productid, modifieddate, documentnode) FROM stdin;
 
   production               example    false    276   ��      �          0    16700    productinventory 
   TABLE DATA           r   COPY production.productinventory (productid, locationid, shelf, bin, quantity, rowguid, modifieddate) FROM stdin;
 
   production               example    false    279   ��      �          0    16707    productlistpricehistory 
   TABLE DATA           m   COPY production.productlistpricehistory (productid, startdate, enddate, listprice, modifieddate) FROM stdin;
 
   production               example    false    280   �      y          0    16638    productmodel 
   TABLE DATA           y   COPY production.productmodel (productmodelid, name, catalogdescription, instructions, rowguid, modifieddate) FROM stdin;
 
   production               example    false    270   .�      �          0    16723    productmodelillustration 
   TABLE DATA           d   COPY production.productmodelillustration (productmodelid, illustrationid, modifieddate) FROM stdin;
 
   production               example    false    283   K�      �          0    16727 %   productmodelproductdescriptionculture 
   TABLE DATA           �   COPY production.productmodelproductdescriptionculture (productmodelid, productdescriptionid, cultureid, modifieddate) FROM stdin;
 
   production               example    false    284   h�      �          0    16732    productphoto 
   TABLE DATA           �   COPY production.productphoto (productphotoid, thumbnailphoto, thumbnailphotofilename, largephoto, largephotofilename, modifieddate) FROM stdin;
 
   production               example    false    286   ��      �          0    16739    productproductphoto 
   TABLE DATA           e   COPY production.productproductphoto (productid, productphotoid, "primary", modifieddate) FROM stdin;
 
   production               example    false    287   ��      �          0    16745    productreview 
   TABLE DATA           �   COPY production.productreview (productreviewid, productid, reviewername, reviewdate, emailaddress, rating, comments, modifieddate) FROM stdin;
 
   production               example    false    289   ��      w          0    16629    productsubcategory 
   TABLE DATA           v   COPY production.productsubcategory (productsubcategoryid, productcategoryid, name, rowguid, modifieddate) FROM stdin;
 
   production               example    false    268   ��      �          0    16755    scrapreason 
   TABLE DATA           L   COPY production.scrapreason (scrapreasonid, name, modifieddate) FROM stdin;
 
   production               example    false    291   ��      �          0    16763    transactionhistory 
   TABLE DATA           �   COPY production.transactionhistory (transactionid, productid, referenceorderid, referenceorderlineid, transactiondate, transactiontype, quantity, actualcost, modifieddate) FROM stdin;
 
   production               example    false    293   �      �          0    16773    transactionhistoryarchive 
   TABLE DATA           �   COPY production.transactionhistoryarchive (transactionid, productid, referenceorderid, referenceorderlineid, transactiondate, transactiontype, quantity, actualcost, modifieddate) FROM stdin;
 
   production               example    false    294   3�      �          0    16782    unitmeasure 
   TABLE DATA           N   COPY production.unitmeasure (unitmeasurecode, name, modifieddate) FROM stdin;
 
   production               example    false    295   P�      �          0    16789 	   workorder 
   TABLE DATA           �   COPY production.workorder (workorderid, productid, orderqty, scrappedqty, startdate, enddate, duedate, scrapreasonid, modifieddate) FROM stdin;
 
   production               example    false    297   m�      �          0    16797    workorderrouting 
   TABLE DATA           �   COPY production.workorderrouting (workorderid, productid, operationsequence, locationid, scheduledstartdate, scheduledenddate, actualstartdate, actualenddate, actualresourcehrs, plannedcost, actualcost, modifieddate) FROM stdin;
 
   production               example    false    298   ��      �          0    18799    city 
   TABLE DATA           K   COPY public.city (id, name, countrycode, district, population) FROM stdin;
    public               example    false    425   ��      �          0    18804    country 
   TABLE DATA           �   COPY public.country (code, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2) FROM stdin;
    public               example    false    426   ��      �          0    18810    countrylanguage 
   TABLE DATA           X   COPY public.countrylanguage (countrycode, language, isofficial, percentage) FROM stdin;
    public               example    false    427         �          0    16819    productvendor 
   TABLE DATA           �   COPY purchasing.productvendor (productid, businessentityid, averageleadtime, standardprice, lastreceiptcost, lastreceiptdate, minorderqty, maxorderqty, onorderqty, unitmeasurecode, modifieddate) FROM stdin;
 
   purchasing               example    false    299   R1      �          0    16832    purchaseorderdetail 
   TABLE DATA           �   COPY purchasing.purchaseorderdetail (purchaseorderid, purchaseorderdetailid, duedate, orderqty, productid, unitprice, receivedqty, rejectedqty, modifieddate) FROM stdin;
 
   purchasing               example    false    301   o1      �          0    16844    purchaseorderheader 
   TABLE DATA           �   COPY purchasing.purchaseorderheader (purchaseorderid, revisionnumber, status, employeeid, vendorid, shipmethodid, orderdate, shipdate, subtotal, taxamt, freight, modifieddate) FROM stdin;
 
   purchasing               example    false    303   �1      �          0    16863 
   shipmethod 
   TABLE DATA           g   COPY purchasing.shipmethod (shipmethodid, name, shipbase, shiprate, rowguid, modifieddate) FROM stdin;
 
   purchasing               example    false    305   �1      �          0    16875    vendor 
   TABLE DATA           �   COPY purchasing.vendor (businessentityid, accountnumber, name, creditrating, preferredvendorstatus, activeflag, purchasingwebserviceurl, modifieddate) FROM stdin;
 
   purchasing               example    false    306   �1      �          0    16885    countryregioncurrency 
   TABLE DATA           ]   COPY sales.countryregioncurrency (countryregioncode, currencycode, modifieddate) FROM stdin;
    sales               example    false    307   �1      �          0    16890 
   creditcard 
   TABLE DATA           h   COPY sales.creditcard (creditcardid, cardtype, cardnumber, expmonth, expyear, modifieddate) FROM stdin;
    sales               example    false    309    2      �          0    16895    currency 
   TABLE DATA           C   COPY sales.currency (currencycode, name, modifieddate) FROM stdin;
    sales               example    false    310   2      �          0    16902    currencyrate 
   TABLE DATA           �   COPY sales.currencyrate (currencyrateid, currencyratedate, fromcurrencycode, tocurrencycode, averagerate, endofdayrate, modifieddate) FROM stdin;
    sales               example    false    312   :2      �          0    16910    customer 
   TABLE DATA           d   COPY sales.customer (customerid, personid, storeid, territoryid, rowguid, modifieddate) FROM stdin;
    sales               example    false    314   W2      �          0    16918    personcreditcard 
   TABLE DATA           W   COPY sales.personcreditcard (businessentityid, creditcardid, modifieddate) FROM stdin;
    sales               example    false    315   t2      �          0    16923    salesorderdetail 
   TABLE DATA           �   COPY sales.salesorderdetail (salesorderid, salesorderdetailid, carriertrackingnumber, orderqty, productid, specialofferid, unitprice, unitpricediscount, rowguid, modifieddate) FROM stdin;
    sales               example    false    317   �2      �          0    16936    salesorderheader 
   TABLE DATA           u  COPY sales.salesorderheader (salesorderid, revisionnumber, orderdate, duedate, shipdate, status, onlineorderflag, purchaseordernumber, accountnumber, customerid, salespersonid, territoryid, billtoaddressid, shiptoaddressid, shipmethodid, creditcardid, creditcardapprovalcode, currencyrateid, subtotal, taxamt, freight, totaldue, comment, rowguid, modifieddate) FROM stdin;
    sales               example    false    319   �2      �          0    16957    salesorderheadersalesreason 
   TABLE DATA           _   COPY sales.salesorderheadersalesreason (salesorderid, salesreasonid, modifieddate) FROM stdin;
    sales               example    false    320   �2      �          0    16961    salesperson 
   TABLE DATA           �   COPY sales.salesperson (businessentityid, territoryid, salesquota, bonus, commissionpct, salesytd, saleslastyear, rowguid, modifieddate) FROM stdin;
    sales               example    false    321   �2      �          0    16977    salespersonquotahistory 
   TABLE DATA           p   COPY sales.salespersonquotahistory (businessentityid, quotadate, salesquota, rowguid, modifieddate) FROM stdin;
    sales               example    false    322   3      �          0    16986    salesreason 
   TABLE DATA           S   COPY sales.salesreason (salesreasonid, name, reasontype, modifieddate) FROM stdin;
    sales               example    false    324   "3      �          0    16994    salestaxrate 
   TABLE DATA           u   COPY sales.salestaxrate (salestaxrateid, stateprovinceid, taxtype, taxrate, name, rowguid, modifieddate) FROM stdin;
    sales               example    false    326   ?3      �          0    17005    salesterritory 
   TABLE DATA           �   COPY sales.salesterritory (territoryid, name, countryregioncode, "group", salesytd, saleslastyear, costytd, costlastyear, rowguid, modifieddate) FROM stdin;
    sales               example    false    328   \3      �          0    17021    salesterritoryhistory 
   TABLE DATA           x   COPY sales.salesterritoryhistory (businessentityid, territoryid, startdate, enddate, rowguid, modifieddate) FROM stdin;
    sales               example    false    329   y3      �          0    17028    shoppingcartitem 
   TABLE DATA           }   COPY sales.shoppingcartitem (shoppingcartitemid, shoppingcartid, quantity, productid, datecreated, modifieddate) FROM stdin;
    sales               example    false    331   �3      �          0    17037    specialoffer 
   TABLE DATA           �   COPY sales.specialoffer (specialofferid, description, discountpct, type, category, startdate, enddate, minqty, maxqty, rowguid, modifieddate) FROM stdin;
    sales               example    false    333   �3      �          0    17051    specialofferproduct 
   TABLE DATA           ^   COPY sales.specialofferproduct (specialofferid, productid, rowguid, modifieddate) FROM stdin;
    sales               example    false    334   �3      �          0    17056    store 
   TABLE DATA           j   COPY sales.store (businessentityid, name, salespersonid, demographics, rowguid, modifieddate) FROM stdin;
    sales               example    false    335   �3      �           0    0    department_departmentid_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('humanresources.department_departmentid_seq', 1, false);
          humanresources               example    false    252            �           0    0    jobcandidate_jobcandidateid_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('humanresources.jobcandidate_jobcandidateid_seq', 1, false);
          humanresources               example    false    257            �           0    0    shift_shiftid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('humanresources.shift_shiftid_seq', 1, false);
          humanresources               example    false    259            �           0    0    address_addressid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('person.address_addressid_seq', 1, false);
          person               example    false    237            �           0    0    addresstype_addresstypeid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('person.addresstype_addresstypeid_seq', 1, false);
          person               example    false    239            �           0    0 #   businessentity_businessentityid_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('person.businessentity_businessentityid_seq', 1, false);
          person               example    false    232            �           0    0    contacttype_contacttypeid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('person.contacttype_contacttypeid_seq', 1, false);
          person               example    false    242            �           0    0    emailaddress_emailaddressid_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('person.emailaddress_emailaddressid_seq', 1, false);
          person               example    false    245            �           0    0 %   phonenumbertype_phonenumbertypeid_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('person.phonenumbertype_phonenumbertypeid_seq', 1, false);
          person               example    false    248            �           0    0 !   stateprovince_stateprovinceid_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('person.stateprovince_stateprovinceid_seq', 1, false);
          person               example    false    235            �           0    0 %   billofmaterials_billofmaterialsid_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('production.billofmaterials_billofmaterialsid_seq', 1, false);
       
   production               example    false    261            �           0    0    illustration_illustrationid_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('production.illustration_illustrationid_seq', 1, false);
       
   production               example    false    281            �           0    0    location_locationid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('production.location_locationid_seq', 1, false);
       
   production               example    false    277            �           0    0    product_productid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('production.product_productid_seq', 1, false);
       
   production               example    false    271            �           0    0 %   productcategory_productcategoryid_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('production.productcategory_productcategoryid_seq', 1, false);
       
   production               example    false    265            �           0    0 +   productdescription_productdescriptionid_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('production.productdescription_productdescriptionid_seq', 1, false);
       
   production               example    false    274            �           0    0    productmodel_productmodelid_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('production.productmodel_productmodelid_seq', 1, false);
       
   production               example    false    269            �           0    0    productphoto_productphotoid_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('production.productphoto_productphotoid_seq', 1, false);
       
   production               example    false    285            �           0    0 !   productreview_productreviewid_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('production.productreview_productreviewid_seq', 1, false);
       
   production               example    false    288            �           0    0 +   productsubcategory_productsubcategoryid_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('production.productsubcategory_productsubcategoryid_seq', 1, false);
       
   production               example    false    267            �           0    0    scrapreason_scrapreasonid_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('production.scrapreason_scrapreasonid_seq', 1, false);
       
   production               example    false    290            �           0    0 $   transactionhistory_transactionid_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('production.transactionhistory_transactionid_seq', 1, false);
       
   production               example    false    292            �           0    0    workorder_workorderid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('production.workorder_workorderid_seq', 1, false);
       
   production               example    false    296            �           0    0 -   purchaseorderdetail_purchaseorderdetailid_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('purchasing.purchaseorderdetail_purchaseorderdetailid_seq', 1, false);
       
   purchasing               example    false    300            �           0    0 '   purchaseorderheader_purchaseorderid_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('purchasing.purchaseorderheader_purchaseorderid_seq', 1, false);
       
   purchasing               example    false    302            �           0    0    shipmethod_shipmethodid_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('purchasing.shipmethod_shipmethodid_seq', 1, false);
       
   purchasing               example    false    304            �           0    0    creditcard_creditcardid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('sales.creditcard_creditcardid_seq', 1, false);
          sales               example    false    308            �           0    0    currencyrate_currencyrateid_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('sales.currencyrate_currencyrateid_seq', 1, false);
          sales               example    false    311            �           0    0    customer_customerid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('sales.customer_customerid_seq', 1, false);
          sales               example    false    313            �           0    0 '   salesorderdetail_salesorderdetailid_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('sales.salesorderdetail_salesorderdetailid_seq', 1, false);
          sales               example    false    316            �           0    0 !   salesorderheader_salesorderid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('sales.salesorderheader_salesorderid_seq', 1, false);
          sales               example    false    318            �           0    0    salesreason_salesreasonid_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('sales.salesreason_salesreasonid_seq', 1, false);
          sales               example    false    323            �           0    0    salestaxrate_salestaxrateid_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('sales.salestaxrate_salestaxrateid_seq', 1, false);
          sales               example    false    325            �           0    0    salesterritory_territoryid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('sales.salesterritory_territoryid_seq', 1, false);
          sales               example    false    327            �           0    0 '   shoppingcartitem_shoppingcartitemid_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('sales.shoppingcartitem_shoppingcartitemid_seq', 1, false);
          sales               example    false    330            �           0    0    specialoffer_specialofferid_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('sales.specialoffer_specialofferid_seq', 1, false);
          sales               example    false    332            �           2606    17171 %   department PK_Department_DepartmentID 
   CONSTRAINT     �   ALTER TABLE ONLY humanresources.department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (departmentid);

ALTER TABLE humanresources.department CLUSTER ON "PK_Department_DepartmentID";
 Y   ALTER TABLE ONLY humanresources.department DROP CONSTRAINT "PK_Department_DepartmentID";
       humanresources                 example    false    253            �           2606    17187 Y   employeedepartmenthistory PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm 
   CONSTRAINT     U  ALTER TABLE ONLY humanresources.employeedepartmenthistory
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (businessentityid, startdate, departmentid, shiftid);

ALTER TABLE humanresources.employeedepartmenthistory CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";
 �   ALTER TABLE ONLY humanresources.employeedepartmenthistory DROP CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";
       humanresources                 example    false    255    255    255    255            �           2606    17193 H   employeepayhistory PK_EmployeePayHistory_BusinessEntityID_RateChangeDate 
   CONSTRAINT     !  ALTER TABLE ONLY humanresources.employeepayhistory
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (businessentityid, ratechangedate);

ALTER TABLE humanresources.employeepayhistory CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";
 |   ALTER TABLE ONLY humanresources.employeepayhistory DROP CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";
       humanresources                 example    false    256    256            �           2606    17179 %   employee PK_Employee_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY humanresources.employee
    ADD CONSTRAINT "PK_Employee_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE humanresources.employee CLUSTER ON "PK_Employee_BusinessEntityID";
 Y   ALTER TABLE ONLY humanresources.employee DROP CONSTRAINT "PK_Employee_BusinessEntityID";
       humanresources                 example    false    254            �           2606    17201 +   jobcandidate PK_JobCandidate_JobCandidateID 
   CONSTRAINT     �   ALTER TABLE ONLY humanresources.jobcandidate
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (jobcandidateid);

ALTER TABLE humanresources.jobcandidate CLUSTER ON "PK_JobCandidate_JobCandidateID";
 _   ALTER TABLE ONLY humanresources.jobcandidate DROP CONSTRAINT "PK_JobCandidate_JobCandidateID";
       humanresources                 example    false    258            �           2606    17459    shift PK_Shift_ShiftID 
   CONSTRAINT     �   ALTER TABLE ONLY humanresources.shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shiftid);

ALTER TABLE humanresources.shift CLUSTER ON "PK_Shift_ShiftID";
 J   ALTER TABLE ONLY humanresources.shift DROP CONSTRAINT "PK_Shift_ShiftID";
       humanresources                 example    false    260            �           2606    17070 (   addresstype PK_AddressType_AddressTypeID 
   CONSTRAINT     �   ALTER TABLE ONLY person.addresstype
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (addresstypeid);

ALTER TABLE person.addresstype CLUSTER ON "PK_AddressType_AddressTypeID";
 T   ALTER TABLE ONLY person.addresstype DROP CONSTRAINT "PK_AddressType_AddressTypeID";
       person                 example    false    240            �           2606    17064    address PK_Address_AddressID 
   CONSTRAINT     �   ALTER TABLE ONLY person.address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (addressid);

ALTER TABLE person.address CLUSTER ON "PK_Address_AddressID";
 H   ALTER TABLE ONLY person.address DROP CONSTRAINT "PK_Address_AddressID";
       person                 example    false    238            �           2606    17086 U   businessentityaddress PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType 
   CONSTRAINT     5  ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (businessentityid, addressid, addresstypeid);

ALTER TABLE person.businessentityaddress CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";
 �   ALTER TABLE ONLY person.businessentityaddress DROP CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";
       person                 example    false    241    241    241            �           2606    17092 U   businessentitycontact PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI 
   CONSTRAINT     4  ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (businessentityid, personid, contacttypeid);

ALTER TABLE person.businessentitycontact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";
 �   ALTER TABLE ONLY person.businessentitycontact DROP CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";
       person                 example    false    244    244    244            |           2606    17080 1   businessentity PK_BusinessEntity_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY person.businessentity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.businessentity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";
 ]   ALTER TABLE ONLY person.businessentity DROP CONSTRAINT "PK_BusinessEntity_BusinessEntityID";
       person                 example    false    233            �           2606    17098 (   contacttype PK_ContactType_ContactTypeID 
   CONSTRAINT     �   ALTER TABLE ONLY person.contacttype
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contacttypeid);

ALTER TABLE person.contacttype CLUSTER ON "PK_ContactType_ContactTypeID";
 T   ALTER TABLE ONLY person.contacttype DROP CONSTRAINT "PK_ContactType_ContactTypeID";
       person                 example    false    243            �           2606    17112 0   countryregion PK_CountryRegion_CountryRegionCode 
   CONSTRAINT     �   ALTER TABLE ONLY person.countryregion
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (countryregioncode);

ALTER TABLE person.countryregion CLUSTER ON "PK_CountryRegion_CountryRegionCode";
 \   ALTER TABLE ONLY person.countryregion DROP CONSTRAINT "PK_CountryRegion_CountryRegionCode";
       person                 example    false    251            �           2606    17165 <   emailaddress PK_EmailAddress_BusinessEntityID_EmailAddressID 
   CONSTRAINT     �   ALTER TABLE ONLY person.emailaddress
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (businessentityid, emailaddressid);

ALTER TABLE person.emailaddress CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";
 h   ALTER TABLE ONLY person.emailaddress DROP CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID";
       person                 example    false    246    246            �           2606    17225 %   password PK_Password_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY person.password
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.password CLUSTER ON "PK_Password_BusinessEntityID";
 Q   ALTER TABLE ONLY person.password DROP CONSTRAINT "PK_Password_BusinessEntityID";
       person                 example    false    247            �           2606    17239 I   personphone PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID 
   CONSTRAINT     #  ALTER TABLE ONLY person.personphone
    ADD CONSTRAINT "PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID" PRIMARY KEY (businessentityid, phonenumber, phonenumbertypeid);

ALTER TABLE person.personphone CLUSTER ON "PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID";
 u   ALTER TABLE ONLY person.personphone DROP CONSTRAINT "PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID";
       person                 example    false    250    250    250            ~           2606    17231 !   person PK_Person_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY person.person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.person CLUSTER ON "PK_Person_BusinessEntityID";
 M   ALTER TABLE ONLY person.person DROP CONSTRAINT "PK_Person_BusinessEntityID";
       person                 example    false    234            �           2606    17247 4   phonenumbertype PK_PhoneNumberType_PhoneNumberTypeID 
   CONSTRAINT     �   ALTER TABLE ONLY person.phonenumbertype
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phonenumbertypeid);

ALTER TABLE person.phonenumbertype CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";
 `   ALTER TABLE ONLY person.phonenumbertype DROP CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID";
       person                 example    false    249            �           2606    17495 .   stateprovince PK_StateProvince_StateProvinceID 
   CONSTRAINT     �   ALTER TABLE ONLY person.stateprovince
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (stateprovinceid);

ALTER TABLE person.stateprovince CLUSTER ON "PK_StateProvince_StateProvinceID";
 Z   ALTER TABLE ONLY person.stateprovince DROP CONSTRAINT "PK_StateProvince_StateProvinceID";
       person                 example    false    236            �           2606    17078 4   billofmaterials PK_BillOfMaterials_BillOfMaterialsID 
   CONSTRAINT     �   ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (billofmaterialsid);
 d   ALTER TABLE ONLY production.billofmaterials DROP CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID";
    
   production                 example    false    262            �           2606    17148    culture PK_Culture_CultureID 
   CONSTRAINT     �   ALTER TABLE ONLY production.culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (cultureid);

ALTER TABLE production.culture CLUSTER ON "PK_Culture_CultureID";
 L   ALTER TABLE ONLY production.culture DROP CONSTRAINT "PK_Culture_CultureID";
    
   production                 example    false    263            �           2606    17156 !   document PK_Document_DocumentNode 
   CONSTRAINT     �   ALTER TABLE ONLY production.document
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (documentnode);

ALTER TABLE production.document CLUSTER ON "PK_Document_DocumentNode";
 Q   ALTER TABLE ONLY production.document DROP CONSTRAINT "PK_Document_DocumentNode";
    
   production                 example    false    264            �           2606    17209 +   illustration PK_Illustration_IllustrationID 
   CONSTRAINT     �   ALTER TABLE ONLY production.illustration
    ADD CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illustrationid);

ALTER TABLE production.illustration CLUSTER ON "PK_Illustration_IllustrationID";
 [   ALTER TABLE ONLY production.illustration DROP CONSTRAINT "PK_Illustration_IllustrationID";
    
   production                 example    false    282            �           2606    17217    location PK_Location_LocationID 
   CONSTRAINT     �   ALTER TABLE ONLY production.location
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (locationid);

ALTER TABLE production.location CLUSTER ON "PK_Location_LocationID";
 O   ALTER TABLE ONLY production.location DROP CONSTRAINT "PK_Location_LocationID";
    
   production                 example    false    278            �           2606    17263 4   productcategory PK_ProductCategory_ProductCategoryID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productcategory
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (productcategoryid);

ALTER TABLE production.productcategory CLUSTER ON "PK_ProductCategory_ProductCategoryID";
 d   ALTER TABLE ONLY production.productcategory DROP CONSTRAINT "PK_ProductCategory_ProductCategoryID";
    
   production                 example    false    266            �           2606    17271 <   productcosthistory PK_ProductCostHistory_ProductID_StartDate 
   CONSTRAINT     �   ALTER TABLE ONLY production.productcosthistory
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate);

ALTER TABLE production.productcosthistory CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";
 l   ALTER TABLE ONLY production.productcosthistory DROP CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate";
    
   production                 example    false    273    273            �           2606    17279 =   productdescription PK_ProductDescription_ProductDescriptionID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productdescription
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (productdescriptionid);

ALTER TABLE production.productdescription CLUSTER ON "PK_ProductDescription_ProductDescriptionID";
 m   ALTER TABLE ONLY production.productdescription DROP CONSTRAINT "PK_ProductDescription_ProductDescriptionID";
    
   production                 example    false    275            �           2606    17285 9   productdocument PK_ProductDocument_ProductID_DocumentNode 
   CONSTRAINT     �   ALTER TABLE ONLY production.productdocument
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (productid, documentnode);

ALTER TABLE production.productdocument CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";
 i   ALTER TABLE ONLY production.productdocument DROP CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode";
    
   production                 example    false    276    276            �           2606    17293 9   productinventory PK_ProductInventory_ProductID_LocationID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productinventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (productid, locationid);

ALTER TABLE production.productinventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";
 i   ALTER TABLE ONLY production.productinventory DROP CONSTRAINT "PK_ProductInventory_ProductID_LocationID";
    
   production                 example    false    279    279            �           2606    17299 F   productlistpricehistory PK_ProductListPriceHistory_ProductID_StartDate 
   CONSTRAINT     	  ALTER TABLE ONLY production.productlistpricehistory
    ADD CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate);

ALTER TABLE production.productlistpricehistory CLUSTER ON "PK_ProductListPriceHistory_ProductID_StartDate";
 v   ALTER TABLE ONLY production.productlistpricehistory DROP CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate";
    
   production                 example    false    280    280            �           2606    17315 R   productmodelillustration PK_ProductModelIllustration_ProductModelID_IllustrationID 
   CONSTRAINT     +  ALTER TABLE ONLY production.productmodelillustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (productmodelid, illustrationid);

ALTER TABLE production.productmodelillustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";
 �   ALTER TABLE ONLY production.productmodelillustration DROP CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID";
    
   production                 example    false    283    283            �           2606    17321 e   productmodelproductdescriptionculture PK_ProductModelProductDescriptionCulture_ProductModelID_Product 
   CONSTRAINT     b  ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (productmodelid, productdescriptionid, cultureid);

ALTER TABLE production.productmodelproductdescriptionculture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";
 �   ALTER TABLE ONLY production.productmodelproductdescriptionculture DROP CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";
    
   production                 example    false    284    284    284            �           2606    17307 +   productmodel PK_ProductModel_ProductModelID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productmodel
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (productmodelid);

ALTER TABLE production.productmodel CLUSTER ON "PK_ProductModel_ProductModelID";
 [   ALTER TABLE ONLY production.productmodel DROP CONSTRAINT "PK_ProductModel_ProductModelID";
    
   production                 example    false    270            �           2606    17327 +   productphoto PK_ProductPhoto_ProductPhotoID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productphoto
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (productphotoid);

ALTER TABLE production.productphoto CLUSTER ON "PK_ProductPhoto_ProductPhotoID";
 [   ALTER TABLE ONLY production.productphoto DROP CONSTRAINT "PK_ProductPhoto_ProductPhotoID";
    
   production                 example    false    286            �           2606    17335 C   productproductphoto PK_ProductProductPhoto_ProductID_ProductPhotoID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productproductphoto
    ADD CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY (productid, productphotoid);
 s   ALTER TABLE ONLY production.productproductphoto DROP CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID";
    
   production                 example    false    287    287            �           2606    17337 .   productreview PK_ProductReview_ProductReviewID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productreview
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (productreviewid);

ALTER TABLE production.productreview CLUSTER ON "PK_ProductReview_ProductReviewID";
 ^   ALTER TABLE ONLY production.productreview DROP CONSTRAINT "PK_ProductReview_ProductReviewID";
    
   production                 example    false    289            �           2606    17345 =   productsubcategory PK_ProductSubcategory_ProductSubcategoryID 
   CONSTRAINT     �   ALTER TABLE ONLY production.productsubcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (productsubcategoryid);

ALTER TABLE production.productsubcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";
 m   ALTER TABLE ONLY production.productsubcategory DROP CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID";
    
   production                 example    false    268            �           2606    17255    product PK_Product_ProductID 
   CONSTRAINT     �   ALTER TABLE ONLY production.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (productid);

ALTER TABLE production.product CLUSTER ON "PK_Product_ProductID";
 L   ALTER TABLE ONLY production.product DROP CONSTRAINT "PK_Product_ProductID";
    
   production                 example    false    272            �           2606    17451 (   scrapreason PK_ScrapReason_ScrapReasonID 
   CONSTRAINT     �   ALTER TABLE ONLY production.scrapreason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrapreasonid);

ALTER TABLE production.scrapreason CLUSTER ON "PK_ScrapReason_ScrapReasonID";
 X   ALTER TABLE ONLY production.scrapreason DROP CONSTRAINT "PK_ScrapReason_ScrapReasonID";
    
   production                 example    false    291            �           2606    17519 D   transactionhistoryarchive PK_TransactionHistoryArchive_TransactionID 
   CONSTRAINT     �   ALTER TABLE ONLY production.transactionhistoryarchive
    ADD CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transactionid);

ALTER TABLE production.transactionhistoryarchive CLUSTER ON "PK_TransactionHistoryArchive_TransactionID";
 t   ALTER TABLE ONLY production.transactionhistoryarchive DROP CONSTRAINT "PK_TransactionHistoryArchive_TransactionID";
    
   production                 example    false    294            �           2606    17511 6   transactionhistory PK_TransactionHistory_TransactionID 
   CONSTRAINT     �   ALTER TABLE ONLY production.transactionhistory
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transactionid);

ALTER TABLE production.transactionhistory CLUSTER ON "PK_TransactionHistory_TransactionID";
 f   ALTER TABLE ONLY production.transactionhistory DROP CONSTRAINT "PK_TransactionHistory_TransactionID";
    
   production                 example    false    293            �           2606    17527 *   unitmeasure PK_UnitMeasure_UnitMeasureCode 
   CONSTRAINT     �   ALTER TABLE ONLY production.unitmeasure
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unitmeasurecode);

ALTER TABLE production.unitmeasure CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";
 Z   ALTER TABLE ONLY production.unitmeasure DROP CONSTRAINT "PK_UnitMeasure_UnitMeasureCode";
    
   production                 example    false    295            �           2606    17549 L   workorderrouting PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence 
   CONSTRAINT     *  ALTER TABLE ONLY production.workorderrouting
    ADD CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY (workorderid, productid, operationsequence);

ALTER TABLE production.workorderrouting CLUSTER ON "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence";
 |   ALTER TABLE ONLY production.workorderrouting DROP CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence";
    
   production                 example    false    298    298    298            �           2606    17543 "   workorder PK_WorkOrder_WorkOrderID 
   CONSTRAINT     �   ALTER TABLE ONLY production.workorder
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (workorderid);

ALTER TABLE production.workorder CLUSTER ON "PK_WorkOrder_WorkOrderID";
 R   ALTER TABLE ONLY production.workorder DROP CONSTRAINT "PK_WorkOrder_WorkOrderID";
    
   production                 example    false    297            �           2606    16618    document document_rowguid_key 
   CONSTRAINT     _   ALTER TABLE ONLY production.document
    ADD CONSTRAINT document_rowguid_key UNIQUE (rowguid);
 K   ALTER TABLE ONLY production.document DROP CONSTRAINT document_rowguid_key;
    
   production                 example    false    264                       2606    18816    city city_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public                 example    false    425            
           2606    18818    country country_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (code);
 >   ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
       public                 example    false    426                       2606    18820 $   countrylanguage countrylanguage_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.countrylanguage
    ADD CONSTRAINT countrylanguage_pkey PRIMARY KEY (countrycode, language);
 N   ALTER TABLE ONLY public.countrylanguage DROP CONSTRAINT countrylanguage_pkey;
       public                 example    false    427    427            �           2606    17353 9   productvendor PK_ProductVendor_ProductID_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (productid, businessentityid);

ALTER TABLE purchasing.productvendor CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";
 i   ALTER TABLE ONLY purchasing.productvendor DROP CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID";
    
   purchasing                 example    false    299    299            �           2606    17361 P   purchaseorderdetail PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID 
   CONSTRAINT     /  ALTER TABLE ONLY purchasing.purchaseorderdetail
    ADD CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (purchaseorderid, purchaseorderdetailid);

ALTER TABLE purchasing.purchaseorderdetail CLUSTER ON "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";
 �   ALTER TABLE ONLY purchasing.purchaseorderdetail DROP CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";
    
   purchasing                 example    false    301    301            �           2606    17369 :   purchaseorderheader PK_PurchaseOrderHeader_PurchaseOrderID 
   CONSTRAINT     �   ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (purchaseorderid);

ALTER TABLE purchasing.purchaseorderheader CLUSTER ON "PK_PurchaseOrderHeader_PurchaseOrderID";
 j   ALTER TABLE ONLY purchasing.purchaseorderheader DROP CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID";
    
   purchasing                 example    false    303            �           2606    17467 %   shipmethod PK_ShipMethod_ShipMethodID 
   CONSTRAINT     �   ALTER TABLE ONLY purchasing.shipmethod
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (shipmethodid);

ALTER TABLE purchasing.shipmethod CLUSTER ON "PK_ShipMethod_ShipMethodID";
 U   ALTER TABLE ONLY purchasing.shipmethod DROP CONSTRAINT "PK_ShipMethod_ShipMethodID";
    
   purchasing                 example    false    305            �           2606    17535 !   vendor PK_Vendor_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE purchasing.vendor CLUSTER ON "PK_Vendor_BusinessEntityID";
 Q   ALTER TABLE ONLY purchasing.vendor DROP CONSTRAINT "PK_Vendor_BusinessEntityID";
    
   purchasing                 example    false    306            �           2606    17106 M   countryregioncurrency PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode 
   CONSTRAINT       ALTER TABLE ONLY sales.countryregioncurrency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (countryregioncode, currencycode);

ALTER TABLE sales.countryregioncurrency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";
 x   ALTER TABLE ONLY sales.countryregioncurrency DROP CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";
       sales                 example    false    307    307            �           2606    17120 %   creditcard PK_CreditCard_CreditCardID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.creditcard
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (creditcardid);

ALTER TABLE sales.creditcard CLUSTER ON "PK_CreditCard_CreditCardID";
 P   ALTER TABLE ONLY sales.creditcard DROP CONSTRAINT "PK_CreditCard_CreditCardID";
       sales                 example    false    309            �           2606    17134 +   currencyrate PK_CurrencyRate_CurrencyRateID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.currencyrate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currencyrateid);

ALTER TABLE sales.currencyrate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";
 V   ALTER TABLE ONLY sales.currencyrate DROP CONSTRAINT "PK_CurrencyRate_CurrencyRateID";
       sales                 example    false    312            �           2606    17126 !   currency PK_Currency_CurrencyCode 
   CONSTRAINT     �   ALTER TABLE ONLY sales.currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currencycode);

ALTER TABLE sales.currency CLUSTER ON "PK_Currency_CurrencyCode";
 L   ALTER TABLE ONLY sales.currency DROP CONSTRAINT "PK_Currency_CurrencyCode";
       sales                 example    false    310            �           2606    17142    customer PK_Customer_CustomerID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customerid);

ALTER TABLE sales.customer CLUSTER ON "PK_Customer_CustomerID";
 J   ALTER TABLE ONLY sales.customer DROP CONSTRAINT "PK_Customer_CustomerID";
       sales                 example    false    314            �           2606    17377 B   personcreditcard PK_PersonCreditCard_BusinessEntityID_CreditCardID 
   CONSTRAINT       ALTER TABLE ONLY sales.personcreditcard
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (businessentityid, creditcardid);

ALTER TABLE sales.personcreditcard CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";
 m   ALTER TABLE ONLY sales.personcreditcard DROP CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID";
       sales                 example    false    315    315            �           2606    17383 D   salesorderdetail PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID 
   CONSTRAINT       ALTER TABLE ONLY sales.salesorderdetail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (salesorderid, salesorderdetailid);

ALTER TABLE sales.salesorderdetail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";
 o   ALTER TABLE ONLY sales.salesorderdetail DROP CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";
       sales                 example    false    317    317            �           2606    17399 U   salesorderheadersalesreason PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID 
   CONSTRAINT     $  ALTER TABLE ONLY sales.salesorderheadersalesreason
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (salesorderid, salesreasonid);

ALTER TABLE sales.salesorderheadersalesreason CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";
 �   ALTER TABLE ONLY sales.salesorderheadersalesreason DROP CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";
       sales                 example    false    320    320            �           2606    17391 1   salesorderheader PK_SalesOrderHeader_SalesOrderID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (salesorderid);

ALTER TABLE sales.salesorderheader CLUSTER ON "PK_SalesOrderHeader_SalesOrderID";
 \   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "PK_SalesOrderHeader_SalesOrderID";
       sales                 example    false    319            �           2606    17413 M   salespersonquotahistory PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate 
   CONSTRAINT       ALTER TABLE ONLY sales.salespersonquotahistory
    ADD CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (businessentityid, quotadate);

ALTER TABLE sales.salespersonquotahistory CLUSTER ON "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";
 x   ALTER TABLE ONLY sales.salespersonquotahistory DROP CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";
       sales                 example    false    322    322            �           2606    17405 +   salesperson PK_SalesPerson_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.salesperson
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE sales.salesperson CLUSTER ON "PK_SalesPerson_BusinessEntityID";
 V   ALTER TABLE ONLY sales.salesperson DROP CONSTRAINT "PK_SalesPerson_BusinessEntityID";
       sales                 example    false    321            �           2606    17421 (   salesreason PK_SalesReason_SalesReasonID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.salesreason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (salesreasonid);

ALTER TABLE sales.salesreason CLUSTER ON "PK_SalesReason_SalesReasonID";
 S   ALTER TABLE ONLY sales.salesreason DROP CONSTRAINT "PK_SalesReason_SalesReasonID";
       sales                 example    false    324            �           2606    17429 +   salestaxrate PK_SalesTaxRate_SalesTaxRateID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.salestaxrate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (salestaxrateid);

ALTER TABLE sales.salestaxrate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";
 V   ALTER TABLE ONLY sales.salestaxrate DROP CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID";
       sales                 example    false    326            �           2606    17445 U   salesterritoryhistory PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID 
   CONSTRAINT     1  ALTER TABLE ONLY sales.salesterritoryhistory
    ADD CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (businessentityid, startdate, territoryid);

ALTER TABLE sales.salesterritoryhistory CLUSTER ON "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";
 �   ALTER TABLE ONLY sales.salesterritoryhistory DROP CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";
       sales                 example    false    329    329    329            �           2606    17437 ,   salesterritory PK_SalesTerritory_TerritoryID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.salesterritory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territoryid);

ALTER TABLE sales.salesterritory CLUSTER ON "PK_SalesTerritory_TerritoryID";
 W   ALTER TABLE ONLY sales.salesterritory DROP CONSTRAINT "PK_SalesTerritory_TerritoryID";
       sales                 example    false    328            �           2606    17475 7   shoppingcartitem PK_ShoppingCartItem_ShoppingCartItemID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.shoppingcartitem
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shoppingcartitemid);

ALTER TABLE sales.shoppingcartitem CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";
 b   ALTER TABLE ONLY sales.shoppingcartitem DROP CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID";
       sales                 example    false    331                       2606    17489 C   specialofferproduct PK_SpecialOfferProduct_SpecialOfferID_ProductID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.specialofferproduct
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (specialofferid, productid);

ALTER TABLE sales.specialofferproduct CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";
 n   ALTER TABLE ONLY sales.specialofferproduct DROP CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID";
       sales                 example    false    334    334                        2606    17481 +   specialoffer PK_SpecialOffer_SpecialOfferID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.specialoffer
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (specialofferid);

ALTER TABLE sales.specialoffer CLUSTER ON "PK_SpecialOffer_SpecialOfferID";
 V   ALTER TABLE ONLY sales.specialoffer DROP CONSTRAINT "PK_SpecialOffer_SpecialOfferID";
       sales                 example    false    333                       2606    17503    store PK_Store_BusinessEntityID 
   CONSTRAINT     �   ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE sales.store CLUSTER ON "PK_Store_BusinessEntityID";
 J   ALTER TABLE ONLY sales.store DROP CONSTRAINT "PK_Store_BusinessEntityID";
       sales                 example    false    335                       1259    18105    ix_vstateprovincecountryregion    INDEX     �   CREATE UNIQUE INDEX ix_vstateprovincecountryregion ON person.vstateprovincecountryregion USING btree (stateprovinceid, countryregioncode);

ALTER TABLE person.vstateprovincecountryregion CLUSTER ON ix_vstateprovincecountryregion;
 2   DROP INDEX person.ix_vstateprovincecountryregion;
       person                 example    false    351    351                       1259    18063    ix_vproductanddescription    INDEX     �   CREATE UNIQUE INDEX ix_vproductanddescription ON production.vproductanddescription USING btree (cultureid, productid);

ALTER TABLE production.vproductanddescription CLUSTER ON ix_vproductanddescription;
 1   DROP INDEX production.ix_vproductanddescription;
    
   production                 example    false    345    345                       2606    17656 N   employeedepartmenthistory FK_EmployeeDepartmentHistory_Department_DepartmentID    FK CONSTRAINT     �   ALTER TABLE ONLY humanresources.employeedepartmenthistory
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (departmentid) REFERENCES humanresources.department(departmentid);
 �   ALTER TABLE ONLY humanresources.employeedepartmenthistory DROP CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID";
       humanresources               example    false    253    4246    255                       2606    17661 P   employeedepartmenthistory FK_EmployeeDepartmentHistory_Employee_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY humanresources.employeedepartmenthistory
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES humanresources.employee(businessentityid);
 �   ALTER TABLE ONLY humanresources.employeedepartmenthistory DROP CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID";
       humanresources               example    false    255    254    4248                       2606    17666 D   employeedepartmenthistory FK_EmployeeDepartmentHistory_Shift_ShiftID    FK CONSTRAINT     �   ALTER TABLE ONLY humanresources.employeedepartmenthistory
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shiftid) REFERENCES humanresources.shift(shiftid);
 x   ALTER TABLE ONLY humanresources.employeedepartmenthistory DROP CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID";
       humanresources               example    false    255    260    4256                       2606    17671 B   employeepayhistory FK_EmployeePayHistory_Employee_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY humanresources.employeepayhistory
    ADD CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES humanresources.employee(businessentityid);
 v   ALTER TABLE ONLY humanresources.employeepayhistory DROP CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID";
       humanresources               example    false    4248    254    256                       2606    17651 ,   employee FK_Employee_Person_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY humanresources.employee
    ADD CONSTRAINT "FK_Employee_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);
 `   ALTER TABLE ONLY humanresources.employee DROP CONSTRAINT "FK_Employee_Person_BusinessEntityID";
       humanresources               example    false    4222    234    254                        2606    17676 6   jobcandidate FK_JobCandidate_Employee_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY humanresources.jobcandidate
    ADD CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES humanresources.employee(businessentityid);
 j   ALTER TABLE ONLY humanresources.jobcandidate DROP CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID";
       humanresources               example    false    258    4248    254                       2606    17556 0   address FK_Address_StateProvince_StateProvinceID    FK CONSTRAINT     �   ALTER TABLE ONLY person.address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid) REFERENCES person.stateprovince(stateprovinceid);
 \   ALTER TABLE ONLY person.address DROP CONSTRAINT "FK_Address_StateProvince_StateProvinceID";
       person               example    false    238    4224    236                       2606    17581 H   businessentityaddress FK_BusinessEntityAddress_AddressType_AddressTypeID    FK CONSTRAINT     �   ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (addresstypeid) REFERENCES person.addresstype(addresstypeid);
 t   ALTER TABLE ONLY person.businessentityaddress DROP CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID";
       person               example    false    240    241    4228                       2606    17576 @   businessentityaddress FK_BusinessEntityAddress_Address_AddressID    FK CONSTRAINT     �   ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (addressid) REFERENCES person.address(addressid);
 l   ALTER TABLE ONLY person.businessentityaddress DROP CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID";
       person               example    false    241    4226    238                       2606    17586 N   businessentityaddress FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);
 z   ALTER TABLE ONLY person.businessentityaddress DROP CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID";
       person               example    false    4220    241    233                       2606    17601 N   businessentitycontact FK_BusinessEntityContact_BusinessEntity_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);
 z   ALTER TABLE ONLY person.businessentitycontact DROP CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID";
       person               example    false    4220    244    233                       2606    17596 H   businessentitycontact FK_BusinessEntityContact_ContactType_ContactTypeID    FK CONSTRAINT     �   ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (contacttypeid) REFERENCES person.contacttype(contacttypeid);
 t   ALTER TABLE ONLY person.businessentitycontact DROP CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID";
       person               example    false    244    4232    243                       2606    17591 >   businessentitycontact FK_BusinessEntityContact_Person_PersonID    FK CONSTRAINT     �   ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (personid) REFERENCES person.person(businessentityid);
 j   ALTER TABLE ONLY person.businessentitycontact DROP CONSTRAINT "FK_BusinessEntityContact_Person_PersonID";
       person               example    false    4222    244    234                       2606    17646 4   emailaddress FK_EmailAddress_Person_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY person.emailaddress
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);
 `   ALTER TABLE ONLY person.emailaddress DROP CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID";
       person               example    false    4222    246    234                       2606    17681 ,   password FK_Password_Person_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY person.password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);
 X   ALTER TABLE ONLY person.password DROP CONSTRAINT "FK_Password_Person_BusinessEntityID";
       person               example    false    234    4222    247                       2606    17701 2   personphone FK_PersonPhone_Person_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY person.personphone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);
 ^   ALTER TABLE ONLY person.personphone DROP CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID";
       person               example    false    4222    234    250                       2606    17706 <   personphone FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID    FK CONSTRAINT     �   ALTER TABLE ONLY person.personphone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phonenumbertypeid) REFERENCES person.phonenumbertype(phonenumbertypeid);
 h   ALTER TABLE ONLY person.personphone DROP CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID";
       person               example    false    249    4240    250                       2606    17686 0   person FK_Person_BusinessEntity_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY person.person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);
 \   ALTER TABLE ONLY person.person DROP CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID";
       person               example    false    233    4220    234                       2606    17956 >   stateprovince FK_StateProvince_CountryRegion_CountryRegionCode    FK CONSTRAINT     �   ALTER TABLE ONLY person.stateprovince
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.countryregion(countryregioncode);
 j   ALTER TABLE ONLY person.stateprovince DROP CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode";
       person               example    false    236    4244    251                       2606    17961 9   stateprovince FK_StateProvince_SalesTerritory_TerritoryID    FK CONSTRAINT     �   ALTER TABLE ONLY person.stateprovince
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);
 e   ALTER TABLE ONLY person.stateprovince DROP CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID";
       person               example    false    236    328    4346            !           2606    17566 6   billofmaterials FK_BillOfMaterials_Product_ComponentID    FK CONSTRAINT     �   ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (componentid) REFERENCES production.product(productid);
 f   ALTER TABLE ONLY production.billofmaterials DROP CONSTRAINT "FK_BillOfMaterials_Product_ComponentID";
    
   production               example    false    262    4272    272            "           2606    17561 <   billofmaterials FK_BillOfMaterials_Product_ProductAssemblyID    FK CONSTRAINT     �   ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (productassemblyid) REFERENCES production.product(productid);
 l   ALTER TABLE ONLY production.billofmaterials DROP CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID";
    
   production               example    false    262    4272    272            #           2606    17571 >   billofmaterials FK_BillOfMaterials_UnitMeasure_UnitMeasureCode    FK CONSTRAINT     �   ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);
 n   ALTER TABLE ONLY production.billofmaterials DROP CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode";
    
   production               example    false    262    4304    295            $           2606    17641 #   document FK_Document_Employee_Owner    FK CONSTRAINT     �   ALTER TABLE ONLY production.document
    ADD CONSTRAINT "FK_Document_Employee_Owner" FOREIGN KEY (owner) REFERENCES humanresources.employee(businessentityid);
 S   ALTER TABLE ONLY production.document DROP CONSTRAINT "FK_Document_Employee_Owner";
    
   production               example    false    264    4248    254            *           2606    17731 :   productcosthistory FK_ProductCostHistory_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productcosthistory
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 j   ALTER TABLE ONLY production.productcosthistory DROP CONSTRAINT "FK_ProductCostHistory_Product_ProductID";
    
   production               example    false    272    4272    273            +           2606    17741 8   productdocument FK_ProductDocument_Document_DocumentNode    FK CONSTRAINT     �   ALTER TABLE ONLY production.productdocument
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (documentnode) REFERENCES production.document(documentnode);
 h   ALTER TABLE ONLY production.productdocument DROP CONSTRAINT "FK_ProductDocument_Document_DocumentNode";
    
   production               example    false    276    4262    264            ,           2606    17736 4   productdocument FK_ProductDocument_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productdocument
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 d   ALTER TABLE ONLY production.productdocument DROP CONSTRAINT "FK_ProductDocument_Product_ProductID";
    
   production               example    false    276    272    4272            -           2606    17746 8   productinventory FK_ProductInventory_Location_LocationID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productinventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (locationid) REFERENCES production.location(locationid);
 h   ALTER TABLE ONLY production.productinventory DROP CONSTRAINT "FK_ProductInventory_Location_LocationID";
    
   production               example    false    4280    278    279            .           2606    17751 6   productinventory FK_ProductInventory_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productinventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 f   ALTER TABLE ONLY production.productinventory DROP CONSTRAINT "FK_ProductInventory_Product_ProductID";
    
   production               example    false    272    4272    279            /           2606    17756 D   productlistpricehistory FK_ProductListPriceHistory_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productlistpricehistory
    ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 t   ALTER TABLE ONLY production.productlistpricehistory DROP CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID";
    
   production               example    false    4272    280    272            0           2606    17766 P   productmodelillustration FK_ProductModelIllustration_Illustration_IllustrationID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productmodelillustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustrationid) REFERENCES production.illustration(illustrationid);
 �   ALTER TABLE ONLY production.productmodelillustration DROP CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID";
    
   production               example    false    4286    283    282            1           2606    17761 P   productmodelillustration FK_ProductModelIllustration_ProductModel_ProductModelID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productmodelillustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);
 �   ALTER TABLE ONLY production.productmodelillustration DROP CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID";
    
   production               example    false    4270    270    283            2           2606    17776 `   productmodelproductdescriptionculture FK_ProductModelProductDescriptionCulture_Culture_CultureID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (cultureid) REFERENCES production.culture(cultureid);
 �   ALTER TABLE ONLY production.productmodelproductdescriptionculture DROP CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID";
    
   production               example    false    4260    284    263            3           2606    17771 e   productmodelproductdescriptionculture FK_ProductModelProductDescriptionCulture_ProductDescription_Pro    FK CONSTRAINT     �   ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (productdescriptionid) REFERENCES production.productdescription(productdescriptionid);
 �   ALTER TABLE ONLY production.productmodelproductdescriptionculture DROP CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro";
    
   production               example    false    275    284    4276            4           2606    17781 e   productmodelproductdescriptionculture FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo    FK CONSTRAINT     �   ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);
 �   ALTER TABLE ONLY production.productmodelproductdescriptionculture DROP CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo";
    
   production               example    false    270    284    4270            5           2606    17791 F   productproductphoto FK_ProductProductPhoto_ProductPhoto_ProductPhotoID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productproductphoto
    ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY (productphotoid) REFERENCES production.productphoto(productphotoid);
 v   ALTER TABLE ONLY production.productproductphoto DROP CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID";
    
   production               example    false    286    4292    287            6           2606    17786 <   productproductphoto FK_ProductProductPhoto_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productproductphoto
    ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 l   ALTER TABLE ONLY production.productproductphoto DROP CONSTRAINT "FK_ProductProductPhoto_Product_ProductID";
    
   production               example    false    287    4272    272            7           2606    17796 0   productreview FK_ProductReview_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productreview
    ADD CONSTRAINT "FK_ProductReview_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 `   ALTER TABLE ONLY production.productreview DROP CONSTRAINT "FK_ProductReview_Product_ProductID";
    
   production               example    false    289    272    4272            %           2606    17801 J   productsubcategory FK_ProductSubcategory_ProductCategory_ProductCategoryID    FK CONSTRAINT     �   ALTER TABLE ONLY production.productsubcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (productcategoryid) REFERENCES production.productcategory(productcategoryid);
 z   ALTER TABLE ONLY production.productsubcategory DROP CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID";
    
   production               example    false    4266    268    266            &           2606    17721 .   product FK_Product_ProductModel_ProductModelID    FK CONSTRAINT     �   ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);
 ^   ALTER TABLE ONLY production.product DROP CONSTRAINT "FK_Product_ProductModel_ProductModelID";
    
   production               example    false    270    272    4270            '           2606    17726 :   product FK_Product_ProductSubcategory_ProductSubcategoryID    FK CONSTRAINT     �   ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (productsubcategoryid) REFERENCES production.productsubcategory(productsubcategoryid);
 j   ALTER TABLE ONLY production.product DROP CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID";
    
   production               example    false    268    272    4268            (           2606    17711 2   product FK_Product_UnitMeasure_SizeUnitMeasureCode    FK CONSTRAINT     �   ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (sizeunitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);
 b   ALTER TABLE ONLY production.product DROP CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode";
    
   production               example    false    4304    295    272            )           2606    17716 4   product FK_Product_UnitMeasure_WeightUnitMeasureCode    FK CONSTRAINT     �   ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weightunitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);
 d   ALTER TABLE ONLY production.product DROP CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode";
    
   production               example    false    272    295    4304            8           2606    17976 :   transactionhistory FK_TransactionHistory_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.transactionhistory
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 j   ALTER TABLE ONLY production.transactionhistory DROP CONSTRAINT "FK_TransactionHistory_Product_ProductID";
    
   production               example    false    4272    272    293            ;           2606    17996 8   workorderrouting FK_WorkOrderRouting_Location_LocationID    FK CONSTRAINT     �   ALTER TABLE ONLY production.workorderrouting
    ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (locationid) REFERENCES production.location(locationid);
 h   ALTER TABLE ONLY production.workorderrouting DROP CONSTRAINT "FK_WorkOrderRouting_Location_LocationID";
    
   production               example    false    278    298    4280            <           2606    18001 :   workorderrouting FK_WorkOrderRouting_WorkOrder_WorkOrderID    FK CONSTRAINT     �   ALTER TABLE ONLY production.workorderrouting
    ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (workorderid) REFERENCES production.workorder(workorderid);
 j   ALTER TABLE ONLY production.workorderrouting DROP CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID";
    
   production               example    false    4306    298    297            9           2606    17986 (   workorder FK_WorkOrder_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY production.workorder
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 X   ALTER TABLE ONLY production.workorder DROP CONSTRAINT "FK_WorkOrder_Product_ProductID";
    
   production               example    false    297    272    4272            :           2606    17991 0   workorder FK_WorkOrder_ScrapReason_ScrapReasonID    FK CONSTRAINT     �   ALTER TABLE ONLY production.workorder
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrapreasonid) REFERENCES production.scrapreason(scrapreasonid);
 `   ALTER TABLE ONLY production.workorder DROP CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID";
    
   production               example    false    297    4298    291            g           2606    18821    country country_capital_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_capital_fkey FOREIGN KEY (capital) REFERENCES public.city(id);
 F   ALTER TABLE ONLY public.country DROP CONSTRAINT country_capital_fkey;
       public               example    false    4360    426    425            h           2606    18826 0   countrylanguage countrylanguage_countrycode_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.countrylanguage
    ADD CONSTRAINT countrylanguage_countrycode_fkey FOREIGN KEY (countrycode) REFERENCES public.country(code);
 Z   ALTER TABLE ONLY public.countrylanguage DROP CONSTRAINT countrylanguage_countrycode_fkey;
       public               example    false    4362    426    427            =           2606    17806 0   productvendor FK_ProductVendor_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 `   ALTER TABLE ONLY purchasing.productvendor DROP CONSTRAINT "FK_ProductVendor_Product_ProductID";
    
   purchasing               example    false    4272    299    272            >           2606    17811 :   productvendor FK_ProductVendor_UnitMeasure_UnitMeasureCode    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);
 j   ALTER TABLE ONLY purchasing.productvendor DROP CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode";
    
   purchasing               example    false    4304    295    299            ?           2606    17816 6   productvendor FK_ProductVendor_Vendor_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES purchasing.vendor(businessentityid);
 f   ALTER TABLE ONLY purchasing.productvendor DROP CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID";
    
   purchasing               example    false    299    306    4318            @           2606    17821 <   purchaseorderdetail FK_PurchaseOrderDetail_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.purchaseorderdetail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 l   ALTER TABLE ONLY purchasing.purchaseorderdetail DROP CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID";
    
   purchasing               example    false    301    272    4272            A           2606    17826 N   purchaseorderdetail FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.purchaseorderdetail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (purchaseorderid) REFERENCES purchasing.purchaseorderheader(purchaseorderid);
 ~   ALTER TABLE ONLY purchasing.purchaseorderdetail DROP CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID";
    
   purchasing               example    false    301    4314    303            B           2606    17831 >   purchaseorderheader FK_PurchaseOrderHeader_Employee_EmployeeID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID" FOREIGN KEY (employeeid) REFERENCES humanresources.employee(businessentityid);
 n   ALTER TABLE ONLY purchasing.purchaseorderheader DROP CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID";
    
   purchasing               example    false    303    4248    254            C           2606    17841 B   purchaseorderheader FK_PurchaseOrderHeader_ShipMethod_ShipMethodID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid) REFERENCES purchasing.shipmethod(shipmethodid);
 r   ALTER TABLE ONLY purchasing.purchaseorderheader DROP CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID";
    
   purchasing               example    false    4316    303    305            D           2606    17836 :   purchaseorderheader FK_PurchaseOrderHeader_Vendor_VendorID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (vendorid) REFERENCES purchasing.vendor(businessentityid);
 j   ALTER TABLE ONLY purchasing.purchaseorderheader DROP CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID";
    
   purchasing               example    false    306    303    4318            E           2606    17981 0   vendor FK_Vendor_BusinessEntity_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);
 `   ALTER TABLE ONLY purchasing.vendor DROP CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID";
    
   purchasing               example    false    306    233    4220            F           2606    17606 N   countryregioncurrency FK_CountryRegionCurrency_CountryRegion_CountryRegionCode    FK CONSTRAINT     �   ALTER TABLE ONLY sales.countryregioncurrency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.countryregion(countryregioncode);
 y   ALTER TABLE ONLY sales.countryregioncurrency DROP CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode";
       sales               example    false    307    4244    251            G           2606    17611 D   countryregioncurrency FK_CountryRegionCurrency_Currency_CurrencyCode    FK CONSTRAINT     �   ALTER TABLE ONLY sales.countryregioncurrency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currencycode) REFERENCES sales.currency(currencycode);
 o   ALTER TABLE ONLY sales.countryregioncurrency DROP CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode";
       sales               example    false    310    307    4324            H           2606    17616 6   currencyrate FK_CurrencyRate_Currency_FromCurrencyCode    FK CONSTRAINT     �   ALTER TABLE ONLY sales.currencyrate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (fromcurrencycode) REFERENCES sales.currency(currencycode);
 a   ALTER TABLE ONLY sales.currencyrate DROP CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode";
       sales               example    false    312    4324    310            I           2606    17621 4   currencyrate FK_CurrencyRate_Currency_ToCurrencyCode    FK CONSTRAINT     �   ALTER TABLE ONLY sales.currencyrate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (tocurrencycode) REFERENCES sales.currency(currencycode);
 _   ALTER TABLE ONLY sales.currencyrate DROP CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode";
       sales               example    false    310    312    4324            J           2606    17626 $   customer FK_Customer_Person_PersonID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (personid) REFERENCES person.person(businessentityid);
 O   ALTER TABLE ONLY sales.customer DROP CONSTRAINT "FK_Customer_Person_PersonID";
       sales               example    false    4222    314    234            K           2606    17636 /   customer FK_Customer_SalesTerritory_TerritoryID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);
 Z   ALTER TABLE ONLY sales.customer DROP CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID";
       sales               example    false    328    4346    314            L           2606    17631 "   customer FK_Customer_Store_StoreID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (storeid) REFERENCES sales.store(businessentityid);
 M   ALTER TABLE ONLY sales.customer DROP CONSTRAINT "FK_Customer_Store_StoreID";
       sales               example    false    314    4356    335            M           2606    17696 <   personcreditcard FK_PersonCreditCard_CreditCard_CreditCardID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.personcreditcard
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (creditcardid) REFERENCES sales.creditcard(creditcardid);
 g   ALTER TABLE ONLY sales.personcreditcard DROP CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID";
       sales               example    false    309    4322    315            N           2606    17691 <   personcreditcard FK_PersonCreditCard_Person_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.personcreditcard
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);
 g   ALTER TABLE ONLY sales.personcreditcard DROP CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID";
       sales               example    false    4222    234    315            O           2606    17846 B   salesorderdetail FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderdetail
    ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid) REFERENCES sales.salesorderheader(salesorderid) ON DELETE CASCADE;
 m   ALTER TABLE ONLY sales.salesorderdetail DROP CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID";
       sales               example    false    319    4334    317            P           2606    17851 P   salesorderdetail FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderdetail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (specialofferid, productid) REFERENCES sales.specialofferproduct(specialofferid, productid);
 {   ALTER TABLE ONLY sales.salesorderdetail DROP CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID";
       sales               example    false    334    334    4354    317    317            Y           2606    17901 X   salesorderheadersalesreason FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheadersalesreason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid) REFERENCES sales.salesorderheader(salesorderid) ON DELETE CASCADE;
 �   ALTER TABLE ONLY sales.salesorderheadersalesreason DROP CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID";
       sales               example    false    320    319    4334            Z           2606    17896 T   salesorderheadersalesreason FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheadersalesreason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (salesreasonid) REFERENCES sales.salesreason(salesreasonid);
    ALTER TABLE ONLY sales.salesorderheadersalesreason DROP CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID";
       sales               example    false    320    324    4342            Q           2606    17856 <   salesorderheader FK_SalesOrderHeader_Address_BillToAddressID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (billtoaddressid) REFERENCES person.address(addressid);
 g   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID";
       sales               example    false    238    4226    319            R           2606    17861 <   salesorderheader FK_SalesOrderHeader_Address_ShipToAddressID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (shiptoaddressid) REFERENCES person.address(addressid);
 g   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID";
       sales               example    false    319    4226    238            S           2606    17866 <   salesorderheader FK_SalesOrderHeader_CreditCard_CreditCardID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (creditcardid) REFERENCES sales.creditcard(creditcardid);
 g   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID";
       sales               example    false    319    4322    309            T           2606    17871 @   salesorderheader FK_SalesOrderHeader_CurrencyRate_CurrencyRateID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY (currencyrateid) REFERENCES sales.currencyrate(currencyrateid);
 k   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID";
       sales               example    false    4326    312    319            U           2606    17876 8   salesorderheader FK_SalesOrderHeader_Customer_CustomerID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY (customerid) REFERENCES sales.customer(customerid);
 c   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID";
       sales               example    false    314    4328    319            V           2606    17881 >   salesorderheader FK_SalesOrderHeader_SalesPerson_SalesPersonID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid) REFERENCES sales.salesperson(businessentityid);
 i   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID";
       sales               example    false    321    319    4338            W           2606    17891 ?   salesorderheader FK_SalesOrderHeader_SalesTerritory_TerritoryID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);
 j   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID";
       sales               example    false    328    319    4346            X           2606    17886 <   salesorderheader FK_SalesOrderHeader_ShipMethod_ShipMethodID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid) REFERENCES purchasing.shipmethod(shipmethodid);
 g   ALTER TABLE ONLY sales.salesorderheader DROP CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID";
       sales               example    false    4316    305    319            ]           2606    17916 O   salespersonquotahistory FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salespersonquotahistory
    ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES sales.salesperson(businessentityid);
 z   ALTER TABLE ONLY sales.salespersonquotahistory DROP CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID";
       sales               example    false    4338    321    322            [           2606    17906 4   salesperson FK_SalesPerson_Employee_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesperson
    ADD CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES humanresources.employee(businessentityid);
 _   ALTER TABLE ONLY sales.salesperson DROP CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID";
       sales               example    false    254    321    4248            \           2606    17911 5   salesperson FK_SalesPerson_SalesTerritory_TerritoryID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesperson
    ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);
 `   ALTER TABLE ONLY sales.salesperson DROP CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID";
       sales               example    false    328    321    4346            ^           2606    17921 :   salestaxrate FK_SalesTaxRate_StateProvince_StateProvinceID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salestaxrate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid) REFERENCES person.stateprovince(stateprovinceid);
 e   ALTER TABLE ONLY sales.salestaxrate DROP CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID";
       sales               example    false    326    236    4224            `           2606    17931 K   salesterritoryhistory FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesterritoryhistory
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES sales.salesperson(businessentityid);
 v   ALTER TABLE ONLY sales.salesterritoryhistory DROP CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID";
       sales               example    false    4338    329    321            a           2606    17936 I   salesterritoryhistory FK_SalesTerritoryHistory_SalesTerritory_TerritoryID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesterritoryhistory
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);
 t   ALTER TABLE ONLY sales.salesterritoryhistory DROP CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID";
       sales               example    false    329    328    4346            _           2606    17926 @   salesterritory FK_SalesTerritory_CountryRegion_CountryRegionCode    FK CONSTRAINT     �   ALTER TABLE ONLY sales.salesterritory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.countryregion(countryregioncode);
 k   ALTER TABLE ONLY sales.salesterritory DROP CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode";
       sales               example    false    251    4244    328            b           2606    17941 6   shoppingcartitem FK_ShoppingCartItem_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.shoppingcartitem
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 a   ALTER TABLE ONLY sales.shoppingcartitem DROP CONSTRAINT "FK_ShoppingCartItem_Product_ProductID";
       sales               example    false    331    272    4272            c           2606    17946 <   specialofferproduct FK_SpecialOfferProduct_Product_ProductID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.specialofferproduct
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);
 g   ALTER TABLE ONLY sales.specialofferproduct DROP CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID";
       sales               example    false    272    334    4272            d           2606    17951 F   specialofferproduct FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.specialofferproduct
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (specialofferid) REFERENCES sales.specialoffer(specialofferid);
 q   ALTER TABLE ONLY sales.specialofferproduct DROP CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID";
       sales               example    false    333    334    4352            e           2606    17966 .   store FK_Store_BusinessEntity_BusinessEntityID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);
 Y   ALTER TABLE ONLY sales.store DROP CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID";
       sales               example    false    335    233    4220            f           2606    17971 (   store FK_Store_SalesPerson_SalesPersonID    FK CONSTRAINT     �   ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid) REFERENCES sales.salesperson(businessentityid);
 S   ALTER TABLE ONLY sales.store DROP CONSTRAINT "FK_Store_SalesPerson_SalesPersonID";
       sales               example    false    4338    321    335            �           0    18094    vstateprovincecountryregion    MATERIALIZED VIEW DATA     >   REFRESH MATERIALIZED VIEW person.vstateprovincecountryregion;
          person               example    false    351    4801            �           0    18051    vproductanddescription    MATERIALIZED VIEW DATA     =   REFRESH MATERIALIZED VIEW production.vproductanddescription;
       
   production               example    false    345    4801            h      x������ � �      i      x������ � �      j      x������ � �      k      x������ � �      m      x������ � �      o      x������ � �      Y      x������ � �      [      x������ � �      T      x������ � �      \      x������ � �      _      x������ � �      ^      x������ � �      f      x������ � �      a      x������ � �      b      x������ � �      U      x������ � �      e      x������ � �      d      x������ � �      W      x������ � �      q      x������ � �      r      x������ � �      s      x������ � �      �      x������ � �      �      x������ � �      {      x������ � �      u      x������ � �      |      x������ � �      ~      x������ � �            x������ � �      �      x������ � �      �      x������ � �      y      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      w      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x����r#I�%�v~�Y�����-�`�G0IF�d��� x N8ܙ8�ஷ���]M������+yewY��9G��?�S�V@S�CMMU����c]�I�Y���Td��6�s�Z?�|�����׋{�ERꍔ�ON�'�u�_u�.yw���P��l���u��x��$�L����3�(�ٻ�"�Іy��к+6D�T�&P��:'�u���_���B��uS&��F(�Ϯ�{�w��i>[�I~Љ�ROt"ۉ}�ı��4�T�|��Q�'>q�,�4��5��9��Ή�Z�e2�Cu���P�g���l���|IJ�x�B%�u�>��]+������!_O�,�/�I�>��	��W��8!Vf��?�"�ĉ�q�JJS��,y.�b4�8�5.�E]�a'��v�GY�h��7z6Ԇ��7׶���w�M��L
�z�9�r"�yI��w���qC�.DN�7e���U��Is\׎�׳�P�^Z��8*v�)ߺJ�Y��E�����;�$)�F�ؑ랸��K�l�:ڮ㟸��u���$�,˱�8�N�������D��N\p=ч�`;A�x�u�d��7�O<k?��nإ;pO<�\a��Sn�x'�g���o+���̓��*�ۿ��+8�|��R��_�61U�+�6W�~ן\��E���R"B[�X�^d�/(S�&�)>���ډ��s����|t]7p0`��M���ĞE'�mݿ�s=Ţ��);N|ǺOg��4�F�����Q�oX�����u�L�3�H��q��G+�u���e��en���u��3=�!�ޝU���/����tc���ӷ>��U��|�x��Z��2�9�')�:Ph"��ퟓd�6u�8T��gl=`Z�I>��/]���t�������۟� �}�ϐ~k)���e�1?5�v0�c}�.޽_d���2��:�+ӊ��Ra������Q�l7���X�Npxփ�^Q��jS���Z���>b�P/E�Х� ���(K=���[Ɇ���袿�$������i>�6T���jRHa��	!(���b�nL�i�ϫ�:���@���.wc�жn�*�$RZD��8B0�j�]`Z�Oc�_��朄���HF�4�)TpzֽN���s�ȡ|��ùuo�Z����uVMtj��>ԟ�P9���T�������7X��Շ����������,�4&y�w~�����C,�Ǖ�K���UI^�G�L��s�,�����0s��,��Óȶ���ZC)�j!m��"���ȱ޿�QΊ�!�}��_�D.�5�B��c����?-eG�7�0�+�͒�/zU����h�ȷ~�ԭꮷH�@��:��Wԏ�dtZ/� �+6r��F8@��"X�]ˎB�b�$�9��uJ��P�i�z��i~�ŏ��F/����s`~�"/8�m���"�bLO/)�9c#iX�����C*�^b�R��0��0
8u�L�@Sp.��Nb�`��s��O)ן��sze�x6�Z�J�|L&eR6�R��;�����༹�,�/�~O�˳�Uߣu��'�����Ng�mb�s��c���z�� �'ʁ0d�ia��6�8Dn{�B�Z�Rhx���O�� eK�0f��W�I�U:@Am�}V�,SVi�=����r8P|Rh&�f/�~ףS��t�s.��B8T@�G�1	���"��u���Q8-�>X�)�W�Z*e}.�o���/�[=�׉�նm�j,ⷿ͇��.-@aG6X��:/f�v���LE�	��+-	��v�[(�Y=E��:-r�a���x�y��+����*l�x�6���y!:��(�z��w7��L�ٳ��������|(�|v�*3��pY_�b�\�E�MR�Z5�}q��	�����^a��o�C�=3+�cR氺k������X�+�Oh�ώ�R�@��Gĩ��?��	��3�h*�}��{��a�XYr�}�j�a��)�+,*X2����b����+:&H4 M����t�Z���4V��8��܂0�u�5׳]�1�>ޤ�"{��(���*�b[,| ��3��s��FV��m��z�.�C��P���6}�)�B���E ?&�c�����)8�+�_U�z���v8��r^�t��+D�B��N׵Ji�� `�����,�7�̀"�~~~\�>;�:�z���U�J��;���΢)��o�;�ע��t��B%��11���'�gT��]����,����K�ed|��tF��
e2��$�U	�CJh�ڀ���sH�ᐮ�ŏU��k��E��n��B��3Wp�t�����X*�1$��Td:�'TQLG���O�n�н�O���.�C���@0Xe�w�E6�/�ֻ=�(�6���e
�,�8��Wl��1�K���G���~�-�9��'�>�m]P�M}z��<qC�ǧ#�dM-;�C���
|��~&>�q�V
��-X����K�\����zYY�_>�C*��[g�W���?���?������b����W�M7R��"���T�t���o�sZ
Q��SBr V����mY<s{d�P�Me���5�}�Aww�	� ��%����O^�5���"� ���$8���<�ʵ.U��*�a�y>=�N?�z�J�|;�� ��e��8�� pW��
���]T����]oW�ڼ��;q̝������.������/Ch�� ��Sx82���qB��UJ��L�e����'������A�<��������TxZ�K�-������- �Y\���h��	OK����ZI�����0H ��>�9`�6���gK���)�Ud1��I�����)���k��N9��	`�C/?���`-ȾR�uv8=
>.�Ai��Y�u*��<`�~M�=GU+p��l�l��N�N	����)��Z�|�O	(>\|�a�\���FJ?@��>RC$%���Ĭ$��Zf��R!��?�+�^�1������)�?:qz?�uY���W|���߄�ܚ�Fϋ�ݡ|^�#�b��v� �#,'I�lׂ���Q`��"�Ph>��w� A��� �-��i�������:����= � U����'�i������:b!Ҧ���7�x����J �Ca��m���M�\�8�+�EG��ֺu�XT�] 	�8pP�(V��/��Ӣ$%嘢�f�^����_[�n�#���Bc�o(Ԡ�}�Gqs']=-�����و��.��~zt��I>�ruP�����qG����%`2����h��4� ��mE�b�'z51�|�c�'��S�����
�����)5� :�֤�ž���QL���w�h>�8�X�0�J�>��돰�.�i(/+?�d~���N�ޤL�9��:�^��-i�@t�<U�,]�g�ӚZ���H�Գ~I�t��u��N��u�'p��k��4��y�A`}��7�u ����W��^�r���\�2��n|�*+�ЂG-�]Z�Ο�@ŊG6{� �n"���#���80�`�]ˆ�9���)��z���.�#M���.wQI����K{�I�_H��N�F�aR���&��:�X�4�h�1M���s�&p9��Xt �d�B@�4\8/��F h��F*,�%�Z�+��jn
��c���	���?�4��,�x�U�(�݉����AõM����=��}-���x����VO�ӝ� ������E��o:�Zv)@s@RPVz�i^���Iy�R�T{U��nھ&���{X���k=MR`qaP#��F�C��3�i��oi=�N�� H��4x�y+��1��T8���@,��ZR��Z���b1 pu60�7���
c�;G[_�@��P`��kf�jfl���#ֈM�@aBȠ5!d���5��
�:"�c}.�����"��;�"mIA���L
�!���"��{J�]!�Ia�] 4 j�Sɪ�0,n@UM�d��X���'d]� ���i$uV�j�^ \�痀j1��,����    B�H)E*��	褡2��X�G���*�^��z���!�`\@��t��o�C��C�ŘD��U�'X�����3�{d}�R1�i���ll��q	��hV�}R��'(�Y(����2k��:���� r�* .;Y�u�L5	���Hs��Mc�!���S�E#}/����mP�n��Ȉio�}[6�\�� ��Jh8t���e�6�Yl����dp���<q�뮱J��m��!d��;�V��dA�] w_��j�E��x��<\�����=�t�����#����[Teͪ6!tA�� ,��?�����yJ���,ճd���y��x�%,�L�א�� !�G�p��#��"A�T��|X?��.�W$�������-5Ǜ�c��(q@�[��U�a�5 �K�������6��m�r�����! Q��W�@rIl�e
�f��'+������B��P�{�G��*_�Kq�zLw���čjs]���b�l �)L�����y�g^���Xe��q��C�S�9�/��,]��s�
�1����=QG��1`+0��򐲳��H��2�>m���?�&��/�`��@������e:<���P��Ұ��֓���q��)��H͘p�!�0֘��+����U�q����T?լ���$��,��O��ퟵWX;ǁ�Ci8Ȼ�`͏`�	Q6�E��E�PiR��ٞ;_�|J^�j8�tP�>��ԫtE�����N=ͪU��jpj��)�%=�~S>�(��m��xa7�"	����P�]2+�ܕ8�\�JQ`-!DűU�)15���u5�iDxq�A(w�Z724T�������$kO>L�æ�?��H��@�/��7�s2�=�%$P<��<&��3=�����Ŋ �}�X1���g�!0 ���zb %@X�=�����-��]���[�߀��>`&���?��m��X{�C�4�Th���^�&���LJ�@�2�&����=4�F+nu�f������zŁ��!ad}z��C+���A���i0r�fmF(�T�J�?�H��C� 
����ho�!��� ��ߦ�B��u�q����zc�Xt�h,S�g��+�U����XI��\%���ߜ��AD����YbΝz
$@�q� x<h�Vz 3�6$p���n&��e5��Np�	\��e�Z�
B�!DN�`�� �x�g�Q�pM�֥}�T-��0�,0��@��#�a]�DOt�t7;Q��fC�Z2E�5p/[���	�"�V�a8�3@��>t�(X#s�¯���|@#)lQj�Cы<��5�գSh��&��|I�s9<`�zG�c��A�v;T�%�Bu��4�x��X"J�'T�N �1#��u�4SN(;a�!��:�"Ѫ0��K�;��j��0�d�Q�����?׾mA£���N��;cv�+!� �����o�X��mz>z�{VT���5��W8��I �Sw�z���\��zٞ��}NxA�A��p�����-�2���W�T�0���*��KO�h/���%������,�U�t���0j;A���UZ֘��o�g�����M������4�ZV�S�ܳQN`�\��֤hvE��x^�a�jds�U�Ä��+Jrm�j�+F-�Z�Ť�w�������?�;4����R�1�S2�mz�8ʈ����~߶}L(�\�<D <A�����H([+߸ՖO�!C��[0H��tx{�b,: ���T������{�;I�S��q�1]�6�ַj��#^H��s��[�}��BX|L-�*+�E�,�z�ȁ��j!�՘��VG����e�6��-���X��l6h����ia��g W[ A�!��{6�� ��z�#S���� q�b�Mi�<�]pW��Tl�q�<� �~-+����gZ�=J6P��=�:�v��~�`i7�s�U���$��xZ�	F�8��
���np�D���#^XCa:����f��˦�ӡ��~�� ��&ѻ�=$m�	����Y�PL�kq��Z�mo�%�q-xt>�r@IE|[%M��5䴿�RQ1O����@� {1ؓ �?�s?�z}�?2`z���Ui��E�0ҝ�~�MGy�?�o1
Y'׻Ò6��`c�b-����]����X�����Q���K�+���R7��7��W�<�c�&�w���I�b��\|.�X�~��<���f�agP�M��Z?�����]��[]Q;�(#��S4��$�9ք>��h���Ns��V 4��X��y�
�HcQ+��g�V �r�FE><��__,V(�!IkN���a�N`��o�7_Ύ��@�K�e��X�d��DF>P[�z��I\g>���1h���|K�ڹܝ�E4^>�o����9Pw��g��ûg�����t��a��'��F��a1@���_����/��{3p���p3B�8�/$<��M�ű�\b�<����l0�5�f��s����|�k)֤e�;n��fep�dW������!�Ȯ�$:=u�����lxl��c�rx���K��!B=T66'����|�1�*���-�u�,��_���]�&fɬ�F��*E!�3 ��b.v��^P�*�_���XXGcy�����H�D��;3
j�}����;��1]0�����><Q���{�|�dW��N��(%7|ϖMZ0�;~v�m�"����sqף�d�7�݁F�q?T����*`D����ZK����0@ �/�E����%0.����XZ�6����ɡB��v%CV��G=!�m���L�kPâ�I^��v��&�t� 5ׇ��3x"> ���]3�7�Ah�+@�T��+�
�'Zۧ�X픋Yw�LG�\��9�}��\�����3����(^�^�d_?��spVt�>��A�9ߕczZߊM��]�,2�A��ꨄ+����nx���+j|��&Z���@���M�Z��j��|�c�������&G� zP����L�ݤSax_��M��|p���Z,�-~�3þ�ū�d��t�����M���X^3Q�lBX�wև|nr0 Y�#J��rHB5nHb�<��y�"���b#!�rY�`\���(�V~�H �fi�]�E�
L9}B�E��{�d�v�r�B���7���m�$��ۅ��#i?������A�5��Qx9K����A�{�%ό�߶~�پ)�xm~�jq�geh�C: ��P�о3����[��'^�"I6������<���A
ǺD1���'��E����`(�=�튡����L8����X&���/�w��Z|^(���CO��|�~MXgI9isΕ(D� �h�'}�v��O�N��0T�S�Ƅg��Ŋ���� ��́: �R��Y5�]�v)��ؑ��u�W��������a��6Oڤ�n)O3�&QA���h��%��^O�� ��%��d'�;~�����LݑE�x#�y�;��D�u�R�E�X30�Zz����������/�����C�px��鲧2��,: �3�*iO,pc�X� �ӲX���N'x��
8�.�P<�Nql��/�Ji�_�aJ�g9��'��o���Eȍ��eaYO����x~6c���6s���=��/����}!��pS;����	�z|$wYZ�����ʽ-���<"�%�_K�'gV��S�S-p��M��e�Y ���֟s�>�%��BF���S@ ~�Dnt	L1z��3�]~G�i�o�1���g�ysL���%]�����Z$�&��f24p�P�� n5~�~�dI����*����P�
�$��9����r�)�� �A�����<�+\�Ӭ�Gl[ai£�Z���-�H�9��uoT�	a�������� �^�:W.���Y6`蔙(^o�Xt������y�2]�tg)�w��0�;K�#TC��c`u ܅�L�2� ��B���=���O�     K���ڥ�:u���=�~ϒd3T�Wg��4e����P:�J�C�Q�Ʌ���d��4�[�@M�a�������5>C�a��(`���3�$x�R�+�@m��a=�����x�p�M�>��%7ҙBf�_xa���k�3�P:��\�?C����r����Q �Q�+���' �mV<��g�i>{X�`����O�R<�V�N�r�e�GG�5� @�Z'R$f�� ��6<�E�%�z���Ni �t�%̭��+8�Sٵ�_��,mʚV� ��%=�.7:+���w�?�t�(R��z�g�%��c����_�Z�4���Y�;<$�EQA�zu�\�A%LǳL�Ռ��l��}�Ǌ�N�٧�o�z���n����?_[t��������Z��G�)V�����_���S�D@�m%�r%�EsO`�y�w-�����Ξ1����T�@=��AK�6�]��T/*n�����b��b!D��gd����:i����.3�H8��F@��)p��YɊ���Wz4.*�3���yL� �y�4M�m��'8y!X�Nh>�v�|��\��9w�]�A�CFn0X��<��Sn�A��a`.�����5'�G��)cv�V�N;18<���J�u*�"`R0+�z4��	��v%A�2�0f�Q�����G�{a���.����KH��G�0��D_�EYO�A>�D(�H�@�]�'�'AĽ�z�S�ЗCW�� ;P8���IZ����7�lg]3u�%��ƅ�\��S����0�1
�QL���F�M��R�J���1g��7��u��9�����xfʆ�P����.X{J`C�.�؊�m23����&e	H]^�O���nK������όд�������8�FW�5�$00���>|c�9y0t����mR����Ϡ� ��	dYYg�c^?���&#����
�}ȈΫW��s��zw�FO�"�子'?�|��Y��8���^��z)��0����(V<V ����=�L�m�^�%�+��@�1�P����B�??c�DN�bһu&L��h�W�I����+�&_��+B�Y�5�L~�g6/I����[8�i��.Ȟ�_�3����$���ɀ�T�9�M
?d�/�DNz\�j`���EV���v�<�e6����4y4���	��Ч7�5^Mt�i�S���g���	����_��C��3�磿~Ȋ-��wH���E J��4�v�~B�b-�[BHc��cgaf�A)&"�z]����E�v�WFi��<���rԃ�FA(�W̥T�Bs���*��Nȶ�1h�������2��ϊbI׀���_�O!�9|�1�"�M�Ώ|]�����
OB��sf-!�|p]�	SQ�ͿjJg�.t�
�~�ٶ��[Had3��"s:��t���C�$�gI^�T>�K<r�$?Â�w#��٦1fד��p��ɓ� �x���N����՜�_�"��� ���귢
��ä��kl���jc�&�<�������/<�1��bpA�k:oh�x�W!	#�}���N�ծ�������2�s��iVO��O��Hv���#�ˋ.��N+�]u�Q�!�A�k&�1Ñ��pXT6�Y����g�Rp�5�L�펛��Ʌ`��p�<�W/z�]h�3-���F��{�,�N�\.��_�����D6/���\��4��/��>T��T
N�$\�L�j8�,��X3�,�P���ŀ(;>,1z���	R\��A%n��<!pZ�y��v��`�O���W�n�d��m�1^$w=B�l��랴8d/�cr�J@�/�rS2'=Nצ?�fŴv�نЀ��`�r1�,��J�E�2<�sHE�㑷S�Q<�,.MAfg߫�+���cM@��t�nԍrL�>m{��#y�$�l`��շ�|f$�."��á1:PS����} C�G8C��*r�8�y7t7�m��U�J��k��i��Ȼ�)ѣ��s\�v=�T,\�?O��fl:�7^3��� 7�Z'K4�{�'�������m>�13�B���ap$".y���LBP}�*
���Ě�s$�}�y�i~��g�#Y>�g:��$�!�3 �_���VB��l�7�B�����a:�5 l�>p�,�\���Ƨ+��~&'0�%q��W/��=<���|ގ>I����ۄ'�]We3��#�� �^�˅�Ѹjܘ����]��I29��rL��9�j>3������� ��-V/@�.�Z{�Ss�O�f��:�I7#�b`7�(���g�|���=-n�2=c�w�>�iif��$�V15$��,֒+�p�WY1)���tD.��!��{d,���=w�M8��z�Op	����翴��I�񚧤�zw~%�k{vy��J��Ô!L�ɼ3�S� �x�s�ۅA�����Jŝ;�T#%p���F�,�Wp��ҭ��3���$lk�dYwq�ɇ���IRӌf��!qBv���ʤɕ��5̲; �!m/�2������0�t�F?�k���� )�9���;Q*Ʉ2Kh՚V�B3���5���X@k�d���l�+2,��G��ck�gG�\M�LFw�t�*�0	c�8.����Ф��ye�3�W%�t���L�t'��b}l��ƔQ��ȝ�|������=.3F4n��$%��YP;
�.���E��/�h�����g�r8���uV�a��F���� S�wk���o�z`<��c�a�:�	�ҋ�6�	CK�Z��#��	��H��ca��M����`)�\v!��J�{����? �Q������W��Ά�T�9��W@�ۿ���O�	�
u���դk{����*6��)\����X��h1?�6��U�H������K�2�!�2cR��w�ϓK�T����_�߶v�::����G� y{d���~*Q�ݶdOh�QI��o��%:�
���z��YǶ2a5Y��'$')wB�aB�U���i6I�j32�E�?,w�7��c-Uc���C9V.#�#��|�����䤤]J��e�UD Y�0�i�u�I�lў#.����d-o�DL-��	>����$��P�lf�T��Z���
��*x0@&(��O̼jJ/_�/UV�3ya�l�R����h�#�|��ob&�#����|�%C��L$j�O��w�]@�P)q�(o������inr����E1�E ���<�j�ce���-���e����%��7�Ϥ�(���xy�O�2*�1/��w����c�$�������ɠ��ۙ��'�����$<INŪE��Sp.# λ���(�ܴ)"ŋ��f�����u�%�r��I(L�D�r�W�Zk^����v5�ˇ#"��}��>o\��5A�D|u@YO�]��-�H�$[֣>��9PJ�y����'��{��� �{h~M��}��[c�%P��Bo�/�c���b> 8�g�%kf���7�Ü t^��<)�,m���D. q��B��!2��6��~O��8��x!�����Y[�O ��Mp^�$E`}�E�
�U`.��g��r���+.0X��8OL���Ú�8�W,Ӣ�ȒBɂ:\;8�-�e�ף�D!)D��C�}�)��p ��Vp0�ͻ���w�~@�� ��Y7�<��Y��# �z����q>  �y�g��*�X�
���f�z4�$DR��o""�sS&�3�b���$�3� `�W����/e��/��l��0�9�X-��i��,B�l��a��x�#"�$7è��`��d��D6��E�VާG���ǫ�:��Ζu|�O`�S^����S�\؊��Yp���v{���9�:&��bڏ��99J��v> M^�)��Oj�'1�$�:�(��D����e̵\-���B+$�JȚ,��ҵl�c��4��OW�B�	��U�_b�"������� �R��Wy��(9��hn���xl���7A��2}���f����<X�Ɋ�w=����0�^��sG�z    ��g�������;^��GX������L��'���T�;��7韑�13��)�6k�F3m��x3�8|J�a�ò��Xl2-�Ox���	�]����3�c�����Y[+^{˪�?�Ɯ��ꧬH��NL,��^��'���2��Ȁ{�lEzl&�x��dr���V�Uŵ�9r��b.����z
(�S����T������e�c��΍y�F���e��̌�.CQ6U�<�e#
�
�/���IkO;H���� ��A�^Uɠ:�3>.�C^���3��~|�Xi��F�[7T3G$
��y(#%m<s:B�\SJ�τ�PJ�ϓ��#Jϒ��83�NZ�ԇK��m��u����r�(���p���*}:6'�QAl3�S���3�_�а]�1�'Ǵ/񺬒GX��12�6Y���n��#�x1�[W��&=B�_ b"���3c�L�������ߘ�3�A�ڊ������	kb����M�H����؄�1�	9�X#W�4+&uӍ��L��O9�l:Y�C�ˁ;'ݣ��hn'o�0��cn-G���+Jl�$�N5O��dt�	pvD�p���Q�#�%[6_���:�"�]�9/|�>�w~�� t�& �rUL���|�ȼ�R�"%l´0���Z
�W�{PJ�V�؊�q�����~#mز3h�e���	a1|��c�[i�f��]J�˛�s=K;#9h
���>p_rx�\= ⭸���M�����9����1�}�z�=��{t(wD��	OjK����[N��乮кd\���F�G�l�� wxx|T dt���S��F~ ��B1f���	2��>w~��B�(� c@�j��+�8�g~���ľwxV9T�S }_<�-������m���ꛃcuk/�~�5�nL���|��gg�O����u*���U	o�iO�G�x�TuWv���Gi@{��P�;�}x����(�:j�t���}�h1�#3+|;���*k�:�������r�����K�.����Fu� �^���:��J[r�0+�Ý/j$���g]&���u}�#����($�������(f|>�f�9�T�'��}��0��[����(�#!u����f�u���B�vm��<�˫^��c� f`!\�N~�����a�l�*�^[�,��ڰ#>��ෞ��2=��2�m��鉮;W�Y�q�iA�\�T�.���r�;�px:*�v���X���s`�@�3�l:㘞��X[�ŋ%������%c����s$��r`��L��k��J3�0�`F��(�֍��.�K ��v��]A��-�V�~x��o��H�|� �ʺLg���1 �Welt��%E�~�*������xDpgæ�f/A�K,Yڅ:-�U� �L6<��.�RXS c��tsdA+�-Әq��!n���N��a��['��W�b�c"�L?�?4����������
$J&x�v*�IVaH]����ռ޿�&�"�����YA�q�I9�q��`�dx:��f�\"���kƆ���PJ��]��PbŴ��jo^���ee��"�92�|B�~�t92f7T�SJ�诋�J#y
���V��`[�T�
��jg��:l�u�'�o��~έ�w_��M�lWŖ�;���xb�N��$�?����J�eb�r1$t$ˊ'v�ק�W�b�w�tI�B��;,U&4�G���$��Z���>;<���±�6�)��7�]�VR�v:ք_>'�btɫk)�BC=��V�d<{%�Fo��b�F�X��3��bG7Y����i�_���h/��v<�bq�_���2�]��_�5H�8��J�� �`J��`+l%��PڨT�̣�a�Y~�~��)^�L�E>K�=�%�MC����٬|=O�xp��=�t*��"�ea�}�󻳃[>�z@�MU-Qv�������� �</�����[s�)y� ��
]�:�$�w�n�J���pw ڕ���*���_��kfP<~�s���ì슷+S,㙹� �`�:����b^'���I�t��o�(�̖�鑄v�h_͕c�ͫ��X�`$]�OJ���g��L���f����ڊ���<�w~s�|t��g�i�/'��_>���!Rr��NW��.>Y_*�!��o��	���UyP�*��� 3�IOwP�ۢ6 /��wЧ�.���ڤI.D7�K��(��j
��=i���l��9R���5h���P�=F�h'/��xn��� ��7�~��Ů�|(�/YQ�m��
������`��"��h�h��#�/�/,�C{��U�W���6��d�1��������M ��ŠQ�g�d �����<�#P��32�N (8�[C%GP��@Յ���o%�o���P�=C������`>��y��6����3`M&T����"�¶��k!��ۘ�pߗ'�P�k�OޢW
N	[�4����}ޑ������n�]�k8�/�:�7C÷P���ԷË�QgTw]�J���4��	=�T���>m�=�}麜��zl8K���"� ؒ���� 's�φ�T߆����Vh���"Q_X]��#S��.�z��� ɳ$�g��B�o��z���o:t��wb>aG�Q`��e�3fx�-�*��C���Cʗ�<}�)~��,����`�\j/�Ƴ�Xv�s"k��YQ�;|1N���I��p'xo�5�n4 @K���c�͂��0.���j��:�H=|(J��e&d�9�O/lÒ�}&�Z}
9�'H�z�ݥKz<|�>}�S��Dv,��/f�r�̒.fJh�����V� �*����4K˴�BO5���_Y����>sg�е>'=���)��c ����O\�"4��4X���#S?��ϋ���gt��[C�ʵy�rHrU�KnY5�Α�MSGM�J9�:]�@���(�{0��K����Ds��K�Ѳ�̢�}q�Ч�xw�m�ui��(I����,Y�|p��
D7Wm��j��ۉ*��{UY�^?Q	5<��%7A��o�р�;���s�GC1�ٴ�@��S�3S�"���P�G����#}������˕��
x�FG�5
\1� s i��S�c�̸@J^VH�aS���v�a�໻`Ec(z�C�uE����x1��Jl��\Kɼ��-���L��U(�S=�B���=GVCv�r��/Ɂ�ْa��������,(w��������MR�I���Y�L� ���m�4R��%�*����M Q�8��Tu��Xtџ��FFid"6����#�H.���ϞUP�|�Զ����o�QZ�-OrW�ê�bB�Y��M�ۀ�	]�������U1z�G��޵��ɠ��o�����C��OdǤ�V���Tb�@�vK��w�ܺ���\���F�pِ�Pn�%���Ǥ���	7 kO&e��VNʼ�k��R�����1r늞�V$�Z�X�)uyj��v�}�_;ߺ�0�t��)����	0�7mK�^l�f?�)h���&�'�Fė�-��^�_@��^����P��_�Zq3��|:�s6�(o�6�?���э�U��|G�춙�g;���fB5�g���Գd��iLFJe�+����z�ʍ�P�'�Z$��N�K&d����t�b���V�|%�_1�r��6�!S��<��j�-dh�K�Q˼x�JB}��L6��+
�0(EL�Sq(��r|�2��mK�Դ����z��y��{@�P�Y3j0}�ݳ��S�d?���>D��5p�U5[H�|���z»n��m��gw&!_�,xA��wp�2���*���}�c7���Q���]9�{R�g]h�z��E�R��_�Tŗ�����(��^�_f������ƛz��)�Ȼ��J����=��ε�>�Ǫ�~�q��R��������~K1�S��g�J~�z�;!߁ ��0������K�03�������nM�ۍ��:�����G�������\ �����g4    ���z���K�%M�/�A��\�2ݬk����lV~Լb��B�[JQ��v[r=���L�	jܴY�/��b�K!c�I �b��/(�G���l����t9���{
B> �ʀ1/�L��3��c�띐Л��ad�i4:��~a>T�� Jx��j����|f��_H�;�e�f�v`RyK͡,�|�-l��u����z�)����3��?���~3��z����]��yu=�G?\�_Cz�IP�~ r

./����{�0�e�ѝـ\z��B�����!9��9���(�g洨V�6��A߬X=���������0x	�� �3}�ق#�\eY�Ϛ	�E6�U f�N�ɰ�k�����5�|ϱ\��׀7���]���łW��G�,�������^�5��=�?� UD�^$���{��C, N0��B��G��HZ}�)b$1����Q(���no��/(�k�l<Q@x>)/�i��!���lMem�b�c6���N�����+"Of)q%D����%-����H�מ�Kh���yuT�²Vf�z�ݗ���yd���{Z�!���rS�z)�?��==�i�z���L8�& ���U�?v��2�+��vv�Ys��ĝ�}��e6�,��^��nsm0�w�f�u>�>̞p�Į������'c#���q����O�_o}���޷��X)�	eɪ��0��TD���G�6�G�x!p5�@1�X}�	�t�[�>;1܎���ka�g�$�F �����<��)�ֱ�K�`�5�²��p��z�նS
��)<���
z��-?ϕ/�	�n�l�w�x�!���ِ��A�#�(䝴���C/*aED��p���F=x7t�!�`b6��\w�H�(cT�^�x<�bC���n�N��	�~`����l};��p�" [�;�n\fO �g�-���I27���.q�,O��i�ݍ���T܋|���^��P��X&G�u�`��)I�5��Y��y!��3n��"u���p��0��L�u�������@��|�U�:Z�.�`�wk�|w��"䙮���?`(�Ǚ1s.�fN�r��h�~�~�'���]�8��/�h��������z�߿��}�N�ȺI_ѳc��w�b�m��+�n�lF���ṛTg-��z1Ӯ�z:����1%�w8 �ܪ̋b�6���Ks�3�$~��Ԉ�Ju=^V&9���0)���7���;0S�>&5ɕ�E5���E���L��a�<:G����<��!Y�^t�n�y��p���H�vS8^U��e�?��JtcxuU.�z�j��×��;&�]�r�^��wE�<ջ;3�&E H�cZ�G<%�15%/�[����d�c�,�Ie�����#�t�X8 a,-fl�CC���2����Ue5L��6����j7�;fپ(��5���� �1+�!*cJ����U��w���9��]���y��6��5�?b����8��$!�j�N��v(�q`)h���i��a�Ş��s3l`3���"�標_���i��(�r����e���nZ��}ԛdq#8p�BNa ��Y_��Flj@$�b��ff�$[�����"�����%/x�
����^�;qȌ̠���t�5 -���ބ#h�����'W��9_�ԗ��8�'ÂQ��`�����n�y�0�ҳ��b6��`���qU��}���[�g�>��.�$ו^�#�z��H�୊����R��8|i���q/����`[E/;;�w�h#�]�8��C��!�mЌ�}7%xR̼�锯���n����te ��fw��u|��	�ն�@�z�+�Y���+� �2��Z���=\��'�Uy`m�B����	�.�5m��Xmx�����El��3����肐��=ִ|%Ody����i�Y�{�`%G�<��T�49�p+X�/�:K;��(���C��/<�5�pJ�i�y ōY��<��0��{R'|~9��-��E:���������[( O\Z��e1��h��
G���v�-M�H�+��W�;�Q�
�a|

���ls7⁲šTc0<}M�w�9r`��t�g�P�0�\�����e	{�.�V���7����n��9Hl>�U���Zp?}t��so����0Yc8�/��J_��|�7q�īI�8��
�Ш+\`_L����ߒ������l�uI��1��.*&٫c���P{X�BL<��F����h��\�}�y�q�^pd�<#�&G���*���v�.�y�hI.��۲=}�������+��}F�r����I�=hyś;d{��Jtgُ����R����ΐ�K�,�(e���Q�q���Qr�`�΢-���\O��P;#��X%���%Gdڏ�2�B�$��8�����;r��L1�~Uk����L��z�U��4���84Z. �ό�kl��}_�4�������E��C�,��r�5>�	6döʼQķ5v�b�>}��0]�"u�@��+���j�	��,�E޶�l��͠��e�ȥ��H���w&G���2�J���| E|o��.p�C�Z�u�ǧHs��XN����2O0:�zj�H���ω29�<<_:�Hf�`zm`�]	G1��+o�`J��N0�2��<k<+���B>� "�Hձ�f/�E0���I����a��c���_S�M.�Eoٙ��9�j)�������x���C����$�S���1:_�ᛧx��ؠ��y�(.ߨ�j
kwZ�ϝ�c�� ���fPYds����/$�K6�/L����1�n��0<��:X7�]b��zt�����7  �M���P���R"���w����*�s���?����,\_t�ju���$���c*I���Xv*r�E��7�y�kY؍�E{�O ���q���J��.3� 5\��w�,�;��݀I�����Ǿ��.����qĭ�SZ�֕\����H���1��?��mU��e�_�0cɌ:{�f��r���&jZ�ugn$��|����$��$�p�۟�0J3��6�E�kKI�nȰLj����<�&=�O�z�H�GTQt�����(`���\6'��)p%�(C����nM��ae؛���?X�\ڄ�\h]����3�L?�QGv}��vjqB�݌j��f^OX�� ���j�d�ǖ�㉆ڽd��� �t��T�2�x!W	�Rڲe�F&EͶ����=K'e�۵1'��%x�F*������(y%!�K���a�;��z���l�j�s� ���tdz�Թ?��]�Ť�w<�Pv.\FW3]ZR'd_y� 4�oH����I)|��N�Q󉻪�H`��7OE)���Y�J��EO�ޝ'�v��9�9���q�元e5t��mL&�@��(� ��v��b�^�L��o�nʻ���7qk/$��bP��B%��ڡ�Az���zI*Y�O9xd�S
WIxv�XZ�wd��%��=��<ٮ)�g�q���-��2���a��V*�Zx~��M�F7�-
dT���K��O6�MI��f�*C���o+����\����̈́~f� >EL���g�l%ۤ�L:��� V	)Lk�q������γ�sy�:L���Ї+۬�M�+|��@b?��wp9ڑDRy��_s��;b>�+G)�AebG^(D�� =?$*�d���Ɠ�����#�g��6��	���ބ!�	���Q�����!oĉ(�;�e�� �Y�,��Hj�I�jRe���H;�˨������	�����:Z�/���Qk.�����p�42�}��x�U?/�c������?��'YV��H$!_L��~��<8�\��0[-'Wvs=��;��A=�K5T6�cg|��p�Yz��1�!Y�2fm��1|.O�@����r��َD�zL1�v(D�.�MY�@�Cn3�!Q��*��y�<i:��i��� Z�����.��{���D��7�l���7�
2<��xL?LY`P�B>�B�z(�eOzm9H����z�5^X;�6�E��~i�f'�6}��Z���ơ#��2�z�N���u�
J?    ��O��cYT$�> �r�b+��P;QH��	BV*r�uy ��Ŭ��F�U(ΖD�g4�MG�N�4���|�g"���=��6s��o�*J�	P��#�]rD��ФB\G�*>�B���=�a9���MI�/�{b��<@SH�W6E��[��4n����Ϊ�R�p�nE&�G����+�t^��jw݋x��< ��G���Ԓʗ��c?RA�)f@��^����<�v�J�1^z�[pΤAX�d�Ik�R���mYx�'#��b�5��bt2�J?+ 5hkt�g�]He��!w\S����6
Sl���Z���E��B�l��X��7VL��q/�M��=d9u�|1#(��q�ه�l�1?q��*�o`$^�Ĝ�#�S9IM���7U�1x8-��R
u���~��!�N/���iwm�-]���4��T����L�:���نZ^n�����Й/�u����r��A��	<���cX�|������"��	����l���(�0P�6��*�җ� ��k�]KTx%��`ۙ���p~ԐTy0L����\����A���n�B�ļF��%/��'�j�3pGdW�ZM�^��L����$�o+��f�9dJU�x�!א��\.
��<��Y�p������37)doċyjR������Ư	��^�d���t�Km?�1':i������ewꠟ�N�J/��_^.�W,�ǰ���X����FQ$Ǽ�x�n͙ￆP�pIY_K�'�����&��RX��I� ���}=�FyVɫ��l�0�u���3E&[�|)����5�}>fK h�y�c^�RJJ�@1�PvM�G0��<9��%f���>��z2T �����l���@\J�B����F�О��O��_�x���]qrM�]?3�ڕn����۵�/�%�Ɠ	�2�^���u.��`:��RX6}��*ʦ60( �2c ����O3�[�EY=&e�]�IFNv���*�`�#��~���<� ���u�#��2|;�|��L���"V��;�����|�jS�=G���/�k;F�_˞�/o�L^�g]v�o�!��s�l�tϬ]=!z"T.X��z(���l�I�|ס�6DM����&Cu�r
���W��E����T&s�6)[k�gy2'@i��z��#i>;�pXCv��8�
��X��@T��[�d��ݐ�����ۅЄ"���|l�N�X�r>�W�WeW�©c�O���E�8�0��i��l�[������I��P*�Q-��:��u�̆>se�̲�~LfX��������HC�Kf�_M^;+�yJF.�60.�AY��ψ_V��Y�\����%4G�'[�;y��܎"!`"�n�*m6�	�	&8��+����x�Gh�F���,� �Y��2}�OV��r�r��|���}m����B]6�b�f�r������@�W~�`R ��b#`5�_��V��W9T��%i;�r�}�Wߵ̚�=(�������Q��!c�`�u󎯼my}[��N4��s�b�>c �I��gHQ�7,<�2� > �u��z2, ʄg� [��n�
-�<(��e@6re]%i�g�U	���g������<C��O�$��~~�$�W������z��*�r�����o�'ux&	s�����sw�-��1�5�F�����g��a�'��،+�k����,Z]�'�>E>�JF���-ᓐ������|b�p�WYj�3���-C��fu�~���Gh�&�=����n3�/(TQ���u	LR�}��O�vk��W���������$��<1�J�T�_�4��$t$"z3:���aM��Z�&ٞg��uj��*Y�<�kuU�5�o�az��Ø�é<�@��y�</L1/�3y�϶��T���Tp���^=i���֋h���fS�m��$�1���3?d
��@��K�a�E�~�Nh��u%F������,��BsS�a%�$rD�p�Ý��cZ&�k"d�zJ8#7~Ĕ���a/$K���M3��Se���&�M���-?o
z����.Y�Ӽ]�(��u�C�"o�:�P*���D�R��L������9��~�ϓX?"/g�����ʌ�|��{��`�Y�Q�E�+9��q0�ʑ�GXː��<-F3n�d�mQ3��'R��%ޟ%�����s;���\��5�«��IB�r5\EgR
��E��ܳ���@q��ȺJ��2�4:�iF��T�z,_Wf$AX���bޔ�\�dj���I���?F���]�MeT+T�\,l:�_40%D;���g�����-(�[��iy�̕s^�ѣ)<�t�ʑ !��'��_պ-��$�^1�q����5�E>S��s�BG���X�UO�������_H`3��^_�+��\��?�m�+�W�y�W���IӅZ�y�G�0�+���f�擳,/�2{��dG>����h�F`����8���,��	4LoHRߺ)�����S�p�@�m����4	'�F8�Ü�������2�>�t�J����.�K�_�=�WIs`+��^a9�˙�J��7�G�O;%��a0��+��O����1�5/vJ��2�v���AV;���e,�-�������	������2ܗ)�S&�+o�dPS�L?i-��rP�ś���Y�ٴ��(3�����k[�0����7����q`�$$& ${�����؄P�fX���B�����A0����|�#� ����t���|p �$:!�	7�Xt�IRy�s)��C�3��ܜC�+�3�͒XT7���y�S�i�У��&���X�ӥ�<�e!�Nd�3;�<ɿW�F(.��Q�L��x��$ʺ�l������kt��`F�$�ǫ�2U@_�|��O#6d���E��S����pV���(%,��D����|{c>��rg"=�Q��bY����?ן�&ԗr��B��S�� X�˚[�,7�x�[��oH̋�)����{z7��~z*Jӕ�b�X�G{����ojS~��':��TΜ���v[��W<��>V˪���|湻����@�e�#�%�+�y!�d���Բ��;��� [1M�r[�U�-�ღ�a�l`=��u��s Jjg��YpYh>1��L3����s#x���.��ӫ{�/a oG�"��,������s�r���ܔ[��b��@��@�N|����"}���O������������ E}�r=aJ���b���$�S:gi�&(����A��yP�%7���ϦRԲ1�o>�,�2@Nc�������'<A�x�U��*��F���� ON�)����$M��T���%�+��L�M�p�Y�C9 ��|V�����BI��_��?���Ks�H�.�F�
���,tޏ�R��Tf�QR>*��A"!��$��v����b�wql6շ�ܩ�;v���];ֳi���>� �T^��J@�Dxxx�{���u�uP��#��Q�G �J�+��t61?�|��ge ���l3��[B =�#FW�-�&�!����Ah]f���3��Fri��}�=F�"��iV�b@��g�b��ؒR(�3�<�3��8o5�ʃ���\�Hv26v)�v�n�]��f������(�D���0�w���P�8�G�Ug��/PKĪ@E"_h!v��0qe!@�U�<;^�1=��Tg[�酾ܮR��2U�=Bk"��e��vy� ��3��Q�5�����vЍ���d��CG���X�Qk���w�j����Àw����	�}�=)<?dm(42�[�[<l�(��P��cP�
g�|�Ycx�Tá{�'�
�驙����K:H��*���`�&i��<��(l~�VI LS�#0�h��fP�,����_��r��F�8��Yϵ��5��ҢA�~�h��_rԴ�j_XLN$�	��7����m�NGn�ys|�+e���2o��%�4��B,��%���(��ݣU
��VCn�A�87q��B��"�h�r����t~��v����.�M���T�5���b�q���Y�+ݝG��R~�����\�3եh��/#�뜇,�	��ZV��L�=Q    ����#'��s���JQ�s����8�� �Q/򣎐Ygλ7�¥C�鳖Ah���\O��L��r���� �;�P_��Ǎ0��M��:��(W����d3�Q���g/�b"mXm��+qJL��j���7T� 40���9 ז���eF��̘�$�?�3W�xǃ�q)�s���e����=�eCv�:�Mړʐ���fWp���/ ���T�L{� ��U@�?�15	��͵�ي�ϟ�q����1[���
%eh6; к�L\@F����vW�HBh"�!�����YZ��gCa�FG���E��m���Z�i�Us@�LIL�x��tp:�Y����ea��5�ah�f>?��P�t0B�5�Y	*o����j\N��$郅�X�����S-�w8�����O�=e&�w~!5�L8�������
���V�kh�a�bb���kC �t�$f��e�a�]n�=*���ѐ�Ѣ�X���F��Lց�A�r�z!�cQ���Pd}4��1*��|���S$Im�e�N ���9�V@8%���qv ��ʂ�b�\��-��� �(8�X�0�%�P�x�D$옴J�����m��a$n~!� fk��-�Ħ�:{��]6�Xa1y\Q��.�R�F��|9d1(Z|yp֗�9Y�B���$���g��Viv���e�P���6e#�e��N��R[��q'���nG2�M2
UY�_4�=Y�ҹ�/q_c��f�1ǥ�c���P���P̄�7Uܕ���aʡ�yE���.pc95�8\v�3�Ѐg:[�r֞�+h4��SK�	��J�a9��\�Y_ơ����j����>)1%8�4l������+H�:�Lڎ�� ��x�R�׍��<��Fp#���e�u������	��n�t�I^t�U�rY��ߕ�haLqw���$g �Ksz�p�%���ܘ�r��^���0%��03ò�Tg��/a�
`�`��֠F���c����h���;P��U��:_�yɹ$�O1��˴��t�b��m�6rf���lK�ǒ�ٷ>����&6]5�r���t";!>�;��V`���s�	k6�V3I[,!c��uo�y����X�'�2���A���d�����Q�OY���^���!�<�"�}ϲy߀"!�[̵({Ce�3��+rW:�nn�ȏ=�x�-z�b3'�=�8-�3��2DZ_~0`*�V}����6b�P�u#�08ۑ�GZś��rJeT�#��Zk��2���آ�t �J8*h*���AW������"j̸ӈ|ͼ1��`�S�o���#�
g�`��.g��P�-�vԙ�!��>6�_4ѱ�Eo�(��q�ҟ��/��N"n�89�|�~� v� S��7�~��EW�aCt`�H���ş�f���rw�ր��+%�Ē)ri.�6uw���_�����]}�1Χ��/jO�`N�@����G��u�	ɗC���}Z��)�b[(�tdV-�;�f��f*3 1.����Y�؃�]���ޤ��A��[�4�m׈�@P�o�S�1j�.�׵K�C;�p�J�J;�� �şi�Jz���� B_(�V����9�i���?|�mڊ��A���yl�D�β�#	e��?P�oϤ�ؑ��E�  2���	��q4Ȅ��z6��l:_𸨋�C҆Ǚ���V�o��:o7!v��Q^u��N$����c!��H�	�Ui�O�|�����x��e�)��eˮ f{"3B� ��}}����"(�{��S
�#gg$1�ݕ+���BB����3���pc�`g��Z1�0N��gO���E��oK�ш��fo�X���6U���m=���虬�Am8�\��8�s �e�Ӿ���19D�_%��<")�M�����C�1As�9��oZ�l$�>E����6�U�����u��$�h\�*l���Y3� У��=bѵ�
O���tȃL¨Z1�q���ᒇW#L�N
lw! h�,ٻ�i��IY���1�uO�I<�h#hgR�옂��'U|"Q!�z������!j�x��(���Vp1t�Dz��5�)yr�7�j��M��vQ7�ֲ܈�	�$!���;�Ɣ=Ķ�(�˫s�؞�����i!M��_׈y��ZOҤ�<���y�3Ӕ���ͳk�h����97`ؐ����R=���_ 
 �����6ի"F�,�u����<�2��(A@_U�MI{��1S��í�Ҭ�h�90���"0�����Dn,eԦو!UY�D��`5�u�a!��t"8)R��kV�ז���rV�����i[��&�`Ĺ��s��pQ>d���O�݃�ϛ�(	oX��/��t��H��H����\����=��0��D�����Ԟ�.}P����|ht��r:�v��~��fR����Kρը�庁���ց4��%��]K����[Wsp��UZ̭woλ����b|�zm
����<Yl3;\�]��^�voMɵ�i�ʚq`'���{&��$%��7AlS,�b��]@W���J�Ze�C�u	�H;�ƶ��7m�������L�4�� �-���p��3&M�0]�mYK�'��vǴ'�K�����L- ����p���������s��}�N����	s�W8��)k��mK6�X�Y�tUc�%�Q�\�n.[��q��B�����CI��Ev���ن�`�V��⦏-l��ҟ�,z�i�Q��:WR�2A�3��'��Rn&�c��lރ	��(���I��~H+�x���s^.��b�M�We6)i�3�ױ�1�����V���,�����@RF��o]��Zi�,�4b(*�%�Qw�x�JC|5妮�tsx��k�2� ��G�POr�Vgʨ�^;%f����w�j��A�M���jy"�������"�w�.�Q�&����v�G%�=`�D���rz��_��W���6�0����(��=M��=Ԙ=��N,_�k�$ ��3�	Py���|E2����^e�3�X�r��<���|H���ie�R-2&���V5ɞ�ߥ�<]�X�8] up~���������}(��v�#������׉q.sI�;z�6� � ���O�hq�3��OG/���}\G7�)�G�t�p���b�"ב
�ʳ[��@/@�|-���ʦ��"���Ӽ�'���A"ɼ3��G�ꖌ�0U؁/t��:��烮�@�.fˊ�-��?�]/�E�x�#'�DD6�A]��Vg����:b@���u2Г0ĆTՃ30)*�*�ku��$��o0|=�U�7�B�z���c�L7��ь�Xr1f���񝋙�R ?��d�l�K9��Q2�<c&ȡl�w�_���gf����a81t��%��Y��������Λ���D�� .o��5���<��O`˦ͷ�	�����貚1T��^-R���.����c�vh\W�!g�B�k_ >"bhX�9��4Pl[o�6N�h̳xf���s)C4Xi^��j̱6Y���{@@�Y����P�����$*m�$��a��e����ͻƳ~�<mr�2���=�4�Ϲ�N��k6߬�.U�"��כʀ�G�����z����Z�O}���[@@�ۿ-V���p�L��Ac뺞�YJ��6�n���;J�#�AW�:O��������6P̎	y�Y�^]�Ϯ�0V��J	�I�ҹQ��c�o�U����7��罶f�13���(����z��6�y�
�q�כZ�+"٥�����ؠý�Y�s��	M����Ğ��4$~"2�����赂Bu�::�S��Zg`���@�����C����K�͠�z��N8��<F>\�����b�z��w���:��<n��Ԁ�Y�k�������}��YO���oR�:��eT`|ׄfƼ��|<�>Se�	H�-�r�Cay��i��yY�Q��uZ
t��;�2��i�1���d6^�hMxq[�_/dB3��[mUӝK���$��]�A��m�5�c������
��N�P3���K�x���\^j ��e��ve>L�i ||�    �}����MlbY#E@��4�]�i�����I�|`���↌�=W3�Մ�Nh1�6ug$�ő$6S��J�l��K]H\4�`�{����y4��v[B�p�3[��@V�_M���뺝�:'�g:�Q����X�V=L3��e-��Y@�����_��죑�e ���6�;�rw��e�:������K6�u�Tۿ/�e��~ɀ)ݕch���C��� 5X5dw �e������lїM8��l< +
�����o��how������c�]�?C��PL����ʵY���҈��Ko�@i����4G������y�>ؑ���^'I��`�v,	�����i��F�b���mv�f�x]L�����%kD�;�Q����bF�������n�qg�
�[řj8��]Hk�̄�@dk��֛Z�D�m�,F�f\�����xٛx,;�}�f�>/E�gZ�Ky�r3����F�?v�oȂz�◻i6�6Ӕt�<��!��(��q��M����C����X�B�"W�N[�F���-J�P4���@ϋ�� wīޔ�Ѻ Z՛tvx�-=s�۴G8A�2hSز^X_DG�A=��>p�2ߔ@��x�#Oa�>D`^ C��.��(D���3f���q�C|�p��K�6��q7V6c�YB��ZXL֕0�H��%��-k����i2��� �uGBҒB��{f`ü�ugc��i�qC;���Z�����;raR?��O0bH,n�I(�Q�k&��q1�U(jp�Br�$��l1�d�ȍ B�~�C7��ӌf�>���@>ûBB$2�Y�yK'����	��o���;q���|�[v�D*B%�^�T�ݮmsRF�]�/��6�*����n�6>"#p��Z��Hy�'I8���
�Q�)v6�Ǥ��5&d);�O���+b^e&��iC���eک�'�|x��	Q�A�Vzz[A3V���*a�*��qO���0�?a��.d�������r�@�TӜ�e��k�<���vVg=ȃ�Cz3�e+�t����v���0�f/������9灳2�X���x�/A�	T4�����0�LM���b�!pW�p�z"�Y��y7��������q0I�)g�Xw$Ha^���d0VF�q>�ާ-��$�;R	2IX7�q��y��B�G�P�̀y1���$�<�z��&]�y%L���g=��9R7�GGsze�E�{��v��w����}�lQ����� �	�읐s������>z�8�]P��B�(4;����z]�����lDPC�����r��֘gϬ9 �f�]��Bk��4M{�e�-�:R�o�>e}	�Ūj F.����p��<���;�b/��	�6ِ-A��@@�`�ꟍh�V`c�Q�~T]}�qȭ�鵂w;���c���v�P���6+�3<��"�E ��&!�6�sč� �'���>d�}�ǟ���2
�1ow��n"tM�D���q�5��Acb�Y�zl�lF7d�(��H~׬���׺ٍ�tCZQ�jǰ��C#2��7 �u�f��n��t ��1���L��t����P\c��ώ<^�S2��:�y�
�z[�3ĳ��7�6d<.1�Q����'�]����v�~�,���iw������f3χ���������Y1t�fc3N�l���-�=;��D�MV���'��tW�^�E����\����|���lM��;[��.�m�2�3k�G8��#ͼ�l���.�6"Cw9�_�����]����`\7���g�FL�j�倔���Ԁ��knur*��;dd�A6?��/�w����#/���9�ՙ���rh��X?9!�h0[���:��K��� �X�%�eJB�
��n���S�Β��.	���|���ެA��A��hO�e�d�ʌ�O1�E�f����zb�Q뗺#A��1�~��Ⱥ�p��}v��J���n�1m9C⯧kJ�%#ڙ���&fb�#�1�+섫>�AB��E{��#S�]:+�X
3ۗ.(]��m����ݳUbވD�/ǻ)�-W��*b��C��v�6�"RcLLX=��.U��e�;Bt�/@hӁ�e6��D��$��1�S�=@l������.%�P%�=�΀Ҥf��Y(4�{�cZ��4��ROz���)Z��;�OpD�BIy���L�#r#Փ�) L0�VZ��ga��8���f��6���ȓ�0N?mX��pR�Ek �G�I��
*��u�q5+�v�Yנ��}���">@'y���t8��9�k��{� p��ĭ�ص��.�ol�Z�huv���J ٴ���~zX�{t��D9Ty�&�3����ф��O~A�������,�M.cT������PK@���<��B%�}-�6� 栘�� ��A�%~�������`�G�C%�]��~3�(d=[4��U=�0�\F�N�V"j~��Y��͉0��@ ���3K���1:�n�5׷w4[���Z{r���HF'�Ȧ�2|���شr��*/���������%@ދs��y�w,.f��.�f1u1L����/���:��u�����i�i��Ί�>|�\��f_�f,0w�U��۪�����;'�����zA P�L��w���ZiB;Ϧ�16?���(�;���!/�خ�ۆcd�!��Lrv@f�2OG.R�.���Pyz,/��Q��
6��\��0'�'S��z�7O�"l���j�!��wg���I�O���P��Є�d�gv@B!�-0z8�����}���f_���y��Â��9P?:�1�^
$��?TY��@ e�dM�lwq��> ���"��[WsFs,g��������,�bR���s��m���@6��}��A��P��?d�n
�`�C���s���ޭ0*���`;7�T&��oƘ���Żz2p�NR�P��q�>�֋��ԅ�B��vo�M3VG�N�w}�����X�FuG7ƌ��`�O�κ�� ���G����^e]âY>/�G�<�a�K`f煱�]�r��;ؠP�w����;���\�@�1���]z�i�d���a�ڱ|��o�8����Ƃ�	m���m�y����� �n1�@yaҹ`�v�;���C6����ACzL����4�|��@<8E=(_�H,�!����˅�>�*#��s}=Fsww7��Ti�DL��^�I� ,�N�ӔF���H�4�ܪ�N�QMf�6����`�u-	�2=�P؅B!�t��
G�ڠhǌ�"�ϭ4�XS�	��e=ͺ�p%;.K�Ɂ}`�ݘ�I�� �J���0�iN���3L�a$����l�w���	S��c�n����eg+Ht|"�A��X��۞��Uye�PBh�����b��z���ϼ\�J��4��6��}��1�l��N�l��1��b�ߙS[�tyL�X��=g��M�RXeIW����	���!Q�k�0an���A��������9=��!�k�{�6�����F��&Xf��iHt���i+]Կu�֌6��?	E7���tj��IyŞy�����r�;QUwN�06r�n�н�e[@�.��:ko�:}�"�`$��o��5'��b���c��(b�Xzr�4�L���y�Ƶ�K�m;���7�e�=dP��~s>�8��������4X�E�����W�3�6�y���w��v^��PP�����:�<�m4Y��ڱ�� Q��?�옩RѮU���ؑ3�]�*����}e�;b�g��o��ߏl���zQ1nK�4F�@n��L,`�?�c�x�hZ�H|������P����@L�}ͣ���F޺U�G�4��IX��1u -�:KcǃL]k�D��4�X�4�w#0���&�����苋6�K�.N�VH*C�|�G�!=��Oq'l?��!yڥ.�N�S�v��8���
&�^"�΄�*W����3����R�ec8��)��Z��u��u`ػ�N���SG�F�4Tb<t!�Ȯ���?1gM�y��a_�$�BAb�Z�;a����38�zU�o�K��\�=>��n۸c^��$�A��;��    ��2�����eZfb�/��*��:�o�Dr��1�R�xb�B�>I���<�h���})�S>�p�%.�����;t����U��P���4�/��D3f� �;BC;�8��e�L��"]X�N�6�#�c��3L�=��M���'���	][�ήM�4�p�u DO��b��=ng�DR\�nM�ыrV���Y'���=t�v
zbTf)�，�<A��vL�<�����b�1��f����]X����H-p�|�`'Lh��J���Y���\C�(�1K��vQ��N��1a�(0��	�G2�pY��Ps����'r�P��n�0���g�Y��X@| QI^�H��7��H����ג�&�J�H��P�VW�s]���l�rNǜ#�XI��������7H��c�y^��y�/��]j��팲��C+]QA*�|~П43`��|	K}��� �t��:�q����~��b��K�ĩ�7PK>q�XEb��Q�����p2�M�h
=��`��RU¸�;���i}OC+ᘽ�b\��I��������k5eh-68�� 1_�l���_�rr  R9g�,�!Z���8Ь�8)������k[�u^V�T���M������ޏY���yz�QrSO*���}媼W �,z=�Ԑ�7��Ƙ�q
��?Ĥr`���Y�~��q�H7}b�	0�`�ym����j�R<@ ���qEP�#��nn w̠�Hł��Y2����Y�����q=^q�l`�,C"$	ʊf_}�ӵ�Ĭ�f��&J����ˤVz����HY��ʪ|%��&QT�$1�1����έ�;��M��9d��ӓ2����wFBh8f�@�GeVi�w%6&N��n�bL	�Z�����(��q���	t�jyV���O�ee��q����0�s+E���Y �4I��x3�}�̛a�Օ�^t���oT��U��C���&"�$1��e���'=�ʸP��g0�vHR��֍:1{�%�*%_��5��c����͕[J�ɠt�7�e����uu�fLV��Ck�8����շZ�Ӻ�ILC��4�i�������L��s(G-��w<&�d�k}|�L�7]&�J8�'�:]2� & O@lH!A@��7��Lǌ X�<]2ܴ�8#cm!�P��:9y�{���V���ȃ
$(4$P��X�Һڔ�=������hE�X��'Ж��@�yF�х��AX�e�M�}�+�A�I`xo��/@��� ]�
S)gE��ջ��P��r䱺KY�8!@��ǒ�}6����[Ws�jUv�>.xP%�M<�T���8�.R|ƥ/+W�:�J�0Z�F/:��y���f�T@N�ZU�v!�N,q`B0 ����n�f.t���[I}.xL���v&�c�<�Z�MZֹ����<%I�k/6�J�ݳQ?y1=Y8�Hgr-��!r��Ij�tVK�~��Z@�Ɠk��E��G�iX�7�Qv��<��.�@�E�Ǽ�;Y.�,yj�Ra0�K��j����n��4GQ��σ�tS?[)mi�7��f�s��K_W����Ѹ^X�(�9���!����\2P��_��
�O�y��Â�ڌ�Gk�3f��1�$�cq��@���D\�1�	F�yݾO�+A�LK���A��z{�nvSf?�~sD荒s�o�ܙw0�u�X��4ȥ���J6�{�7�eh/ h�\f����*���cv'�낡��G�S�߆#e/dB��
P�C�Z���@�U[*�6A�����죂����=&Y�w�PA �����@bY�a�#�H󘢙L!�����{��,Zqq��y����1�ȓ�λ]��=�NI��F�9�a���QuCWmtڔ�Ě�n&��dO�kL��{��pp�,�/���yO�GyL�f~w���8!��̆��#.x����. \yf`��L�UD��c����.���]�34��I���ᾗ�@��mM�,��kɌ��N�+�t9���G��`0[��y,�)�/_�С+ݔόlL{�_���HVW��`,�="��0�+���ۧ&�lt ��C��Q��t$���;ZS��X.뙎\�qdb	˯���&�W�O���C®6�z� ʪ�ޱ����@ :�N��z�&VX��,(˖qFP���gh�,���܇�q`E�܁:�1{�8�Y��L(x��[�H",<�O`-���21�/�':��Y���$��3��A����$��
��z���O�O��XP�����b1�Z�B�4����$G�!'�:�qvA#�W�Θ���R�feW�T��0~Z��$�Nʷ�$�1�D��t{a>�� �o��"O��*e�M�J ��<�0-�끮bh��?���O� bm%�C���Y���7ןX3q:2�-5	�o���!OG/�u0�d�S4ݥ�6���lYVw��iY���+;1�<�q�D���V?�`�^�d}v�P���@�����"X��\���{����( ��}z5�/XNwI�S�t��%���g��2��bH���ڧ���+��$gM�aͼ��8���b�_o+X�p�wz��B:�*)zM�A"��Y���n��8I��h�@�:�Xs2��+=�ݫ\s
��Z��k���\�F�B���7��00G�P� �o�y�@��+kUdb���NL�!x�Ύn����������)�x�B����:n��D̈́zc�π����$.y��}� ���B����z���Ԝכz1�ڮ�\r���@�l��JW��) ���O��\_��gGlGl��R�Ve. �k>j.�ֲl���K�������4d;�(�b�����@>%=Jf����:ƃ�5H��|�9��z��� t^��ە���&�Ww���9N|���+��ys�<�:7
Zi�Ϊ�{q�<:�����m]eRC��wl��r}�K>Ȫ| ߿��񊕟������K�̊��8q���<�:�)�%Ex�\�lo�:#q����>�v�{���O�	]��g���@.�}�q�Դ~�&�0�-�C�����(��
")��V�ԕ��F�&
橯�*�g�kio^
'{��?��L�no& �7�L�����T��>m�gvo��BFb�����ӌUW�ѯ����~�����q�V�?Z�?��r�zˇ*�
;De��(�W7o:o,v�a� h�=?>��lY�J��vl�%q\= ��i�!�aAW��X���'�"|A	׫�R����}9�3���/�A�4�l�Ɯ���ݽ��K��U��zH0=�*ޢ���u��e��b�S�:�:�m*�>۽�Q���W] 5D��S�����h}�	|���N��y_/���:�rc}gܨ�R�*]�k��D�°��˹@^QȀh�ƴy@_�ޖ�i笸C��"����%�׊#��L_M��s��|���?�}:"�=1���V����:������3��t_Wu������`��� j�^���KB8&� ����������^$Nk��Z�J�d�P#5HX��ؘ�W�/�ķ��lK�I,T���̫�L]�pR�GN�=��u�[>��D:���|�b�\�o�����X��@ef9 _Lb>4=����`��>Ar2�b���lĵ,�nWP-�q�83�c�ە�M ��ش�Ϛ��N�����XV-�?
F��?X�5D����0ڏ��@��eb!rBi��
ʥ���۪��;?��2�b�
Xh]ek��'����͗Ktw��
i���f�7^�-��
|�v�!-V����8�}@ۘ-����Z	$�^�u�J�'�eʉ�[J+�ҏG���Kn�@*L���8���O�Om0]͗���u��,?4�$T���n��sYQ��I녬��f��ߋl]i�S���ɜׁ���FoX�3ԽAo~h2&j��h��� �,�����x�s*��AB�x���F�3HC��Br��R�?�n�fu�UǗ�4�[eֵ���-s�)��\�u��.k�%���+S    ��HU�";:O!��f&S������˝����]*��ë�}Jv���43����a.6�c��iY��D�a�lƚ� �C�����dCg8�a�$Xwim�{҉�a	X�H=)��Ɣ�ޔ�b(覬�G��G��Q~:�$�;�㼺?��CքXAZ����S⮮�g`k@l��ZMӣ׼ǉ���៰[����YL���]辆a$�@	ş���30{	�?��=��  wh�Y�r�e>�t_YLCQ`�1�T�G��*������t5�1:O�(%!i=�f�IMJ�:��� ��ᓘu�N���~���|��� _��)�o�4��߿ӭ���/��l�����t�2�d�DƼĶ�*9ł�	��z͊�8�O��"��D���t"]�U�C$p��E����:�>�v��<!N$��B�Oj�{���\��~��%l:�m���J��D��ܡf�;䀅V����<A^`#z'ݖU!���MD@��o�ZUgP���@��氨���	s��Nʑ���k&�_`-�Wu_ޫ��*��� ���:r�W�)4s��H�b����':T� ��Ė�G�	e�	}Gy�%��IU�ȀuY'��'��5g��1�R�����vV�s��_��iϢp@A��*�Mh�����ű	�t֦�Ra�ӝ���{��U�.Wۿ�i�ᜥ����e}��G��0o˜n4ݱ󶅦� J��V+"�2�$;�SH7錡�i~�*�ov�D�q�NY13d9��,�Bf>�W��r"��!�	
bZ���iאɗE�-GϺDFKo�|ݶ��@b���+��O��I�g%g�kCՇ��Ħ�+�
m�,G�\���I~���8`F'���EcD��m%��r5:UՓ�[�=v �[/�b�f:�$,��Ӣ��M�h	�Y3:%� �1h�[��z��Xj�����I�\�����d��\oR՚��:`S��;�Ԫ^g�7:{����[�SB�Ua��}�	2B=��sg��S�S���=m�X��͇��h%�k]���ekI�\za63�)�|�d��}O�=����$��a}1�-��p�^��@���h�G�GU�C�S.[��)�P ~R�y5ˋmq�5�*Vi����7�	B��V;/�i�� ��� ��K�f������D�M\��0	sx񂎑>KO��t�[�ؘ@XN���*����������5��$��-��tZ��o=�@��}6ћ
��(�1n����7�x�f1�ep�u�}���c�n��bL�~_N��w���,�I{�R}$�<����t��e�4�Y�峻�]�!*#&c�W�y�����h�!��-W�ƚF��_��g0��$`|էC�G�E,�U��8>ȁ�9J6�M��z����Lh]�������M��F�s�e��8b��i��X������
��oJ�>ހ�r�����0��}�*#*���魛�&4$R+�O�do+�=B$G*���A��@q��#�j���vٳ����������1�E��MS�G�(E:�{	Ar�I�}a�&Z�k��\�F�������]���_X�?���u������8��s�>)�c�������7��#0	%�T ��<q�/�&�fmԳ�b�������|i;�&���bХ'A�AB�g�*'Y�o-x$���Cs)�����U8ȿ��'��^${J��*]���UQ؟�V&�q�A6�Ź�6����X�CT_h�ƿ�C<ņ�T�	��*?����D�RnǱ�Dx6V}I��Z�K$::��
�UU�0�����C&Bl�{섅�(S��
��T���\����_򂦑q��\��~�P�O�����b�������e�d]���K��$�ˎ��!ƺ® �����s��B�[d���foJb�]�B�e�q�	Y㖰Էg��9wY ��G'i��uKV���E��C&*�ؕ�Of�q\�ũՕ�v�<˗<(�O���CB��H� :�3}�=2S	g���`y#�5#���E����$V� #N]�@x�:����w�sj����`�A�񸘂�y�}M}�!6�v�ף#W����(�J���IV�C��ԍ�sx�!/� �K�(ם�ٌ��}N!V���j�1�\Lӽ�y>���Zs�?~ϗC>t�0G��o����(�I�m����iG̵�߼���b��sb�W���5m���ަT'�w�`��?h;X�f�T���B:�Ch�':�H��Ȋ>�2=�(]�ȹ�7���bV��LQ���I�y���$�V��E:��9<��U�c�Xn���xGF�hH���|��]�G��6=�6W�v�5H�w�=3�'��̏`����e9�3��n$S���=<�r�CQ��fr3$�;:�K^�I��KͩI�,��eiϿ�iH�AN�wȹ�+������?��ƛ�>�=�p�J^��ޝ���JN �(�_�d �/�P�8��_Eb̶)Fk��NvhLnL%%3%�a�C^;ZVw��R�C��xC�`}���L[���;TYwL���Q�ou܃�%V���E�γ��j�Ó�����#+�R4��`Yf�MJ�}���2Khկ�4��6-�Ds�մ��Ս�#�Kl�͞����-��!�)W�۳A�>c�C(�Ǔz�o?�q�
R�^��c*�c�!J6���6��tcλ��l��4db��9�<v(�����(ǆ���v��`R/�<_�����5��� ��2��Q>;�e�6��,9iw���v��P	��H���)�q��Q "5`ĺ�?�=����q�����۽|H~����En(���Q��ChF��Xo�f'�99dl�$	]	B(�_��}khk�-I"�|dw8.� �-��9��Y���v"�S��M�Z�5�Ea�I��y��F1���#���9'��'�
� ��1��	�D�N�����:hb�mnɈN����:]xx����ŷ��;�>�6h0ИX������B�}3`�` %@�]}���ė��Z�&��46�����X(*8l��i�C���0�sb��':SZ����pq]��Z���đ�-!s�cq��@TN����v6zM�o�� ��EL}��h-|0�8qh0cf��P��朎���׷U!���4Y%�W弸g	�z%�fF��:y�{!�h^�@��/s�xYܥ��R:%��Ч _gҮ��\��Ml�,�����6����p{uh ������:E��K�fR@.����.�>I�g�,�QB:7�"��y�{q�WU��2tT�	���7{s���z�b�&97�k���_�GV�L�Y&�B�.I�f��8 0|A��t�My�"�6+�Wp�J�]m~�<{�'�i�TȖe�|�`}lH$�G"���t�_ym�KҲ׉#}��ʓ��@@�o�Ć���G,PN�n; ���M��`�/��M��J�/*;����7׉��d�p칪~6�ք�q��{�]��s���b�I9�i]�����(���u��_��(�c=NG�/�nu#��K���p�:_�z=W��Zn�"�=�K�b�hH�������n��_��Gf�5p��ZI�Wj=ǃ�>��4�nF�oR�A��d~&��yT{�fJ�1ӻ1����׏��ǋ�7S_`�H�p��jF9f�?��L��2d�h@I�����v�C�#�a2�jV���`u7h0Y�U��
��N�#b�j�F��?�߲�iی��U���?\m�� &��t�2������ȇ��G��u�&��C��?5�3C`��C���zL��,�������bQsU%���W��64�c��^��ta]��Ņ�h�C���%�]\$��^���7,jo�̊P�n�ށ�����.�޷�+�đ����u�AV�V����W��<�bN'�NM�m��A���a�/j��'>`����'���B�!��=���}�:����,���(� p(�;���w^)����{��^�ydN���u�rg���u��jQhu�,�V�踺    �@D�e�e�I�yd}_�M���c�����c��gc�"xl�ܔ��it���W�5 �u9��byf�=U�n� �B�}���h���hJL��G�L�:�1S�ͻG�0��Yƻ[Y��\0i��3c�Ծ�cq���ޤ����\gi�BO/�&�W�U��q'<����5���H:�(��,�3/ӱkǺ,�ur\��6��������4�d���ܽР���<z�� eP1%���$�������qǁ�t��G��a �Fx4S���w�젦��uE�.<�3�$�l�ITz0/��q4_�qjyY�,�~0{f4��z5M�foG�����z�gK6�
���w��n�~�6�Z�Y��L�I{ɟ�kB�R&�YP�G��k�&��bt��7�J�t%p�5�5�l�n���DoK�X�����U�Ϭ���c*(�v�C#WD��u�%;4�$��$�~�^I���~e�.�b��H�����am�N}{��wk�i�PC1��]67�����9�e�z�[���x �w����G��Q,���"���o0�L���h3��� Nb����D挅�v��фc<I�� W�~~���Y�ogw�>�l� ���P �W��eq�=��ѹ�+��c��E�n���K�I�tkVy��{+�GZ���v�PG���w��By;[����m��b*��i����3Tj%�%^.=8�F<�*w�fK\d�Yvt�y���.���qkI�gx���hZH\!�}�2م 0��<5l.-j�(2�N���������C�ۂ��9�F�.�0S˺����]Pڎ?8D�1���qw�vd�E����?�[3L��zu�8�!�&±�g�,���c�bhr�r�nv[k�14����~�ڭ;�2����|!`l�-z?92��x,	}��j����;6��D-�P_\^���1��͘�jF�moʊ�t1e�%�V�6��J��i������>T��+W:�;�|b���F
#�5�/%���SG�>����uO�8TVs�#�]�]�r� UX'g��g���3�ݎ�? �3SY��C�^�g��U)@�?8^���hn!�~r���xt$�?D1�A��4A�Q�������
��Ԛ~��X|Fp޲�k}�*IXMǥ�a���Dwk�����L��x��<�;��0v�����S�F�e�@����;���sڮt��إEq^b�������L}��m�����0��Υ�"��t���{���@ѡH�)g�N���_�	���"Y�=H���iC��T�H���`T�4�:	���r=d�6D0ڕ�|>XIK�W���Z�U��n\s�^V�RA!���L�vP����gf,��լ��{��@\[c�f*��kf���s�]]� ��3�(5�Ϊ�����xhOo%���K7q5�=֚��_�3�^$r�H� ��^��z�EI���h���Ψ	^0�Zw��=�l�[:˔Ϋ��-�M�Z͡}C���I�9�"�b �<�z�v$�21ԨK�P�5�r%
'�O�Z��8�ٍN��)���TU����G��Zd����u�e����f��^��Yix[�K�����4��^K-�e���W'0@���#����Y|m�3���9�m�Uk�q�[�i�mo���a`�U�r�ۮ�FE�Y�4b9�;dK 3H�@t:XK������r����'������]ƥ��|��w�dtޗ�i��Ƒ�v oEu���p�ә�To`m���؉����l:X1;6�41-FWj=d�v3�'^��!��l�fL4R�8��e��xAMIb��Y �u�U6X>[�q�/�{	��;�6���K�Z�`(bnm�Dm�AF�5����i��H�u����|��ܐ�w�`��(��7�����맩Y�.�O̞���#�7��5��5�8[-U����CG`�P�>��TC��G~ ��0��cVi�^���l�L8R�h�t�d-�����<��#Y�cf��*f3�@'&T�/L�&B$�#���k5�XW��y�.�]C�%�2&P��IF������[D�A��n�t�]�2�NxE*e�Pϓ��8�����n�T
`k�w�KR��׼A� �u�$�}$�k��s��[�sa�]P�{>Nl��`]�������Cu:��ouv��ۗȘ�bhP��N\d�5z���j���H�K'��4@�&�m�,B�:���0����l�ԟ��5� � �ᢅ͏ž��H�8��Z�yUb�#I�=i�.�(�s����U&�����m餦���K��DC8e@��0���/0؊E(\$��T�B��'V}�'PB5i�[���ÕNY�J�u�ݣKv��r�eZ�BR�H�Y��Mmn]��I��ٓ��w��r5a�B����9�|]g���Ո�Y��ѓ@���w&�^����N�Dl7B�D:Hq�'��������xї�k̮m��g�u��P����=b��\��4x�)6���_\ae��M^��a��ո���<��:�X�J����W��[2*��S�e*d��z������/�6>$І^T��b�~�*�R#q�֫�g���=�I�AG3���3���[Ʃ�Y?9�����L_�2�������KobF��vytxWC�B%�~�d�R��g�b%��æP�}�栃SBuCfޢ'ٽA2�d,
�F�����?�YĴﬞhN��t�O�c�NYJoa( $8hE��>	��r��f�#�ĥ4�>�.���W��`��X��<Jü,�"$@,	I%2a��9'	�9K��4=aJ̄��PV�*��]*��K�������	���|e�)$�0�p`��Lg�
��w�4�E؃���B&p�M�xL�ؼ ����2H�aJj3C���$a�hrl�f�SCU��	4��'�%�mV��q(����	�Y����I*V	Е�Bֲ�te�?ј��ro���
Sǥy3�c���F���7R!���<ۛ2�0��0��bI��3�e�d��$Т^l�f@m7�r��WO������r9�#"��6'��x�2_=�7��T��
���pp`&LЗ@���2<5d���2��֠y�P�u�c$�|5`b&� ӛq�-���k)A��@rLm3��oZb�@�� �M�ϓ<UI@�Ӹ��N���l�4R!/�UWy9Y�owO�'P�^�cZߞE��Dz�u���٫�#c��_VDᨻ���S�P\Cq@Z�s���9j��BgB�Ĺ�?OVu#F���WrX��k�]7�!|
��``,
�Y2�8���Q��W;�E�L�k��N$v���}��� ���'�V�`�U=}���Yބ��9=������c�,�C����[��A�,=�:����c�vE��G��"F ��	K���MsV��`�7�D�q&�9�Ӌ��Ay�a�}A�o������~���3��7���������y�I���b/L"�T�T��I�&��q~���N��q5�I(��wo�B ���/��m(�u��ge���J�w�M���T�b�; 1'Ih�0�*�ݳ�|z2ah����4>�縷 ����`  E�tZ�=�W��e$	&����}��YZ	���鴜]�M��K��+!aB*|���;�|������D��:-
3:]'ࢬ�(���$OMXj/�Q����\-�Ռd=��$��c�����ѕZq�x%Ȥ��E�c�`�p��pb_���i������|���*�"z0*�kV<�,���<��a1>����0���1��Y2�%�7�n/�rZ��V���	-���j=���=ƪ|)�}���lB�-g��>zM�b�׳~H��vߒ��J���2=�USa��M�z'�~�G�~�4:*��VA\�3C$|�WRBӓ��	�n�۲i?D�L��ʤ�µ6�=�_�:f��I�̴�ƪY��1�e@H�AZ?��@�x�1Kr�V�sYA���fq�s�A��ruޑ�BR<O��y�C���@�uY��ߛ�jF����W�i�}KO� a{h�+�-N`�*"	� �/����}� dɻPF3/�}6���<��    ��HV4��F�66�?���*����MXP��4Z̘|���C#�*@WV{R��N=&� ���R=ۧF�q�16�N?�n��I���z��/�q��Ň$`U4I�eJ�^+��&�a��ı���_}�c�Y�p1�P��ؙu}y.EPd����'Lb�1�$���� �'����B�g���-���5��.�}91Pxgy(����se�o��_�:�l��J^c@�,��J�{�j�|У׏��$�5�N@|f3�t|ēы���S��Ԝ�̅���"vH�P�7)�22����[3�d�ǅsyq�\��&O.�RrPs���ϒ��$q��QMM�8����B���3ݧ~��:\#(���f�蜋) ��	GHBn�2)��v��0�H��a��f�������Dέ���wo�&��q߯�)�PS��Ј-ӣ�I�G�Z�J?9��% �u���g=����5����qF�c�y�����m�Y���h�3���1���uUԣ�g���>��S�����G$�L`�)�}�t��lh���I;�O���9����J�5K���|]ҫ/E��)�G��W�u�ʚ̈́�Y5c��3u��V�����#�tl�f(ڋy�/��ϯTؚ�}j0L>�|��ۿ��q����9��7�8V�(�����̈���̗ۿ	��b��E�A�/���������c�5�',; �����MRN*�K]0䘡P~�����]	���С���@3�T�}k���������wm�6�/����� XOMʹ�9c퉮=�),G����z�뼯Zh;!�A���L����UZ�RR���8�~�mAV~8�8I�)7:��4�@ռAW����@H��	xշ���L��G��#����V-Smj�a5J8�7��+. �x �lf��8��NS���:�\B\Rc�+0i�����U��޺����N>�z�H�9	�2������ �*5+j�/qX�cV� ��P�PJHq�D�̜���H�g������ߥ��ug*��&��i�����n��\�bD�Ȉ#��-�3�#B��8)2,n!>���֌�M
lL�D��W�� P���^_�^���f%\�i�^��7=�HG���֬�]�c��a��ȧeu�|��@F�6]�A�GP��M�����
gA"���EI�0����u�0?r��PLߧ��S���Q�3>�G�Rz��2���� a.�B_�Ĝ�!��G i���d^/�/t�X&%�s}ϛ��yh��9�8k`z�>�:�H=1��E!>h�,q����x�j(Ia}E�XdI��_�kK΂�qU���y��8$��E�ebc�U�ZC��sȅ����|��O�~("K1��J��\M� ���c�;��׎)��b����8��׳96��|m� ���aB���,ք9.�*_�n2)��]��.V��cjh�O�̋�?Y���'�3yl�ca�9�%2o6M�����N�[1�k�L�y�z�fGo�+�"�$s��^bI���|L�́V�~��q:Y<�3��?P��ُ:e�%��>�>^4�N��{�%��Oeu_.�4y4x X�e"e��O��A�}�R�P&Z�*�c��0� �ˈ�5!����� ��q���d��Ui��؋=�4�'+4%^s�l?��ă�îq��F-�g74��Ȫ�U�>�L�c ���<F���]�������j��aq�\��Y�0(�8JJ#� �;!S�0��3a���6-x
6�%��H&���(X��!d0�8�#�2�jJ94���
��J�Z=ߣ�D�KHGi6M��Q�GR��z�KU-�:O�=��� �t0�hX�`:^��?�׎�������1=9��\ ��X��ؙ�J�@`3�X�}�G��)]\��2�1�1��/Z�ZK�:�㚉�k���(}�񕞀���2�]=�l̎O�2��*�0>���mecJK�e���mM�U�C�0G�U�(���6����~t.Ӈߕqx����a2��>�x�}�c���Bf����:cU����R?������j��#;9t��.�e��A!�!��� ��z�O`��@�O�u�_=�V���k6��#ǒ�v��p����@$�������8+]R�4��j�|�aL�ρ�Ϙ�43:�	L["������da-k0��ϥ��i��� նo;2�b��|*1N� ō���ӑ�Hh� #�)Ǣ��48���O���!��0��V���l۶�=�:7�n�PI¢� r��T�`�yE����@qJ|V���g������#W�l�{{^O<�q��RK�t'.=m Q�~I�$dl]�����¥ (�>ə�~�N#m�z��\`�U��N�Qr�-�7,	6p��E��c@��j:+֦�z��yd�B[7{�Ŕ��zRR��������!L��! =5 �S�@��H���فO`c�&�~[��+1�q%� �J�*V��>���&��}���7���{ƿy��5����A���0��}��匁�~,b@�4��2�Q@w�r;׺���r��\n�n>\�jS1W%���8¸�Pﯳ��έ���#m����ߦө���t�`l�j��fY��kLBI+�6�|���K7�#�"�K	�y	�t����G��0P1��Ae��/�:T�,�l�O�ˁY/�Jm�����j��>��h���,����]W<�������i����D���s��V#�*��Z@�W�Dzq���QY.-���hr��Twfh�\�w�[9�����؆���� �m>#~��5�L��^d@�{�m���\��P��(p����0B4:��x�vx�ׇnqy�����s��S)0'�� a�
4gY�u��J:�0R�썮<�!D�%�<,��I�i*`=kic�^�9I�y�>�h���l����W։�?�D�⮌��558�nsC����<c	��GWG�20��:
��g�v&����-�:�N�(׺�o��{�pt8@x�&�ky���x��aK[�R:�3X�����z��|L�ۗ$1�w�o�0g�GWXDkD}8�����ڔq;ȘQ	3uϨ���+����>�PX!�3���ӻ�ς|`��,���/�6!ȧ��'�G��G79��W��>�	��(�?��|x��"aq2�����~�7�.�^V�9�(Ӈ���X�ST٘Kȫr

��]V7)Y�g5�Ƒ+�BI��D��=�,ݬ�@|.���&�*����J���������g��ћ�\�;(:��r\Z�������3�B�T�UN4@�\j]?����_�no��a=�	O)��*�i�%;i~�C�ʤ*ڣ��L��9�@]���9f�@��Hg{32���[��iM����9s��Y���(h��� �bi���Y�Yv(b�;��H�ϸ���C�W��_.SY��҂ằ�m��}�g����&.��ZW���y[��G:�]�u47MG��ok��[U�c}vA��$�G��X�Bь����P�N�{��L�� 5�`�tL��y�<��xÓ
,/�06�fb�j0�frbűtȉ%�M�o�X*=�r!�z���"�j�Ƞ��h�>� <��� D0w�E�Zݗe��eW����H际�+X���4�C��>��@u�T��{V!��E=�u���K=�O�bN�lutS�K�d`;�e�N�T��J��_�EV��
��4Zn���n���ћퟡ.%a�JW=��@������W�1�O�$����֛y9��$�i�FH���ɛW���i���C����J�y��ֈk`�l�����^Ǒd�5�Wh9�8��&������:���e{AI,�Gy�U���00?���0`��Y����U�?����CҸQ]�T�����/32BRW7��4�J!\��TT?U��@����_�n��Ւ����(���7�|�\�pw]�����$*�^�X��Ft̔�ހے^ȭ�]�9L��~��+a�mʹi�����P� ���p,�D�PL��z �g�Q��k��1-�@�    Ӵ]�xp+�VeC;�]8	"�����,��ə+�ا�/�+��S�Et^���,����:�\��Z���OoxpR��u��z��{�^P��K,&�K��1�¹���M������G�՛�`�zROn�5"�W�Y���q����/*�Ϥܐ:ļM��Y=�EȰ���h���$��$�6��+�y^��1
&~Ժ����~O��N**%a����z�R��(��,��PH�M��RN��`������6��y��q��+nKW'�I� b;�צE�Ж�g��~�$�.x.��R4������/ѺV|}�<x������嬳�+�B7����M������G�����Q�	�'�oG=Lfp����//��ո�XY,�aW�[߿�Ӏ��@��1KI g��F�7��2��!2c�Q��r��Q�UH�a���v�9C>"7e���$;���cx�MG+�I.M���G��f�#B����,��v����v�c���#f�P��H	7/zf㚢:K�^���N��K��A����4��˝U2��t,-��4���É|��2I���M�z�M�c���xmZ��}�����1���]�6�Q�q�ꃋ�TG/M�Tn\�B�Di�$��	�Ѕ��LҨ�>A�R�3z�v����_�جk> ӳzUC��&�$5����;=�K�IB��5��+����̷3j��CH�i�iXU-CS����|��w��hʗ���6�Og�uS��f�sCD�\S$�$ݹxB.���J�B\���� ��s���Z3I��Ʉj��y��������c@3��T���/]֐�$��{�>� $ ����X��O�U��5`����mλcY��Υ� �N��ʛb��!K�����:�#~[o�s��OG���I���z�\�AiF��5)���t���٧l��p�"S�_�{1�#W���]�%�!�LɁ�y�n7�=B*"���S�M�fl��6H"J6����Y���
�$Ó�E:��C�v�������	7��m��^5n����rZZ�|^�M��?���������i�b�w���/�ލ�n~I���M�ۗ����|]�}�t��fț�}�ԃ!Ѷ�����7T��{�][gt�)�e��.�y͕aqno?ȝX�&�"j!PU5k����t����^Ic�����.C}�`�>}Ƣ�(m�pIH�v?I�]����[��~��Jc즩�%�m�3����Ϋs���3�������>��IS�B�S�@Bn ��p���o���1�+w�}ࡏ�x�T_��lE��9��lP���峬wu��X��壼i�ɚ��iqi�
C=�����'�*���?5�P�%��a�\����>��������� 0�y�����
P�m��wk%@:��� ���K4[PB�w�����ޤ�t.;ۀm�ͷ�Wɒ��j-��晤k��|F����s��(�Ĕ�k�\��$Мί�8�h$2��^Q
���L��ɭ��fn=2�$y�Osc�5� ,�����$NbQ�}��J���$i�
� H�~���.)�[��'>={��o>�+�XD�<Nh5SSХC�)C&�<�D��-�M�����Z��":��"A�59�fz�����G��N�Ğ�\ Pל�G�6M����h�Yd[���c����W�#�/kEL0�Wɸ#�<o���)dx��°�wP��oZ��)�W>�+AQ;:�SI��)�bW.;�M[l�����e�x�Mg-��T�I<��!�x(�6�ȳ�_�q���@��OK�~�e� ��7=�I�L�t��|j�M۵#.@&��!��� ϐ����/^Ʊ|Y>���ʇL��$�M۸�$y��c�;r!�7��6(e��=�{.MH�
��g2��㴧z[��9U��n��7�]�'ڔf�uW�֤7���}I/=�6o'On�Eh�s����������h�\~�.q$�:ۭ�0\����C_�w|�;lQ�ev��ҵ�T)q�km��$!~��������6v��7bQ�ҹ~�����������֛�ޖ��RP��z��k��e;���.��H��d��Z	l���E;Oy[n�iK�`�.aQ^N<��,)�
���Ͷ�%	�N��y�*h�'�I^�>Z&�U��nsȄ]F�wQ�C0���
�O}�P�����V�	���5Lo�R0	Iኮo愤�ݠ䡷�b�H.W=3�^x($�a�FZmv7���Р�re�><n��5L��ٛIϔ�>���өX��j��
�(�e�IXVy�i�s�f���Թ�v4�)ba�]������X��k��0J���L~���$���(�UQ-Mv���s)���]Q�
~w�p! �z�U�42E�*�tȤ�m���)�	<d�@�-�=D���U�~��r�&�s�VB,&�e'�#�kgd]��u��W߼s�7t��
�����6w�w�}�/�{�c}�_g�M��{����JC��%[�g+rrw�2����kG�"f��wS@���[�g�}SGqxvϣ��/��-,��}�ܱ88��pB��������5[�8�OL��"t�Gs|+���*��>�7���
��O�s1��:��ҙ�z�%P�1��ٚ�/��R������N)F��9���a�������b�	k݅�ƶ��ap��evg
�¹-ML���qoƍ	R�:�Y����I����0��oMk�'?�Mf��m�o��W�Č�O�ۦ�l��$/zJ.o
�P1���曦��EVͧ��[ޜ�����<\��	kI(+�_y��PbE��7��bm�l�8P��6k��<�*�҄�9X�5�K-A�|��c�L`ҞA
XO���|I�[yɱ�zț�cu�_�ۙ��\]�C��}T�)��l,�
���./9t�c��0z�"�N�P��o�qɳ����Lq��H
My��Y����?~붓����>dU-W�1wM#O� �Bϸ�����r@��[8P�����R���s��1�;�BW���Dqm�yA�ў�L�S?��`����8�ۮ�2 Ao����m`U�v/0��bۿ~*�[�
4�mj2��o>�����4ϴ���h�^�䚝�����}�{
�N�����B?�zC/E{��d�b�B�N����%��c{͙����B�:?�{�FaD�v��hb�S;�u��X���"g�vƊ��r�G�璝$9�� |�Jf ��ٵ��Z1��O���9ԓj5�}��VB��g]�`�A�����Y�{�n>>2��o,l4�̊+���r�&��Ū�L�?����ҵ&�35����s����D2;�S���_`��
W���W�ʰ�Cjm P��E�/�JH^ew��\=��S	�N B�+Z�}K-�^]]/���]}�w�������@Q7�:_	�S,E���o+���<���l�4:���ƾ/uJ����k$WRW�jruSc�Ub"C L�?M�>n�[�o���^!��=���z��]_ ��K@����S��7h�:쏈�૛��ߡ~�7��7�$�/�;<�)�� t�b����O���^vi��;|4s�?}Kӱ8�a�W�������o��L�܆eh��k��zʝ��ᑾ T�L��cG��IA^_P��O���>!r=Rz,�<�3��(� b?�qQ���_ߎ��f��hq)$6�n�4ߥ��)�p��吗���y3{�����IC��&f�;��>�i41�����JGl��s �� 
n����JH�'?�.�����HaӾ��FA`tD1�$�ƚ�
8㪏�?��FLǚ�LE*��P���C��➊f� ��/�k^�H�&����'��.]7�b;�1	���b�.���n�����3f��D#���R��.������=�6C��}���j��St,��3DLٳ�x�CI��z���,#�6��A(iSW��C`�w�~�<y+,h{&�n�v�����	��s����;�L���02>�}�0��i�X� l/��W��I�a.���2�LMY�!�ړz�t�)��6��*E    �;�`�
q��/HJ�׶����&�|�Q�Bb��ĤY���������C���}Ӄ�9P%��'�bܓ��w�2�̨S�j�h]k�G���-��W9m�U)�HB�^}�w��o_�=�n��S諉$ÄfΗϷ�����*�x����������v�_�o� �4!]|2�F�:_��n���D��E(�B\n�=�}Q�W�'f7r�1� ��\�赙4oyB -�uB��/��¨�_Ğ�����┱EI�[���2�m�=��ǿC�p��']�|��ta��w�~Z�bC�pg6BS٣�_7�/��vĚ.�ߢT������+���JM�(	پk�AZ�R�)~��tݓ�j�ߧ\��M+Iv�eyC+P�����6�oȤUteE������8	'�M��o>zp�X��H�{Cf��4y�~��Ό��GM�}��覨L�M%tҫg���x�e�f�d�|������c�fB��d�ߚ�s:	��/�h�B���T�fו�~Z���J�T�&a�s�������GQ㘻~a(ާɭXʦ�D�xh�l���&���ˈfq!P��}�ƒ��[w�q&r5�<۸�F�{8��:碞Q�̌.�����䤘��ʧB�!&����X�i�g����z���0�Y���{��=Q{�IHS>*�l�;Ê��*7GC`����X�/NZ���7����'�k�+U�]�V?h�^2ƽ��a�� �;�C}����dq߹�rӷ��)ݷ��j���"�n��Bi,~��Xz���8���_�4Li�f�T������al�����_�[zM�~2�I�p��B!�<��\Ko�-���hpzP,��Χ�7&9�c��$�ٿ%|?�H�<zŚ��Kn��ͤ0�խ-�'���xPU����CU̐�_h�?�d%�6�<^X�?s -��Cd���譙�h O/��@cv�f���g՘�>@�d�-C_���/��b��i�O�?~��ۻ��)�$�Z�AhV�3��y�+i:W���*�����'|[��C`����ߙ@�R��qj�p����X�X@�/��*0�N�)#н��.�7~N�PUƔ��d{�ؓ��tb�E��h�����N���{92j$��(6u�.B��v]C �jpqi��d�)�"��E����{(�fx�\�d�`�E��u���^������٪8���\z�)vus��(��w^7[�$�M��͇x0���iU���)WsC�#��A�[�Etv��m�TX��0 S����Χ��uM2���(��7a>L��!@N���}�q��*���AÜ��x�τ����<�[%�v��N+*	�Dm)�f�u4U�<M�t����I�gJ�kZ%mLK�� �_ౘ�ߚ
��E�-��K���5/ֽ`�i����'2�5O�vZw��m���鎦H	�B�l|̹�S*y�	��k��KDv�%�2�<���+�����	���M)�xޮ����g(Ħ���`ө0�5`;�������G�?Vi�}.����*�wh2'+8�|*fs�f�Lҏ� �]sSaM#����2D��
���u
s!��.s[���hI)\p�]]�g�g*��I�E=���'�)ݼ֩���F>-��n��Ng�6������_���͐HPن����̝g�:��E#L%�us4����V���M�����H�~��f%gR�)�6�tci��$}���Iݶ�a�=����d莯�E��k�W 8�R��Iz��\��ߤ���84���ޞ���3g�c�c63�l���xMg�'B�W�:����2���hu��X���.���^m�����������Qz���f��)h�N��aOF�l^���[�/�(A������ج��iv�/��c��,6bx���g�w��Q��*o/(2��]"e�M�^�+m�-�������aWqd �#�>=hX���M�cz����w�r�K}�Wc�*��v?Z����m���A�)����]m��X�o$@��q�?�V��u@�S�*�WL=�:��D��y̓����˲�i�'䩆��_�����ϔ�A��1����'�����f�
�?��m�ǋ��9	��L֭�e��d7T��^8mq��{�'�L��֮�V���.UG���w�>��77�3����H(fд����:_K�ܵ��rj�#��O٠b�@V��$�ُr#T�|�ঐ�MS�40�	t���$�t�&��\po%�}�f�s�q�86W�d-�~C���9y��t��%��ZpbE��˦~�z�"�(��D8������4�4X�D�����
W�L������Y�|n�76�81�bUW��qb(}�z�mM�^e[Տ�ȖБ�2�긦��Lt9X����i	��.;��?#�*E,w��f��<!��[��^���u#�C�*�>XE�_���,j)���L�*�� �>�m���bL�MM=	t|����d��n"F?�Ŵ1fs("n���*;ɟ���?�r��m�	������x�^�D'd�'��f��@1o�kauS�����D�l��.�r~��+���I�,d���K�+hqЋ�@��z#h��Nf��d�#S���ۓ�5[ݱ��SlN��W,��X�zw�SqP]_�)&r�R<(��P�b�PY��o��б�}���L�S�]��V^����u�(����a N�tŮ�=��Չnm���RH� J,$r�
��j��.�Aelq�g�zi3&�#�W��I҂���k�I0���]�Xc`�w<��$�aT��U~%��t:�W����M��dtm��Y�SU&��5ǟ�G~^��b�ƞ�F��~�Ym�G{�{��(Gc�2^<��F��#u�D��*1b�o*����r(���kt����v!�X��2u��}�n��U��ܤ>i�^m����^������B��L��S���ŞY���:A�����j�$Ee�qh������͔6|Yff��;QS����t�s�3��u̳:ƕ4�>���X ~n�W���`5mw��x`��_��u�=��s3e���+ ��9t�<0�I𹺼˯ntC���O��[ X6x�n;nw�J�U�C�H�co��?�
�g���_��������t�x|8j7��Y>Y�n7����LQ@CUh�o����x9�CP=�Lt��?��ωyh�:ڝ �&fȅ�N�nť��zxc{��"M�k�/��ν�胴Iu�&yEz1�B��Rŉ1��L�;c�u��Rô��O���Q� Ѡ��Nm!�E��T��9�&�B��l������a��,�����_;Yҧ���5�(��"ڭ��75�u��4�4C3��Q�c����9�@�
�^VR� ;H;�Z�'5�D���f<�fŏxݩY��y�F��Ʀg^c�'+�񪛒f#��C��И���2ǐ��`�g5��"j�}ǋt�����3���l^�qA���b<�gO7-D63bE���w�?���|%�ݝ
�����o��Ȋ�M]�M�y��1}�� }�>3��<��~�Iܤ8�U���]�^ՙЂ�I�P(��ֈ���1�6�8�#��<��iu3 r.���ě"�������GL'�b�Bf��q��1�Iw���lT�'����Bj��z y�IÇW<�v�|����8{�ΐ|���P|^܉��-�m�)I6�TdW�on����'�~Yh}ޠA|7/X�=�Ь/�����{_��`H�#��uO�$[�J����h �Y"z����C��z���a�a��C����\X\IǌxN�ޙ�a�\z�*�EӅ�M>���Gb��;��t;j5]YHER2��L��RK~�X���wN֭V�gh��lIK^)�S�	^�<���MH�W*1	X�T�t�;ɖ�8���b��2�>�b��|s=<�q���h���}e�
�SL�ou#�������}����k�y�Z�4��ܮ|,��t-�Iq���x�)�%JUc�L엗�M,mU{,���.� I����
��P]7Ń �  �ѡ��]������Ψʮ��Jh�����>n���䪳��
.�	I��$���E��w�rS�p!eC)�׸���wR�$Rrm���Z��4V�B�b~p0��'_
���ѝ
q?)rA�&�z?e�m[W	 I�e-651m�b�{�nG��$��Acz֖J'�5���)
#q"�ЯbV��󚔘�F���L�'$�am�2f��P'������u�\��m��0ĒK)��3�;:�[n�6�	�	��K"��m7���j����o3m#z'��u�D.���H�C�j{n��#u���ܸ��x�È{��%���{�ǣj���&ļg�C6���}c�aQ�$��LjJ�Z(�O:�H�a�I��0u^�k���W���%�<q�8Ȁ6`|9�S�8�ö�6�.�5R��/r:JI� ��vK�%vZ1���Si�)s�k$�8V�i5�]�ξ�k3�����Mgp��<�Cm�~��],��<����σ�=�*�\,��tyC?�Vx����K@���t�X��O��wE��t0�אD�j��װ��,h��A��lT/��B���	��q�*�$�S!·��`�l�p+w�5�Oz�O�l?���3�i*�X«pr!o4N~1D22%����G�'�T!�(�ǡ��h$���-Hb�kV�H�s[�\ãuL��b�����ʾgE�p�C{"�N*4ұ Ɐ��`�O���=����9B��T(]�K]�N��2h� ��L�k�]G�竞tV��yg=ʅ���e�B��9_|��������I��t>I]hM!]Uٳ7 QuJB�L�V�Ú#�e��2_գ׹e(����}6��9���@�vP�}��z����5o�$��Ώ4�����./�'4�����F�9�vzPdE��]w�0M3��=���SV�������q�{6�?~ʛ6?��0�E���0��ï^d��J�7���-H�-��T`����а� ��Z�kX�B���������Zcu�h{!VPV��wڏ�=�xD<z#g���w7�o!���� �%�4P�e�	�F�I"��_o��mނn*�@��&���}��w)�j�I$����v*�<^Me?E4%��iRݙ�$��Pd �ݫc�m�m���*o�a*�e55�1�I�h�t����u-�^�U㕘g���u>�ˍx�=a{s���o�2�V�u+2=h{�9 p���t��8n��p{i�!�>N�i�	��*�9(2�J����;;V�D��R"��X|]3����yO�$�E�=o�qT�T�:��]���1�H�(d�`��G�N�u>̆ad1h���'HUTkU��C�E�e�g�ła��z}�OM�H�6��1��W4��EQ�Z����!��v��.*�@^��%?��`Mo����Muq���$�k�9�� ������8Y�l�RD�	0��}�ͪ3�0&�A:�)���4~�FAmK��g�����9���G�[����
���\V��TÔ=���s��|��5V��L@3ϗ�FS��sD��P��2K�0p!OeQIyӥh�A2�^A1�x�\$��VT���n�{��:��ʀ�"x�����ǅ�A{vI�Z@�+�s_�Z,�S^l+��C�.Sj��J˕PD��C#>�y]
�~ 4RU��W�^F<#�L��;'���'<��%O:��O�4��Ƕ�DiO��'V90��L�he�-�6�V"}};=�^�Ѝ9dD��lU��D�H����RNw�e9��/A� :$�=�-��Op��uk..��D��8�-����?�Xg������*7·_��%���B�/��r��p>)��K�%?{����^��Tj�8�@�zu��0�}��O%�b�`2��k��#5��y!��B�Vq����f���V��,���t�B�8'����۬_�r�����RZ�&>(*'�bI�H�SZ�
�잤<���iIO����5�$���ڹ@IY��r�HӦ՟G�43��ūZ�~�	.�f�8���>� n���)/����h�S��$D�)����0�z�
4�3%|��HV��m4[�Ix7R�G��?���B��0�:����L�W�$Ԙ�S?:����$���ݟ�� 
x�.��P�^׫�2�"{R�8[֝��/Z�/Q�S�:Y��gE����pǘa������c�B���"�� OŘ8�o7�B߹���s�~I@��{��Y�ڱ�I�9!c�;u`���0=�1Ŗ�b��2f*���?@�ey컰�O�!�8�5�F��N��H>F�H����r�� t���`����;DRXe�Xw������ה��ā��P�~��ڗ�2�~��A>cv�<�~�*V�b���@t7]U�T Fxbχ@֕��:��lB ��lva�=�G�!�*�=�
	B��1�}��;� �,	��X��t]��L�*��4�)���i��vt�z��XU �ue�c3Hӏ� 9�����X�nY�"z�B��А.r��ѐ���l�T� �4�d���Z�XBD �XA�z����ʽ�ۿt�~ڠ ���Ԙ�V��+b����#��Ǣ�~���W������,���=4}�+��<�x�I�a������w�����j]�uA��(���9�p$,:I(m�%�ξ_Z�$����Pҩ��sY�xF���f�W�0ȇ�FG��C���~�x�l���q2�5�'}� ����m�^ow 4{����D?�Ч�� ���i"[BY9٭�e�K�,��8��]�)(a2��fS3��j�!۞s>-2�M���xw.k �E����rwm�����3��݆Qq#9�J��L�����/d R�8�����rB�L���<��QΪjv��#�E�t��u������+z�c���Lʗ��)���Tu��������J3�n.����j+�ɀ�R
���ˑ�0�*O@�S-qT�+��)��]�ϖ{�ؑ&`�o����fF�1i\�e��(':��J��=��^�@�Sb'��U/�Cw����!O�@"G����@(����(~�E5��aRQ�����q�AN U<��U�ى��'������<�b@z��^]��y�0��s4ֺ�9��P�b��N�٨Y��x��sl>=��ݕ�n#��w�=<�:�B8�(p�0`��0A��	�@���6���)�KHe.� ����1�\Ɖӑ|
�zaٜӡ �{�0Z�lUW8�elZ�П4�6������_&���;�tl�t�d�RҸ ���l�gf�vJ�	I|���	G@�`�=	��/M9Ґ'�p��.�ǸH �tw�$Ӳ�PҸRMR��+BVN4%���H���N	��D�f�a�/}��v�j2�D^�#�M^�W2'�[�s^�&1�thj��# �G��q���x����B�ٓ�����q���  =�;N�-�$��F�����'�!���f�U�� �Ix���yl��X@�B�����v7������і�ڂܐ��n����KqaنB��	�x68ڻ�k'��<�몆��:��7�"�� ��z��z�c:\�e2�9��ݝkЀ�1�p�������j�O��'%Ц$	��j8u��rIf6���xNjʛq�
y#�=�)O�Ȟ�.�:����@$ ��͐��ꏫ���z�D���!�ǝ\� q �\<�b�ru�SP�m�n���>�N�S�цi��s��䆐vT-�]�����eݕ�ә�2�������M�v���Q��Ǌ�/1N�詫,gr xi��p�'���UݚC�A�%)bA �W��	M�z!w�
��1a;��RӐ�i�G�>��_u:kʼ7�9�hAII�`^2��Ue�|y��^4n�ݭ:�"%��6t�����6i-%�����;c�����H�#����r��2.��B]!q%��@����)
tF�t�������e�;�<�f�ѽ��7���0��l�աo�k�ΦDۈ%zg5�E�^0�>�!cG.xH
����1C�-4"%���;�TS��q���&Ip_rS�ٍdj
Sś����?��� �Mb�      �      x��}Ko�J��:�+��*L���c)ɲ,�a]Iv^{za�)іH_Jt^y7�l���� ���ܪٍ;�F�E�1�I���ND��m��ꦝ)�8�8��B���}��y��<a�U��(���(Kt�L�F��3��ſx�e�3C3d��[���(dn�{G����DO�;�}��'���^-�2���e��u�z�/�|�_,y�LV;���֏h�V^�f���č��1]�c����!���f�oڞEL؞���S?�Jj��&�u���q��uz�o6�oX=��,������j�q������"Z�~���zme�����o�W�L_�����T;Q���
R	H%�h�WI16FGY��l�����<ҫ[Ppg۬��j�:�-n���؜���V�;��l�0-��<�m.qe��A��?���@i=䷋x�~�Gz/��b	<�j]�䦆5g}��I���ZS�nف�;f��L�ai��M�/Ď8a�sq��RR[|8�O����ķ_�8��Q��F�?�u�]�i�sf���F��zL�B���2��b���d?�aH���L�#���I�s���h�����,�?��|5g.^�8a�d�f��-w<l���BZ0��\fz�Q����l�%ԉ��C'���C
6��.��h��>?K�^��'5�,���F�X�-V�I<�Rx_E����t���7�9Ϧ�>MW؆d����څVk��r�J|��Kɭ����}d��TO�DQ2��E{�_vXs��-D\o�D���jc!��,����yv�O��8���N���{��0�x�����A�ZZm�d�I���z-㷅�ZI�؋��E�7�j�������,�1����J�m/p
�o������Ft��_z�z��1XT��d781�n�&��1�=_���}>���i�Y���(�]���߬#Ȋ#�'0a|öv:��-�Ƕl�⻣+YZ�,�B���H_p}�����Ն`:�A��b��0+Ć�XЕ��C6�hz�O��;.���:��Q��;���xv�2�j=�V������c�6I�i��Y8,�����=���e6-��G�v9b�|E��lR�7B��g�&���G0���4ـ/���G��4�ʹC+4�Cّ? ��
�3�6a=k�Z���jOQv����?�f�+��m�Y�PC�\y($���������k�8�6S����o�x=2Ӂ!���g#V��.�aojڰf�Mp�����<������ �.�6��#�0$2�yw/t�{ʗÜ�R�=#��
��7	+���t���XB3�m��WB�;s�'�l'd�3��:���l����7�����#����4�#8W+p�h���TȖ�0�c�`��0�9XZ�'O�����&r���&�&9�<f���˲��Xf�U4�w���u���Bs�8_�w��x��A
��>T�rB�����HG'Hm��X��S�K3��Ȑ�p2M�޽!J�S�r?�)� #]�����P��3=�Qz߮.�C7�}<��XJ7_�I��a�,�y�FZ�%Q�lחg"1g}����B���y�zk��>ͱ����Z�w���k7��7WN�U��ߖ�ӂђo+�|��8e��V���;�G�0�e-a�� ��T�@��I�����n��x���Q��6�uБ�<����Z��C���4��a�`C�M˅Ϸ�T��,p}S:O�DArg�Y�׷�$�����_��bV����3<�J�8���h�>��=�5�B
1�v�[�D���e�A��IA핑@��s��G�b���kZ�c�W�yR��r}�;6�/L\�`�=�@Bl'�]��P0���JoAf���=�s�U3��ś����vq��0M��Q����� �ݔ�!�+�=�]΢$#��7�R��b���� v >Ӵ�Vu�v���$��*l��Ї�&�+����0�^ |A�]V�<oյ�V�]��,N����+v{Tה�yN	�}[�|��t�G�]�gW-#$/˓(�j3�Ta�X��t�{I������r�O�AB?�Y�Z)-+�V`�k� ��Jws�l6�|�~>_�x�����W��4�P8|#`���D(/d�4L/�~NP���� B���)PT��e�F����<����´ߘ[�#��9���1�O�$ct(�X�J�\����
�.x
��@˟j��6=�'ӸX�x�re(��=/tպ!*HW4�/o��k�@�|�np�.�h[k\� o�%�I�!a�<���
���$�W����Cx�ε�8��<^Do��<KAXڅ�+��o��8u�E�$X�vQ����g���Iz�3��FWk\t���}��s�-�g�t�05��p����H����l��h�a� �҇���Kd���]5��j?�`�8�ЗH�Bq�2kG}�_����l�+��IoN��#x��J�[4�N����.��yS
J	��p���:�T<$WA��<�%R%3�Ւ��U�[`k�. f��k'�;I�q�g?J!�a1�v�d�9�r=�;���r�+p�"B���X�c'=��W~0�y��x;�	`�+�TM�lQ�S���d����A��^ү�a���x�w���ׄ�����Bk6.Ys��go���L�l���Ndq6ұ��4�����U�����6�z=��l%\�Ú�ٺf���a}(�H��c��cp��E`1l���P@�M!��xUY��P��CT��{`�5[ڨ{M�G|�(���7�#�HZ�Wf3�V)�eI�Y���x�I� )��o�L��E�E+} 4�������&��	��"~@!�&U\��8p�.�����r��hf࿪|�W�}��G������_���%�Ys�5G6z����4\c	t:��d�2��-� ?�pZ������t�y}��/`>���f͑vS;-�O���iY8�H��|�2�iz��
r�0�薻3Fp���cȴ�njZs|ƚ��҇��IA($� ��0�*�@Fmז����Q{�I��o*K����"��pF�9�N�v��d�K�f`�b���,��+*��F}�f��V�4�z��zT�*(2& �2c� ݵ=��sxF����>q��H�E�Evz�����C���8�<�P���!�R��$�� �J�"�TY�D�����g@��,K7ā�g������QɱRX�i<�s�a#b�fڲ���2���o�
� ��i�O����x6�(�HM)���U��$19��<�(�W���I�O*�勗�F��S�����4��X�b�����b�۝x��3��	�ۆ�k�'C��"��Ȕ�]�����|���ٵzZ�y!k*���e1d��	e�s�Ođnh�?G���-*X0���=�τO�"��VSk��Xk^	`_�o�O�ƺ.�a�Bw�l[�����R��y�w�O9l<ٝ֙�jc;�[���C�S�=��C�()�=���xɶ���V%�����tX�{k�����w��!�c��v�(�󭤑udz�!}7s�� ���t [�0E��	���V���$��֘>ku�Vw �������U�n�"�J*9 ��]�H�T�� F]��`��N%:�@x�����O9�6��O��[�u�#˝e�'Y*M#dTnP�)J^R�FbiţoUC �֥��e�ђ��ɽ ,�A(A<�	\U\�ġ!"��K>v4w)��'HC�� K
'}�E@��Zc�;m,�A�r��)9�<�(ܢGYJ�-��#*�/����D��5Y#����Z�_W~�����ڞi�R���A�X�>Z2G(�,�w��-�_l�����8�k|zÿUK��B�<�`D,�����<�!�9Ϩ x�g�V�
X�Z;������}ߥ�̠��̹��R��e�P5���ADt�7Հ�$>�#�	�3ch��
��X;� ,'�<{]�y)_���H�y:J�B���%t<)\%����d	����|��Vt�0�g}��Ӣggz��.��_r��g�,U)�J��8J�!	����d6���w�F�$���R�D��u�!2���    ��C�qX��(�j|l�쬣��{l����thρ`{|%�g9P�uXϱYI'�U�p ��op�8��~~6:��'}�N����CI�\����x:SVԀ&a�Xڢ���iG�څ�C\甐�H�i����ֆ�����ޗ�t|˳6|J�ٞg�����7M�7ސ�JZ� Wx����,� ȉ�>>KJ���k�������O�!��c�}��pR�=�!�-�05���R�N�R?��F�H8��=%N�� ��?`�>-��J�yŁ�,ʾd�7�]l	\��}�0]�ݢ{�b��-T�9_㟁f��K	���!����H��'���O�Ȣ�ߥ4���c][��a���I�x�qUkL��ޤ���UD�^���Z{��'�V~�e=���ƅJ���ɀ�w|!��.x�-���)� ���<���%"��V����[��h���4\!��bE�V /���2���c����hq�?ċ�[�+@�_?q*q�>��Z{\c�5_l�A�oR��3)%
"n5U}pUa�HU5RXQ���1�s̗8j~�=�ƽ����8^��5N��l��oi��C�h�Gw2��	E��{��3#C���ۿ��A��x��.ǲGa�uQۅ�p�g��A�k�R�E9��ex��2��D�fQ<����y�^�,@�lVk��ڒ��ߣĿ!��@�E���K���)^�y_׵�DO;`�Z&{��+�����P��M��o��o8�E���6�~<O��>�aH�!6j���8���@�n��u�Z�)T�����*��nϐ�CW%O`�ɼ�g����)���nac������˳��$�@]D뮡6[[��*��j��l�'o�'��X\����_h���1'@C� �;Zo�FeU����3_�k�y�ր ��v}�b��,]QE�`��4D�F��!ZW�T�vH1r^й����һ�����ֹ�C�	�]_j�3*�,o��!\��Tv�����<�kJc�z2����y��O��/�5 �Nӥ>�*�TY'��i�ސ����`^��]���Զ�G�YD�'�>,�*	�<9.)��Q<_�uʭ	l��i�Α�	�����^Q������~��0d#1��,��[��W�=oԴ��
4"�*ʀ��G2�!r@����zT$sdEݑI��-%�j5��	|B��&��R��Q���d�ƕ֩� �~�������|�L�CƩ�o���E�_�*m�� �?=o����J�,���-��n� �s�u�}։�͡L��G�ȣ^0CzJ�l�H��Y�H��	�?Z者؁���L�iB2N_�`�*�_F��T�2��B�L�n�B@C`ʇ>�6����_>�������d}8�~Y�?� 5��7N��Y�<^{�70�*�L.ΤH�Tơ���	_��Ma�o�4f?�)D��"���.��6f@v��uZ��M6�<�G( 	a���¢�!鐨՗]0��mX����X�k[Z�=d����/��[��9d�yo��e�,R��D���Y
$��E<�ik��.w����۽> ΡY�Ȓ��V��e���*AL��U���4�~Y��e$�z�)v|րۺ��N���ա2̏�����H�d�ʁ(�-&
� UB��'_8�/)�(�ہi�h������v��-�
e^�!_m�f��|a"�S�X���П�ъ�h��c�=�����=��鄬�.�Q��C��#���T��\G�.��:��n����s���V�ߦ���q�A<��o����k�h���'�J�]'�q2���"��B�k��8@�=�¢����Î�a�T
_'G,��_D\c���Jj}J�X%�I&�8����<�����`D�d����{�w�����J�P��wv�~� �s���T�C̅(G��x��>y�2|Y( $�͹`��C}�=c�G��dF.~������D�mʶ�[�:�*dR���e���q�xs���2��u'�V@���'���4_���e��5�Ά��Y
i;ܻ��"������:��Ά��g�#_��>��?�c�������Pk\�Y�;w�.U��Cx�Tm��<��Y@Ah�Sx�Y�T�O��j����1��y�~����)�V�[�*�E,ߐu�P���Dd�>�*=��P֌0���~(�f�o�\���G�q=`��C���-���Q����1�r��,���l��,�q'�E\P-!�O���=3lI ĩq�uk����uK����ܞ�ض*���nKzN�,(T$nΗk��~�s����,֭iݫ>��u�X?OB:.�Hް-d�	O:��a ����
2���+��֯�{��Q6��>4�{�uGx�h����*=��uU�8EƆ��A�cJ�d�h�������uGZ���_�B��D����t�I]�Es,ܶ��a�|��6�b��?,cP��y�Oi��u�XlȺ��oLM�� �C1�tL.hZaq��wI�9��J��"�hj���5}v�'F�(�0����3�|7tV	���ɒ-�9eVC�c�R�A��UU|���9e����s�)�L��n7�\4��#Q��y��1=Q��1C�P�!�ىaȂ�s:����'�5J��Sw<�mk��%_�����ky���j��)���*5�yR�B7p'����/���e�s�hgw�u/���!�γفW���K���|��p�.D�5������]?�B��u&SI�~�5Gg�#N	򃳘���A�P��D���n�`(��L�p1������x�N&�˥�7��kO1�{��9�z��։t�D�U���&N]�����ӓ�q-����P��]h��HM�L���G_4o��B(�-l�V�� �/y�bD&��B�U��$��%�a�2~/��.뵴^��,�q~c(��M[YbC0��AE�P���T��BUc\ʇ����}���'��K�:Z�c,p���GƯ���	Η:�%���`�"�[���T_���X�b����+��'��f�@�.y4��jE4�Ó9��c�'����K���B�L!
"����&M�Ĉ�zWZ�z$X���b�@uyX��,9g��ϣ$�������*���}}-���X��^k��8����8"�Z���L��NpOf�I��q58�_�d�;���>���XxL�^�EQ ��Ò�*�qC�\k�Գ�Pi��'�l�Eb��a/��8`�`�]W�O��Cᦨ�;rMW� {|6x=hK�tE���W�zg]�A��|�xݯ�K%��pT�L����j�Kɻ�R�� ���Oפ͆�z0���5,����e)X��Ҡ���fI˕�
��jF+�����t�yF]��ʑ��*2gy��V��0Tc�ଧ�m�.����x����E���N��&!9`'�B�j�ˑb+��:,�6b� C��b�e�C��T�a8��~��"X��]�2�>l��::��-{&M'T�$��Ӌ���T#],�	�S�޼u����Y/�9�>|���X(q�h
� 0�q.�� ̄#�ro�EP~]�'�s��?�?�+�S�#����Q���-�	��;�M����U��|j+�|�M7J�ڑ~��������;jP��4}<4���*���2�+��LW68��ܐ����|#@ԯ`�h����x�D�5.���� j%� ��%"��/)=d��
H �/�n7�^�E���E�7Es�z^Q��L�j��_�ܢ�C�J2��"�}�>��|� *��1�����-N֫�Z�ި~
[�&^($w�[<��X�p��.n@ቺBɈ�׽� 3����~۾_�=��{/��sA����?��_�$^P<�J�X�����#z��d�A��\_��ד�:Ա���8ѐӭ��>�T��"�[Svj4���lO��z8�e\�}��(�ʗ���%�2e^�/�`A��}����]��.�c���^�sy���]�T�Tʖ�K?��i�����ޣy�l����RJU�V��C�?�>�������G#¡l�s����e��	d�G�;�U-l<d/�z]��32"���@    ��O�W|��R� ���eŨ��t�!��ww�*K��P��r�K�w�lhSl���Z�9�S�(;��+Z��ꅔ�C���I��W�D�n4��с��~S�j��{h�~�(N�L����t|��H�xgI��X�h�'��-�z��K#�귰������6��7� >��M�Y�����?Y�O������݀�3n��yW��S�1d��P'�mفO�e��6�{���QN׶em�O��o$@T���Y�Bk��Xc����ۏ)5_h��D�$e \x�`�i�2�%'~xI�ҋ�gd�[�|v�� mm��ק��=Y7� `+SP��i7���Lϔa���.��ޑ��m��g�����)V�%��i�Z����@�������#���!�d>"peb�$Zi�RuC�)�	J��� l1٠���Ȃ�5���k��^2�l3��Gx�X>\�=N�ϩ���|�g4n:����c���&�w]��h �T��jL\��&b�_��Y�.�������2�I�XlP��3��s�_����$��Y��ܺ�.S�m;��z�Έ����_��X�}�V��a��6^Ө �͛5]��|�OԘ�e����Е�w%��*��jm�����E�D�C�yL��lp����ۅe�����HS��	�2E�*����,��,K).c�t t�U#��'%�4�A��'<Β=�Z�%���b���}t�� ��?��=��O�[�#���Պu�O��.�i��K�^K�!���1��|�q � �Atl����T�ΔMW6Ҕ ��U���. ���/qJC�X����m��v�����Pm���C���V�n�Իw d��6��ҁW�n_�Y�m���I՞+�/S�Ʀ��7mדc* ��	Dt\ Ԡw>���"%I��������?�\�ϧE^����Ruܢ&�D�H;��FK5)hV[=�)uz\܊$1u ���[�E��Z?h?���,�"(xV-2e��� [YD'\�X:e��|�➋[���N�|.:-�ުj���T�`�	�M3��!u���Ie:�M;��\������|9j��S|4J&s��oͯ��HfPT��>��tq��F$��3/eЋ֩6�.yڙ�=��(Yخ��[9�m�%���*Vxz]��c�Smؼ�n��]���̔k
��R:|�6N���\[I�{��gæ6��a��V�^�+�LQ�݋fQ�AU�B(�)�	mG��Ai��:��Do/ P'9���6�Xc����C�w�g�6ϢK��f�~,Cڄb�]9��$��]�>�K�w~�F�l�����	)+ ��g�ktB2����E�ob�G���M����Wm]�B���ب�����c�Y_z(���65QN�T���i��3�ӯ)�x�^���1~�����]\�B�<VYF�O�]8
,9��׺���n>������hTAV���^���I�뻬�Юc��U�PS�m��Q���\�@1e�R�d�����cWm4�)��"أ�"Mޞ�uD��W���sy� �}��Jjߟ��>��صV���l]�#�ua�L�QEk���m�S�!P�=�'Q�^M�S�J�#bJ���������@ͺux�E�L�7. �����9�B'$j4Mzߗd�wb8٨������ټ�SGc�Kɡ)�P�#-�P]6)�r��Ÿ;|ڔ����A�S�Z�nz��I��{�E$)���4ũ��3�i��]�QqU����SN١|�u���Ǒ6����Izp ݤ�y�#�~̝<�O��Jh�F���x����8]J��+�uo�³H���zϥ;������_����JJ//g�cJ0a��X�.�D>�E�̾��#1��2p4�gzFqQD@��y���*+~1R���z$���%6|�N�\�>Q�� 
���>I���״Qo%��!M�$M�fYw|	-�}G�/@< t�#L��q�H��N�������u�o&�H�Z�_�ќ�{L^���0uk�+;�F�*²;B�o��>�+4�8�N��` �p�d˸ލ�Wm���/+~&�z���T\ Q�3B�מS�w�AP;��:������ڨጓH)A��`��ە��t�b u����G(�˟��'w1����J~[D#_b"U����<�e�@Z���F�����xNh������E~�B@��C9?O��du_��a>M���d�QZ7d������ѕbXn1��k�	y�Beҳ�����Rz�� �������pv8�8hp=��0E^\�d*K���hl��"�?��*^��0y���х�� �d�����7ǒ=�3Y	2��*���yC֣J����Qi�hPG��J���{�s1�.��/����Cw滆��l4�G��ʰ���~�(�RӖ��j
X���A,[b�|L@�`��N��v���ɛ��@��CVܻ��v	LW4F2+2��eu�.��-� �)d��(��0��Ԙg[�nH���a8����<��T�:�D��al�1��xz4D�q�X�.�7>t��o�D%9]Dc%�\J�-����?C|��@o���cQ�Ŋ���qF�M�~R_5q�{+,��B�CN� �sԗU@�;�&��Q�t<���
v�1~q.~Ȋ����X���,&n�8���o�}��\ �!kҭ*WM�'���`���
�T�&��m�Dit���;���}	zӱ�E�dt`��{dg�L�I�3N��,hV��Ka]`i� ��#���k�}0�?xK�kh$H�u�Z?K���:��d���<��Zh�#����J5њ6��75��<U;n^��wB���I^TFA
^\���2�P��d�;N��}o�޻��؋�v��⊜�!�m����ז%H_�v �+CH GKМpI�`�U��6]v���g5�GM)ھ[_M�f��T���Jmq��l���� "=��T_?\���e|�R�h�� �܁x��[�١{W��W�Ǔ78���ZY�RJ^uJ����If���Xo�eI� T9ni�N���E��אX�
������(V��a�/�y���z"��ӄ��!A]��^��,�t��O������8Hs�}E9l|����T�^��N��8���n�������y����9dt��`������?҇GtcL������X7N��N�Thqv�wߓ�.}E�Y�٘Ռ'�s<^�]�>}����-��ָi��S4��<�~,���I,�E�����e�kȹU�R�/_�=CrW�_&4�}����ƍ6��9�I���x��3���
\�<5��H[Z�t,�U\�M�D°�Ɣ�az��"��[ٸ&�x4��6�]��#�!����g�P��Q�W�Ah�(z����}�y��א����'B�����������ǳ8���rC��B�Ӳ�a�	{����k�#X׌
�S���D��1��=�\M�"�l�<߷.;�� J��/����ЗF!������M7p>W��/�Y!K�XT;�W	��3�˩8���v٪���[�c�4��1��,�9����z�2�Udvw����z/_EmВ.�li��!���o���g��m����{�":��e��n�&����K�(� ��Z�1X�]ִ3(�A�ls`��6l����pl�@�N`y*�Wع�g����i�ˬz#>�F�������6;��.���2˿Y�6}�W�X��S���M7Y��vH>
r/��u�Fp��o��l�-z��.��~���>C0j�a�ퟮ�dZe敾�FVDA7����~!*[�Ɓ%�7���d�����BX犑Sç:��r�|�'�,��@���;���'��$6����vySg�Ot��,}��Q��f�&��2��؉�ST�(XD�z�fIF�5lvy�ջC�gB#�jI�_~�}�����bf��h�J�����o�w�{��OQ"����~�}잲�t��4e�9�ཙOI]ޡPC�YJ}�G�q�>�jW�cvœ��>��L1)�C9
�dߩ�G���o���/��sp�]����o鿻�Yv�Ϙ �  r�����-"��K�L��"N�� 7��Af���:^)�)ݴVz��@��+S���Jӄ�UM�j�E�O96��:0͍�=ƒ�pW&���G~�ǎ��/}�o9i̷�<FO8���|Ē쪩/Gl�Ec��פ��b�#���T��$��B�UT���|ϓ0�q�PvtS�{YN�>�C�8�!ΰ�cWq�N�r���mzBX1�a`�����7r�Բ���\��������l��D?�'����.�fW}�9�&���kY�&ء%�p�mY��e�I�`UZ���=0}�ɚM�rT+�zD6��~۳�I���7G�E��d�+.�A��կ6Q�_Ƌ�;0a�F�U{��[M.�FGo�l��)n^��*��L�����֝��*Ʈ����&0���~>8F�"��g.KG�/�L$�&��P%s%���E8������Gm0jR�!g��2�����q(eV��S��(�"+]��J��}�a�L�����S��_cU�a��Vӷ>�������<�MK(%Y�	��O�x��8&��?h��1�Xm�����+���_7��//Ǥ�����xw�!� ���T�@)0x���t���X�B�F���[�˒��[8���x���q�n��������}��F�YE4! I����D�`���ӕ��yOc6Q�An�ޢ�׮��yt�
H^�C�r�~��}�KX�C"y�]���m"]i�f�E�^l�d�F��qeb�{��uȯ��hO��#M��?�*��      �      x�}[Iv�H�]���(� �KN"$(&)��^8%�� 5HH%�v��E_��bm��pH���|/ ���O�����9�.�w����Ze6�{������F�3[�-/�9F'����T:Ӯ�9l�)6'�[��ە�c��f?�m��2��昘��������~z�.o������N�]�6��q����w�+����Qr����?Ѽf����/������]
�j~,�R7;�{�W?�f[/�׶|�䑞������r��-�6�զ'tG��9�&��^7:m�!�q�K���5�8�_�����������iH��z�̼�?����p���__W�����HN�����*�۩3-~�x�-�7�U/M�EG�_y��V�7L'�F�{�����IzɶYt����ʰ�p^L����a�4[������cJ�IÅ��[�j���x�M���9�R�B�M�
���E#�{K��J]�n'��$���؝����.%GL �\�v��ư��nU��{�Z�	�&�*��s�2�6��m�~���6ud��;w5kT����1;d�� ��V#�6M�(Ǫ_��NJ]��n�Ŀdʸ$�4����',̠Msq���nL�Ȍ�5�N����xj�~5������p�F�n�a��[���O��h5�H�cw�[-����q.��0�����d>I�Q�L����4:=�*���$W�Ε;��3������p֥g�Iv��j���ߠ�2Z����/�7��6s��KPMia��[o�0�?��fe�#�fI�me
�+����a^��E�V�#G�T0]hWƋ?��i�cZ�(=�cj@�1����Zx�rꍟ�| ��˅7�6i�Q��ԍWo|�锕��\�Tj����	:�+���(*?:�o�F��1Gw^�;�
~�a:�ަq�q� �~�υW��u�a=��1�(Ae2
����R@�J/\���y-wf�84�iz�;g�1k�Σ71f�{j�ʄ�q�w�Gp���n�;F �R��F���<
��#�f�6+��W��X怞S�6.���
Mm���Л�qu�;.��i���}zqo�P���/&tsY�mW&4��+�E���^Q��w���:���~B����)6�y��&�cڹ��&z
*ӻ���6�.o	//;&�zeڝ9^�S�_�����w��bb�2��#�����4��2�L�Jw�����Gt�$M�]�5��Q�8�*��~�&!N����wk��v��I��=Eω��Ѡ6��cT��.zcvlV��;���_�]l���̙��UN�D�ǍI�2�R8]ឋ� 5츬O/#`Mz�%�B$\�����bE�t>��pͶ���z���&DT�����������O�P��_�4��h�|��� "��¿�_��/���)*Z1�	������Ԇ}�+��BP<�,�n�]��ܾ��%B���l��f&KAxu��l>�fы(�:�l�+r�2��7Ձx�a�������E�3A��M�6g��\����,�U�+��S�,睉7ψ�7�Z�P�S(ƃA�[.V9��	�� �_�οM	�2��Θ5,������ڜ��<�n�#n�/O&Ns<gso�ϿD���df�9UOY���+����9��<98C;��aѷU����qУ�)�!	�W	g����k����oev1�hw1X� � u*��w-H�.H>]�����|��s�W�,G���Nf#䦽Η7��+w��o�D���EOIR����-�,���q�f���dU�����r�����]�����R06wt5w(�����v �:Nw�������V
M���Ƞ��/�N�*�H�������M��!y5{wj��n�W��D��+K�`̌���������!^����ES����@�O�fZS��$*�[�6��G�W�!f
<6r���*[>�"㺲�1��z���hw�ouO&#F�5�bW�=g����� \�+����ڝ�gE�v�3�7�gE�s���p$���[%��+ou;�S�Ov V�[ϩ~f�D��C ��#�����r�Z;#�@�W4,�,��ƌZ2	�RnS�V��^���Wæ�F�^Y��=���,��>5�Eyh�5a��ĀYa�.!��Yo�wEN:����թ�fe�������x :>�U�6Pe����0>��ޑ(���92��|�eA�fe#߮,��s[��Y�����d�yZ���r�Η\ �i��Kw(9ĸ/�v���K��%b�A��e�7�ֹR�����$(7i,��Pa�rJ\��D4���I�^��t�'�!��"8������IhS� ������,�E�,�� �M	F�l���t���BA,R�2�T����Dr����C��]s�ۙ���	U��Rv0�8\��zt2�*:�,$� >��C���It��?3���ع�1�8w��6&�G���<�p<�B�a0ƨ�a��S���c�M�ZP�dO�@��NJ���1]t~��v�	.�q����Հ�; Tw�\��M^iל]��.�hs�Hƹɡ��:3�A��3�tSS��q�Yb
[t5�?R�^�!Q����"fI(HmeW�85W���U��BX!��c�"�(�3��H>��n�@�H�[�/��!��A�@5I�.��������T�>�En�|�"o]C�B��&�W
��]H�t��Lʐ�C��$E/%g�������f���S�I�>�js�P^�>�A�8ձ�&#ep�C�Z/�=��KM�JzSB�OU����V�2����0,���.Z��zq�dl�}�\�@�Pd�ܱ:G�҂�)1������9fGa���U�>�
A��r Rd�l�.��d��CW�7�@���ˡ=QC�Z\����e4�R�<�,.�I�U���Coq��_�8��op��B'��JF�P��С�3@�*1/HJ��0w$L���ǫ='<:/��1��C���'�Y��=��6']�a�&Ar��R�#|���ē8H(�q�)��]����
0�H�	�K��G�p 8(��͹�"gd��92(�T�rfPrث?J�"�'�/�<qrw��z��\�"(��\`�׿�/�����Ş�c���ȆX��2ښ������9��Mf
1����G X�t���1�32�<e��ms����k�	a|�Ǽ9�k��7�z�� iK��l@�À8�s�����a��˚����<����ˮϟ/�����Q�WZ�<�o�tp͉�0#�<���b�%(T����S,�}�H�>�2`x�n�~h��_��bk��s�dB$S?&���FLl}�aׁM}^��V����w�^�zC����ݝ�i�����`���2�%�M��R7����qt�Lw���Uv!@Q�`����zO*��_۴Я��v�G����̍�f�\{�{��ӠA��$7��i�v���_
�Z�5`S�O��*��.4B�M�x7]�l��ei\$��$>�k2��F/���]�h��F�L��T�����;I���%�u��ޖ��k�p2�u�F �0�a��W��ݴ��QQ`�Qt�6�������ţ�:���n���.QX����W�(0΅mA�,ے�D�?�)O��^L�2��o��hCq�Β@� W<L̯�� B�xE�=L-9��.Q��v��F��S�1|pqŇB��=G��Y��{O���׎%
�7����nk_��uryp��:�F�Lۨ,x�\⠗lf�"8���_��k��^����ʇ*��Ф�Jv�����ͻ����E;Ͽt���D;gZ�"�6���hҿ��@"[�K��l��Mt�u�`Cq��]���I��������u����Ÿ$9�b6�}���O�0�����I���=���4�s:V����B0�cbX1��L_�Bs*�
GA`�����{�6l���O@O�nC̼��3{bv�1.�6;�ev΄`⺰���!k��z3{���/��7�>�Nʘpk9+@�����U�'�o	����\x�� +  ���m��I�L��AD� 	8,W��c����ʥ)@-�S�3�D��~F�p���R�5R�?Jd��Q~�F�V�b�$�����QvC_��/���yƾ��.;��&9�TD���j�١p�+� o�f�k�'%aҝ9B��	�	okaJ�E\Y"^D7Z�������ge>�>����x<��`3D#`��f,�S�3�F���D�`�2��}F�!��iȻ�Y��D�?�"�<�C�d.�7J��t/�~�<t����<4<�0Z��O��\<�`���g�nab�HVw�va�[�	�4t6}u��q>��Hn�7Sg�@�EZ^������<}����-[��&sP�<\H0K�%��Zl\u(������<F����De|��`�����C�^����oʇ��Z ���qn(�\��"B�v�]vQz��<��z�$��,���{j"���;��3C�A��ލ�kpgaA�XKZ���]�V�ӚƲ���mE2��;'B��w���
������g~�=#���B�����18[?!��{P���#�W�βy�����!���d��@ ����\�cOCt���0�o��=��G���f�5���	��N�ͺ�(���J.��Q�(B$O⭝��v?W:���5��S.>T���N�X�� M\T�-Aߛ4�=;�.񗟱*6�*@�b��@uq�B������B;�v" �����6��)�fT���/��Q��|�ςB�����/@e>�Z�z�"vh�ȡRgVe#�ɞz���5Y�扄>���d�D{�O��5?'fwqf�[S>+Ԓ��R���LRQtk�u邞���*WT�:2tDlO���%�ͣ)�}3��ݙ.�~�%QLE�%[#�[�~JNzQb(���d?NBR��P�k��CsE�:m��B�ho�GAN"ҟ<�5��Xd��b,%�@h�"��"3G���1�3�t���$c.;�Ě����=��+�a|0�XJ�d^�u��e����,�0�GtE<���Os��,�>������ݘc�����y��8�n��(�C6��FZ"KK�ɪ��_�bi-�X�IgUJRQ�(��9�+bA���zX�Vc>B�]���%%��Ѡ�:�O�$�_>�,H�Ͷ	��7��h�ʏ�**�r���	�b�%`e�h^Qv�*��׳l��p���d��d]�V>KG��ן� �l:nς-�k��Wb��&ʮ2�]�	b�at�)�a��h� �\��
�;�*�Fc�f!�&�,N�X������*�\DmH�+�H:[�W�uZ��1�i�Ƌn��yh2Wd�f���]�b�>��zj�|H=�X;Y���N�$������0�ϡ�5pB3�� ��2�0h�����0�.�\�A�t���+9b[WaS�K���'_�z�f�\�}r�6Y�L�F�W�$=a��,^r�d�|�!`�LTx,<�/d�!=�$��$F�,@=F�m��Ue��f�n��Y:|]�N���Y�k���ɀx�F�D{su���&��ZQ��dg�y4��|&�.����q�l'�ӓ����+�>զ�߃5�m�D�r��꜑� ��S���v���
�,���9���E�K�����%1�#*f�PE�燎kz��pi��|rgߞv,1-̓񉺼7��}뢑�*���)�Y�݂'K�������Q�2sM�� E�S�k����ӐlŦ����Ct�k�,�=k�?AoM�� I�d��}�i�x��tC�Sp*Cy�h�t!�=�0_:�-|.<��+`",3�l��u�G���� S����h�����LTDwJ  �u�`d@ud��L�`^�Deǳ��Z����*
+����Y��D�6�ye��tV,{��f����ٺ�QD�a��crLc�e�����+ԑo��d�˻��k�I�F�
�*ZuN*"q�I�x1�����or&Vct<��������H·E�cF�|H�W4s�F60�����O�Ӷ�<Ju�x�+�Q�A*
�>�!�l��*���L��	|;��a���<?�a
*-y�*:����N�:{B���II�^x�L0�\v�8�e
�quH�)��,�-�eYT�g��]�@�3J`���!Φ�.;spɣ|��A���2����{v�]��aW%|�&�R�����|��Q?�q�~���댳���ޅ���e�!>P ���A	0�9��w�\- z�@m���X�溵�3�3{����#�{��Z�s����N|�Mr ���*9P$ɭ-z���6uF�av�cEM�7|�"�:��T���K�
�!�Px�yh�ƥO��t��.�%VL�/y��lʡl�45?�g��"����$#`Q��ct2r�C��p��!����5#�1��'�H��)�/-$FkZN�0V4HQ�:�@ҞyI�WƦ~�fR���t��g,�T�Q�Ђ��v45'����/J�7Z�g�+���:�]���I7�8�̵�M0��E ��e�@�¹��r�s�{���Z,+[Ʋ�]�H&{;�ld�����@0>p�fϗΦZW@Lҟ̌*�B���YM�R�L&#��8+�V���44�"���t�f_�4֤_��Ҩk���hS�! �H|��d��E�+HC�U�^Lɶ.�3�%ֺ���$t�����W�X�7
\=�s!E
�e�vW��D��0��&�=�╭}`EC닌��ϭ�yk�IV��zeY���iqԂ���Y��k�'*u�]f�{��&�Q�'"ATmoG���47i��F�W�P��d����ڃ"�>�A�������Tl��O�jz0�Y�����}~5�`Q��L��ϵ��V��.�bG�Q�I���JwI������g�
]BJ��|=�Khu2��z�8rp�8ݓ�)�[AgY�U���&�-��{��&��Lv\���T=.�Yʅ����(��v��Wλ���)%!��U��+��85���L����m��0�z��&2�ʯ�A��
�*7���k�,�$�gyF���!Κ�vk��<�%�"��a-)�ɛ�w��:4یVMA���k��=���;Z��h��]�e��V'�_�˟f��I�{˿��'��nbqJ>�L#Z'�uq��i�3a�����|lk�d�`+�y�%�B0t�W7��ˣ�sf[4�]�g�U�A"�A�8�6�Yw���O"���mN
n��L$�*�D�Ҡ���W�˳��ҕp�W71M.�^�'p5L�P�N�B�.D�Ė+i >I�@v���Ν.�X�?�t/G��E�n��Dh:��k�|T%(�+�vY���Ex��y�/y�ԗ��Z;���eM��$����J��R���      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     