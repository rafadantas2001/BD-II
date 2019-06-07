/* Script de CREATE do DB curso_etec e suas tabelas */

create database curso_etec;
go

use curso_etec;
go

create table area
        (id_are       int           not null  primary key,
         nm_are       varchar (30)  not null);
go

create table curso
        (id_cur       int           not null  primary key,
         id_are       int           not null,
         nm_cur       varchar (50)  not null,
	 Constraint cur_are_fk foreign key (id_are) references area);
go

create table turma
	(id_tur       int           not null  primary key,
	 id_cur       int           not null,       
	 nm_tur       varchar (5)   not null,
	 Constraint tur_cur_fk foreign key (id_cur) references curso);
go

create table aluno
	(id_alu       int           not null  primary key,
	 id_tur       int           not null,
	 pn_alu       varchar (30)  not null,
	 un_alu       varchar (20)  not null,
	 dt_nas_alu   date          not null,
	 Constraint alu_tur_fk foreign key (id_tur) references turma);
go

create table professor
	(id_prof      int           not null  primary key,
	 id_cur       int           not null,       
	 nm_prof      varchar (50)  not null,
	 tt_hs_prof   int           not null,
	 vl_hora_prof numeric (7,2) not null,
	 Constraint prof_cur_fk foreign key (id_cur) references curso);
go

create table materia
	(id_mat       int           not null  primary key,
	 id_prof      int           not null,
	 id_tur       int           not null,
	 nm_mat       varchar (40)  not null,
	 sg_mat       varchar (10)  not null,
	 Constraint mat_prof_fk foreign key (id_prof) references professor,
	 Constraint mat_tur_fk  foreign key (id_tur)  references turma);
go

/* Script de INSERT no DB curso_etec */
	 
insert into area (id_are, nm_are)
       values (1,'Informacao e Comunicacao'),
	      (2,'Gestao'),
              (3,'Eletronica'),
	      (4,'Mecanica');

insert into curso (id_cur, id_are, nm_cur)
       values (1,1,'Informatica'),
	      (2,1,'Redes de Computadores'),
	      (3,2,'Administracao'),
              (4,2,'Contabilidade'),
	      (5,2,'Logistica'),
	      (6,3,'Eletronica');

insert into turma (id_tur, id_cur, nm_tur)
       values (1,1,'1Q'),
	      (2,1,'2Q'),
	      (3,1,'3Q'),
	      (4,2,'1QR'),
              (5,2,'2QR'),
              (6,2,'3QR'),
	      (7,3,'1M'),
	      (8,3,'2M'),
	      (9,3,'2M');

insert into aluno (id_alu,id_tur,pn_alu,un_alu,dt_nas_alu)
       values (1,1,'Maria','Silva','2001-05-01'),
	      (2,1,'Jose','Matos','2001-05-02'),
	      (3,2,'Marcos','Sousa','2000-03-05'),
	      (4,2,'luiza','Souza','2003-04-03'),
              (5,3,'Lucia','Madeira','2003-04-03'),
	      (6,3,'Carlos','Silva','1999-06-30'),
	      (7,4,'Antonio','Souza','1999-06-30'),
              (8,4,'Silvio','Silveira','2001-04-30'),
	      (9,6,'Silvia','Moura','2001-04-30'),
	      (10,6,'Carlos','Paoli','1999-08-30'),
	      (11,7,'Antonio','Silveira','2001-04-30');

insert into professor (id_prof,	id_cur,	nm_prof,tt_hs_prof,vl_hora_prof)
       values (1,1,'Jose Silva',100,'10.50'),
	      (2,1,'Maria Santos',50,'15.80'),
	      (3,1,'Silvana Silva',60,'14.20'),
              (4,3,'Sueli Navarro',20,'17.45'),
              (5,3,'Marco Antonio',10,'10.50'),
              (6,6,'Silvio Sebastiao',10,'15.80'),
              (7,6,'Celia Gaviao',120,'21.30');

insert into  materia (id_mat, id_prof, id_tur, nm_mat, sg_mat) 
       values (1,1,1,'Logica Programacao','LP'),	
              (2,2,2,'Tecnicas de Linguagem Banco de Dados II','BD II'),	
              (3,2,3,'Tecnicas de Linguagem Banco de Dados III','BD III'),	
	      (4,5,2,'Empreendedorismo e Inovação','EI'),	
              (5,4,2,'Ingles Instrumental','II'),	
              (6,3,4,'Aplicativos Informatizados','AI'),	
              (7,1,4,'Logica Programação','LP');


			  create table professor_bk_insert
	(id_prof		int				not null primary key,
	 id_cur			int				not null,
	 nm_prof		varchar(50)		not null,
	 tt_hs_prof		int				not null,
	 vl_hora_prof	numeric(7,2)	not null
	)
	go

create table professor_bk_delete
	(id_prof		int				not null primary key,
	 id_cur			int				not null,
	 nm_prof		varchar(50)		not null,
	 tt_hs_prof		int				not null,
	 vl_hora_prof	numeric(7,2)	not null
	)
	go

	create trigger trg_insertprofessor on professor_bk_insert
after insert 
as begin
		insert into professor_bk_insert
		select * from inserted
	end
go

create trigger trg_deleteprofessor on professor_bk_delete
	after delete
	as begin
		insert into professor_bk_delete
		select * from deleted
	end
go
