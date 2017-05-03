-- Create an affectedAreas table
CREATE TABLE affectedAreas
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE
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
  name VARCHAR(40) NOT NULL UNIQUE,
  description TEXT,
  tth INTEGER NOT NULL,
  affectedAreaId INTEGER REFERENCES affectedAreas NOT NULL
);

INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (1, 'Pulled Groin', 'Results from putting too much stress on muscles in your groin and thigh.', 2, 1);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (2, 'Cervical Radiculopathy', 'Pinched nerve.', 6, 2);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (3, 'Herniated Disc', 'Soft substance on the inside of the disc (nucleus pulposi) is pushed out', 12, 2);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (4, 'Femur Fracture', 'Bone fracture.', 8, 3);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (5, 'Shattered Toenail', '20 percent of the US population suffers from onychorrhexis.', 3, 4);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (6, 'Nintendo Thumb', 'Painful affliction of opposable digits.', 1, 6);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (7, 'Amnesia', null, 1, 6);
INSERT INTO injuries (id, name, description, tth, affectedAreaId) VALUES (8, 'Pulled Muscle', 'Results from putting too much stress on any muscles.', 2, 1);

CREATE TABLE causes
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE
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
  state VARCHAR(2) NOT NULL,
  injuryId INTEGER REFERENCES injuries NOT NULL,
  causeId INTEGER REFERENCES causes NOT NULL
);

INSERT INTO incidents (state, injuryId, causeId) VALUES ('VT', 1, 2);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('CT', 5, 3);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('MA', 5, 7);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('AK', 6, 2);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('CA', 3, 5);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('NY', 2, 5);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('WY', 1, 1);
INSERT INTO incidents (state, injuryId, causeId) VALUES ('NY', 1, 6);
