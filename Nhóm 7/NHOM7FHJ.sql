-- TẠO DATABASE
CREATE DATABASE QUANLYCONGTY 
GO
USE QUANLYCONGTY 
GO
-- TẠO BẢNG
-- PHONGBAN
CREATE TABLE PhongBan (
  MaPB INT PRIMARY KEY,
  TenPB NVARCHAR(100) UNIQUE,
  DienThoai VARCHAR(15));
-- NHANVIEN
CREATE TABLE NhanVien (
  MaNV INT PRIMARY KEY,
  HoTen NVARCHAR(100),
  NgaySinh DATE,
  CongViec NVARCHAR(150),
  MaPB INT,
  FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB));
-- NGUOITHAN
CREATE TABLE NguoiThan (
  MaNV INT, 
  QuanHe NVARCHAR(10) CHECK (QuanHe IN (N'Vợ', N'Chồng')),
  NgayKetHon DATE NOT NULL,
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV));
-- NHACUNGCAP
CREATE TABLE NhaCungCap (
  MaNCC VARCHAR(10) PRIMARY KEY,
  TenNCC NVARCHAR(100),
  DiaChi NVARCHAR(200));
-- CUNGCAP_THIETBI
CREATE TABLE CungCap_ThietBi (
  MaPB INT,
  MaNCC VARCHAR(10),
  NgayLamViecGanNhat DATE,
  PRIMARY KEY (MaPB, MaNCC),
  FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB),
  FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC));
-- DUAN
CREATE TABLE DuAn (
  MaDA VARCHAR(10) PRIMARY KEY,
  TenDA NVARCHAR(100),
  KinhPhi MONEY,
  ThanhPho NVARCHAR(100));
-- KYNANG
CREATE TABLE KyNang (
  MaKN VARCHAR(10) PRIMARY KEY,
  ChuThich NVARCHAR(200));
-- SUDUNG_KYNANG
CREATE TABLE SuDung_KyNang (
  MaNV INT,
  MaDA VARCHAR(10),
  MaKN VARCHAR(10),
  PRIMARY KEY (MaNV, MaDA, MaKN),
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
  FOREIGN KEY (MaDA) REFERENCES DuAn(MaDA),
  FOREIGN KEY (MaKN) REFERENCES KyNang(MaKN));
-- THAMGIA_DUAN
CREATE TABLE ThamGia_DuAn (
  MaNV INT,
  MaDA VARCHAR(10),
  ThanhPho NVARCHAR(100),
  TieuBang NVARCHAR(100),
  DanSo INT,
  PRIMARY KEY (MaNV, MaDA),
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
  FOREIGN KEY (MaDA) REFERENCES DuAn(MaDA),
  UNIQUE (MaNV, ThanhPho));
