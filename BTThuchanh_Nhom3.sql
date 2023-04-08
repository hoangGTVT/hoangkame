﻿
use  BTTThucHanh

create table NHACUNGCAP(
  MACONGTY NVARCHAR(40) NOT NULL PRIMARY KEY,
  TENCONGTY NVARCHAR(40) NOT NULL,
  TENGIAODICH NVARCHAR(40),
  DIACHI NVARCHAR(40),
  DIENTHOAI NVARCHAR(40),
  FAX NVARCHAR(40),
  EMAIL NVARCHAR(40)

)

CREATE TABLE LOAIHANG
(
   MALOAIHANG NVARCHAR(40) NOT NULL PRIMARY KEY,
   TENLOAIHANG NVARCHAR(40) NOT NULL,
)

CREATE TABLE MATHANG
(
   MAHANG NVARCHAR(40) NOT NULL PRIMARY KEY ,
   TENHANG NVARCHAR(40) NOT NULL,
   MACONGTY NVARCHAR(40),
   MALOAIHANG NVARCHAR(40),
   SOLUONG NVARCHAR(40),
   DONVITINH NVARCHAR(40),
   GIAHANG NVARCHAR(40)
   constraint fk_NHACUNGCAP_MACONGTY
   FOREIGN KEY (MACONGTY)
   REFERENCES NHACUNGCAP(MACONGTY),
   constraint fk_LOAIHANG_MALOAIHANG
   FOREIGN KEY (MALOAIHANG)
   REFERENCES LOAIHANG(MALOAIHANG),
)

CREATE TABLE NHANVIEN
(
   MANHANVIEN NVARCHAR(40) NOT NULL PRIMARY KEY,
   HO NVARCHAR(40) NOT NULL,
   TEN NVARCHAR(40) NOT NULL,
   NGAYSINH NVARCHAR(40),
   NGAYLAMVIEC NVARCHAR(40),
   DIACHI NVARCHAR(40),
   DIENTHOAI NVARCHAR(40),
   LUONGCOBAN INT,
   PHUCAP INT

)

CREATE TABLE KHACHHANG
(
  MAKHACHHANG NVARCHAR(40) NOT NULL PRIMARY KEY,
  TENCONGTY NVARCHAR(40) NOT NULL,
  TENGIAODICH NVARCHAR(40),
  DIACHI NVARCHAR(40),
  DIENTHOAI NVARCHAR(40),
  FAX NVARCHAR(40),
  EMAIL NVARCHAR(40)
  
)

CREATE TABLE DONDATHANG 
(
  SOHOADON INT NOT NULL PRIMARY KEY ,
  MAKHACHHANG NVARCHAR(40),
  MANHANVIEN NVARCHAR(40),
  NGAYDATHANG NVARCHAR(40),
  NGAYGIAOHANG NVARCHAR(40),
  NGAYCHUYENHANG NVARCHAR(40),
  NOIGIAOHANG NVARCHAR(40)
  constraint fk_KHACHHANG_MAKHACHHANG
   FOREIGN KEY (MAKHACHHANG)
   REFERENCES KHACHHANG(MAKHACHHANG),
    constraint fk_NHANVIEN_MANHANVIEN
   FOREIGN KEY (MANHANVIEN)
   REFERENCES NHANVIEN(MANHANVIEN),
)

CREATE TABLE CHITIETDATHANG
(
  SOHOADON INT NOT NULL ,
  MAHANG nvarchar(40) not null,
  GIABAN int,
  SOLUONG smallint,
  MUCGIAMGIA numeric(2,1),
   constraint Pk_CHITIETDATHANG PRIMARY KEY (SOHOADON,MAHANG),
    constraint fk_DONDATHANG_SOHOADON
   FOREIGN KEY (SOHOADON)
   REFERENCES DONDATHANG(SOHOADON),
    constraint fk_MATHANG_MAHANG
   FOREIGN KEY (MAHANG)
   REFERENCES MATHANG(MAHANG),

)


/*Câu 2: Bổ sung ràng buộc thiết lập giá trị mặc định bằng 1 cho cột SOLUONG 
và 0 cho cột MUCGIAMGIA trong bang CHITIETDATHANG 
*/

ALTER TABLE CHITIETDATHANG
	ADD CONSTRAINT df_CHITIETDATHANG_SOLUONG
		DEFAULT 1 FOR SOLUONG
