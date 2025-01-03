create or replace table sporsalonları.customers
(
    id         bigint unsigned auto_increment
        primary key,
    FirstName  varchar(50) not null,
    LastName   varchar(50) not null,
    Email      varchar(50) not null,
    Phone      varchar(50) not null,
    created_at timestamp   null,
    updated_at timestamp   null,
    constraint customers_email_unique
        unique (Email)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.exercises
(
    id          bigint unsigned auto_increment
        primary key,
    Name        varchar(50) not null,
    MuscleGroup varchar(50) not null,
    created_at  timestamp   null,
    updated_at  timestamp   null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.gyms
(
    id         bigint unsigned auto_increment
        primary key,
    Name       varchar(50) not null,
    Adress     text        not null,
    Phone      varchar(50) not null,
    created_at timestamp   null,
    updated_at timestamp   null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.equipment
(
    id          bigint unsigned auto_increment
        primary key,
    Name        varchar(50)     not null,
    GymID       bigint unsigned not null,
    `Condition` varchar(50)     not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint equipment_gyms_id_fk
        foreign key (GymID) references sporsalonları.gyms (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.lockerrooms
(
    id             bigint unsigned auto_increment
        primary key,
    lockerNumber   varchar(50)     not null,
    Status         varchar(50)     not null,
    AssignedLocker bigint unsigned not null,
    created_at     timestamp       null,
    updated_at     timestamp       null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.membershiptype
(
    id          bigint unsigned auto_increment
        primary key,
    Name        varchar(50)    not null,
    Description varchar(50)    not null,
    Payment     decimal(10, 2) not null,
    created_at  timestamp      null,
    updated_at  timestamp      null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.memberships
(
    membershipID     int auto_increment
        primary key,
    CustomerID       bigint unsigned null,
    StartDate        date            null,
    EndDate          date            null,
    MembershipTypeID bigint unsigned null,
    constraint memberships_customers_id_fk
        foreign key (CustomerID) references sporsalonları.customers (id),
    constraint memberships_membershiptype_id_fk
        foreign key (MembershipTypeID) references sporsalonları.membershiptype (id)
);

create or replace table sporsalonları.participations
(
    id         bigint unsigned auto_increment
        primary key,
    CustomerID bigint unsigned not null,
    EntryTime  datetime        not null,
    ExitTime   datetime        not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint participations_customers_id_fk
        foreign key (CustomerID) references sporsalonları.customers (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.payments
(
    id          bigint unsigned auto_increment
        primary key,
    CustomerID  bigint unsigned not null,
    Amount      decimal(10, 2)  not null,
    PaymentDate date            not null,
    PaymentType varchar(50)     not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint payments_customers_id_fk
        foreign key (CustomerID) references sporsalonları.customers (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.invoices
(
    id          bigint unsigned auto_increment
        primary key,
    PaymnetID   bigint unsigned not null,
    InvoiceDate date            not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint invoices_payments_id_fk
        foreign key (PaymnetID) references sporsalonları.payments (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.programs
(
    id          bigint unsigned auto_increment
        primary key,
    Name        varchar(50) not null,
    Description text        not null,
    created_at  timestamp   null,
    updated_at  timestamp   null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.staff
(
    id         bigint unsigned auto_increment
        primary key,
    FirstName  varchar(50) not null,
    LastName   varchar(50) not null,
    Position   varchar(50) not null,
    Phone      varchar(50) not null,
    Email      varchar(50) not null,
    created_at timestamp   null,
    updated_at timestamp   null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.shifts
(
    id         bigint unsigned auto_increment
        primary key,
    StaffID    bigint unsigned not null,
    StartTime  time            not null,
    EndTime    time            not null,
    date       date            not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint shifts_staff_id_fk
        foreign key (StaffID) references sporsalonları.staff (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.supplements
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(50)     not null,
    description text            not null,
    price       decimal(10, 2)  not null,
    Stocks      bigint unsigned not null,
    created_at  timestamp       null,
    updated_at  timestamp       null
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.trainers
(
    id         bigint unsigned auto_increment
        primary key,
    FirstName  varchar(50) not null,
    LastName   varchar(50) not null,
    Email      varchar(50) not null,
    Phone      varchar(50) not null,
    created_at timestamp   null,
    updated_at timestamp   null,
    constraint trainers_email_unique
        unique (Email)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.classes
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(50)     not null,
    GymID      bigint unsigned not null,
    StartTime  time            not null,
    EndTime    time            not null,
    TrainerID  bigint unsigned not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint classes_gyms_id_fk
        foreign key (GymID) references sporsalonları.gyms (id),
    constraint classes_trainers_id_fk
        foreign key (TrainerID) references sporsalonları.trainers (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.class_members
(
    ClassMemberID bigint unsigned auto_increment
        primary key,
    ClassID       bigint unsigned not null,
    CustomerID    bigint unsigned not null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    constraint class_members_classes_id_fk
        foreign key (ClassID) references sporsalonları.classes (id),
    constraint class_members_customers_id_fk
        foreign key (CustomerID) references sporsalonları.customers (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.dietplans
(
    id              bigint unsigned auto_increment
        primary key,
    CustomerID      bigint unsigned null,
    TrainerID       bigint unsigned not null,
    PlanDescription text            not null,
    StartDate       date            not null,
    EndDate         date            not null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint dietplans_customers_id_fk
        foreign key (CustomerID) references sporsalonları.customers (id),
    constraint dietplans_trainers_id_fk
        foreign key (TrainerID) references sporsalonları.trainers (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.workoutplans
(
    id         bigint unsigned auto_increment
        primary key,
    ProgramID  bigint unsigned null,
    CustomerID bigint unsigned not null,
    StartDate  date            not null,
    EndDate    date            not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint workoutplans_customers_id_fk
        foreign key (CustomerID) references sporsalonları.customers (id),
    constraint workoutplans_programs_id_fk
        foreign key (ProgramID) references sporsalonları.programs (id)
)
    collate = utf8mb4_unicode_ci;

create or replace table sporsalonları.programexercises
(
    id              bigint unsigned auto_increment
        primary key,
    WorkoutPlanID   bigint unsigned not null,
    ExerciseID      bigint unsigned not null,
    SetCount        bigint unsigned not null,
    RepetitionCount bigint unsigned not null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint programexercises_exercises_id_fk
        foreign key (ExerciseID) references sporsalonları.exercises (id),
    constraint programexercises_workoutplans_id_fk
        foreign key (WorkoutPlanID) references sporsalonları.workoutplans (id)
)
    collate = utf8mb4_unicode_ci;

