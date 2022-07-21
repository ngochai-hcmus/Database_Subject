--Nguyễn Thị Ngọc Hải
--20127490
--20CLC09

--a. In ra câu chào “Hello World !!!”.
create proc sp_HelloWorld
as
	print 'Hello World !!!'
go
--test câu a
exec sp_HelloWorld

go

--b. In ra tổng 2 số.
create proc sp_Tong2So
	@a int,
	@b int
as
begin
	declare @tong int
	set @tong = @a +@b
	print @tong
end

go
--test câu b
exec sp_Tong2So 12, 5

go

--c. Tính tổng 2 số (sử dụng biến output để lưu kết quả trả về).
create proc sp_TinhTong2So
	@a int,
	@b int,
	@tong int out
as
	set @tong = @a + @b

go
--test câu c
declare @tong int
exec sp_TinhTong2So 12, 5, @tong out
print @tong

go

--f. Kiểm tra 1 số nguyên có phải là số nguyên tố hay không.
create proc sp_KiemTraSNT
	@so int
as
begin
	declare @dem int, @i int
	set @dem = 0
	set @i = 2
	while @i < @so
	begin
		if @so % @i = 0
			set @dem = @dem + 1
		set @i = @i + 1
	end
	if @dem = 0
		return 1
	else
		return 0
end

go
--test câu f
declare @KT int
exec @KT = sp_KiemTraSNT 17
print @KT

go

--g. In ra tổng các số nguyên tố trong đoạn m, n.
create proc sp_TongSNTMN
	@m int,
	@n int
as
begin
	declare @i int
	declare @tong int
	set @i = @m
	set @tong = 0
	while @i <= @n
	begin
		declare @kt int
		exec @kt = sp_KiemTraSNT @i
		if @kt = 1
			set @tong = @tong + @i
		set @i = @i + 1
	end
	print @tong
end

go
--test câu g
exec sp_TongSNTMN 5, 12

go

--h. Tính ước chung lớn nhất của 2 số nguyên.
create proc sp_UCLN
	@a int,
	@b int
as
begin
	if @a = 0 or @b = 0
		return @a + @b
	while @a != @b
	begin
		if @a > @b
			set @a = @a - @b
		else
			set @b = @b - @a
	end
	return @a
end

go
--test câu h
declare @UC int
exec @UC = sp_UCLN 17, 24
print @UC

go

--i. Tính bội chung nhỏ nhất của 2 số nguyên.
create proc sp_BCNN
	@a int,
	@b int
as
begin
	declare @UCLN int
	exec @UCLN = sp_UCLN @a, @b
	return (@a * @b) / @UCLN
end

go
--test câu i
declare @BC int
exec @BC = sp_BCNN 17, 24
print @BC

go

--j. Xuất ra toàn bộ danh sách giáo viên.
create proc sp_XuatDSGV
as
	select * from GIAOVIEN

go
--test câu j
exec sp_XuatDSGV

go

--k. Tính số lượng đề tài mà một giáo viên đang thực hiện.
create proc sp_TinhSLDT
	@MAGV char(3),
	@SLDT int out
as
	select @SLDT = count(distinct MADT) from THAMGIADT where MAGV = @MAGV

--test câu k
declare @DT int
exec sp_TinhSLDT '001', @DT out
print @DT

go

--l. In thông tin chi tiết của một giáo viên(sử dụng lệnh print): Thông tin cá nhân, Số lượng đề tài tham gia, Số lượng thân nhân của giáo viên đó.
--Tính số lượng thân nhân
create proc sp_TinhSLTN
	@MAGV char(3),
	@SLTN int out
as
	select @SLTN = count(TEN) from NGUOITHAN where MAGV = @MAGV

go
--test số lượng thân nhân
declare @TN int
exec sp_TinhSLTN '001', @TN out
print @TN

go

create proc sp_TTChiTiet
	@MAGV char(3)
as
begin
	declare @HOTEN nvarchar(50)
	set @HOTEN = (select HOTEN from GIAOVIEN WHERE MAGV = @MAGV)
	print N'Họ tên: ' + @HOTEN
		
	declare @LUONG int
	set @LUONG = (select LUONG from GIAOVIEN WHERE MAGV = @MAGV)
	print N'Lương: ' + cast(@LUONG as varchar)

	declare @PHAI nvarchar(3)
	set @PHAI = (select PHAI from GIAOVIEN WHERE MAGV = @MAGV)
	print N'Phái: ' + @PHAI
		
	declare @NGAYSINH date
	set @NGAYSINH = (select NGAYSINH from GIAOVIEN WHERE MAGV = @MAGV)
	print N'Ngày sinh: ' + cast(@NGAYSINH as varchar)
		
	declare @DIACHI nvarchar(50)
	set @DIACHI = (select DIACHI from GIAOVIEN WHERE MAGV = @MAGV)
	print N'Địa chỉ: ' + @DIACHI

	declare @SLDT int
	exec sp_TinhSLDT @MAGV, @SLDT out
	print N'Số lượng đề tài tham gia: ' + cast(@SLDT as varchar)

	declare @SLTN int
	exec sp_TinhSLTN @MAGV, @SLTN out
	print N'Số lượng thân nhân: ' + cast(@SLTN as varchar)
end

go
--test câu l
exec sp_TTChiTiet '001'

go

--m. Kiểm tra xem một giáo viên có tồn tại hay không (dựa vào MAGV).
create proc sp_KiemTraGVTonTai
	@MAGV char(3)