ALTER TABLE CHITIETDATHANG
	ADD CONSTRAINT df_CHITIETDATHANG_MUCGIAMGIA
		DEFAULT 0 FOR MUCGIAMGIA

/* 
Câu 3: Bổ sung cho bang DONDATHANG ràng buộc kiểm tra ngày giao hàng 
và ngày chuyển hàng phải sau hoặc bằng với ngày đặt hàng 
*/

ALTER TABLE DONDATHANG
	ADD CONSTRAINT chk_DONDATHANG_NGAYGIAOHANG
		CHECK (NGAYGIAOHANG >= NGAYDATHANG)

ALTER TABLE DONDATHANG
	ADD CONSTRAINT chk_DONDATHANG_NGAYCHUYENHANG
		CHECK (NGAYCHUYENHANG >= NGAYDATHANG)

/*
Câu 4: Bổ sung ràng buộc cho bảng NHANVIEN để đảm bảo rằng một nhân viên chỉ có thể làm việc trong công ty 
khi đủ 18 tuổi và không quá 61 tuổi
*/

ALTER TABLE NHANVIEN
	ADD CONSTRAINT chk_NHANVIEN_TUOI
		CHECK (DATEDIFF(yy, NGAYSINH, NGAYLAMVIEC) BETWEEN 18 AND 61)
/*
Cau 6:Với các bảng đã tạo được, câu lệnh: DROP TABLE nhacungcap có thể thực hiện được không? Tại sao? 
KHÔNG ĐƯỢC, VÌ TABLE NHACUNGCAP CÓ KHÓA NGOẠI LÀ MACONGTY Ở TABLE MATHANG NÊN MUỐN XÓA TABLE NHACUNGCAP TRƯỚC HẾT CHÚNG TA PHẢI XÓA DỮ LIỆU
TRONG TABLE MATHANG CÓ LIÊN QUAN ĐẾN NHACUNGCAP
*/

INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
VALUES ('NCC001', N'Công ty TNHH A', N'Quận 1', N'TP.HCM', '0901234567', '0123456789', 'info@companya.com');

INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL) 
VALUES ('NCC002', N'Công ty TNHH B',N' Quận 2', N'TP.HCM', '0909876543', '0987654321', 'info@companyb.com');

INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL) 
VALUES ('NCC003', N'Công ty TNHH C', N'Quận 3', N'TP.HCM', '0912345678', '0765432198', 'info@companyc.com');

INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL) 
VALUES ('NCC004', N'Công ty TNHH D', N'Quận 4', N'TP.HCM', '0987654321', '0123456789', 'info@companyd.com');

INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL) 
VALUES ('NCC005', N'Công ty TNHH E', N'Quận 5', N'TP.HCM', '0912345678', '0987654321', 'info@companye.com');



INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG) 
VALUES ('LH001', N'Điện thoại di động');

INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG) 
VALUES ('LH002', N'Máy tính bảng');

INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG) 
VALUES ('LH003', N'Laptop');

INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG) 
VALUES ('LH004', N'Phụ kiện điện thoại');

INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG) 
VALUES ('LH005', N'Phụ kiện máy tính bảng');


INSERT INTO NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN, PHUCAP)
VALUES
('NV001', N'Nguyễn', N'Văn A', '1990-05-01', '2010-01-01', N'Hà Nội', '0987654321', 5000000, 1000000),
('NV002', N'Trần', N'Thị B', '1995-08-21', '2015-06-15', N'Hồ Chí Minh', '0987123456', 5500000, 1500000),
('NV003', N'Lê', N'Văn C', '1993-02-15', '2013-03-22', N'Đà Nẵng', '0905123456', 6000000, 2000000),
('NV004', N'Phạm', N'Thị D', '1998-12-30', '2018-11-01', N'Nghệ An', '0909123456', 4500000, 800000),
('NV005', N'Hoàng', N'Văn E', '1985-06-25', '2005-05-15', N'Hà Tĩnh', '0978123456', 7000000, 2500000);

