CREATE TABLE nguoidung(
tenDangNhap VARCHAR(50) PRIMARY KEY,
matKhau VARCHAR(255),
hoVaTen NVARCHAR(255),
email VARCHAR(255),
ngaySinh DATE);

CREATE TABLE theLoai (
maTheLoai VARCHAR(50) PRIMARY KEY,
tenTheLoai NVARCHAR(255));

CREATE TABLE baiBao(
maBaiBao VARCHAR(50) PRIMARY KEY,
tenBaiBao NVARCHAR(500),
moTa TEXT CHARACTER SET UTF8MB4,
filePath VARCHAR(500),
noiDung TEXT CHARACTER SET UTF8MB4,
ngayDang DATE,
tenDangNhap VARCHAR(50),
luotXem INT,
FOREIGN KEY (tenDangNhap) REFERENCES nguoidung(tenDangNhap));

CREATE TABLE theLoaiChinh(
maBaiBao VARCHAR(50) PRIMARY KEY,
maTheLoai VARCHAR(50),
FOREIGN KEY(maBaiBao) REFERENCES baibao(maBaiBao),
FOREIGN KEY(maTheLoai) REFERENCES theloai(maTheLoai));

CREATE TABLE danhSachTheLoaiPhu(
maTheLoai VARCHAR(50),
maBaiBao VARCHAR(50),
PRIMARY KEY(maTheLoai, maBaiBao),
FOREIGN KEY(maTheLoai) REFERENCES theLoai(maTheLoai),
FOREIGN KEY(maBaiBao) REFERENCES baibao(maBaiBao));

CREATE TABLE binhLuan(
maBinhLuan VARCHAR(50) PRIMARY KEY,
tenDangNhap VARCHAR(50),
maBaiBao VARCHAR(50),
noiDung TEXT CHARACTER SET UTF8MB4,
ngayBinhLuan DATE,
FOREIGN KEY (tenDangNhap) REFERENCES nguoidung(tenDangNhap),
FOREIGN KEY(maBaiBao) REFERENCES baibao(maBaiBao));