-- THÊM DỮ LIỆU
-- PhongBan
INSERT INTO PhongBan (MaPB, TenPB, DienThoai) VALUES
(1, N'Phòng Nhân sự', 0123456789),
(2, N'Phòng Kỹ thuật', 0987654321),
(3, N'Phòng Kế toán', 0112233445),
(4, N'Phòng Marketing', 0556677889),
(5, N'Phòng IT', 0998877665);
-- NhanVien
INSERT INTO NhanVien (MaNV, HoTen, NgaySinh, CongViec, MaPB) VALUES
(1, N'Nguyễn Văn A', '1990-01-01', N'Nhân viên hành chính', 1),
(2, N'Trần Thị B', '1991-02-02', N'Kỹ sư phần mềm', 2),
(3, N'Lê Văn C', '1989-03-03', N'Kế toán trưởng', 3),
(4, N'Phạm Thị D', '1992-04-04', N'Nhân viên truyền thông', 4),
(5, N'Hồ Văn E', '1993-05-05', N'Quản trị hệ thống', 5);
-- NguoiThan
INSERT INTO NguoiThan (MaNV, QuanHe, NgayKetHon) VALUES
(1, N'Vợ', '2015-06-01'),
(2, N'Chồng', '2016-07-02'),
(3, N'Vợ', '2014-08-03'),
(4, N'Chồng', '2018-09-04'),
(5, N'Vợ', '2020-10-05');
-- NhaCungCap
INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi) VALUES
('NCC01', N'Công ty ABC', N'123 Đường A, Hà Nội'),
('NCC02', N'Công ty DEF', N'456 Đường B, TP.HCM'),
('NCC03', N'Công ty XYZ', N'789 Đường C, Đà Nẵng'),
('NCC04', N'Công ty MNP', N'101 Đường D, Cần Thơ'),
('NCC05', N'Công ty QRS', N'202 Đường E, Huế');
-- CungCap_ThietBi
INSERT INTO CungCap_ThietBi (MaNCC, MaPB, NgayLamViecGanNhat) VALUES
('NCC01', 1, '2023-01-10'),
('NCC02', 2, '2023-02-15'),
('NCC03', 3, '2023-03-20'),
('NCC04', 4, '2023-04-25'),
('NCC05', 5, '2023-05-30');
-- 6. DuAn
INSERT INTO DuAn (MaDA, TenDA, ThanhPho, KinhPhi) VALUES
('DA01', N'Dự án A', N'Hà Nội', 50000000),
('DA02', N'Dự án B', N'TP.HCM', 75000000),
('DA03', N'Dự án C', N'Đà Nẵng', 60000000),
('DA04', N'Dự án D', N'Huế', 30000000),
('DA05', N'Dự án E', N'Cần Thơ', 45000000);
-- KyNang
INSERT INTO KyNang (MaKN, ChuThich) VALUES
('KN01', N'Lập trình'),
('KN02', N'Lên kế hoạch nhu cầu vật tư'),
('KN03', N'Quản lý dự án'),
('KN04', N'Kế toán tài chính'),
('KN05', N'Phân tích dữ liệu');
-- SuDung_KyNang
INSERT INTO SuDung_KyNang (MaNV, MaKN, MaDA) VALUES
(1, 'KN03', 'DA01'),
(2, 'KN01', 'DA02'),
(3, 'KN04', 'DA03'),
(4, 'KN02', 'DA04'),
(5, 'KN05', 'DA05');
-- ThamGia_DuAn
INSERT INTO ThamGia_DuAn (MaNV, MaDA, ThanhPho, TieuBang, DanSo) VALUES
(1, 'DA01', N'Hà Nội', N'Bắc', 8000000),
(2, 'DA02', N'TP.HCM', N'Nam', 9000000),
(3, 'DA03', N'Đà Nẵng', N'Trung', 1200000),
(4, 'DA04', N'Huế', N'Trung', 500000),
(5, 'DA05', N'Cần Thơ', N'Nam', 1500000);
---Truy vấn kết nối nhiều bảng 
 ---CÂU 1:Liệt kê họ tên nhân viên, tên phòng ban, tên dự án mà họ tham gia, và kỹ năng họ đã sử dụng trong dự án đó.
