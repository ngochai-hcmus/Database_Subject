--Nguyễn Thị Ngọc Hải
--20127490
--20CLC09

--Q40. Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
select HOTEN, TENKHOA
from (GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM) join KHOA K on BM.MAKHOA = K.MAKHOA
where LUONG >= all (select LUONG
					from GIAOVIEN)

--Q41. Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
select GV.*
from GIAOVIEN GV
where LUONG >= all (select LUONG
					from GIAOVIEN GV1
					where GV1.MABM = GV.MABM)

--Q42. Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.
select DT.*
from DETAI DT
where MADT not in (select MADT
				   from THAMGIADT TG join GIAOVIEN GV on TG.MAGV = GV.MAGV
				   where GV.HOTEN = N'Nguyễn Hoài An')

--Q43. Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia. Xuất ra tên đề tài, tên người chủ nhiệm đề tài.
select TENDT, HOTEN as N'GVCNDT'
from DETAI DT join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
where MADT not in (select MADT
				   from THAMGIADT TG join GIAOVIEN GV on TG.MAGV = GV.MAGV
				   where GV.HOTEN = N'Nguyễn Hoài An')

--Q44. Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
select GV.*
from (GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM) join KHOA K on BM.MAKHOA = K.MAKHOA
where K.TENKHOA = N'Công nghệ thông tin' and not exists (select *
														 from THAMGIADT TG
														 where TG.MAGV = GV.MAGV)

--Q45. Tìm những giáo viên không tham gia bất kỳ đề tài nào
select GV.*
from GIAOVIEN GV
where not exists (select *
				  from THAMGIADT TG
				  where TG.MAGV = GV.MAGV)

--Q46. Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
select GV.*
from GIAOVIEN GV
where LUONG > (select GV1.LUONG
			   from GIAOVIEN GV1
			   where GV1.HOTEN = N'Nguyễn Hoài An')
			   
--Q47. Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
select GV.*
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM
where exists (select *
			  from THAMGIADT TG
			  where TG.MAGV = GV.MAGV)

insert into GIAOVIEN values ('011',N'Nguyễn Hoài An',2100,'Nam','2-2-1977',N'135 Trần Hưng Đạo, Q.1',NULL,'MMT')

--Q48. Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
select GV.*
from GIAOVIEN GV
where exists (select *
			  from GIAOVIEN GV1
			  where GV.HOTEN = GV1.HOTEN and GV.PHAI = GV1.PHAI and GV.MABM = GV1.MABM and GV.MAGV != GV1.MAGV)

--Q49. Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ môn “Công nghệ phần mềm”
select GV.*
from GIAOVIEN GV
where LUONG > any (select GV1.LUONG
				   from GIAOVIEN GV1,BOMON BM
				   where GV1.MABM = BM.MABM AND BM.TENBM = N'Công nghệ phần mềm')

--Q50. Tìm những giáo viên có lương lớn hơn lương của tất cả giáo viên thuộc bộ môn “Hệ thống thông tin”
select GV.*
from GIAOVIEN GV
where LUONG > all (select GV1.LUONG
				   from GIAOVIEN GV1,BOMON BM
				   where GV1.MABM = BM.MABM AND BM.TENBM = N'Hệ thống thông tin')

--Q51. Cho biết tên khoa có đông giáo viên nhất
select TENKHOA
from KHOA K join BOMON BM on K.MAKHOA = BM.MAKHOA join GIAOVIEN GV on BM.MABM = GV.MABM
group by TENKHOA
having count(GV.MAGV) >= all (select COUNT(GV1.MAGV)
							  from KHOA K1 join BOMON BM1 on K1.MAKHOA = BM1.MAKHOA join GIAOVIEN GV1 on BM1.MABM = GV1.MABM
							  group by K1.MAKHOA)

--Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
select HOTEN
from (GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT) join THAMGIADT TG on GV.MAGV = TG.MAGV
group by GV.MAGV, HOTEN
having count(distinct TG.MADT) >= all (select count(distinct TG1.MADT)
									   from (GIAOVIEN GV1 join DETAI DT1 on GV1.MAGV = DT1.GVCNDT) join THAMGIADT TG1 on GV1.MAGV = TG1.MAGV
									   group by TG1.MAGV)

--Q53. Cho biết mã bộ môn có nhiều giáo viên nhất
select GV.MABM
from BOMON BM join GIAOVIEN GV on BM.MABM = GV.MABM
group by GV.MABM
having count(GV.MAGV) >= all (select count(GV1.MAGV)
							  from BOMON BM1 join GIAOVIEN GV1 on BM1.MABM = GV1.MABM
							  group by BM1.MABM)

--Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
select HOTEN, TENBM
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join THAMGIADT TG on GV.MAGV = TG.MAGV
group by HOTEN, TENBM
having count(distinct TG.MADT) >= all (select count(distinct TG1.MADT)
									   from GIAOVIEN GV1 join BOMON BM1 on GV1.MABM = BM1.MABM join THAMGIADT TG1 on GV1.MAGV = TG1.MAGV
									   group by TG1.MAGV)

--Q55. Cho biết tên giáo viên tham gia nhiều đề tài nhất của bộ môn HTTT.
select HOTEN
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join THAMGIADT TG on GV.MAGV = TG.MAGV
where BM.TENBM = N'Hệ thống thông tin'
group by HOTEN
having count(distinct TG.MADT) >= all (select count(distinct TG1.MADT)
									   from GIAOVIEN GV1 join BOMON BM1 on GV1.MABM = BM1.MABM join THAMGIADT TG1 on GV1.MAGV = TG1.MAGV
									   where BM1.TENBM = N'Hệ thống thông tin'
									   group by TG1.MAGV)

--Q56. Cho biết tên giáo viên và tên bộ môn của giáo viên có nhiều người thân nhất.
select HOTEN, TENBM
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join NGUOITHAN NT on GV.MAGV = NT.MAGV
group by HOTEN, TENBM
having count(NT.TEN) >= all (select count(NT1.TEN)
									   from GIAOVIEN GV1 join BOMON BM1 on GV1.MABM = BM1.MABM join NGUOITHAN NT1 on GV1.MAGV = NT1.MAGV
									   group by GV1.MAGV)

--Q57. Cho biết tên trưởng bộ môn mà chủ nhiệm nhiều đề tài nhất.
select HOTEN
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM join DETAI DT on GV.MAGV = DT.GVCNDT
group by HOTEN
having count(DT.MADT) >= all (select count(distinct DT1.MADT)
							  from GIAOVIEN GV1 join BOMON BM1 on GV1.MAGV = BM1.TRUONGBM join DETAI DT1 on GV1.MAGV = DT1.GVCNDT
							  group by GV1.MAGV)