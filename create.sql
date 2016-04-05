-- table for users for login
create table users(
	username VARCHAR(100) NOT NULL ,
	password VARCHAR(100) NOT NULL,
	PRIMARY KEY(username)
);

create table sessions(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name varchar(100) NOT NULL,
	description varchar(1000),
	datetime INTEGER UNSIGNED NOT NULL,
	user VARCHAR(100) NOT NULL,
	CONSTRAINT FOREIGN KEY(user) REFERENCES users(username) ON DELETE CASCADE ON UPDATE CASCADE
);


-- table for experiment data
create table experiments(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name varchar(100) NOT NULL,
	location varchar(100) NOT NULL,
	description varchar(1000),
	user VARCHAR(100) NOT NULL,
	filename VARCHAR(100) NOT NULL,
	datetime INTEGER UNSIGNED NOT NULL,
	sid INT NOT NULL,
	tracefilereceived BOOL NOT NULL DEFAULT 0,
	CONSTRAINT FOREIGN KEY(user) REFERENCES users(username) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(sid) REFERENCES sessions(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- table for experiment details
 
create table experimentdetails(
          expid INT NOT NULL,
          macaddress CHAR(17) NOT NULL,
          osversion INT NOT NULL,
          wifiversion VARCHAR(30),
	  ip_addr VARCHAR(20),
          rssi varchar(5),
          bssid varchar(18),                     
          ssid varchar(25),                     
          linkspeed varchar(10),
          numberofcores INT NOT NULL,
          storagespace INT NOT NULL,
          memory INT NOT NULL,
          processorspeed INT NOT NULL,
          wifisignalstrength INT NOT NULL,
          filereceived BOOL NOT NULL,
          CONSTRAINT FOREIGN KEY(expid) REFERENCES experiments(id) ON DELETE CASCADE ON UPDATE CASCADE,
          PRIMARY KEY(expid, macaddress)
     ); 


CREATE TABLE `apsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `user` varchar(100) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `datetime` int(10) unsigned NOT NULL,
  `sid` int(11) NOT NULL,
  `tracefilereceived` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `sid` (`sid`),
  CONSTRAINT `apsettings_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `apsettings_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `sessions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)



