 
DROP DATABASE RGR;
CREATE DATABASE RGR;
USE RGR;
DROP TABLE IF EXISTS department, positions, project, employe_programs, employe;

    CREATE TABLE `department` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `name` varchar(200) NOT NULL,
        PRIMARY KEY (`id`)
    );

    CREATE TABLE `employe` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `department_id` INT NOT NULL,
        `position_id` INT NOT NULL,
        `name` varchar(150) NOT NULL,
        `male` bool NOT NULL,
        `age` smallint NOT NULL,
        PRIMARY KEY (`id`)
    );

    CREATE TABLE `positions` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `position_name` varchar(100) NOT NULL,
        PRIMARY KEY (`id`)
    );


    CREATE TABLE `project` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `employe_id` INT NOT NULL,
        `department_id` INT NOT NULL,
        `project_date` DATE NOT NULL,
        `project_title` varchar(200) NOT NULL DEFAULT 'unknown_project',
        `project_description` TEXT NOT NULL,
        PRIMARY KEY (`id`)
    );

    CREATE TABLE `employe_programs` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `employe_id` INT NOT NULL,
        `program_name` varchar(100) NOT NULL,
        `login` varchar(75) NOT NULL DEFAULT '-',
        `password` varchar(20) NOT NULL DEFAULT '-',
        `access` bool NOT NULL DEFAULT false,
        PRIMARY KEY (`id`)
    );


    ALTER TABLE `employe` ADD CONSTRAINT `employe_fk0` FOREIGN KEY (`department_id`) REFERENCES `department`(`id`);

    ALTER TABLE `employe` ADD CONSTRAINT `employe_fk1` FOREIGN KEY (`position_id`) REFERENCES `positions`(`id`);

    ALTER TABLE `project` ADD CONSTRAINT `project_fk0` FOREIGN KEY (`employe_id`) REFERENCES `employe`(`id`);

    ALTER TABLE `project` ADD CONSTRAINT `project_fk1` FOREIGN KEY (`department_id`) REFERENCES `employe`(`department_id`);

    ALTER TABLE `employe_programs` ADD CONSTRAINT `employe_programs_fk0` FOREIGN KEY (`employe_id`) REFERENCES `employe`(`id`);


-- внесение данных
INSERT INTO department(name) 
VALUES	("Департамент по управлению персоналом"),                  ("Департамент по контролю качества"), 
        ("Департамент по маркетингу и рекламе"),                   ("Департамент по информационным технологиям"), 
        ("Департамент по финансам и бухгалтерии"),                 ("Департамент по корпоративным коммуникациям"), 
        ("Департамент по исследованиям и разработкам ИС"),         ("Департамент по юридическим вопросам"), 
        ("Департамент по закупкам и снабжению"),                   ("Департамент по логистике");

INSERT INTO positions(position_name) 
VALUES	("Менеджер отдела продаж"),                         ("Менеджер по работе с клиентами"), 
        ("Директор департамента по управлению персоналом"), ("Креативный менеджер технологий"), 
        ("Специалист технической безопасности"),            ("Специалист технической поддержки клиентов"), 
        ("Уборщик"),                                        ("Креативный директор"), 
        ("Директор корпоративной коммуникации"),            ("Бухгалтер");

INSERT INTO employe(department_id, position_id, name, male, age)
VALUES 	(6, 1, "Осипова Елена Михайловна", True, 38),
        (9, 2, "Данилова Фатима Ярославовна", True, 21),
        (2, 3, "Панина Софья Игоревна", True, 30),
        (3, 4, "Еремеев Дмитрий Романович", True, 42),
        (8, 5, "Беляков Никита Даниилович", True, 53),
        (9, 6, "Кондратьева Екатерина Артёмовна", False, 44),
        (7, 7, "Гаврилова Мия Александровна", False, 22),
        (6, 8, "Дмитриева Татьяна Кирилловна", False, 49),
        (9, 9, "Прокофьева Ясмина Егоровна", False, 50),
        (4, 10, "Ларионова Александра Львовна", False, 46);


INSERT INTO project(employe_id, department_id, project_date, project_title, project_description)
VALUES  (1, 2, "2023-03-11", "Внедрение технологии 5G", "Создание инфраструктуры нового поколения сетей для обеспечения более высокой скорости передачи данных и улучшения качества связи."),
        (1, 2, "2018-08-28", "Развитие системы кабельного телевидения", "Улучшение качества телевизионного сигнала, добавление новых каналов и развитие технологий интерактивного телевидения"),
        (1, 2, "2023-08-04", "Расширение сети интернета в сельской местности", "Подключение к сети интернета домов и организаций, находящихся в отдаленных и малонаселенных районах."),
        (8, 6, "2018-12-24", "Скоростной интернет для городских районов", "Цель проекта - обеспечить высокоскоростной интернет в малозаселенных районах города, где сейчас доступ к современным технологиям связи ограничен."),
        (3, 2, "2021-03-27", "Развитие облачных сервисов для бизнес-клиентов", "Предоставление облачных сервисов для предприятий и увеличение функционала облачных хранилищ данных."),
        (3, 2, "2023-01-07", "Обновление сетевого оборудования", "Замена устаревшего оборудования на современное и более производительное для улучшения качества предоставляемых услуг."),
        (3, 2, "2020-01-14", "Улучшение техподдержки и клиентского обслуживания", "Повышение качества обслуживания клиентов, ускорение процессов решения проблем и внедрение новых технологий в области технической поддержки."),
        (8, 6, "2018-01-09", "Внедрение оптических волоконных сетей", "Создание инфраструктуры на основе оптических волоконных сетей для улучшения качества интернет-соединения и повышения скорости передачи данных."),
        (8, 6, "2022-02-22", "Внедрение сетей Интернета вещей", "Создание инфраструктуры для подключения умных устройств и внедрения интернета вещей для домашнего и коммерческого использования."),
        (8, 6, "2018-07-07", "Увеличение доступности Wi-Fi в городских общественных местах", "Расширение зоны покрытия беспроводного интернета в парках, библиотеках, торговых центрах и других общественных местах.");

