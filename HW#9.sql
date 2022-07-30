--R1. Tên đề tài phải duy nhất
--			I	D	U
--	DETAI	+	-	+(TENDT)
create trigger R1 on DETAI
for insert, update
as
	if(update(TENDT))
	begin
		if exists(select *
				  from inserted I join DETAI DT on I.TENDT = DT.TENDT
				  group by I.TENDT
				  having count(*) > 1)
		begin
			raiserror(N'Tên đề tài phải duy nhất',16,1)
			rollback
		end
	end

--test R1
select * from DETAI

insert into DETAI(MADT, TENDT) values ('111', N'HTTT quản lý các trường ĐH')

update DETAI set TENDT = N'Nghiên cứu tế bào gốc' where MADT = '001'

go
--R2. Trưởng bộ môn phải sinh trước 1975
--			I	D	U
-- GIAOVIEN	-	-	+(NGAYSINH)	
-- BOMON	+	-	+(TRUONGBM)
create trigger R2_GV on GIAOVIEN
for update
as
	if(update(NGAYSINH))
	begin
		if exists(select *
				  from inserted I
				  where year(I.NGAYSINH) >= 1975 and I.MAGV in (select TRUONGBM from BOMON))
		begin
			raiserror(N'Trưởng bộ môn phải sinh trước 1975',16,1)
			rollback
		end
	end

--test R2_GV
select * from GIAOVIEN where MAGV in (select TRUONGBM from BOMON)

update GIAOVIEN set NGAYSINH = '2/2/2020' where MAGV = '001'

go

create trigger R2_BM on BOMON
for insert, update
as
	if (update(TRUONGBM))
	begin
		if exists(select *
				  from GIAOVIEN
				  where year(NGAYSINH) >= 1975 and MAGV in (select TRUONGBM from inserted))
		begin
			raiserror(N'Trưởng bộ môn phải sinh trước 1975',16,1)
			rollback
		end
	end

--test R2_BM
select * from BOMON

insert into BOMON(MABM, TRUONGBM) values ('111', '006')

update BOMON set TRUONGBM = '007' where MABM = 'CNTT'

go
--R3. Một bộ môn có tối thiểu 1 giáo viên nữ
--			I	D	U
-- GIAOVIEN	-	+	+(PHAI)	
create trigger R3 on GIAOVIEN
for delete, update
as
begin
	if update(PHAI)
	begin
		if not exists(select *
					  from deleted D join GIAOVIEN GV on D.MABM = GV.MABM
					  where GV.PHAI = N'Nữ')
		begin
			raiserror(N'Một bộ môn có tối thiểu 1 giáo viên nữ',16,1)
			rollback
		end
	end
end

--test R3
select * from GIAOVIEN

update GIAOVIEN set PHAI = N'Nam' where MAGV = '006'

go
--R4. Một giáo viên phải có ít nhất 1 số điện thoại
--			I	D	U
-- GIAOVIEN	+	-	+(MAGV)
-- GV_DT	-	+	+(MAGV)
create trigger R4_GV on GIAOVIEN
for insert, update
as
	if(update(MAGV))
	begin
		if not exists(select *
					  from GV_DT
					  where MAGV in (select I.MAGV from inserted I))
		begin
			raiserror(N'Một giáo viên phải có ít nhất 1 số điện thoại',16,1)
			rollback
		end
	end

--test R4_GV
insert into GIAOVIEN(MAGV) values ('111')

go

create trigger R4_GV_DT on GV_DT
for delete, update
as
	begin
		if(not exists(select *
					  from GV_DT
					  where MAGV in (select MAGV from deleted)))
			begin
				raiserror(N'Một giáo viên phải có ít nhất 1 số điện thoại', 16, 1)
				rollback
			end
	end

--test R4_GV_DT
select * from GV_DT

delete from GV_DT where MAGV = '002'

go
--R5. Một giáo viên có tối đa 3 số điện thoại
--			I	D	U
-- GIAOVIEN	-	-	+(MAGV)
-- GV_DT	+	-	+(MAGV)
create trigger R5_GV on GIAOVIEN
for update
as
	if(update(MAGV))
	begin
		if exists(select *
				  from inserted I join GV_DT GD on I.MAGV = GD.MAGV
				  group by I.MAGV
				  having count(*) > 3)
		begin
			raiserror(N'Một giáo viên có tối đa 3 số điện thoại',16,1)
			rollback
		end
	end

go

create trigger R5_GV_DT on GV_DT
for insert, update
as
	if(update(MAGV))
	begin
		if exists (select *
				   from GV_DT
				   where MAGV in (select I.MAGV from inserted I)
				   group by MAGV
				   having count(*) > 3)
		begin
			raiserror(N'Một giáo viên có tối đa 3 số điện thoại',16,1)
			rollback
		end
	end

--test R5_GV_DT
select * from GV_DT where MAGV = '003'

insert into GV_DT(MAGV, DIENTHOAI) values ('003','003')

update GV_DT set MAGV = '001' where MAGV = '002'

go
--R6. Một bộ môn phải có tối thiểu 4 giáo viên
--			I	D	U
-- GIAOVIEN	-	+	+(MABM)	
create trigger R6 on GIAOVIEN
for delete, update
as
	if(update(MABM))
	begin
		if exists(select *
				  from deleted D join BOMON BM on D.MABM = BM.MABM
				  group by D.MAGV
				  having count(*) < 4)
			begin
				raiserror(N'Một bộ môn phải có tối thiểu 4 giáo viên', 16, 1)
				rollback
			end
	end

--test R6
update GIAOVIEN set MABM = 'MMT' where MAGV = '002'

go
--R7. Trưởng bộ môn phải là người lớn tuổi nhất trong bộ môn.
--			I	D	U
-- GIAOVIEN	-	-	+(NGAYSINH)
-- BOMON	+	-	+(TRUONGBM)
create trigger R7_GV on GIAOVIEN
for update
as
	if(update(NGAYSINH))
	begin
		if not exists(select *
					  from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM
					  where BM.MABM in (select I.MABM from inserted I)
						 and year(GV.NGAYSINH) <= all (select year(GV1.NGAYSINH)
													   from GIAOVIEN GV1
													   where GV1.MABM = BM.MABM)) 
		begin
			raiserror(N'Trưởng bộ môn phải là người lớn tuổi nhất trong bộ môn.',16,1)
			rollback
		end
	end

go

create trigger R7_BM on BOMON
for insert, update
as
	if(update(TRUONGBM))
	begin
		if not exists(select *
					  from GIAOVIEN GV
					  where GV.MAGV in (select TRUONGBM from inserted)
						and year(GV.NGAYSINH) <= all(select year(GV1.NGAYSINH)
													 from GIAOVIEN GV1
													 where GV.MABM = GV1.MABM)) 
		begin
			raiserror(N'Trưởng bộ môn phải là người lớn tuổi nhất trong bộ môn.',16,1)
			rollback
		end
	end

--test R7
update GIAOVIEN set NGAYSINH = '1/1/1970' where MAGV = '009' 