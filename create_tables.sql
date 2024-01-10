CREATE TABLE `Student` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`full_name` varchar(200) NOT NULL,
	`date_of_birth` DATE NOT NULL,
	`address` varchar(200) DEFAULT 'NULL',
	`email` varchar(100) DEFAULT 'NULL',
	`group_id` INT NOT NULL,
	`budget` bool NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Phone_numbers` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`student_id` INT NOT NULL,
	`phone_number` varchar(25) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Groups` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`group_name` varchar(10) NOT NULL,
	`direction_id` INT(100) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Directions_of_study` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`direction_name` varchar(100) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Disciplines` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(200) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Teachers` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(200) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `DirectionDisciplineTeacher` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`direction_id` INT NOT NULL,
	`discipline_id` INT NOT NULL,
	`teacher_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Marks` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`student_id` INT NOT NULL,
	`sub_disc_teach_id` INT NOT NULL,
	`mark` INT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Pair_time` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`time_start` TIME NOT NULL,
	`time_end` TIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Lessons_shedule` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`sub_disc_teach_id` INT NOT NULL,
	`time_id` INT NOT NULL,
	`date` DATE NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Attendance` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`schedule_id` INT NOT NULL,
	`student_id` INT NOT NULL,
	`presense` bool NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `Student` ADD CONSTRAINT `Student_fk0` FOREIGN KEY (`group_id`) REFERENCES `Groups`(`id`);

ALTER TABLE `Phone_numbers` ADD CONSTRAINT `Phone_numbers_fk0` FOREIGN KEY (`student_id`) REFERENCES `Student`(`id`);

ALTER TABLE `Groups` ADD CONSTRAINT `Groups_fk0` FOREIGN KEY (`direction_id`) REFERENCES `Directions_of_study`(`id`);

ALTER TABLE `DirectionDisciplineTeacher` ADD CONSTRAINT `DirectionDisciplineTeacher_fk0` FOREIGN KEY (`direction_id`) REFERENCES `Directions_of_study`(`id`);

ALTER TABLE `DirectionDisciplineTeacher` ADD CONSTRAINT `DirectionDisciplineTeacher_fk1` FOREIGN KEY (`discipline_id`) REFERENCES `Disciplines`(`id`);

ALTER TABLE `DirectionDisciplineTeacher` ADD CONSTRAINT `DirectionDisciplineTeacher_fk2` FOREIGN KEY (`teacher_id`) REFERENCES `Teachers`(`id`);

ALTER TABLE `Marks` ADD CONSTRAINT `Marks_fk0` FOREIGN KEY (`student_id`) REFERENCES `Student`(`id`);

ALTER TABLE `Marks` ADD CONSTRAINT `Marks_fk1` FOREIGN KEY (`sub_disc_teach_id`) REFERENCES `DirectionDisciplineTeacher`(`id`);

ALTER TABLE `Lessons_shedule` ADD CONSTRAINT `Lessons_shedule_fk0` FOREIGN KEY (`sub_disc_teach_id`) REFERENCES `DirectionDisciplineTeacher`(`id`);

ALTER TABLE `Lessons_shedule` ADD CONSTRAINT `Lessons_shedule_fk1` FOREIGN KEY (`time_id`) REFERENCES `Pair_time`(`id`);

ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_fk0` FOREIGN KEY (`schedule_id`) REFERENCES `Lessons_shedule`(`id`);
