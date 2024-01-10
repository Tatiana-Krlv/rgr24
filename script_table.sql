Student {
	id integer pk increments
	full_name varchar(200)
	date_of_birth date
	address varchar(200) null def(NULL)
	email varchar(100) null def(NULL)
	group_id integer *> Groups.id
	budget bool
}

Phone_numbers {
	id integer pk increments
	student_id integer *> Student.id
	phone_number varchar(25)
}

Groups {
	id integer pk increments
	group_name varchar(10)
	direction_id integer(100) *> Directions_of_study.id
}

Directions_of_study {
	id integer pk increments
	direction_name varchar(100)
}

Disciplines {
	id integer pk increments
	name varchar(200)
}

Teachers {
	id integer pk increments
	name varchar(200)
}

DirectionDisciplineTeacher {
	id integer pk increments
	direction_id integer *> Directions_of_study.id
	discipline_id integer *> Disciplines.id
	teacher_id integer *> Teachers.id
}

Marks {
	id integer pk increments
	student_id integer *> Student.id
	sub_disc_teach_id integer > DirectionDisciplineTeacher.id
	mark integer null
}

Pair_time {
	id integer pk increments
	time_start time
	time_end time
}

Lessons_shedule {
	id integer pk increments
	sub_disc_teach_id integer *> DirectionDisciplineTeacher.id
	time_id integer *> Pair_time.id
	date date
}

Attendance {
	id integer pk increments
	schedule_id integer *> Lessons_shedule.id
	student_id integer
	presense bool
}
