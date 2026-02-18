
-- E-TİCARET SQL ANALİZ PROJESİ (SQL SERVER)

CREATE TABLE musteriler (
    musteri_id INT PRIMARY KEY IDENTITY(1,1),
    ad_soyad VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    sehir VARCHAR(50),
    kayit_tarihi DATETIME DEFAULT GETDATE()
);

CREATE TABLE urunler (
    urun_id INT PRIMARY KEY IDENTITY(1,1),
    urun_adi VARCHAR(100) NOT NULL,
    kategori VARCHAR(50),
    fiyat DECIMAL(10,2) NOT NULL,
    stok INT CHECK (stok >= 0)
);

CREATE TABLE siparisler (
    siparis_id INT PRIMARY KEY IDENTITY(1,1),
    musteri_id INT,
    siparis_tarihi DATE NOT NULL,
    durum VARCHAR(30) CHECK (durum IN ('Hazırlanıyor','Kargoda','Teslim Edildi')),
    FOREIGN KEY (musteri_id) REFERENCES musteriler(musteri_id)
);

CREATE TABLE siparis_detaylari (
    siparis_detay_id INT PRIMARY KEY IDENTITY(1,1),
    siparis_id INT,
    urun_id INT,
    adet INT CHECK (adet > 0),
    birim_fiyat DECIMAL(10,2),
    FOREIGN KEY (siparis_id) REFERENCES siparisler(siparis_id),
    FOREIGN KEY (urun_id) REFERENCES urunler(urun_id)
);
