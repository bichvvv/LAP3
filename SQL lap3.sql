use Quanlibanhang

--- 1. MỖI HÃNG SX CÓ BAO NHIÊU LOẠI SP
SELECT Hangsx.tenhang, COUNT(Sanpham.masp) AS so_luong_sp
FROM Hangsx
JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.tenhang
--2. TỔNG TIỀN NHẬP CỦA MỖI SẢN PHẨM NĂM 2018
SELECT masp, SUM(soluongN * dongiaN) AS TongTienNhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2020
GROUP BY masp;
--3. SẢN PHẨM CÓ TỔNG SỐ LƯỢNG XUẤT NĂM 2018 LÀ LỚN HƠN 10000 SẢN PHẨM CỦA HÃNG SAMSUNG
SELECT SANPHAM.MASP, SUM(BANGXUAT.SOLUONGX) AS TONGSOLUONGXUAT
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) as tong_soluong_xuat
FROM Sanpham
JOIN Xuat ON Sanpham.masp = Xuat.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
--4. THỐNG KÊ SỐ LƯỢNG NHÂN VIÊN NAM CỦA MỖI PHÒNG BAN
SELECT phong, COUNT(*) AS SoLuongNam
FROM Nhanvien
WHERE gioitinh = 'Nam'
GROUP BY phong
--5. TỔNG SỐ LƯỢNG NHẬP CỦA MỖI HÃNG SẢN XUẤTTRONG NĂM 2018
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) as TongSoLuongNhap
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Nhap.ngaynhap) = 2020
GROUP BY Hangsx.tenhang
--6. TỔNG LƯỢNG TIỀN XUẤT CỦA MỖI NHÂN VIÊN TRONG NĂM 2018 LÀ BAO NHIÊU
SELECT Nhanvien.tennv ,Nhanvien.manv ,SUM(Xuat.soluongX*Sanpham.giaban) as TongtienXuat
FROM Xuat
JOIN Sanpham ON Xuat.masp = Sanpham.masp
JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE YEAR(Xuat.ngayxuat) = 2019
GROUP BY Nhanvien.tennv,Nhanvien.manv 
--7. TỔNG TIỀN NHẬP CỦA MỖI NHÂN VIÊN TRONG THÁNG 8 NĂM 2018 CÓ TỔNG GIÁ TRỊ LỚN HƠN 100.000
SELECT Nhanvien.tennv ,Nhanvien.manv ,SUM(Nhap.soluongN*Sanpham.giaban) as Tongtiennhap
from Nhap 
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE YEAR(Nhap.ngaynhap) = 2020 and Month(Nhap.ngaynhap) = 07 
GROUP BY Nhanvien.manv,Nhanvien.tennv 
having SUM(Nhap.soluongN*Sanpham.giaban)  > 100000
--- 8.ĐƯA RA DANH SÁCH CÁC SẢN PHẨM ĐÃ NHẬP NHỮNG CHƯA XUẤT BAO GIỜ
SELECT SP.masp, SP.tensp
FROM Sanpham SP
LEFT JOIN Nhap N ON SP.masp = N.Masp
LEFT JOIN xuat X ON SP.masp = X.Masp
WHERE soluongN IS NOT NULL AND X.Masp IS NULL
GROUP BY SP.masp, SP.tensp
--- 9. ĐƯA RA DANH SÁCH CÁC SẨN PHẨM ĐÃ NHẬP NĂM 2018 VÀ XUẤT NĂM 2018*/
SELECT SP.mahangsx, SP.tensp
FROM SANPHAM SP
LEFT JOIN Nhap N ON SP.mahangsx = N.Masp
LEFT JOIN Xuat X ON SP.mahangsx = X.Manv
WHERE YEAR(Ngaynhap) = 2020 AND YEAR(Ngayxuat) = 2020
GROUP BY SP.mahangsx, SP.tensp
--- 10. ĐƯA RA DANH SÁCH CÁC NHÂN VIÊN VỪA NHẬP VỪA XUẤT
SELECT NV.Manv, Tennv
FROM Nhanvien NV
LEFT JOIN Nhap N ON NV.Manv = N.Manv
LEFT JOIN Xuat X ON NV.Manv = X.Manv
WHERE soluongN IS NOT NULL AND soluongX IS NOT NULL
GROUP BY NV.Manv, NV.Tennv
--- 11. ĐƯA RA DANH SÁCH CÁC NHÂN VIÊN KHÔNG THAM GIA VIỆC NHẬP XUẤT*/
SELECT NV.Manv, Tennv
FROM Nhanvien NV
LEFT JOIN Nhap N ON NV.Manv = N.Manv
LEFT JOIN Xuat X ON NV.Manv = X.Manv
WHERE soluongN IS NULL AND soluongX IS NULL
GROUP BY NV.Manv, NV.Tennv