INSERT INTO employe_programs(employe_id, program_name, login, password, access)
VALUES  (1, "G Suite", "tiger7", "H2t@5Y8z", True),
        (1, "Microsoft Office Word", "-", "-", True),
        (1, "Slack", "jumper", "L!p3s@9X", True),
        (3, "Trello", "123cat", "N6k#p2Ft", False),
        (3, "Zoom", "4rhino", "G8j@4L1r", True),
        (3, "SQL-admin", "7guitar", "B@5r7P!z", True),
        (3, "Adobe Creative Cloud", "blaze6", "K3t@9L4z", True),
        (3, "FredOn Analys", "swift2", "H6b!p2Tl", True),
        (8, "SAP Business One", "lunar7", "J5g@2H8k", True),
        (8, "VCK Company Account Editor", "biker9", "G9t#4Y6w", True);


-- ТРИГГЕРЫ
-- INSERT
DROP TRIGGER IF EXISTS project_insert;
DELIMITER //
CREATE TRIGGER project_insert BEFORE INSERT ON project
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe.id) FROM employe WHERE employe.id = NEW.employe_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Cannot insert this employe_id. Such employe was not found.';
END IF;
IF (NEW.department_id != (SELECT employe.department_id FROM employe WHERE employe.id = NEW.employe_id))
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'This employe does not belong to this department';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS employe_insert;
DELIMITER //
CREATE TRIGGER employe_insert BEFORE INSERT ON employe
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(department.id) FROM department WHERE department.id = NEW.department_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'No such department_id.';
END IF;
IF ((SELECT COUNT(positions.id) FROM positions WHERE positions.id = NEW.position_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'No such position_id.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS employe_programs_insert;
DELIMITER //
CREATE TRIGGER employe_programs_insert BEFORE INSERT ON employe_programs
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe.id) FROM employe WHERE employe.id = NEW.employe_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'No such employe_id.';
END IF;
END //
DELIMITER ;

-- UPDATE
DROP TRIGGER IF EXISTS project_update;
DELIMITER //
CREATE TRIGGER project_update BEFORE UPDATE ON project
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe.id) FROM employe WHERE employe.id = NEW.employe_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Cannot update this employe_id. Such employe was not found.';
END IF;

IF (NEW.department_id != (SELECT employe.department_id FROM employe WHERE employe.id = NEW.employe_id))
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'This employe does not belong to this department';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS employe_update;
DELIMITER //
CREATE TRIGGER employe_update BEFORE UPDATE ON employe
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(department.id) FROM department WHERE department.id = NEW.department_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'No such department_id.';
END IF;
IF ((SELECT COUNT(positions.id) FROM positions WHERE positions.id = NEW.position_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'No such position_id.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS employe_programs_update;
DELIMITER //
CREATE TRIGGER employe_programs_update BEFORE UPDATE ON employe_programs
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe.id) FROM employe WHERE employe.id = NEW.employe_id) = 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'No such employe_id.';
END IF;
END //
DELIMITER ;

-- DELETE
DROP TRIGGER IF EXISTS employe_programs_update;
DELIMITER //
CREATE TRIGGER employe_delete BEFORE DELETE ON employe
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe_programs.employe_id) FROM employe_programs WHERE employe_programs.employe_id = OLD.id) != 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'You cannot delete this employe. Because it is in the table employe_programs. Remove it from employe_programs table first.';
END IF;
IF ((SELECT COUNT(project.employe_id) FROM project WHERE project.employe_id = OLD.id) != 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'You cannot delete this employe. Because it is in the table project. Remove it from project table first.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS department_delete;
DELIMITER //
CREATE TRIGGER department_delete BEFORE DELETE ON department
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe.department_id) FROM employe WHERE employe.department_id = OLD.id) != 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'You cannot delete this department. Because some employees are attached to him.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS positions_delete;
DELIMITER //
CREATE TRIGGER positions_delete BEFORE DELETE ON positions
FOR EACH ROW 
BEGIN
IF ((SELECT COUNT(employe.position_id) FROM employe WHERE employe.position_id = OLD.id) != 0)
    THEN 
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'You cannot delete this position. Because some employees are attached to him.';
END IF;
END //
DELIMITER ;
