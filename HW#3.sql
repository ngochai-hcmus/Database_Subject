--TRUY VẤN
--Q11
select GV.HOTEN, GV1.HOTEN
from GIAOVIEN GV left join GIAOVIEN GV1 on GV.GVQLCM = GV1.MAGV


--Q12
select GV.HOTEN
from GIAOVIEN GV join GIAOVIEN GV1 on GV.GVQLCM = GV1.MAGV
where GV1.HOTEN = N'Nguyễn Thanh Tùng'

--Q13
select GV.HOTEN
from BOMON BM join GIAOVIEN GV on BM.TRUONGBM = GV.MAGV
where BM.TENBM = N'Hệ thống thông tin'

--Q14
select distinct GV.HOTEN
from DETAI DT join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
where DT.MACD = N'QLGD'

--Q15
select CV.TENCV
from CONGVIEC CV join DETAI DT on CV.MADT = DT.MADT
where DT.TENDT = N'HTTT quản lý các trường ĐH' and CV.NGAYBD between '2008-03-1' and '2008-03-31'

--Q16
select GV.HOTEN, GV1.HOTEN
from GIAOVIEN GV left join GIAOVIEN GV1 on GV.GVQLCM = GV1.MAGV

--Q17
select CV.*
from CONGVIEC CV join DETAI DT on CV.MADT = DT.MADT
where CV.NGAYBD between '2007-01-01' and '2007-08-01'

--Q18
select GV.HOTEN
from GIAOVIEN GV join GIAOVIEN GV1 on GV.MABM = GV1.MABM
where GV1.HOTEN = N'Trần Trà Hương' and GV.HOTEN != N'Trần Trà Hương'

--Q19
select distinct GV.*
from (GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM) join DETAI DT on GV.MAGV = DT.GVCNDT

--Q20
select distinct GV.HOTEN
from (GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM) join KHOA K on GV.MAGV = K.TRUONGKHOA

--Q21
select distinct GV.HOTEN
from (GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM) join DETAI DT on GV.MAGV = DT.GVCNDT

--Q22
select distinct K.TRUONGKHOA
from KHOA K join DETAI DT on K.TRUONGKHOA = DT.GVCNDT

--Q23
select distinct GV.MAGV
from GIAOVIEN GV join THAMGIADT TGDT on GV.MAGV = TGDT.MAGV
where GV.MABM = 'HTTT' and TGDT.MADT = '001'

--Q24
select GV.*
from GIAOVIEN GV join GIAOVIEN GV1 on GV.MABM = GV1.MABM
where GV1.MAGV = '002' and GV.HOTEN != N'Trần Trà Hương'

--Q25
select GV.*
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM

--Q26
select HOTEN, LUONG
from GIAOVIEN