--Nguyễn Thị Ngọc Hải
--20127490
--20CLC09

--d. In ra tổng 3 số (Sử dụng lại stored procedure Tính tổng 2 số)
create proc sp_TinhTong2So
	@a int,
	@b int
as
	return @a+@b

go

create proc sp_TinhTong3So
	@a int,
	@b int,
	@c int
as
	declare @sum int
	exec @sum = sp_TinhTong2So @a, @b
	exec @sum = sp_TinhTong2So @sum, @c
	return @sum

go

--e. In ra tổng các số nguyên từ m đến n.
create proc sp_TongSoNguyenMN
	@m int,
	@n int
as
	declare @sum int
	declare @i int
	set @sum = 0
	set @i = @m
	while(@i <= @n)
	begin
		set @sum = @sum + @i
		set @i = @i +1
	end
	return @sum

go

--p. Thực hiện xoá một giáo viên theo mã. Nếu giáo viên có thông tin liên quan (Có thân nhân, có làm đề tài, ...) thì báo lỗi.
create proc sp_XoaGV
	@MAGV char(3)
as
begin
	if exists(select MAGV from THAMGIADT where MAGV = @MAGV)
	begin
		print N'GV đang tham gia đề tài, không thể xoá'
		return 0
	end
	if exists(select TRUONGBM from BOMON where TRUONGBM  = @MAGV)
	begin
		print N'GV đang là trưởng bộ môn, không thể xoá'
		return 0
	end
	if exists(select TRUONGKHOA from KHOA where TRUONGKHOA = @MAGV)
	begin
		print N'GV đang là trưởng khoa, không thể xoá'
		return 0
	end
	if exists(select GVCNDT from DETAI where GVCNDT = @MAGV)
	begin
		print N'GV đang chủ nhiệm đề tài, không thể xoá'
		return 0
	end
	if exists(select MAGV from GV_DT where MAGV = @MAGV)
	begin
		print N'GV_DT đang tham chiếu'
		return 0
	end
	delete from GIAOVIEN where MAGV = @MAGV
	return 1
end

go
--s. Thêm một giáo viên: Kiểm tra các quy định: Không trùng tên, tuổi > 18, lương > 0
create proc sp_ThemGV 
	@MAGV char(3), 
	@HOTEN nvarchar(50), 
	@LUONG int, 
	@PHAI nvarchar(3), 
	@NGAYSINH date, 
	@DIACHI nvarchar(50), 
	@GVQLCM char(3), 
	@MABM varchar(4)
as
begin
	if not exists(select HOTEN from GIAOVIEN where HOTEN = @HOTEN) and year(getdate())- year(@NGAYSINH) > 18 and @LUONG > 0
	begin
		insert into GIAOVIEN values (@MAGV, @HOTEN, @LUONG, @PHAI, @NGAYSINH, @DIACHI, @GVQLCM, @MABM)
		print N'Thành công'
		return 1
	end
	return 0
end