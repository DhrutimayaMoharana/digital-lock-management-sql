CREATE TABLE company (
  id int NOT NULL AUTO_INCREMENT,
  company_name varchar(45) NOT NULL,
  registration_no varchar(15) NOT NULL,
  short_company_name varchar(6) DEFAULT NULL,
  gstin varchar(15) NOT NULL,
  company_address varchar(255) DEFAULT NULL,
  state varchar(60) NOT NULL,
  city varchar(50) NOT NULL,
  pincode varchar(10) NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE agreement (
  id int NOT NULL AUTO_INCREMENT,
  agreement_type_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-YEARLY 2-MONTHLY)',
  duration int NOT NULL,
  
  # Can use this one in place of above two
  # agreement_type_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-6MONTH 2-12MONTH 3-24MONTH)',
  
  valid_from timestamp NOT NULL,
  valid_to timestamp NOT NULL,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE user_type (
  id int NOT NULL AUTO_INCREMENT,
  user_type_name TINYINT NOT NULL COMMENT 'Use as ENUM (1-SUPER_ADMIN, 2-BD_ADMIN, 3-ADMIN, 4-USER)',
  PRIMARY KEY (id)
) ;


CREATE TABLE user (
  id int NOT NULL AUTO_INCREMENT,
  user_name varchar(45) NOT NULL,
  user_type_id int NOT NULL,
  address varchar(255) DEFAULT NULL,
  login_id varchar(20) NOT NULL COMMENT 'Use as a login credential while sign-in',
  password varchar(64) NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  company_id int DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (user_type_id) REFERENCES user_type (id)
) ;


CREATE TABLE driver (
  id int NOT NULL AUTO_INCREMENT,
  driver_name varchar(20) NOT NULL,
  license_number varchar(20) NOT NULL,
  
  # driving_experience int DEFAULT NULL COMMENT 'mention the year experience that driver have',
  
  is_active TINYINT(1) DEFAULT 1,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id)
) ;


CREATE TABLE lock_inventory(
  id int NOT NULL AUTO_INCREMENT,
  serial_number varchar(45) NOT NULL,
  mgf_date timestamp NOT NULL,
  warranty_period int DEFAULT NULL COMMENT 'warranty_period is of monthly type',
  sim_number varchar(20) NOT NULL,
  msisdn varchar(15) NOT NULL COMMENT 'MSISDN Stand for Mobile Station Integrated Services Digital Network (number uniquely identifying a subscription in a Global System for Mobile communications)',
  imei_number varchar(20) NOT NULL,
  status_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-SOLDED 2-UNSOLDED)',
  is_active TINYINT(1) DEFAULT 1,
  vendor_id int NOT NULL,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE lock_issued (
  id int NOT NULL AUTO_INCREMENT,
  issued_date timestamp NOT NULL,
  company_id int NOT NULL,
  lock_inventory_id int NOT NULL,
  validity_end timestamp DEFAULT NULL,
  is_active TINYINT(1) DEFAULT 1,
  battery_status TINYINT DEFAULT NULL,
  occupied_status_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-OCCUPIED 2-NOTOCCUPIED)',
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (lock_inventory_id) REFERENCES lock_inventory (id)
) ;