SELECT NV.HoTen, PB.TenPB, DA.TenDA, KN.ChuThich AS KyNang 
FROM NhanVien NV
JOIN PhongBan PB ON NV.MaPB = PB.MaPB
JOIN SuDung_KyNang SDK ON NV.MaNV = SDK.MaNV 
JOIN DuAn DA ON SDK.MaDA = DA.MaDA
JOIN KyNang KN ON SDK.MaKN = KN.MaKN
go
---CÂU 2: Liệt kê tên nhà cung cấp, tên phòng ban và tên dự án mà có thiết bị được cung cấp cho phòng ban đó, đồng thời nhân viên của phòng ban đó đang tham gia dự án ở thành phố trùng với thành phố của dự án.
SELECT NCC.TenNCC, PB.TenPB, DA.TenDA
FROM CungCap_ThietBi CC
JOIN PhongBan PB ON CC.MaPB = PB.MaPB
JOIN NhaCungCap NCC ON CC.MaNCC = NCC.MaNCC JOIN NhanVien NV ON PB.MaPB = NV.MaPB
JOIN ThamGia_DuAn TG ON NV.MaNV = TG.MaNV JOIN DuAn DA ON TG.MaDA = DA.MaDA
WHERE TG.ThanhPho = DA.ThanhPho
go
---UPDATE 
---CÂU 3: Đổi công việc của nhân viên ở phòng IT thành “Chuyên viên IT”
UPDATE NhanVien
SET CongViec = N'Chuyên viên IT' WHERE MaPB IN (
SELECT MaPB
FROM PhongBan
WHERE TenPB = N'Phòng IT' )
go
---CÂU 4: Cập nhật kinh phí của tất cả các dự án tại thành phố "Hà Nội" sao cho tăng thêm 10% kinh phí hiện tại nếu dự án đó có ít nhất một nhân viên tham gia sử dụng kỹ năng "Lập trình".
UPDATE DuAn
SET KinhPhi = KinhPhi * 1.1 
WHERE ThanhPho = N'Hà Nội' AND MaDA IN (
SELECT MaDA
FROM SuDung_KyNang WHERE MaKN = 'KN01' )
go
---DELETE 
---CÂU 5: Xóa các bản ghi kỹ năng "Lập trình" mà không có người thân làm chung thành phố.
DELETE FROM SuDung_KyNang 
WHERE MaKN = 'KN01'
AND MaNV NOT IN (
    SELECT NT.MaNV
    FROM NguoiThan NT
    JOIN NhanVien NV_NT ON NT.MaNV = NV_NT.MaNV
    JOIN ThamGia_DuAn TG_NT ON NV_NT.MaNV = TG_NT.MaNV 
    JOIN ThamGia_DuAn TG_NV ON NT.MaNV = TG_NV.MaNV
    WHERE TG_NT.ThanhPho = TG_NV.ThanhPho)
go
---Câu 6: Xóa các nhà cung cấp trong bảng NhaCungCap chưa từng cung cấp thiết bị cho bất kỳ phòng ban nào (không có bản ghi trong bảng CungCap_ThietBi).
DELETE FROM NhaCungCap 
WHERE NOT EXISTS ( 
SELECT *
FROM CungCap_ThietBi
WHERE CungCap_ThietBi.MaNCC = NhaCungCap.MaNCC)
go
---Group By 
---Câu 7: Danh sách phòng ban có nhiều dự án nhất:
SELECT pb.TenPB, COUNT(DISTINCT tg.MaDA) AS SoLuongDuAn
FROM PhongBan pb
JOIN NhanVien nv ON pb.MaPB = nv.MaPB
JOIN ThamGia_DuAn tg ON nv.MaNV = tg.MaNV GROUP BY pb.TenPB
ORDER BY SoLuongDuAn DESC 
GO
---Câu 8: Danh sách nhân viên tham gia từ 3 dự án trở lên:
SELECT nv.HoTen, COUNT(DISTINCT tg.MaDA) AS SoDuAnThamGia 
FROM NhanVien nv
JOIN ThamGia_DuAn tg ON nv.MaNV = tg.MaNV 
GROUP BY nv.MaNV, nv.HoTen
HAVING COUNT(DISTINCT tg.MaDA) >= 3 
GO

