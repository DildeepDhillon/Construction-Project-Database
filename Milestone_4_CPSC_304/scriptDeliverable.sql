DROP TABLE newspaper;
DROP TABLE billboard;
DROP TABLE youtube;
DROP TABLE markets;
DROP TABLE advertisement;
DROP TABLE project_manager;
DROP TABLE invested;
DROP TABLE hires;
DROP TABLE employs;
DROP TABLE owner;
DROP TABLE institution;
DROP TABLE investor;
DROP TABLE architect;
DROP TABLE worked_for;
DROP TABLE subcontractor;
DROP TABLE general_contractor;
DROP TABLE project;
DROP TABLE municipality;
DROP TABLE developer;



CREATE TABLE advertisement (
    companyname VARCHAR(50) PRIMARY KEY
);

GRANT SELECT ON advertisement TO PUBLIC;

CREATE TABLE newspaper(
    companyname VARCHAR(50) PRIMARY KEY,
    pagenumber INT,
    FOREIGN KEY (companyname) REFERENCES advertisement ON DELETE CASCADE
);

GRANT SELECT ON newspaper TO PUBLIC;

CREATE TABLE billboard (
    companyname VARCHAR(50),
    billboardlocation VARCHAR(30), -- Changed name since location was not allowed
    billboardsize INT, -- Changed name since size was not allowed
    PRIMARY KEY (companyname),
    FOREIGN KEY (companyname) REFERENCES advertisement ON DELETE CASCADE
);

GRANT SELECT ON billboard TO PUBLIC;

CREATE TABLE youtube (
    companyname VARCHAR(50),
    canskip CHAR(1), -- Oracle doesnt support boolean so use 1 == true, 0 == false
    adlength INT,
    PRIMARY KEY (companyname),
    FOREIGN KEY (companyname) REFERENCES advertisement ON DELETE CASCADE
);

GRANT SELECT ON youtube TO PUBLIC;

CREATE TABLE municipality (
    city VARCHAR(50) PRIMARY KEY
);

GRANT SELECT ON municipality TO PUBLIC;

CREATE TABLE developer (
    license_number INT PRIMARY KEY,
    developername varchar(50), -- Changed name to make it work
    phone_number INT
);

GRANT SELECT ON developer TO PUBLIC;

CREATE TABLE project (
    project_id INT PRIMARY KEY,
    site_address VARCHAR(50) UNIQUE,
    budget INT,
    deadline VARCHAR(30),
    city VARCHAR(50),
    permit_number INT UNIQUE,
    license_number INT,
    FOREIGN KEY (license_number) REFERENCES developer ON DELETE CASCADE,
    FOREIGN KEY (city) REFERENCES municipality ON DELETE CASCADE
);

GRANT SELECT ON project TO PUBLIC;

CREATE TABLE markets (
    project_id INT,
    companyname VARCHAR(50),
    cost INT,
    PRIMARY KEY (project_id, companyname),
    FOREIGN KEY (project_id) REFERENCES project ON DELETE CASCADE,
    FOREIGN KEY (companyname) REFERENCES advertisement ON DELETE CASCADE
);

GRANT SELECT ON markets TO PUBLIC;

CREATE TABLE investor (
    investorname VARCHAR(50), -- Changed name or wouldnt work
    PRIMARY KEY (investorname)
);

GRANT SELECT ON investor TO PUBLIC;

CREATE TABLE owner (
    ownername varchar(50), -- Changed name or wouldnt work
    percentage_owned INT,
    is_majority_owner CHAR(1), -- Oracle doesnt support so use 1 == true and 0 == false
    PRIMARY KEY (ownername),
    FOREIGN KEY (ownername) REFERENCES investor ON DELETE CASCADE
);

GRANT SELECT ON owner TO PUBLIC;

CREATE TABLE institution (
    institutionname varchar(50),
    interest_rate DECIMAL(4,2),
    prime_rate DECIMAL(4,2),
    location varchar(50),
    PRIMARY KEY (institutionname),
    FOREIGN KEY (institutionname) REFERENCES investor ON DELETE CASCADE
);

GRANT SELECT ON institution TO PUBLIC;

CREATE TABLE project_manager (
    companyname VARCHAR(50),
    managername VARCHAR(50), -- Changed name to make it work
    project_id INT,
    PRIMARY KEY (companyname, managername),
    FOREIGN KEY (project_id) REFERENCES project ON DELETE CASCADE
);

GRANT SELECT ON project_manager TO PUBLIC;