INSERT INTO KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
VALUES
('KH001', N'Công ty A', N'Công ty TNHH A', N'Hà Nội', '0987654321', '0431234567', 'contact@a.com'),
('KH002', N'Công ty B', N'Công ty TNHH B', N'Hồ Chí Minh', '0987123456', '0831234567', 'contact@b.com'),
('KH003', N'Công ty C', N'Công ty TNHH C', N'Đà Nẵng', '0905123456', '0231234567', 'contact@c.com'),
('KH004', N'Công ty D', N'Công ty TNHH D', N'Nghệ An', '0909123456', '0238234567', 'contact@d.com'),
('KH005', N'Công ty E', N'Công ty TNHH E', N'Hà Tĩnh', '0978123456', '0391234567', 'contact@e.com');

INSERT INTO DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
VALUES
(1, 'KH001', 'NV001', '2023-03-01', '2023-03-08', '2023-03-06', 'Hà Nội'),
(2, 'KH002', 'NV002', '2023-03-02', '2023-03-09', '2023-03-07', 'Hồ Chí Minh'),
(3, 'KH003', 'NV003', '2023-03-03', '2023-03-10', '2023-03-08', 'Đà Nẵng'),
(4, 'KH004', 'NV004', '2023-03-03', '2023-03-10', '2023-03-08', 'Cao Bằng'),
(5, 'KH005', 'NV005', '2023-03-03', '2023-03-10', '2023-03-08', 'Đà Lạt')


INSERT INTO CHITIETDATHANG (SOHOADON, MAHANG, GIABAN, SOLUONG, MUCGIAMGIA) VALUES 
(1, 'MH001', 200000, 2, 0.1),
(2, 'MH002', 150000, 3, 0),
(3, 'MH003', 300000, 1, 0),
(4, 'MH004', 500000, 2, 0.2),
(5, 'MH005', 100000, 5, 0.05)


INSERT INTO MATHANG (MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG) VALUES
('MH001', N'Laptop Dell Inspiron 14', 'NCC001', 'LH001', '10', 'Cái', '15000000'),
('MH002', N'Laptop HP Pavilion 15', 'NCC002', 'LH002', '5', 'Cái', '18000000'),
('MH003', N'Điện thoại iPhone 12 Pro Max', 'NCC003', 'LH003', '15', 'Cái', '30000000'),
('MH004', N'Điện thoại Samsung Galaxy S21 Ultra', 'NCC004', 'LH004', '20', 'Cái', '25000000'),
('MH005', N'Máy tính bảng Samsung Galaxy Tab S7', 'NCC005', 'LH005', '8', 'Cái', '18000000')


--1:Liệt kê tất cả thông tin của các mặt hàng trong bảng MATHANG.
SELECT * FROM MATHANG

--2:Liệt kê tất cả các mặt hàng có giá bán lớn hơn 20.000.000 đồng trong bảng MATHANG.
SELECT * FROM MATHANG WHERE MATHANG.GIAHANG > 20000000

--3: Liệt kê tất cả các mặt hàng có tên bắt đầu bằng chữ "Điện thoại iPhone 12 Pro Max" trong bảng MATHANG.
SELECT * FROM MATHANG WHERE TENHANG = N'Điện thoại iPhone 12 Pro Max'

--4: Liệt kê tất cả các mặt hàng có số lượng tồn kho ít hơn 10 trong bảng MATHANG.
SELECT * FROM MATHANG WHERE SOLUONG < 10

--5Liệt kê tất cả thông tin nhân viên đến từ hà nội
SELECT * FROM NHANVIEN 
where DIACHI=N'Hà Nội'

--6: in ra thông tin khách hàng có đơn đặt hàng có ngày giao hàng 2023-03-08
select * from KHACHHANG join DONDATHANG on KHACHHANG.MAKHACHHANG = DONDATHANG.MAKHACHHANG
where NGAYGIAOHANG= '2023-03-08'


--7: in ra hóa đơn có trị giá hóa đơn cao nhất có ngày giao hàng 2023-03-08
select DONDATHANG.SOHOADON, NGAYGIAOHANG, GIABAN* SOLUONG
from DONDATHANG join CHITIETDATHANG on DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON
where NGAYGIAOHANG= '2023-03-08'


--8: In thông tin nhân viên xuất hóa đơn trong ngày 2023-03-01
select NHANVIEN.MANHANVIEN, HO, TEN,SOHOADON ,NGAYDATHANG 
from  NHANVIEN join DONDATHANG on NHANVIEN.MANHANVIEN= DONDATHANG.MANHANVIEN
where NGAYDATHANG='2023-03-01'

