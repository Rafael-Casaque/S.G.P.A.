CREATE TABLE user (
	institutional_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    phone TEXT,
    user_type TEXT,
	room INTEGER,
	login TEXT,
	password TEXT
)


CREATE TABLE part(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
    description  TEXT,
    max_days_for_student INTEGER,
    max_days_for_professor INTEGER
);

CREATE TABLE part_item(
	patrimonial_id INTEGER PRIMARY KEY AUTOINCREMENT,
    status TEXT,
    observation TEXT,
    part_id INTEGER,
	FOREIGN KEY (part_id) REFERENCES part(id)
);

CREATE TABLE reservation(
	reservation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_time_scheduled_for_checkout TEXT,
    user_id INTEGER,
    technician_id INTEGER,
	FOREIGN KEY (user_id) REFERENCES user(institutional_id),
	FOREIGN KEY (technician_id) REFERENCES user(institutional_id)	 
);

CREATE TABLE reservation_item(
	reservation_id INTEGER, 
	part_item_id INTEGER,
	FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id),
	FOREIGN KEY (part_item_id) REFERENCES part_item(patrimonial_id),
	PRIMARY KEY (reservation_id, part_item_id)
);

CREATE TABLE checkout(
	checkout_id INTEGER PRIMARY KEY AUTOINCREMENT,
    technician_id INTEGER,
    user_id INTEGER,
    reservation_id INTEGER,
	FOREIGN KEY (technician_id) REFERENCES user(institutional_id),
	FOREIGN KEY (user_id) REFERENCES user(institutional_id),
	FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)	 
);

CREATE TABLE checkout_item(
    checkout_id INTEGER,
    part_item_id INTEGER,
    due_date TEXT,
    return_date TEXT,
	FOREIGN KEY (checkout_id) REFERENCES checkout(checkout_id),
	FOREIGN KEY (part_item_id) REFERENCES part_item(patrimonial_id),
	PRIMARY KEY (checkout_id, part_item_id)
);


CREATE TABLE event(
	 id INTEGER PRIMARY KEY AUTOINCREMENT,
	 event_type TEXT,
	 time_stamp TEXT,
	 part_item_id INTEGER,
     user_id INTEGER,
     technician_id INTEGER,
	 FOREIGN KEY(part_item_id) REFERENCES part_item(patrimonial_id),
	 FOREIGN KEY(user_id) REFERENCES user(institutional_id),
	 FOREIGN KEY(technician_id) REFERENCES user(institutional_id)
);

