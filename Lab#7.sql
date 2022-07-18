--Nguyễn Thị Ngọc Hải
--20127490
--20CLC09

--Q58. Cho biết tên giáo viên nào mà tham gia đề tài đủ tất cả các chủ đề.
select KQ.HOTEN
from GIAOVIEN KQ
where not exists (select C.MADT
				  from DETAI C
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q59. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
select KQ.TENDT
from DETAI KQ
where not exists (select C.MAGV
				  from GIAOVIEN C
				  where MABM = 'HTTT'
				  except
				  select BC.MAGV
				  from THAMGIADT BC
				  where BC.MADT = KQ.MADT)

--Q60. Cho biết tên đề tài có tất cả giảng viên bộ môn “Hệ thống thông tin” tham gia
select KQ.TENDT
from DETAI KQ
where not exists (select C.MAGV
				  from GIAOVIEN C
				  where MABM in (select MABM from BOMON BM where BM.TENBM = N'Hệ thống thông tin')
				  except
				  select BC.MAGV
				  from THAMGIADT BC
				  where BC.MADT = KQ.MADT)

--Q61. Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD.
select KQ.*
from GIAOVIEN KQ
where not exists (select C.MADT
				  from DETAI C
				  where C.MACD = 'QLGD'
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q62. Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia.
select KQ.HOTEN
from GIAOVIEN KQ
where not exists (select C.MADT
				  from THAMGIADT C
				  where C.MAGV in (select MAGV from GIAOVIEN GV where GV.HOTEN = N'Trần Trà Hương')
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV and KQ.HOTEN != N'Trần Trà Hương')
