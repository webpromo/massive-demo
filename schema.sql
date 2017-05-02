-- Create an affectedAreas table
CREATE TABLE affectedAreas
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40)
);

INSERT INTO affectedAreas (id, name) VALUES (1, 'Groin');
INSERT INTO affectedAreas (id, name) VALUES (2, 'Neck');
INSERT INTO affectedAreas (id, name) VALUES (3, 'Leg');
INSERT INTO affectedAreas (id, name) VALUES (4, 'Foot');
INSERT INTO affectedAreas (id, name) VALUES (5, 'Head');
INSERT INTO affectedAreas (id, name) VALUES (6, 'Hand');
INSERT INTO affectedAreas (id, name) VALUES (7, 'Wrist');
INSERT INTO affectedAreas (id, name) VALUES (8, 'Ankle');
INSERT INTO affectedAreas (id, name) VALUES (9, 'Elbow');

-- Recreate our data from yesterday
CREATE TABLE injuries
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40),
  description TEXT,
  tth INTEGER,
  affectedAreaId INTEGER REFERENCES affectedAreas
);

INSERT INTO injuries (id, name, description, tth) VALUES (1, 'Pulled Groin', 'Results from putting too much stress on muscles in your groin and thigh.', 2);
INSERT INTO injuries (id, name, description, tth) VALUES (2, 'Cervical Radiculopathy', 'Pinched nerve.', 6);
INSERT INTO injuries (id, name, description, tth) VALUES (3, 'Herniated Disc', 'Soft substance on the inside of the disc (nucleus pulposi) is pushed out', 12);
INSERT INTO injuries (id, name, description, tth) VALUES (4, 'Femur Fracture', 'Bone fracture.', 8);
INSERT INTO injuries (id, name, description, tth) VALUES (5, 'Shattered Toenail', '20 percent of the US population suffers from onychorrhexis.', 3);
INSERT INTO injuries (id, name, description, tth) VALUES (6, 'Nintendo Thumb', 'Painful affliction of opposable digits.', 1);
INSERT INTO injuries (id, name, description, tth) VALUES (7, 'Amnesia', null, 1);
INSERT INTO injuries (id, name, description, tth) VALUES (8, 'Pulled Muscle', 'Results from putting too much stress on any muscles.', 2);

-- Update the existing injuries
UPDATE injuries SET affectedAreaId = 1 WHERE id = 1;
UPDATE injuries SET affectedAreaId = 2 WHERE id = 2;
UPDATE injuries SET affectedAreaId = 2 WHERE id = 3;
UPDATE injuries SET affectedAreaId = 3 WHERE id = 4;
UPDATE injuries SET affectedAreaId = 4 WHERE id = 5;
UPDATE injuries SET affectedAreaId = 6 WHERE id = 6;
UPDATE injuries SET affectedAreaId = 6 WHERE id = 7;
UPDATE injuries SET affectedAreaId = 1 WHERE id = 8;

CREATE TABLE causes
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40)
);

INSERT INTO causes (id, name) VALUES (1, 'Exploding poached egg');
INSERT INTO causes (id, name) VALUES (2, 'Sneezing');
INSERT INTO causes (id, name) VALUES (3, 'Legend of Zelda');
INSERT INTO causes (id, name) VALUES (4, 'Aerosol can');
INSERT INTO causes (id, name) VALUES (5, 'Superglue');
INSERT INTO causes (id, name) VALUES (6, 'Diving');
INSERT INTO causes (id, name) VALUES (7, 'Snapping a carrot');

CREATE TABLE incidents
(
  id SERIAL PRIMARY KEY,
  usState VARCHAR(2),
  injuryId INTEGER REFERENCES injuries,
  causeId INTEGER REFERENCES causes
);

INSERT INTO incidents (usState, injuryId, causeId) VALUES ('VT', 1, 2);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('CT', 5, 3);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('MA', 5, 7);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('AK', 6, 2);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('CA', 3, 5);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('NY', 2, 5);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('WY', 1, 1);
INSERT INTO incidents (usState, injuryId, causeId) VALUES ('NY', 1, 6);
