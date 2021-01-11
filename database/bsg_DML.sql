-- ":" used to denote variables that will be input by the user

/********************************************************
Certifications
********************************************************/
-- used in the certification page to display all Certifications
-- used in the people page to populate the certs in the people filter
-- and the form to add new people
SELECT * FROM bsg_cert;

-- used in the certification page to add new Certifications
INSERT INTO bsg_cert(title) values (:certname);

/********************************************************
People Page
********************************************************/
-- used in the people page to diaplay the certifications in the
-- filter dropdown, and certifications in the add new person form
SELECT id, title FROM bsg_cert;

--used in the people page to display a list of filtered people by a
--given credential
SELECT p.id, fname, lname, homeworld, age FROM bsg_people p INNER JOIN bsg_cert_people cp ON cp.pid = p.id INNER JOIN bsg_cert c ON c.id = cp.cid WHERE c.id = (:cert_id)

-- ******************** CRUD ***************************
-- C(reate):
-- Used in the add new person form to add new person
INSERT INTO bsg_people (fname, lname, homeworld, age) VALUES (:fname_input, :lname_input, :homeworld_input, :age_input);
-- For each selected certificate in the add new person form, we add a new
-- row to the intersection table (M:M relationship between people and certificates)
-- Note: This is also used when updating a person
INSERT into bsg_cert_people (cid, pid) VALUES (:certificate_id, :person_id);

-- R(ead):
-- used to display all the people
SELECT id, fname, lname, homeworld, age FROM bsg_people;

-- U(pdate)
-- See below
-- used to update a person, information passed from an update form

-- D(elete):
-- used to delete a person, person_id is passed in the URL route
-- because of the fk constraint, we must delete the corresponding
-- rows of the intersection table first
-- Note: We also do this when updating a person
DELETE FROM bsg_cert_people WHERE pid = (:person_id);
DELETE FROM bsg_cert_people WHERE pid = (:person_id);

/********************************************************
Update People Page
********************************************************/
-- Used to preselect the form with the selected person's existing certificates
SELECT cid FROM bsg_cert_people WHERE pid = (:person_id)

-- U(pdate)
-- See below
-- used to update a person, information passed from an update form
UPDATE bsg_people SET fname = (:fname_input), lname = (:lname_input), homeworld = (:homeworld_input), age = (:age_input) WHERE id = (:person_id)