---SUBQUERY
---Câu 9: Danh sách phòng ban không có nhân viên tham gia dự án:
SELECT pb.TenPB
FROM PhongBan pb 
WHERE NOT EXISTS (
SELECT *
FROM NhanVien nv
JOIN ThamGia_DuAn tg ON nv.MaNV = tg.MaNV 
WHERE nv.MaPB = pb.MaPB)
GO
--Câu 10: Liệt kê các dự án không có nhân viên nào tham gia:
SELECT da.MaDA, da.TenDA, da.KinhPhi 
FROM DuAn da
WHERE da.MaDA NOT IN ( 
SELECT DISTINCT tg.MaDA
FROM ThamGia_DuAn tg) 
ORDER BY da.KinhPhi DESC 
GO
---Câu bất kỳ 
---Câu 12: Tìm tất cả các phòng ban có ngày làm việc gần nhất với nhà cung cấp trước ngày 1/4/2023 và đếm số nhân viên trong mỗi phòng ban đó.
SELECT PB.TenPB, COUNT(NV.MaNV) AS SoNhanVien
FROM PhongBan PB
JOIN CungCap_ThietBi CCTB ON PB.MaPB = CCTB.MaPB LEFT JOIN NhanVien NV ON PB.MaPB = NV.MaPB
WHERE CCTB.NgayLamViecGanNhat < '2023-04-01' GROUP BY PB.TenPB
go
---Bài cá nhân 
---23678491 – HUỲNH NGUYỄN NHỰT LINH
---Câu 1: Danh sách nhân viên và các dự án họ đang tham gia (có kỹ năng):
SELECT nv.HoTen, da.TenDA, kn.ChuThich 
FROM SuDung_KyNang sdk
JOIN NhanVien nv ON sdk.MaNV = nv.MaNV 
JOIN DuAn da ON sdk.MaDA = da.MaDA 
JOIN KyNang kn ON sdk.MaKN = kn.MaKN 
GO
---Câu 2: Tăng kinh phí 10% cho các dự án mà có ít nhất 2 nhân viên tham gia
UPDATE DuAn
SET KinhPhi = KinhPhi * 1.1 
WHERE MaDA IN ( 
SELECT MaDA
FROM ThamGia_DuAn 
GROUP BY MaDA
HAVING COUNT(MaNV) >= 2)
---Câu 3: Xóa kỹ năng chưa được nhân viên nào sử dụng
DELETE FROM KyNang 
WHERE MaKN NOT IN (SELECT DISTINCT MaKN FROM SuDung_KyNang) 
GO
---Câu 4: Đếm số nhân viên có kỹ năng theo từng loại kỹ năng, sắp xếp giảm dần:
SELECT kn.ChuThich, COUNT(DISTINCT sdk.MaNV) AS SoNhanVien 
FROM KyNang kn
JOIN SuDung_KyNang sdk ON kn.MaKN = sdk.MaKN 
GROUP BY kn.ChuThich
ORDER BY SoNhanVien DESC 
GO
---Câu 5: Nhân viên có kỹ năng thuộc loại phổ biến nhất (kỹ năng được nhiều người dùng nhất)
SELECT nv.HoTen 
FROM NhanVien nv 
WHERE MaNV IN ( 
SELECT MaNV
FROM SuDung_KyNang 
WHERE MaKN = ( 
SELECT TOP 1 MaKN
FROM SuDung_KyNang 
GROUP BY MaKN
ORDER BY COUNT(MaNV) DESC)) 
GO
---Câu 6: Phòng ban có nhiều nhân viên nhất:
SELECT TenPB
FROM PhongBan 
WHERE MaPB = (
SELECT TOP 1 MaPB
FROM NhanVien GROUP BY MaPB
ORDER BY COUNT(*) DESC) 
GO
---23673661 – NGUYỄN HỒNG HUY
--Câu 1: Danh sách họ tên của nhân viên, tên phòng ban mà họ làm việc và tên các dự án mà họ tham gia.
SELECT
NV.HoTen, PB.TenPB, DA.TenDA
FROM NhanVien NV 
JOIN PhongBan PB ON NV.MaPB = PB.MaPB 
JOIN ThamGia_DuAn TGDA ON NV.MaNV = TGDA.MaNV 
JOIN DuAn DA ON TGDA.MaDA = DA.MaDA
go
---Câu 2: Tăng kinh phí của dự án 'DA02' thêm 10%.
UPDATE DuAn
SET KinhPhi = KinhPhi * 1.1 
WHERE MaDA = 'DA02'
go
---Câu 3: Xóa tất cả các nhân viên khỏi bảng NhanVien không tham gia vào bất kỳ dự án nào (không có trong bảng ThamGia_DuAn).
DELETE FROM NhanVien
WHERE MaNV NOT IN (SELECT DISTINCT MaNV 
FROM ThamGia_DuAn)
go
---Câu 4: Đếm số lượng nhân viên trong mỗi phòng ban. Hiển thị tên phòng ban và số lượng nhân viên.
SELECT PB.TenPB,
COUNT(NV.MaNV) AS SoLuongNhanVien 
FROM PhongBan PB 
JOIN NhanVien NV ON PB.MaPB = NV.MaPB 
GROUP BY PB.TenPB
go
---Câu 5: ---CÂU 5:Tìm thông tin của các nhân viên có cùng quan hệ vợ/chồng với nhân viên 'Nguyễn Văn A'.
SELECT *
FROM NhanVien NV
WHERE NV.MaNV IN ( SELECT NT.MaNV FROM NguoiThan NT
WHERE NT.QuanHe IN ( SELECT NT2.QuanHe FROM NguoiThan NT2
WHERE NT2.MaNV = ( SELECT MaNV FROM NhanVien
WHERE HoTen = N'Nguyễn Văn A' ) )
AND NT.MaNV = ( SELECT MaNV FROM NhanVien
WHERE HoTen = N'Nguyễn Văn A' ) )
go
---23691991 – NGUYỄN THỊ THÀNH NHÀN
---Câu 1: Hãy liệt kê danh sách các nhân viên, bao gồm tên của họ, kỹ năng mà họ sử dụng, và tên dự án mà kỹ năng đó được áp dụng. Chỉ lấy thông tin đối với những dự án có kinh phí thực hiện lớn hơn 50 triệu đồng.
SELECT NV.HoTen, KN.ChuThich AS KyNang, DA.TenDA FROM NhanVien NV
JOIN SuDung_KyNang SDK ON NV.MaNV = SDK.MaNV JOIN KyNang KN ON SDK.MaKN = KN.MaKN
JOIN DuAn DA ON SDK.MaDA = DA.MaDA WHERE DA.KinhPhi > 50000000
go
---Câu 2: Cập nhật lại công việc của các nhân viên thuộc phòng IT thành "Kỹ thuật viên hệ thống" nếu họ đang tham gia ít nhất một dự án có kinh phí từ 40 triệu trở lên.
UPDATE NhanVien
SET CongViec = N'Kỹ thuật viên hệ thống'
WHERE MaPB = (SELECT MaPB FROM PhongBan WHERE TenPB = N'Phòng IT')
AND MaNV IN ( SELECT MaNV
FROM ThamGia_DuAn TG
JOIN DuAn DA ON TG.MaDA = DA.MaDA WHERE DA.KinhPhi >= 40000000 )
go
---Câu 3: Xóa các bản ghi trong bảng SuDung_KyNang của những nhân viên đang sử dụng kỹ năng "Lập trình" (KN01) nhưng không có người thân làm việc tại cùng thành phố với dự án họ tham gia.
DELETE FROM SuDung_KyNang
WHERE MaKN = 'KN05'
  AND MaNV NOT IN (
    SELECT NT.MaNV
    FROM NguoiThan NT
    JOIN NhanVien NV2 ON NT.MaNV = NV2.MaNV
    JOIN ThamGia_DuAn TGDA ON NV2.MaNV = TGDA.MaNV
    WHERE TGDA.ThanhPho IN (
      SELECT ThanhPho
      FROM ThamGia_DuAn TGDA2
      WHERE TGDA2.MaNV = SuDung_KyNang.MaNV))
