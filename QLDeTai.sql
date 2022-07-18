create database QLDeTai

go
use QLDeTai
go

create table BOMON
(
	MABM varchar(4), 
	TENBM nvarchar(50), 
	PHONG char(3), 
	DIENTHOAI varchar(10), 
	TRUONGBM char(3), 
	MAKHOA varchar(4), 
	NGAYNHANCHUC date

	constraint PK_BOMOM primary key(MABM)
)

create table KHOA
(
	MAKHOA varchar(4), 
	TENKHOA nvarchar(50), 
	NAMTL int, 
	PHONG char(3), 
	DIENTHOAI varchar(10), 
	TRUONGKHOA char(3), 
	NGAYNHANCHUC date

	constraint PK_KHOA primary key(MAKHOA)
)

create table GIAOVIEN
(
	MAGV char(3), 
	HOTEN nvarchar(50), 
	LUONG int default(0), 
	PHAI nvarchar(3), 
	NGAYSINH date, 
	DIACHI nvarchar(50), 
	GVQLCM char(3), 
	MABM varchar(4)

	constraint PK_GIAOVIEN primary key(MAGV)
)

create table GV_DT
(
	MAGV char(3), 
	DIENTHOAI varchar(10)

	constraint PK_GV_DT primary key(MAGV,DIENTHOAI)
)

create table DETAI
(
	MADT char(3), 
	TENDT nvarchar(50),  
	CAPQL nvarchar(20), 
	KINHPHI int,
	NGAYBD date, 
	NGAYKT date, 
	MACD char(4), 
	GVCNDT char(3)

	constraint PK_DETAI primary key(MADT)
)

create table CHUDE
(
	MACD char(4), 
	TENCD nvarchar(50)

	constraint PK_CHUDE primary key(MACD)
)

create table CONGVIEC
(
	MADT char(3), 
	SOTT int, 
	TENCV nvarchar(50), 
	NGAYBD datetime, 
	NGAYKT datetime

	constraint PK_CONGVIEC primary key(MADT,SOTT)
)

create table THAMGIADT
(
	MAGV char(3), 
	MADT char(3), 
	STT int, 
	PHUCAP float, 
	KETQUA nvarchar(10)

	constraint PK_THAMGIADT primary key(MAGV,MADT,STT)
)

create table NGUOITHAN
(
	MAGV char(3), 
	TEN nvarchar(10), 
	NGSINH datetime, 
	PHAI nvarchar(3)

	constraint PK_NGUOITHAN primary key(MAGV,TEN)
)

--BOMON
--TRUONGBOMON -- GIAOVIEN(MAGV)
--MAKHOA -- KHOA(MAKHOA)
alter table BOMON
add constraint FK_BOMON_GIAOVIEN
foreign key (TRUONGBM)
references GIAOVIEN(MAGV)

alter table BOMON
add constraint FK_BOMON_KHOA
foreign key (MAKHOA)
references KHOA(MAKHOA)

--KHOA
--TRUONGKHOA -- GIAOVIEN(MAGV)
alter table KHOA
add constraint FK_KHOA_GIAOVIEN
foreign key (TRUONGKHOA)
references GIAOVIEN(MAGV)

--GIAOVIEN
--GVQLCM -- GIAOVIEN(MAGV)
--MABM -- BOMON(MABM)
alter table GIAOVIEN
add constraint FK_GIAOVIEN_GIAOVIEN
foreign key (GVQLCM)
references GIAOVIEN(MAGV)

alter table GIAOVIEN
add constraint FK_GIAOVIEN_BOMON
foreign key (MABM)
references BOMON(MABM)

--GV_DT
--MAGV -- GIAOVIEN(MAGV)
alter table GV_DT
add constraint FK_GV_DT_GIAOVIEN
foreign key (MAGV)
references GIAOVIEN(MAGV)

--THAMGIADT
--MAGV -- GIAOVIEN(MAGV)
--MADT,STT -- CONGVIEC(MADT,SOTT)
alter table THAMGIADT
add constraint FK_THAMGIADT_GIAOVIEN
foreign key (MAGV)
references GIAOVIEN(MAGV)

alter table THAMGIADT
add constraint FK_THAMGIADT_CONGVIEC
foreign key (MADT,STT)
references CONGVIEC(MADT,SOTT)

--CONGVIEC
--MADT -- DETAI(MADT)
alter table CONGVIEC
add constraint FK_CONGVIEC_DETAI
foreign key (MADT)
references DETAI(MADT)

--DETAI
--MACD -- CHUDE(MACD)
alter table DETAI
add constraint FK_DETAI_CHUDE
foreign key (MACD)
references CHUDE(MACD)