CREATE TABLE invested (
    project_id INT,
    investorname VARCHAR(50),
    amount INT,
    PRIMARY KEY (project_id, investorname),
    FOREIGN KEY (project_id) REFERENCES project ON DELETE CASCADE,
    FOREIGN KEY (investorname) REFERENCES investor ON DELETE CASCADE
);

GRANT SELECT ON invested TO PUBLIC;

CREATE TABLE architect (
    companyname VARCHAR(50),
    phone_number INT,
    city VARCHAR(50),
    house_number VARCHAR(5),
    street_name VARCHAR(50),
    postal_code CHAR(7),
    province VARCHAR(50),
    PRIMARY KEY (companyname)
);

GRANT SELECT ON architect TO PUBLIC;

CREATE TABLE hires (
    license_number INT,
    companyname VARCHAR(50) NOT NULL,
    cost INT,
    PRIMARY KEY (license_number),
    FOREIGN KEY (companyname) REFERENCES architect ON DELETE CASCADE,
    FOREIGN KEY (license_number) REFERENCES developer ON DELETE CASCADE
);

GRANT SELECT ON hires TO PUBLIC;

CREATE TABLE subcontractor (
    companyname VARCHAR(50),
    phone_number INT,
    type VARCHAR(50),
    city VARCHAR(50),
    house_number VARCHAR(25),
    street_name VARCHAR(50),
    postal_code CHAR(7),
    province VARCHAR(50),
    PRIMARY KEY (companyname)
);

GRANT SELECT ON subcontractor TO PUBLIC;

CREATE TABLE general_contractor (
    companyname VARCHAR(50),
    phone_number INT,
    city VARCHAR(50),
    house_number VARCHAR(25),
    street_name VARCHAR(50),
    postal_code CHAR(7),
    province VARCHAR(50),
    PRIMARY KEY (companyname)
);

GRANT SELECT ON general_contractor TO PUBLIC;

CREATE TABLE worked_for (
    subcontractor_name VARCHAR(50),
    general_contractor_name VARCHAR(50),
    hours_worked INT,
    cost INT,
    PRIMARY KEY (subcontractor_name, general_contractor_name),
    FOREIGN KEY (subcontractor_name) REFERENCES subcontractor ON DELETE CASCADE,
    FOREIGN KEY (general_contractor_name) REFERENCES general_contractor ON DELETE CASCADE
);

GRANT SELECT ON worked_for TO PUBLIC;

CREATE TABLE employs (
    companyname VARCHAR(50),
    license_number INT,
    cost INT,
    PRIMARY KEY (companyname, license_number),
    FOREIGN KEY (companyname) REFERENCES general_contractor ON DELETE CASCADE,
    FOREIGN KEY (license_number) REFERENCES developer ON DELETE CASCADE
);

GRANT SELECT ON employs TO PUBLIC;

INSERT INTO advertisement VALUES ('Captivate Ads');
INSERT INTO advertisement VALUES ('Buzzworthy Studios');
INSERT INTO advertisement VALUES ('Click Marketing');
INSERT INTO advertisement VALUES ('Ad Blitz Inc');
INSERT INTO advertisement VALUES ('Vancouver Marketing');

INSERT INTO newspaper VALUES ('Captivate Ads', 3);
INSERT INTO newspaper VALUES ('Buzzworthy Studios', 5);
INSERT INTO newspaper VALUES ('Click Marketing', 1);
INSERT INTO newspaper VALUES ('Ad Blitz Inc', 2);
INSERT INTO newspaper VALUES ('Vancouver Marketing', 4);

INSERT INTO billboard VALUES ('Captivate Ads', 'Times Square', 10);
INSERT INTO billboard VALUES ('Buzzworthy Studios', 'Shibuya Crossing', 15);
INSERT INTO billboard VALUES ('Click Marketing', 'Piccadilly Circus', 8);
INSERT INTO billboard VALUES ('Ad Blitz Inc', 'Hollywood Walk of Fame', 12);
INSERT INTO billboard VALUES ('Vancouver Marketing', 'Las Vegas Strip', 50);

INSERT INTO youtube VALUES ('Captivate Ads', '1', 30);
INSERT INTO youtube VALUES ('Buzzworthy Studios', '1', 60);
INSERT INTO youtube VALUES ('Click Marketing', '0', 150);
INSERT INTO youtube VALUES ('Ad Blitz Inc', '1', 45);
INSERT INTO youtube VALUES ('Vancouver Marketing', '0', 90);