go
---Câu 4: Tính tổng số kinh phí của các dự án mà nhân viên trong các phòng ban có nhân viên kết hôn sau năm 2017 tham gia, và sắp xếp theo tên phòng ban.
SELECT PB.TenPB, SUM(DA.KinhPhi) AS TongKinhPhi FROM PhongBan PB
JOIN NhanVien NV ON PB.MaPB = NV.MaPB JOIN NguoiThan NT ON NV.MaNV = NT.MaNV
JOIN ThamGia_DuAn TG ON NV.MaNV = TG.MaNV JOIN DuAn DA ON TG.MaDA = DA.MaDA
WHERE YEAR(NT.NgayKetHon) > 2017 GROUP BY PB.TenPB
ORDER BY PB.TenPB
go
---Câu 5: Liệt kê tên nhân viên và tên phòng ban của những nhân viên tham gia dự án ở thành phố có kinh phí cao nhất trong số các dự án.
SELECT NV.HoTen, PB.TenPB
FROM NhanVien NV
JOIN PhongBan PB ON NV.MaPB = PB.MaPB
JOIN ThamGia_DuAn TGDA ON NV.MaNV = TGDA.MaNV JOIN DuAn DA ON TGDA.MaDA = DA.MaDA
WHERE DA.KinhPhi = ( SELECT MAX(KinhPhi) FROM DuAn)
go
---23699001 – PHAN TRỌNG PHÚC
--Câu 1: Liệt kê tên nhân viên, tên dự án, và tên nhà cung cấp đã cung cấp thiết bị cho phòng ban của nhân viên đó, chỉ bao gồm các nhân viên có ngày sinh trước năm 1992 và tham gia dự án tại thành phố "Đà Nẵng".
SELECT NV.HoTen, DA.TenDA, NCC.TenNCC
FROM NhanVien NV
JOIN ThamGia_DuAn TGDA ON NV.MaNV = TGDA.MaNV 
JOIN DuAn DA ON TGDA.MaDA = DA.MaDA
JOIN PhongBan PB ON NV.MaPB = PB.MaPB
JOIN CungCap_ThietBi CCTB ON PB.MaPB = CCTB.MaPB 
JOIN NhaCungCap NCC ON CCTB.MaNCC = NCC.MaNCC 
WHERE YEAR(NV.NgaySinh) < 1992 AND TGDA.ThanhPho = N'Đà Nẵng'
go
--Câu 2: Cập nhật công việc của tất cả nhân viên trong phòng ban "Phòng Marketing" thành "Chuyên viên truyền thông" nếu họ tham gia ít nhất một dự án có kinh phí dưới 40 triệu.
UPDATE NhanVien
SET CongViec = N'Chuyên viên truyền thông'
WHERE MaPB = (
SELECT MaPB FROM PhongBan WHERE TenPB = N'Phòng
Marketing') AND MaNV IN ( 
SELECT TGDA.MaNV
FROM ThamGia_DuAn TGDA
JOIN DuAn DA ON TGDA.MaDA = DA.MaDA 
WHERE DA.KinhPhi < 40000000 )
go
--Câu 3: Xóa tất cả các bản ghi trong bảng SuDung_KyNang liên quan đến kỹ năng "Phân tích dữ liệu" (mã KN05) của các nhân viên không có người thân làm việc ở cùng thành phố với dự án họ tham gia.
DELETE FROM SuDung_KyNang
WHERE MaKN = 'KN01'
AND MaNV NOT IN (
SELECT NT.MaNV
FROM NguoiThan NT
JOIN NhanVien NV_NT ON NT.MaNV = NV_NT.MaNV
JOIN ThamGia_DuAn TG_NT ON NV_NT.MaNV = TG_NT.MaNV
JOIN ThamGia_DuAn TG_NV ON NT.MaNV = TG_NV.MaNV
WHERE TG_NT.ThanhPho = TG_NV.ThanhPho)
go
---Câu 4: Tính số lượng kỹ năng khác nhau được sử dụng bởi mỗi phòng ban, chỉ bao gồm các phòng ban có nhân viên kết hôn trước năm 2017, và sắp xếp theo số lượng kỹ năng giảm dần.
SELECT PB.TenPB, COUNT(DISTINCT SDKN.MaKN) AS SoKyNang
FROM PhongBan PB
JOIN NhanVien NV ON PB.MaPB = NV.MaPB 
JOIN NguoiThan NT ON NV.MaNV = NT.MaNV
JOIN SuDung_KyNang SDKN ON NV.MaNV = SDKN.MaNV 
WHERE YEAR(NT.NgayKetHon) < 2017
GROUP BY PB.TenPB 
ORDER BY SoKyNang DESC
go
--Câu 5: Liệt kê tên nhân viên và tên dự án của những nhân viên tham gia dự án tại thành phố có dân số thấp nhất trong số các thành phố có dự án.
SELECT NV.HoTen, DA.TenDA
FROM NhanVien NV
JOIN ThamGia_DuAn TGDA ON NV.MaNV = TGDA.MaNV 
JOIN DuAn DA ON TGDA.MaDA = DA.MaDA
WHERE TGDA.ThanhPho = ( 
SELECT ThanhPho
FROM ThamGia_DuAn
WHERE DanSo = (SELECT MIN(DanSo) 
               FROM ThamGia_DuAn))
