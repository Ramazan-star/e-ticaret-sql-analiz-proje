-- ==========================================
-- E-TİCARET SQL ANALİZ PROJESİ
-- ==========================================

-- TABLOLAR

CREATE TABLE musteriler (
    musteri_id SERIAL PRIMARY KEY,
    ad_soyad VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    sehir VARCHAR(50),
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE urunler (
    urun_id SERIAL PRIMARY KEY,
    urun_adi VARCHAR(100) NOT NULL,
    kategori VARCHAR(50),
    fiyat DECIMAL(10,2) NOT NULL,
    stok INT CHECK (stok >= 0)
);

CREATE TABLE siparisler (
    siparis_id SERIAL PRIMARY KEY,
    musteri_id INT REFERENCES musteriler(musteri_id),
    siparis_tarihi DATE NOT NULL,
    durum VARCHAR(30) CHECK (durum IN ('Hazırlanıyor','Kargoda','Teslim Edildi'))
);

CREATE TABLE siparis_detaylari (
    siparis_detay_id SERIAL PRIMARY KEY,
    siparis_id INT REFERENCES siparisler(siparis_id),
    urun_id INT REFERENCES urunler(urun_id),
    adet INT CHECK (adet > 0),
    birim_fiyat DECIMAL(10,2)
);

-- ==========================================
-- ÖRNEK VERİLER
-- ==========================================

INSERT INTO musteriler (ad_soyad, email, sehir) VALUES
('Ahmet Yılmaz','ahmet@mail.com','İstanbul'),
('Mehmet Demir','mehmet@mail.com','Ankara'),
('Ayşe Kaya','ayse@mail.com','İzmir');

INSERT INTO urunler (urun_adi, kategori, fiyat, stok) VALUES
('Laptop','Elektronik',25000,10),
('Kulaklık','Elektronik',1500,50),
('Spor Ayakkabı','Giyim',3000,30);

INSERT INTO siparisler (musteri_id, siparis_tarihi, durum) VALUES
(1,'2025-02-01','Teslim Edildi'),
(2,'2025-02-05','Kargoda'),
(3,'2025-02-10','Hazırlanıyor');

INSERT INTO siparis_detaylari (siparis_id, urun_id, adet, birim_fiyat) VALUES
(1,1,1,25000),
(1,2,2,1500),
(2,3,1,3000),
(3,2,1,1500);

-- ==========================================
-- ANALİZ SORGULARI
-- ==========================================

-- 1️⃣ En Çok Satan Ürün
SELECT 
    u.urun_adi,
    SUM(sd.adet) AS toplam_satis
FROM siparis_det