INSERT INTO municipality VALUES ('Surrey');
INSERT INTO municipality VALUES ('Vancouver');
INSERT INTO municipality VALUES ('Richmond');
INSERT INTO municipality VALUES ('Delta');
INSERT INTO municipality VALUES ('Langley');

INSERT INTO developer VALUES (789012, 'Quick Construction Company', 6045892387);
INSERT INTO developer VALUES (345678, 'Ace Construction Ltd', 7783924829);
INSERT INTO developer VALUES (123456, 'SeaShore Builders Ltd', 2363930498);
INSERT INTO developer VALUES (234567, 'Pacific Development Ltd', 7788903848);
INSERT INTO developer VALUES (948379, 'Fraser Property Group', 6040593968);

INSERT INTO project VALUES (1, '123 St', 900000, '22/April/2025', 'Surrey', 12345, 789012);
INSERT INTO project VALUES (2, '456 St', 34567456,'30/May/2029', 'Vancouver', 23456, 345678);
INSERT INTO project VALUES (3, '789 St', 9003000, '14/December/2024', 'Richmond', 34567, 123456);
INSERT INTO project VALUES (4, '321 St', 7890678, '07/March/2026', 'Delta', 45678, 234567);
INSERT INTO project VALUES (5, '654 St', 2345234, '28/June/2027', 'Langley', 56789, 948379);

INSERT INTO markets (project_id, companyname, cost) VALUES (1, 'Captivate Ads', 100000);
INSERT INTO markets (project_id, companyname, cost) VALUES (2, 'Buzzworthy Studios', 80000);
INSERT INTO markets (project_id, companyname, cost) VALUES (3, 'Click Marketing', 150000);
INSERT INTO markets (project_id, companyname, cost) VALUES (4, 'Ad Blitz Inc', 70000);
INSERT INTO markets (project_id, companyname, cost) VALUES (5, 'Vancouver Marketing', 500000);

INSERT INTO investor VALUES ('John Doe');
INSERT INTO investor VALUES ('Jane Smith');
INSERT INTO investor VALUES ('Michael Brown');
INSERT INTO investor VALUES ('Alice Garcia');
INSERT INTO investor VALUES ('David Miller');
INSERT INTO investor VALUES ('Bank of Montreal');
INSERT INTO investor VALUES ('Royal Bank of Canada');
INSERT INTO investor VALUES ('Toronto-Dominion Bank');
INSERT INTO investor VALUES ('Scotiabank');
INSERT INTO investor VALUES ('CIBC');

INSERT INTO invested VALUES (1, 'John Doe', 10000);
INSERT INTO invested VALUES (2, 'Jane Smith', 29504);
INSERT INTO invested VALUES (3, 'Michael Brown', 79036);
INSERT INTO invested VALUES (4, 'Alice Garcia', 65832);
INSERT INTO invested VALUES (5, 'David Miller', 75639);
INSERT INTO invested VALUES (1, 'Bank of Montreal', 368439);
INSERT INTO invested VALUES (2, 'Royal Bank of Canada', 753958);
INSERT INTO invested VALUES (3, 'Toronto-Dominion Bank', 782385);
INSERT INTO invested VALUES (4, 'Scotiabank', 890479);
INSERT INTO invested VALUES (5, 'CIBC', 670238);

INSERT INTO owner VALUES ('John Doe', 51, '1');
INSERT INTO owner VALUES ('Jane Smith', 50, '0');
INSERT INTO owner VALUES ('Michael Brown', 15, '0');
INSERT INTO owner VALUES ('Alice Garcia', 10, '0');
INSERT INTO owner VALUES ('David Miller', 4, '0');

INSERT INTO institution VALUES ('Bank of Montreal', 0.05, 0.03, 'Surrey, British Columbia');
INSERT INTO institution VALUES ('Royal Bank of Canada', 0.06, 0.04, 'Surrey, British Columbia');
INSERT INTO institution VALUES ('Toronto-Dominion Bank', 0.07, 0.05, 'Surrey, British Columbia');
INSERT INTO institution VALUES ('Scotiabank', 0.08, 0.06, 'Surrey, British Columbia');
INSERT INTO institution VALUES ('CIBC', 0.09, 0.07, 'Surrey, British Columbia');