as
begin
	if exists(select MAGV from GIAOVIEN where MAGV = @MAGV)
	begin
		print N'Giáo viên tồn tại'
		return 1
	end
	print N'Không tồn tại giáo viên ' + @MAGV
	return 0
end

go
--test câu m
exec sp_KiemTraGVTonTai '012'

go

--n. Kiểm tra quy định của một giáo viên: Chỉ được thực hiện các đề tài mà bộ môn của giáo viên đó làm chủ nhiệm.
create proc sp_KiemTraQDGV
	@MAGV char(3)
as
begin
	if @MAGV not in (select TG.MAGV
					 from THAMGIADT TG
					 where TG.MAGV = @MAGV
					 except
					 select TG.MAGV
					 from (THAMGIADT TG join DETAI DT on TG.MADT = DT.MADT) join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
					 where GV.MABM in (select MABM from GIAOVIEN where MAGV = @MAGV))
	and @MAGV in (select TG.MAGV from THAMGIADT TG where TG.MAGV = @MAGV)
	begin
		print N'Đúng quy định'
		return 0
	end
	print N'Không đúng quy định'
	return 1
end

go
--test câu n
exec sp_KiemTraQDGV '002'

go

--o. Thực hiện thêm một phân công cho giáo viên thực hiện một công việc của đề tài:
	--Kiểm tra thông tin đầu vào hợp lệ: giáo viên phải tồn tại, công việc phải tồn tại, thời gian tham gia phải > 0
	--Kiểm tra quy định ở câu n.
create proc sp_ThemPC
	@MAGV char(3),
	@MADT char(3),
	@SOTT int,
	@NGAYBD datetime,
	@NGAYKT datetime
as
begin
	if not exists (select MAGV from GIAOVIEN where MAGV = @MAGV)
	begin
		print N'Không thành công'
		return 0
	end
	if not exists (select MADT, SOTT from CONGVIEC where MADT = @MADT and SOTT = @SOTT)
	begin
		print N'Không thành công'
		return 0
	end
	if day(@NGAYKT) - day(@NGAYBD) < 0
	begin
		print N'Không thành công'
		return 0
	end
	if exists (select *
			   from DETAI DT join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
			   where DT.MADT = @MADT and GV.MABM in (select MABM from GIAOVIEN where MAGV = @MAGV))
	begin
		insert into THAMGIADT values (@MAGV, @MADT, @SOTT, NULL, NULL)
		print N'Thành công'
		return 1
	end
	print N'Không thành công'
	return 0
end

go
--test câu o
exec sp_ThemPC '002', '002', '4', '2/2/2020', '2/2/2022'

go

--q. In ra danh sách giáo viên của một phòng ban nào đó cùng với số lượng đề tài mà giáo viên tham gia, số thân nhân, số giáo viên mà giáo viên đó quản lý nếu có, ...
create proc sp_InDSGV
as
begin
	declare cursDSGV cursor for (select MAGV from GIAOVIEN)
	open cursDSGV
	declare @MAGV char(3)
	fetch next from cursDSGV into @MAGV
	while @@FETCH_STATUS = 0
	begin
		exec sp_TTChiTiet @MAGV
		declare @SLGVQL int
		set @SLGVQL = (select COUNT(*) from GIAOVIEN where GVQLCM = @MaGV)
		print N'Số GV quản lý: ' + cast(@SLGVQL as varchar)
		print '-------------------------------------------------'
		fetch next from cursDSGV into @MAGV
	end
	close cursDSGV
	deallocate cursDSGV
end

go
--test câu q
exec sp_InDSGV

go

--r. Kiểm tra quy định của 2 giáo viên a, b: Nếu a là trưởng bộ môn của b thì lương của a phải cao hơn lương của b. (a, b: mã giáo viên)
create proc sp_KiemTraQDLuong
	@MAGVa char(3),
	@MAGVb char(3)
as
begin
	if @MAGVa in (select TRUONGBM 
				  from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
				  where GV.MAGV = @MAGVb)
	begin
		declare @LUONGa int, @LUONGb int
		select @LUONGa = LUONG from GIAOVIEN where MAGV = @MAGVa
		select @LUONGb = LUONG from GIAOVIEN where MAGV = @MAGVb
		if @LUONGa > @LUONGb
		begin
			print N'Đúng quy định'
			return 1
		end
	print N'Không đúng quy định'
	return 0
	end
	print N'Đúng quy định'
	return 1
end

go
--test câu r
exec sp_KiemTraQDLuong '002', '003'

go

--t. Mã giáo viên được xác định tự động theo quy tắc: 
	--Nếu đã có giáo viên 001, 002, 003 thì MAGV của giáo viên mới sẽ là 004. Nếu đã có giáo viên 001, 002, 005 thì MAGV của giáo viên mới là 003.
create proc sp_XacDinhTDMaGV
	@MAGV char(3) out
as
begin
	declare @num int, @temp char(3)
	set @num = 1
	
	while (1 = 1)
	begin
		if (@num < 10)
			set @temp = '00' + cast(@num as varchar)
		else if (@num < 100)
			set @temp = '0' + cast(@num as varchar)
		else
			set @temp = cast(@num as varchar)		
		if not exists(select * from GIAOVIEN where MAGV = @temp)
		begin
				set @MAGV = @temp
				return
		end
		set @num = @num + 1
	end
end

go
--test câu t
declare @MAGV char(3)
exec sp_XacDinhTDMaGV @MAGV out
print @MAGV
