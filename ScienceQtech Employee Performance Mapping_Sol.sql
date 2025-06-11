
CREATE DATABASE employee;
USE employee;

# QUESTION 3
SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT
FROM 
    emp_record_table;

# QUESTION 4
SELECT 
    EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM 
    emp_record_table
WHERE 
    EMP_RATING < 2;
SELECT 
    EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM 
    emp_record_table
WHERE 
    EMP_RATING BETWEEN 2 AND 4;
SELECT 
    EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM 
    emp_record_table
WHERE 
    EMP_RATING > 4;

# QUESTION 5
SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,DEPT
FROM 
    emp_record_table
WHERE 
    DEPT = 'Finance';

# QUESTION 6
SELECT 
    m.EMP_ID,
    concat(m.FIRST_NAME,' ',
    m.LAST_NAME) as 'FullName',
    COUNT(e.EMP_ID) AS NUM_REPORTERS
FROM 
    emp_record_table m
JOIN 
    emp_record_table e ON m.EMP_ID = e.MANAGER_ID
GROUP BY 
    m.EMP_ID, m.FIRST_NAME, m.LAST_NAME;

# QUESTION 7
SELECT 
    EMP_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'FullName',
    DEPT
FROM
    emp_record_table
WHERE
    DEPT = 'Healthcare' 
UNION SELECT 
    EMP_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'FullName',
    DEPT
FROM
    emp_record_table
WHERE
    DEPT = 'Finance';
    
# QUESTION 8
SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    EMP_RATING,
    MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_DEPT_RATING
FROM 
    emp_record_table;

# QUESTION 9
SELECT 
    ROLE,
    SALARY,
    MIN(SALARY) OVER (PARTITION BY ROLE) AS MIN_SALARY,
    MAX(SALARY) OVER (PARTITION BY ROLE) AS MAX_SALARY
FROM 
    emp_record_table;

# QUESTION 10
SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,  
    dense_rank() OVER (ORDER BY EXP DESC) AS EXPERIENCE_RANK
FROM 
    emp_record_table;
    
  # QUESTION 11
  
  CREATE VIEW High_salary_Employee AS
    SELECT 
        EMP_ID,
        CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'Name',
        COUNTRY,
        SALARY
    FROM
        emp_record_table
    WHERE
        SALARY > 6000;
SELECT 
    *
FROM
    High_salary_Employee;

# QUESTION 12
SELECT 
    *
FROM
    emp_record_table
WHERE
    EXP > (SELECT 10)

# QUESTION 13
DELIMITER //

CREATE PROCEDURE ExperiencedEmployees()
BEGIN
    SELECT EMP_ID, concat(FIRST_NAME,' ',LAST_NAME) as 'Name', EXP
    FROM emp_record_table
    WHERE (EXP) > 3;
END //

DELIMITER ;
CALL ExperiencedEmployees();

# QUESTION 14
 DELIMITER $$

CREATE FUNCTION get_standard_role(EXP INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE role VARCHAR(50);
    
    IF EXP <= 2 THEN
        SET role = 'JUNIOR DATA SCIENTIST';
    ELSEIF EXP > 2 AND exp <= 5 THEN
        SET role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF EXP > 5 AND exp <= 10 THEN
        SET role = 'SENIOR DATA SCIENTIST';
    ELSEIF EXP > 10 AND exp <= 12 THEN
        SET role = 'LEAD DATA SCIENTIST';
    ELSEIF EXP > 12 AND exp <= 16 THEN
        SET role = 'MANAGER';
    ELSE
        SET role = 'OTHER';
    END IF;

    RETURN role;
END$$

DELIMITER ;
SELECT EMP_ID, EXP, ROLE, get_standard_role(EXP) AS expected_role
FROM data_science_team
WHERE ROLE = get_standard_role(EXP);

# QUESTION 15
use employee;
CREATE INDEX idx_first_name ON emp_record_table(FIRST_NAME(100));
SELECT 
    EMP_ID, FIRST_NAME
FROM
    employee.emp_record_table
WHERE
    FIRST_NAME = 'Eric';

# QUESTION 16
SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    EMP_RATING,
    (0.05 * SALARY * EMP_RATING) AS bonus
FROM
    emp_record_table;

# QUESTION 17
SELECT 
    CONTINENT, COUNTRY, AVG(SALARY) AS average_salary
FROM
    emp_record_table
GROUP BY CONTINENT , COUNTRY
ORDER BY average_salary DESC;