INSERT INTO project_manager VALUES ('Apex Blueprint', 'Jane Smith', 1);
INSERT INTO project_manager VALUES ('Keystone Construction Solutions', 'Alex Yu', 1);
INSERT INTO project_manager VALUES ('Hammerhead Horizon', 'Bob Thomas', 1);
INSERT INTO project_manager VALUES ('Steadfast Structures', 'Olivia Jones', 1);
INSERT INTO project_manager VALUES ('Bridgeway Builders', 'Ethan Garcia', 1);

INSERT INTO general_contractor VALUES ('Turner Construction Company', 6046784689, 'Surrey', '2654', 'King George Hwy', 'V3W 4E3', 'BC');
INSERT INTO general_contractor VALUES ('Other Construction Company', 7784597853, 'Langley', '13483', '72 Ave', 'V3W 2N7', 'BC');
INSERT INTO general_contractor VALUES ('Another Construction Company', 2368734829, 'Richmond', '10688', 'No 6 Rd', 'V6W 1E7', 'BC');
INSERT INTO general_contractor VALUES ('One More Construction Company', 6048925930, 'Richmond', '8640', 'Alexandra Rd', 'V6X 4K6', 'BC');
INSERT INTO general_contractor VALUES ('Last Construction Company', 6048925930, 'Richmond', '7188', 'Westminister Hwy', 'V6X 1A1', 'BC');

INSERT INTO employs VALUES ('Turner Construction Company', 789012, 10000000);
INSERT INTO employs VALUES ('Other Construction Company', 345678, 8000000);
INSERT INTO employs VALUES ('Another Construction Company', 123456, 12000000);
INSERT INTO employs VALUES ('One More Construction Company', 234567, 9000000);
INSERT INTO employs VALUES ('Last Construction Company', 948379, 15000000);

INSERT INTO subcontractor VALUES ('ABC Electrical Inc.', 2223334444, 'Electrical', 'Surrey', '100', 'King George Blvd', 'V3T 2V6', 'British Columbia');
INSERT INTO subcontractor VALUES ('DEF Plumbing Ltd.', 3334445555, 'Plumbing', 'Burnaby', '200', 'Imperial Street', 'V5H 1Y9', 'British Columbia');
INSERT INTO subcontractor VALUES ('GHI Mechanical Inc.', 4445556666, 'Mechanical', 'Richmond', '300', 'Cambie Road', 'V6X 2G1', 'British Columbia');
INSERT INTO subcontractor VALUES ('JKL Construction Ltd.', 5556667777, 'Construction', 'Delta', '400', 'Nordel Way', 'V4G 1L2', 'British Columbia');
INSERT INTO subcontractor VALUES ('MNO Finishing Inc.', 6667778888, 'Finishing', 'Langley', '500', 'Fraser Highway', 'V1M 2G6', 'British Columbia');

INSERT INTO worked_for VALUES ('ABC Electrical Inc.', 'Turner Construction Company', 2000, 500000);
INSERT INTO worked_for VALUES ('DEF Plumbing Ltd.', 'Other Construction Company', 1500, 300000);
INSERT INTO worked_for VALUES ('GHI Mechanical Inc.', 'Another Construction Company', 2500, 600000);
INSERT INTO worked_for VALUES ('JKL Construction Ltd.', 'One More Construction Company', 1800, 450000);
INSERT INTO worked_for VALUES ('MNO Finishing Inc.', 'Last Construction Company', 3000, 750000);

INSERT INTO architect VALUES ('Zaha Hadid Architects', 6048792857, 'Surrey', '14310', '64 Ave', 'V3W 1Z1', 'BC');
INSERT INTO architect VALUES ('Gensler', 7789085432, 'Surrey', '12822', '16 Ave', 'V4A 1N4', 'BC');
INSERT INTO architect VALUES ('Arup', 2368956734, 'Surrey', '1681', '152 St', 'V4A 4N3', 'BC');
INSERT INTO architect VALUES ('Astonish Designs', 6045873982, 'Surrey', '14752', '108A Ave', 'V3R 1W8', 'BC');
INSERT INTO architect VALUES ('BIG - Bjarke Ingels Group', 7783467923, 'Surrey', '1677', '128st', 'V4A 3V2', 'BC');

INSERT INTO hires VALUES (789012, 'Zaha Hadid Architects', 2000);
INSERT INTO hires VALUES (345678, 'Gensler', 1500);
INSERT INTO hires VALUES (123456, 'Arup', 2500);
INSERT INTO hires VALUES (234567, 'Astonish Designs', 1800);
INSERT INTO hires VALUES (948379, 'BIG - Bjarke Ingels Group', 3000);


