-- TẠO DATABASE
CREATE DATABASE QLCT
GO
USE QLCT
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
  MaNVNT INT,
  QuanHe NVARCHAR(10) CHECK (QuanHe IN (N'Vợ', N'Chồng')),
  NgayKetHon DATE NOT NULL,
  PRIMARY KEY (MaNV, MaNVNT),
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
  FOREIGN KEY (MaNVNT) REFERENCES NhanVien(MaNV));
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
INSERT INTO NguoiThan (MaNV, MaNVNT, QuanHe, NgayKetHon) VALUES
(1, 2, N'Vợ', '2015-06-01'),
(2, 3, N'Chồng', '2016-07-02'),
(3, 4, N'Vợ', '2014-08-03'),
(4, 5, N'Chồng', '2018-09-04'),
(5, 1, N'Vợ', '2020-10-05');
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
INSERT INTO ThamGia_DuAn (MaNV, MaDA, ThanhPho, Ti, DanSo) VALUES
(1, 'DA01', N'Hà Nội', N'Bắc', 8000000),
(2, 'DA02', N'TP.HCM', N'Nam', 9000000),
(3, 'DA03', N'Đà Nẵng', N'Trung', 1200000),
(4, 'DA04', N'Huế', N'Trung', 500000),
(5, 'DA05', N'Cần Thơ', N'Nam', 1500000);
