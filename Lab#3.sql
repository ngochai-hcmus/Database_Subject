--Q1
select HOTEN, LUONG
from GIAOVIEN
where PHAI = N'Nữ'

--Q2
select HOTEN, LUONG*1.1 as 'LUONGMOI'
from GIAOVIEN

--Q3
select MAGV
from GIAOVIEN
where HOTEN like N'Nguyễn%' and LUONG>2000
union
select TRUONGBM
from BOMON
where year(NGAYNHANCHUC)>1995

--Q4
select HOTEN
from GIAOVIEN GV, BOMON BM, KHOA
where GV.MABM = BM.MABM and BM.MAKHOA = KHOA.MAKHOA and KHOA.TENKHOA = N'Công nghệ thông tin'

--Q5
select*
from BOMON, GIAOVIEN
where TRUONGBM = MAGV

--Q6
select MAGV, HOTEN, BM.*
from BOMON BM, GIAOVIEN GV
where GV.MABM = BM.MABM

--Q7
select TENDT, GVCNDT
from DETAI

--Q8
select MAKHOA, TENKHOA, GV.*
from KHOA, GIAOVIEN GV
where GV.MAGV = KHOA.TRUONGKHOA

--Q9
select distinct GV.MAGV, GV.HOTEN
from THAMGIADT, GIAOVIEN GV
where GV.MABM = 'VS' and GV.MAGV = THAMGIADT.MAGV AND THAMGIADT.MADT = '006'

--Q10
select MADT, TENCD, HOTEN, NGAYSINH, DIACHI
from DETAI DT, CHUDE CD, GIAOVIEN GV
where DT.CAPQL = N'Thành phố' and DT.MACD = CD.MACD and DT.GVCNDT = GV.MAGV
