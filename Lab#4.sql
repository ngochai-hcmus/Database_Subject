create database QLMayTinh

go
use QLMayTinh
go

--Cau 1: tao bang va tao rang buoc khoa chinh cho cac bang tren
create table PHONGMAY
(
	IDToaNha varchar(10),
	IDPhongMay varchar(10),
	TenPhong nvarchar(20),
	IDMayGV varchar(10)

	constraint PK_PHONGMAY primary key (IDToaNha, IDPhongMay)
)

create table TOA_NHA
(
	IDToaNha varchar(10),
	Ten nvarchar(20),
	IDServer varchar(10)

	constraint PK_TOA_NHA primary key (IDToaNha)
)

create table MAYTINH
(
	IDToaNha varchar(10),
	IDMayTinh varchar(10),
	TenMay nvarchar(20),
	IDPhong varchar(10)

	constraint PK_MAYTINH primary key (IDToaNha, IDMayTinh)
)

--Cau 2: tao rang buoc khoa ngoai cho cac bang tren

--PHONGMAY
--IDToaNha -- TOA_NHA(IDToaNha)
--(IDToaNha,IDMayGV) -- MAYTINH(IDToaNha, IDMayTinh)
alter table PHONGMAY
add constraint FK_PHONGMAY_TOA_NHA
foreign key (IDToaNha)
references TOA_NHA(IDToaNha)

alter table PHONGMAY
add constraint FK_PHONGMAY_MAYTINH
foreign key (IDToaNha, IDMayGV)
references MAYTINH(IDToaNha, IDMayTinh)

--TOA_NHA
--(IDToaNha, IDServer) -- MAYTINH(IDToaNha, IDMayTinh)
alter table TOA_NHA
add constraint FK_TOA_NHA_MAYTINH
foreign key (IDToaNha, IDServer)
references MAYTINH(IDToaNha, IDMayTinh)

--MAYTINH
--(IDToaNha, IDPhong) -- PHONGMAY(IDToaNha, IDPhongMay)
alter table MAYTINH
add constraint FK_MAYTINH_PHONGMAY
foreign key (IDToaNha, IDPhong)
references PHONGMAY(IDToaNha, IDPhongMay)

--Cau 3: nhap lieu
insert into TOA_NHA values ('N01',N'Toà nhà mới', NULL)
insert into TOA_NHA values ('N02',N'Dãy F', NULL)

insert into PHONGMAY values ('N01','I51' ,N'Phòng Server toà nhà I', NULL)
insert into PHONGMAY values ('N01','I52' ,N'Phòng máy 52', NULL)
insert into PHONGMAY values ('N02','I51' ,N'Phòng Server dãy F', NULL)

insert into MAYTINH values ('N01','M01' ,N'LAB51-WS01', 'I51')
insert into MAYTINH values ('N01','M02' ,N'LAB52-WS01', 'I52')

update TOA_NHA set IDServer = 'M01' where IDToaNha = 'N01'
update TOA_NHA set IDServer = 'M01' where IDToaNha = 'N02'

update PHONGMAY set IDMayGV = 'M02' where IDPhongMay = 'I52'