go
---Câu 6: Liệt kê tên phòng ban và số điện thoại của các phòng ban có nhân viên sử dụng kỹ năng "Lập trình" (mã KN01) nhưng chưa từng làm việc với nhà cung cấp có địa chỉ tại "Hà Nội".
SELECT PB.TenPB, PB.DienThoai 
FROM PhongBan PB
JOIN NhanVien NV ON PB.MaPB = NV.MaPB
JOIN SuDung_KyNang SDKN ON NV.MaNV = SDKN.MaNV 
WHERE SDKN.MaKN = 'KN01'
AND NOT EXISTS ( 
SELECT 1
FROM CungCap_ThietBi CCTB
JOIN NhaCungCap NCC ON CCTB.MaNCC = NCC.MaNCC 
WHERE CCTB.MaPB = PB.MaPB
AND NCC.DiaChi LIKE N'%Hà Nội%' )
go
---23719901 – TRẦN HOÀNG TRỌNG
--Câu 1: Liệt kê họ tên nhân viên, tên kỹ năng và tên dự án mà họ đang sử dụng kỹ năng đó để làm việc.
SELECT nv.HoTen, kn.ChuThich, da.TenDA 
FROM NhanVien nv
JOIN SuDung_KyNang sdk ON nv.MaNV = sdk.MaNV 
JOIN KyNang kn ON sdk.MaKN = kn.MaKN
JOIN DuAn da ON sdk.MaDA = da.MaDA
go
---Câu 2: Hiển thị tên các nhà cung cấp đã từng làm việc với phòng ban tên là "Công Nghệ Thông Tin".
SELECT DISTINCT ncc.TenNCC  
FROM NhaCungCap ncc
JOIN CungCap_ThietBi cc ON ncc.MaNCC = cc.MaNCC
JOIN PhongBan pb ON cc.MaPB = pb.MaPB 
WHERE pb.TenPB = 'Công Nghệ Thông Tin'
go
---Câu 3: Cập nhật số điện thoại của các phòng ban có hơn 10 nhân viên thành 'Đang cập nhật'.
UPDATE PhongBan
SET DienThoai = 'Đang cập nhật' 
WHERE MaPB IN (
SELECT MaPB 
FROM NhanVien 
GROUP BY MaPB
HAVING COUNT(*) > 10 );
---Câu 4: Xóa các kỹ năng không còn được bất kỳ nhân viên nào sử dụng
DELETE FROM KyNang 
WHERE MaKN NOT IN (
SELECT DISTINCT MaKN
FROM SuDung_KyNang )
go
---Câu 5: Liệt kê nhân viên làm nhiều dự án nhất, kèm số lượng dự án họ tham gia.
SELECT nv.HoTen, COUNT(DISTINCT sdk.MaDA) AS SoDuAn
FROM NhanVien nv
JOIN SuDung_KyNang sdk ON nv.MaNV = sdk.MaNV 
GROUP BY nv.HoTen
HAVING COUNT(DISTINCT sdk.MaDA) = ( SELECT MAX(SoLuong)
FROM (SELECT MaNV, COUNT(DISTINCT MaDA) AS SoLuong
FROM SuDung_KyNang 
GROUP BY MaNV) AS BangPhu )
go
---Câu 6: Liệt kê tên các phòng ban từng nhận thiết bị từ nhà cung cấp có địa chỉ ở Hà Nội.
SELECT DISTINCT pb.TenPB
FROM PhongBan pb
JOIN CungCap_ThietBi cc ON pb.MaPB = cc.MaPB 
JOIN NhaCungCap ncc ON cc.MaNCC = ncc.MaNCC 
WHERE ncc.DiaChi LIKE '%Hà Nội%'
go

