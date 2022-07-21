--Q63. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn Hóa Hữu Cơ tham gia.
select distinct DT.TENDT 
from DETAI DT,GIAOVIEN GV1
where GV1.MABM in (select MABM from BOMON BM where BM.TENBM = N'Hóa hữu cơ')
and not exists((select GV.MAGV 
				from GIAOVIEN GV, BOMON BM
				WHERE GV.MABM = BM.MABM and BM.TENBM = N'Hóa hữu cơ')
                except
			   (select TG.MAGV 
			    from THAMGIADT TG
				where DT.MADT=TG.MADT))


--Q64. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài 006.
select KQ.HOTEN
from GIAOVIEN KQ
where not exists (select C.MADT, C.SOTT
				  from CONGVIEC C
				  where C.MADT = '006'
				  except
				  select BC.MADT, BC.STT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q65. Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề Ứng dụng công nghệ.
select KQ.*
from GIAOVIEN KQ
where not exists (select C.MADT
				  from DETAI C
				  where C.MACD in (select MACD from CHUDE where CHUDE.TENCD = N'Ứng dụng công nghệ')
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q66. Cho biết tên giáo viên nào đã tham gia tất cả các đề tài của do Trần Trà Hương làm chủ nhiệm.
select KQ.HOTEN
from GIAOVIEN KQ
where not exists (select C.MADT
				  from DETAI C
				  where C.GVCNDT in (select MAGV from GIAOVIEN GV where GV.HOTEN = N'Trần Trà Hương')
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q67. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa CNTT tham gia.
select KQ.TENDT
from DETAI KQ
where not exists (select C.MAGV
				  from GIAOVIEN C
				  where MABM in (select MABM from BOMON BM where BM.MAKHOA = 'CNTT')
				  except
				  select BC.MAGV
				  from THAMGIADT BC
				  where BC.MADT = KQ.MADT)

--Q68. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài Nghiên cứu tế bào gốc.
select KQ.HOTEN
from GIAOVIEN KQ
where not exists (select C.MADT, C.SOTT
				  from CONGVIEC C
				  where C.MADT in (select MADT from DETAI where DETAI.TENDT = N'Nghiên cứu tế bào gốc')
				  except
				  select BC.MADT, BC.STT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q69. Tìm tên các giáo viên được phân công làm tất cả các đề tài có kinh phí trên 100 triệu?
select KQ.HOTEN
from GIAOVIEN KQ
where not exists (select C.MADT
				  from DETAI C
				  where C.KINHPHI > 100
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)

--Q70. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
select KQ.TENDT
from DETAI KQ
where not exists (select C.MAGV
				  from GIAOVIEN C
				  where MABM in (select MABM from BOMON BM where BM.MAKHOA in (select K.MAKHOA from KHOA K where K.TENKHOA = N'Sinh học'))
				  except
				  select BC.MAGV
				  from THAMGIADT BC
				  where BC.MADT = KQ.MADT)

--Q71. Cho biết mã số, họ tên, ngày sinh của giáo viên tham gia tất cả các công việc của đề tài “Ứng dụng hóa học xanh”.
select GV.MAGV, GV.HOTEN, GV.NGAYSINH
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
where TG.MADT in (select MADT from DETAI where DETAI.TENDT = N'Ứng dụng hóa học xanh')
group by GV.MAGV, GV.HOTEN, GV.NGAYSINH
having count (distinct TG.STT) = (select count(SOTT)
								  from CONGVIEC
								  where CONGVIEC.MADT in (select MADT from DETAI where DETAI.TENDT = N'Ứng dụng hóa học xanh'))

--Q72. Cho biết mã số, họ tên, tên bộ môn và tên người quản lý chuyên môn của giáo viên tham gia tất cả các đề tài thuộc chủ đề “Nghiên cứu phát triển”.
select KQ.MAGV, KQ.HOTEN, BM.TENBM, QL.HOTEN as N'GVQLCM'
from (GIAOVIEN KQ join BOMON BM on KQ.MABM = BM.MABM) join GIAOVIEN QL on KQ.GVQLCM = QL.MAGV
where not exists (select C.MADT
				  from DETAI C
				  where C.MACD in (select MACD from CHUDE where CHUDE.TENCD = N'Nghiên cứu phát triển')
				  except
				  select BC.MADT
				  from THAMGIADT BC
				  where BC.MAGV = KQ.MAGV)