--NGUOITHAN
--MAGV -- GIAOVIEN(MAGV)
alter table NGUOITHAN
add constraint FK_NGUOITHAN_GIAOVIEN
foreign key (MAGV)
references GIAOVIEN(MAGV)

--GIAOVIEN
insert into GIAOVIEN values ('001',N'Nguyễn Hoài An','2000','Nam','1973-02-15',N'25/3 Lạc Long Quân, Q.10, TP HCM',NULL,NULL)
insert into GIAOVIEN values ('002',N'Trần Trà Hương','2500',N'Nữ','1960-06-20',N'125 Trần Hưng Đạo, Q.1, TP HCM',NULL,NULL)
insert into GIAOVIEN values ('003',N'Nguyễn Ngọc Ánh','2200',N'Nữ','1975-05-11',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM','002',NULL)
insert into GIAOVIEN values ('004',N'Trương Nam Sơn','2300','Nam','1959-06-20',N'215 Lý Thường Kiệt, TP Biên Hoà',NULL,NULL)
insert into GIAOVIEN values ('005',N'Lý Hoàng Hà','2500','Nam','1954-10-23',N'22/5 Nguyễn Xí, Q,Bình Thạnh, TP HCM',NULL,NULL)
insert into GIAOVIEN values ('006',N'Trần Bạch Tuyết','1500',N'Nữ','1980-05-20',N'127 Hùng Vương, TP Mỹ Tho','004',NULL)
insert into GIAOVIEN values ('007',N'Nguyễn An Trung','2100','Nam','1976-06-05',N'234 3/2, TP Biên Hoà',NULL,NULL)
insert into GIAOVIEN values ('008',N'Trần Trung Hiếu','1800','Nam','1977-08-06',N'21/11 Lý Thường Kiệt, TP Mỹ Tho','007',NULL)
insert into GIAOVIEN values ('009',N'Trần Hoàng Nam','2000','Nam','1975-11-22',N'234 Trần Não, An Phú, TP HCM','001',NULL)
insert into GIAOVIEN values ('010',N'Phạm Nam Thanh','1500','Nam','1980-12-12',N'211 Hùng Vương, Q.5, TP HCM','007',NULL)

--KHOA
insert into KHOA values ('CNTT',N'Công nghệ thông tin','1995','B11','0838123456','002','2005-02-20')
insert into KHOA values ('HH',N'Hoá học','1980','B41','0838456456','007','2001-10-15')
insert into KHOA values ('SH',N'Sinh học','1980','B31','0838454545','004','2000-10-11')
insert into KHOA values ('VL',N'Vật lý','1976','B21','0838223223','005','2003-09-18')

--BOMON
insert into BOMON values ('CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,'CNTT',NULL)
insert into BOMON values ('HHC',N'Hoá hữu cơ','B44','0382222222',NULL,'HH',NULL)
insert into BOMON values ('HL',N'Hoá lý','B42','0838878787',NULL,'HH',NULL)
insert into BOMON values ('HPT',N'Hoá phân tích','B43','0838777777','007','HH','2007-10-15')
insert into BOMON values ('HTTT',N'Hệ thống thông tin','B13','0838125125','002','CNTT','2004-09-20')
insert into BOMON values ('MMT',N'Mạng máy tính','B16','0838676767','001','CNTT','2005-05-15')
insert into BOMON values ('SH',N'Sinh học','B33','0838898989',NULL,'SH',NULL)
insert into BOMON values ('VLDT',N'Vật lý điện tử','B23','0838234234',NULL,'VL',NULL)
insert into BOMON values ('VLUD',N'Vật lý ứng dụng','B24','0838454545','005','VL','2006-02-18')
insert into BOMON values ('VS',N'Vi sinh','B32','0838909090','004','SH','2007-01-01')

--UPDATE GIAOVIEN
update GIAOVIEN set MABM = 'MMT' where MAGV = '001'
update GIAOVIEN set MABM = 'HTTT' where MAGV = '002'
update GIAOVIEN set MABM = 'HTTT' where MAGV = '003'
update GIAOVIEN set MABM = 'VS' where MAGV = '004'
update GIAOVIEN set MABM = 'VLDT' where MAGV = '005'
update GIAOVIEN set MABM = 'VS' where MAGV = '006'
update GIAOVIEN set MABM = 'HPT' where MAGV = '007'
update GIAOVIEN set MABM = 'HPT' where MAGV = '008'
update GIAOVIEN set MABM = 'MMT' where MAGV = '009'
update GIAOVIEN set MABM = 'HPT' where MAGV = '010'

--GV_DT
insert into GV_DT values ('001','0838912112')
insert into GV_DT values ('001','0903123123')
insert into GV_DT values ('002','0913454545')
insert into GV_DT values ('003','0838121212')
insert into GV_DT values ('003','0903656565')
insert into GV_DT values ('003','0937125125')
insert into GV_DT values ('006','0937888888')
insert into GV_DT values ('008','0653717171')
insert into GV_DT values ('008','0913232323')

--CHUDE
insert into CHUDE values ('NCPT',N'Nghiên cứu phát triển')
insert into CHUDE values ('QLGD',N'Quản lý giáo dục')
insert into CHUDE values ('UDCN',N'Ứng dụng công nghệ')

--DETAI
insert into DETAI values ('001',N'HTTT quản lý các trường ĐH','ĐHQG','20','2007-10-20', '2008-10-20','QLGD','002')
insert into DETAI values ('002',N'HTTT quản lý giáo vụ cho một khoa',N'Trường','20','2000-10-12', '2001-10-12','QLGD','002')
insert into DETAI values ('003',N'Nghiên cứu chế tạo sợi Nano Platin','ĐHQG','300','2008-05-15', '2010-05-15','NCPT','005')
insert into DETAI values ('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước','100','2007-01-01', '2009-12-31','NCPT','004')
insert into DETAI values ('005',N'Ứng dụng hóa học xanh',N'Trường','200','2003-10-10', '2004-12-10','UDCN','007')
insert into DETAI values ('006',N'Nghiên cứu tế bào gốc',N'Nhà nước','4000','2006-10-20', '2009-10-20','NCPT','004')
insert into DETAI values ('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường','20','2009-05-10', '2010-05-10','QLGD','001')

--CONGVIEC
insert into CONGVIEC values ('001','1',N'Khởi tạo và Lập kế hoạch','2007-10-20','2008-12-20')
insert into CONGVIEC values ('001','2',N'Xác định yêu cầu','2008-12-21','2008-03-21')
insert into CONGVIEC values ('001','3',N'Phân tích hệ thống','2008-03-22','2008-05-22')
insert into CONGVIEC values ('001','4',N'Thiết kế hệ thống','2008-05-23','2008-06-23')
insert into CONGVIEC values ('001','5',N'Cài đặt thử nghiệm','2008-06-24','2008-12-20')
insert into CONGVIEC values ('002','1',N'Khởi tạo và Lập kế hoạch','2009-05-10','2009-07-10')
insert into CONGVIEC values ('002','2',N'Xác định yêu cầu','2009-07-11','2009-10-11')
insert into CONGVIEC values ('002','3',N'Phân tích hệ thống','2009-10-12','2009-12-20')
insert into CONGVIEC values ('002','4',N'Thiết kế hệ thống','2009-12-21','2010-03-22')
insert into CONGVIEC values ('002','5',N'Cài đặt thử nghiệm','2010-03-23','2010-05-10')
insert into CONGVIEC values ('006','1',N'Lấy mẫu','2006-10-20','2007-02-20')
insert into CONGVIEC values ('006','2',N'Nuôi cấy','2007-02-21','2008-08-21')

--THAMGIADT
insert into THAMGIADT values ('001','002','1','0',NULL)
insert into THAMGIADT values ('001','002','2','2',NULL)
insert into THAMGIADT values ('002','001','4','2',N'Đạt')
insert into THAMGIADT values ('003','001','1','1',N'Đạt')
insert into THAMGIADT values ('003','001','2','0',N'Đạt')
insert into THAMGIADT values ('003','001','4','1',N'Đạt')
insert into THAMGIADT values ('003','002','2','0',NULL)
insert into THAMGIADT values ('004','006','1','0',N'Đạt')
insert into THAMGIADT values ('004','006','2','1',N'Đạt')
insert into THAMGIADT values ('006','006','2','1.5',N'Đạt')
insert into THAMGIADT values ('009','002','3','0.5',NULL)
insert into THAMGIADT values ('009','002','4','1.5',NULL)

--NGUOITHAN
insert into NGUOITHAN values ('001',N'Hùng','1990-01-14','Nam')
insert into NGUOITHAN values ('001',N'Thủy','1994-12-08',N'Nữ')
insert into NGUOITHAN values ('003',N'Hà','1998-09-03',N'Nữ')
insert into NGUOITHAN values ('003',N'Thu','1998-09-03',N'Nữ')
insert into NGUOITHAN values ('007',N'Mai','2003-03-26',N'Nữ')
insert into NGUOITHAN values ('007',N'Vy','2000-02-14',N'Nữ')
insert into NGUOITHAN values ('008',N'Nam','1991-05-06','Nam')
insert into NGUOITHAN values ('009',N'An','1996-08-19','Nam')
insert into NGUOITHAN values ('010',N'Nguyệt','2006-01-14',N'Nữ')