CREATE TABLE card_inventory (
  id int NOT NULL AUTO_INCREMENT,
  card_number bigint(15) NOT NULL,
  rfid varchar(15) NOT NULL,
  mfg_date timestamp NOT NULL,
  warranty_period int NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  card_provider_company_id int NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE card_issued (
  id int NOT NULL AUTO_INCREMENT,
  company_id int NOT NULL,
  card_inventory_id int NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (card_inventory_id) REFERENCES card_inventory (id),
  PRIMARY KEY (id)
);

CREATE TABLE device_access (
  id int NOT NULL AUTO_INCREMENT,
  card_issued_id int NOT NULL,
  lock_issued_id int NOT NULL,
  company_id int NOT NULL,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  FOREIGN KEY (lock_issued_id) REFERENCES lock_issued (id),
  FOREIGN KEY (card_issued_id) REFERENCES card_issued (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  PRIMARY KEY (id)
);

CREATE TABLE vehicle_type (
  id int NOT NULL AUTO_INCREMENT,
  vehicle_type_name TINYINT NOT NULL COMMENT 'Use as ENUM (1-TRUCK, 2-10KL_TANKER, 3-8KL_TANKER ,... )',
  PRIMARY KEY (id)
) ;

CREATE TABLE vehicle (
  id int NOT NULL AUTO_INCREMENT,
  vehicle_number varchar(10) NOT NULL,
  manufacturer_name varchar(55) NOT NULL,
  mgf_date timestamp NOT NULL,
  insurance_number varchar(13) NOT NULL,
  polution_number varchar(15) NOT NULL,
  chassis_number varchar(17) NOT NULL,
  engine_number varchar(17) NOT NULL,
  vehicle_type int NOT NULL,
  company_id int NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (vehicle_type) REFERENCES vehicle_type (id)
) ;


CREATE TABLE site (
  id int NOT NULL AUTO_INCREMENT,
  address varchar(255) DEFAULT NULL,
  state varchar(60) NOT NULL,
  city varchar(50) NOT NULL,
  pincode varchar(10) DEFAULT NULL,
  geofence_type_id TINYINT DEFAULT NULL COMMENT 'Use as ENUM (1-CIRCLE 2-PLYGON)',
  image varchar(255) DEFAULT NULL,
  is_active TINYINT(1) DEFAULT 1,
  latitude double DEFAULT NULL,
  longitude double DEFAULT NULL,
  site_name varchar(45) DEFAULT NULL,
  company_id int DEFAULT NULL,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES company (id)
) ;


CREATE TABLE geofence (
  id int NOT NULL AUTO_INCREMENT,
  place_name varchar(45) DEFAULT NULL,
  latitude double DEFAULT NULL,
  longitude double DEFAULT NULL,
  is_active TINYINT(1) DEFAULT 1,
  radius int DEFAULT NULL,
  site_id int DEFAULT NULL,
  FOREIGN KEY (site_id) REFERENCES site (id),
  PRIMARY KEY (id)
) ;

CREATE TABLE audit_log (
  id int NOT NULL AUTO_INCREMENT,
  company_id int DEFAULT NULL,
  end_point varchar(255) DEFAULT NULL COMMENT 'APIs that hit',
  ip_address varchar(15) DEFAULT NULL COMMENT 'ip of the user who hit that perticular API',
  is_active TINYINT(1) DEFAULT 1,
  request_body blob DEFAULT NULL,
  requested_at timestamp DEFAULT NULL,
  requested_by int DEFAULT NULL,
  response_body mediumtext DEFAULT NULL,
  user_id int DEFAULT NULL,
  status varchar(45) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE route (
  id int NOT NULL AUTO_INCREMENT,
  company_id int NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  route_name varchar(255) DEFAULT NULL,
  total_distance double NOT NULL,
  total_minute int NOT NULL,
  destination int DEFAULT NULL,
  source int DEFAULT NULL,
  created_at timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_at timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (destination) REFERENCES geofence (id),
  FOREIGN KEY (source) REFERENCES geofence (id)
); 


CREATE TABLE transporter (
  id int NOT NULL AUTO_INCREMENT,
  transporter_name varchar(45) DEFAULT NULL,
  registration_no varchar(45) NOT NULL,
  gstin varchar(15) NOT NULL,
  address varchar(255) DEFAULT NULL,
  city varchar(45) DEFAULT NULL,
  state varchar(45) DEFAULT NULL,
  pincode varchar(10) DEFAULT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE vendor (
  id int NOT NULL AUTO_INCREMENT,
  vendor_name varchar(45) NOT NULL,
  gstin varchar(15) NOT NULL,
  vendor_address varchar(255) DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  country varchar(56) DEFAULT NULL,
  state varchar(60) NOT NULL,
  city varchar(50) NOT NULL,
  pincode varchar(10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE contact_details (
  id int NOT NULL AUTO_INCREMENT,
  contact_person_name varchar(45) NOT NULL,
  country_code int NOT NULL,
  phone_number varchar(50) NOT NULL,
  email varchar(30) DEFAULT NULL,
  company_id int DEFAULT NULL,
  user_id int DEFAULT NULL,
  driver_id int DEFAULT NULL,
  transporter_id int DEFAULT NULL,
  vendor_id int DEFAULT NULL,
  source_trip_id int DEFAULT NULL,
  destination_trip_id int DEFAULT NULL,
  created_on timestamp DEFAULT NULL, 
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  is_active TINYINT(1) DEFAULT 1,
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (user_id) REFERENCES user (id),
  FOREIGN KEY (driver_id) REFERENCES driver (id),
  FOREIGN KEY (transporter_id) REFERENCES transporter (id),
  FOREIGN KEY (source_trip_id) REFERENCES trip (id),
  FOREIGN KEY (destination_trip_id) REFERENCES trip (id),
  FOREIGN KEY (vendor_id) REFERENCES vendor (id),
  PRIMARY KEY (id)
);

CREATE TABLE trip (
  id int NOT NULL AUTO_INCREMENT,
  is_active TINYINT(1) DEFAULT 1,
  source int NOT NULL,
  destination int NOT NULL,
  company_id int NOT NULL,
  route_id int NOT NUll,
  vehicle_id int NOT NUll,
  driver_id int NOT NUll,
  transporter_id int DEFAULT NULL,
  expected_start_date timestamp DEFAULT NULL,
  start_date timestamp DEFAULT NULL,
  expected_end_date timestamp DEFAULT NULL,
  end_date timestamp DEFAULT NULL,
  actual_distance double DEFAULT NULL,
  expected_distance double DEFAULT NULL,
  created_on timestamp DEFAULT NULL,
  created_by int DEFAULT NULL,
  updated_on timestamp DEFAULT NULL,
  updated_by int DEFAULT NULL,
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (destination) REFERENCES geofence (id),
  FOREIGN KEY (source) REFERENCES geofence (id),
  FOREIGN KEY (route_id) REFERENCES route (id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicle (id),
  FOREIGN KEY (driver_id) REFERENCES driver (id),
  FOREIGN KEY (transporter_id) REFERENCES transporter (id),
  PRIMARY KEY (id)
);


CREATE TABLE lock_used(
  id int NOT NULL AUTO_INCREMENT,
  is_active TINYINT(1) DEFAULT 1,
  lock_issued_id int NOT NULL,
  trip_id int NOT NULL,
  locking_status_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-LOCKING 2-UNLOCKING)',
  battery_status TINYINT NOT NULL,                    
  FOREIGN KEY (lock_issued_id) REFERENCES lock_issued (id),
  FOREIGN KEY (trip_id) REFERENCES trip (id),
  PRIMARY KEY (id)
);


CREATE TABLE way_points (
  id int NOT NULL AUTO_INCREMENT,
  route_id int NOT NULL,
  place_name varchar(30) NOT NULL,
  latitude double NOT NULL,
  longitude double NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  FOREIGN KEY (route_id) REFERENCES route (id),
  PRIMARY KEY (id)
);


CREATE TABLE event_type (
   id int NOT NULL AUTO_INCREMENT,
   event_type_name_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-TRIP_START, 2-TRIP END, 3-TRIP_STOP, 4-LOCK, 5-UNLOCK, 6-FORCED_UNLOCK,7-ROUTE_DEVIATION, 8-UNAUTHORIZED_STOPPAGE, 9-TAMPERING)',
   PRIMARY KEY (id)
);

CREATE TABLE event (
  id BIGINT NOT NULL AUTO_INCREMENT,
  company_id int NOT NULL,
  trip_id int NOT NULL,
  event_type_id int NOT NULL,
  place_name varchar(30) NOT NULL,
  latitude double NOT NULL,
  longitude double NOT NULL,
  created_on timestamp DEFAULT NULL,
  event_status varchar(15) NOT NULL,
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (trip_id) REFERENCES trip (id),
  FOREIGN KEY (event_type_id) REFERENCES event_type (id),
  PRIMARY KEY (id)
);

CREATE TABLE alert_type (
  id int NOT NULL AUTO_INCREMENT,
  type_name_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-FORCED UNLOCK, 2-ROUTE_DEVIATION, 3-UNAUTHORIZED_STOPPAGE, 4-TAMPERING)',
  PRIMARY KEY (id)
);

CREATE TABLE alerts (
  id int NOT NULL AUTO_INCREMENT,
  alert_severity_level_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-HIGH 2-MODERATE 3-LOW)',
  created_on timestamp NOT NULL,
  alert_type_id int NOT NULL,
  lock_issued_id int NOT NULL,
  trip_id int NOT NULL,
  FOREIGN KEY (lock_issued_id) REFERENCES lock_issued (id),
  FOREIGN KEY (trip_id) REFERENCES trip (id),
  FOREIGN KEY (alert_type_id) REFERENCES alert_type (id),
  PRIMARY KEY (id)
);

CREATE TABLE sms (
  id int NOT NULL AUTO_INCREMENT,
  sms_template varchar(155) NOT NULL,
  created_on  timestamp NOT NULL,
  sms_status_id TINYINT NOT NULL COMMENT 'Use as ENUM (1-DELIVERED 2-NOTDELIVERED)',
  trip_id int NOT NULL,
  company_id int NOT NULL,
  event_id bigint NOT NULL,
  FOREIGN KEY (trip_id) REFERENCES trip (id),
  FOREIGN KEY (event_id) REFERENCES event (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  PRIMARY KEY (id)
);