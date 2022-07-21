--Viết các câu truy vấn	Q27 -> Q34 trong bài tập Quản lý đề tài.
--Q27: Cho biết	số lượng giáo viên và tổng lương của họ.
select count(*) as 'Số lượng giáo viên', sum(LUONG) as 'Tổng lương'
from GIAOVIEN 

--Q28: Cho biết	số lượng giáo viên và lương trung bình của từng bộ môn
select MABM, count(*) as 'Số lượng giáo viên', avg(LUONG) as 'Lương tb'
from  GIAOVIEN
group by MABM

--Q29: Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó
select CD.TENCD, count(DT.MADT) as 'Số lượng đề tài'
from CHUDE CD, DETAI DT
where CD.MACD = DT.MACD
group by DT.MACD, CD.TENCD

--Q30: Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia
select GV.HOTEN, count(distinct TG.MADT) as 'Số lượng đề tài'
from GIAOVIEN GV, THAMGIADT TG 
where GV.MAGV = TG.MAGV
group by GV.MAGV, GV.HOTEN

--Q31: Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm 
select GV.HOTEN, count(distinct DT.MADT) as 'Số lượng đề tài'
from GIAOVIEN GV, DETAI DT
where GV.MAGV = DT.GVCNDT
group by GV.MAGV, GV.HOTEN

--Q32: Với mỗi giáo viên cho biết tên giáo viên và số người thân của giáo viên đó
select GV.HOTEN, count(NT.MAGV) as 'Số lượng người thân'
from GIAOVIEN GV, NGUOITHAN NT
where GV.MAGV = NT.MAGV
group by GV.MAGV, GV.HOTEN

--Q33: Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên
select GV.HOTEN
from GIAOVIEN GV, THAMGIADT TG
where GV.MAGV = TG.MAGV
group by GV.MAGV, GV.HOTEN
having count(distinct TG.MADT) >= 3

--Q34: Cho biết số lượng giáo viên đã tham gia vào đề tài Ứng dụng hóa học xanh 
select count(GV.MAGV) as 'Số lượng giáo viên'
from GIAOVIEN GV, DETAI DT
where GV.MAGV = DT.GVCNDT AND DT.TENDT = N'Ứng dụng hóa học xanh'
group by GV.MAGV
