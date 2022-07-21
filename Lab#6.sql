--Q35. Cho biết mức lương cao nhất của các giảng viên.
select distinct LUONG as N'Mức lương cao nhất của GV'
from GIAOVIEN
where LUONG >= all (select LUONG
			       from GIAOVIEN)

--Q36. Cho biết những giáo viên có lương lớn nhất.
select GV.*
from GIAOVIEN GV
where LUONG >= all (select LUONG
			       from GIAOVIEN)

--Q37. Cho biết lương cao nhất trong bộ môn “HTTT”.
select distinct LUONG as N'Mức lương cao nhất của GV'
from GIAOVIEN GV
where GV.MABM = 'HTTT' and LUONG >= all (select LUONG
										 from GIAOVIEN GV1
										 where GV1.MABM = 'HTTT')

--Q38. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
select GV.HOTEN
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
where BM.TENBM = N'Hệ thống thông tin' 
	  and year(GV.NGAYSINH) <= all (select year(GV1.NGAYSINH)
									from GIAOVIEN GV1 join BOMON BM1 on GV1.MABM = BM1.MABM
									where BM1.TENBM = N'Hệ thống thông tin')


--Q39. Cho biết tên giáo viên nhỏ tuổi nhất khoa Công nghệ thông tin.
select GV.HOTEN
from (GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM) join KHOA K on BM.MAKHOA = K.MAKHOA
where K.TENKHOA = N'Công nghệ thông tin' 
	  and year(GV.NGAYSINH) >= all (select year(GV1.NGAYSINH)
									from (GIAOVIEN GV1 join BOMON BM1 on GV1.MABM = BM1.MABM) join KHOA K1 on BM1.MAKHOA = K1.MAKHOA
									where K1.TENKHOA = N'Công nghệ thông tin')