--9: In ra thông tin công ty cung cấp các mặt hàng.
select NHACUNGCAP.MACONGTY, TENCONGTY,MATHANG.MAHANG, TENHANG
from NHACUNGCAP join MATHANG on NHACUNGCAP.MACONGTY = MATHANG.MACONGTY

--10: In ra tên loại hàng có số lượng nhiều hơn 10
select MATHANG.MALOAIHANG, TENLOAIHANG, SOLUONG
from LOAIHANG join MATHANG on LOAIHANG.MALOAIHANG=MATHANG.MALOAIHANG
where SOLUONG>10
--11: in ra thông tin nhân viên xuất hóa đơn có trị giá hóa đơn giảm dần
select NHANVIEN.MANHANVIEN, HO, TEN, (GIABAN*SOLUONG-MUCGIAMGIA*(GIABAN*SOLUONG))as TRIGIAHOADON
from NHANVIEN join DONDATHANG on NHANVIEN.MANHANVIEN= DONDATHANG.MANHANVIEN
              join CHITIETDATHANG on DONDATHANG.SOHOADON = CHITIETDATHANG.SOHOADON
ORDER BY TRIGIAHOADON DESC

--12: iN RA THÔNG IN KHACH HÀNG CÓ  TRI GIÁ HÓA ĐƠN CAO NHẤT
SELECT KHACHHANG.MAKHACHHANG, TENGIAODICH, DIACHI, DONDATHANG.SOHOADON,(GIABAN*SOLUONG-MUCGIAMGIA*(GIABAN*SOLUONG))as TRIGIAHOADON
FROM KHACHHANG JOIN DONDATHANG ON KHACHHANG.MAKHACHHANG= DONDATHANG.MAKHACHHANG
               JOIN CHITIETDATHANG ON DONDATHANG.SOHOADON= CHITIETDATHANG.SOHOADON
AND CHITIETDATHANG.SOHOADON = (SELECT CHITIETDATHANG.SOHOADON
			FROM CHITIETDATHANG
			WHERE (GIABAN*SOLUONG-MUCGIAMGIA*(GIABAN*SOLUONG)) = (SELECT MAX(GIABAN*SOLUONG-MUCGIAMGIA*(GIABAN*SOLUONG))
							FROM KHACHHANG JOIN DONDATHANG ON KHACHHANG.MAKHACHHANG= DONDATHANG.MAKHACHHANG
               JOIN CHITIETDATHANG ON DONDATHANG.SOHOADON= CHITIETDATHANG.SOHOADON))

--13:Hiển thị tên hàng được bán ra trong ngày 2023-03-01
select MATHANG.MAHANG, TENHANG, DONDATHANG.SOHOADON, NGAYDATHANG
from MATHANG join CHITIETDATHANG on MATHANG.MAHANG = CHITIETDATHANG.MAHANG
             join DONDATHANG on CHITIETDATHANG.SOHOADON=DONDATHANG.SOHOADON
where NGAYDATHANG='2023-03-01'

--14: Lấy re thông tin khách hàng và mặt hàng mà khách hàng đó đã mua
select KHACHHANG.MAKHACHHANG , TENGIAODICH, DIACHI, DONDATHANG.SOHOADON, GIABAN, CHITIETDATHANG.SOLUONG, TENHANG
from KHACHHANG join DONDATHANG on KHACHHANG.MAKHACHHANG= DONDATHANG.MAKHACHHANG
               join CHITIETDATHANG on DONDATHANG.SOHOADON= CHITIETDATHANG.SOHOADON
			   join  MATHANG on CHITIETDATHANG.MAHANG= MATHANG.MAHANG

--15: lấy ra top 3 khách hàng có trị giá hóa đơn cao nhất
--11: Lấy ra top 3 khách hàng có trị giá hóa đơn cao nhất
select top (3) KHACHHANG.MAKHACHHANG, TENGIAODICH, DIACHI, DONDATHANG.SOHOADON,(GIABAN*SOLUONG-MUCGIAMGIA*(GIABAN*SOLUONG))as TRIGIAHOADON
FROM KHACHHANG JOIN DONDATHANG ON KHACHHANG.MAKHACHHANG= DONDATHANG.MAKHACHHANG
               JOIN CHITIETDATHANG ON DONDATHANG.SOHOADON= CHITIETDATHANG.SOHOADON
  
 ORDER BY TRIGIAHOADON DESC
