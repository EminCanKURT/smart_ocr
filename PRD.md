# SmartOCR Mobil Uygulaması Paketi PRD

## 1. Ürün Vizyonu

SmartOCR, Flutter ekosisteminde kullanılmak üzere geliştirilmiş yeniden kullanılabilir bir modüldür. Bu paket, kullanıcıların yüklediği resimlerden metinleri çıkararak, yapay zeka desteğiyle (DeepSeek API) eksik veya hatalı kısımları tamamlar. Böylece, belgeler, notlar, menüler gibi metinlerin dijital ortama aktarımında yüksek doğruluk ve kullanılabilirlik sağlanır.

## 2. Hedef Kitle

- Flutter geliştiricileri ve mobil uygulama paketleri oluşturmak isteyen ekipler.
- Görüntüden metne dönüşüm ihtiyacı olan uygulama geliştiricileri.
- Maliyet etkin, ücretsiz ya da düşük maliyetli çözümleri tercih eden kullanıcılar.

## 3. Temel Özellikler ve Uygulama Akışı

### A. Görsel Yükleme

- **Ekran:** Ana Ekran / Resim Seçim Ekranı
- **İşlev:**
  - Kullanıcı galeriden resim seçer veya kamera ile fotoğraf çeker.
  - Seçilen resim, önizleme alanında gösterilir.
  - Ücretsiz görüntü yükleme imkanı (ör. image_picker paketi).

### B. OCR İşlemi (Lokal)

- **Ekran:** OCR İşlem Ekranı (Loading ve Sonuç)
- **İşlev:**
  - Seçilen resim üzerinde Tesseract OCR veya Google ML Kit kullanılarak metin çıkarma yapılır.
  - İlk ham OCR sonucu elde edilir (Tesseract tamamen offline, ücretsiz ve açık kaynak).
  - Çıkan sonuçta belirsizlikler veya eksiklikler tespit edilebilir.

### C. AI Düzeltme (Online Hibrit)

- **Ekran:** AI Düzeltme ve Önizleme Ekranı
- **İşlev:**
  - Ham OCR sonucu, DeepSeek API (veya benzeri, ücretsiz kota sunan bir API) ile gönderilir.
  - API, metnin bağlamını değerlendirip hatalı veya eksik bölümleri tamamlar.
  - Ücretsiz kullanım kotası sayesinde ek maliyet minimum düzeydedir.
  - Kullanıcı, düzeltilmiş metni gözden geçirir ve onaylar.

### D. Sonuç ve Kaydetme

- **Ekran:** Sonuç Ekranı
- **İşlev:**
  - Düzeltilmiş metin cihazda saklanır veya paylaşılır.
  - Kullanıcı, sonuç üzerinde düzenleme yapabilir.

## 4. Teknoloji ve Mimari

- **Paket Tipi:** Flutter için yeniden kullanılabilir modül/paket
- **Framework & Dil:** Flutter & Dart
- **OCR Motoru:** Tesseract OCR (offline, ücretsiz, açık kaynak)
- **AI Düzeltme:** DeepSeek API (ücretsiz kullanım kotası mevcut, düşük maliyetli)
- **State Management & Routing:** GetX (Clean Architecture çerçevesinde)
- **Responsive Tasarım:** flutter_screenutil
- **Local Depolama:** Hive (basit veriler) / Drift (SQL tabanlı işlemler)
- **Kod Üretimi:** build_runner, hive_generator, drift_dev
- **Kod Kalitesi:** very_good_analysis

## 5. Kalite Standartları & Teslimat

- **Mimari:** Clean Architecture (Presentation, Domain, Data katmanları)
- **Kod Standartları:** SOLID prensipleri, Clean Code, modüler yapı, ayrılmış sorumluluklar
- **Test Stratejisi:** Unit, widget ve entegrasyon testleriyle sürekli entegrasyon (CI) uygulanacaktır.
- **Sürüm Planı:** Paket, pub.dev gibi platformlarda dağıtılacak; düzenli sürüm güncellemeleri ve iyileştirmeler yapılacaktır.

## 6. Kullanıcı Akışı Diyagramı (Özet)

1. **Ana Ekran:** Kullanıcı resim seçer veya kamera ile fotoğraf çeker.
2. **OCR İşlemi Ekranı:** Seçilen resim üzerinde offline OCR çalıştırılır; ham metin elde edilir.
3. **AI Düzeltme Ekranı:** Ham OCR sonucu, DeepSeek API ile düzeltilir; kullanıcıya önizleme sunulur.
4. **Sonuç Ekranı:** Düzeltilmiş metin kaydedilir veya paylaşılır.

## 7. Projenin Adım Adım Detaylı Yapılma Sırası

1. **Proje Kurulumu:**

   - Flutter projesi oluşturulur ve gerekli bağımlılıklar (get, tesseract_ocr, image_picker, flutter_screenutil, hive, drift, http, permission_handler, very_good_analysis, build_runner, hive_generator, drift_dev) eklenir.
   - Proje dosya yapısı Clean Architecture prensiplerine göre organize edilir.

2. **Temel UI ve Görsel Yükleme:**

   - Ana Ekran oluşturulur; kullanıcı resim seçebilsin veya kamera ile fotoğraf çekebilsin.
   - image_picker kullanılarak resim seçimi ve önizleme ekranı geliştirilir.

3. **OCR İşlemi:**

   - Tesseract OCR entegrasyonu gerçekleştirilir.
   - Seçilen resim üzerinde OCR çalıştırılır ve ham metin elde edilir.
   - Hatalı/eksik kısımların belirlenmesi için temel hata kontrol mekanizması eklenir.

4. **AI Düzeltme Entegrasyonu:**

   - DeepSeek API veya benzeri ücretsiz kota sunan AI düzeltme servisinin entegrasyonu sağlanır.
   - OCR sonucunu alan bir servis katmanı oluşturularak, metin AI'ya gönderilir ve düzeltilmiş metin alınır.
   - Kullanıcıya düzeltilmiş metnin önizlemesi sunulur.

5. **Veri Yönetimi ve Kaydetme:**

   - Hive ve/veya Drift kullanılarak lokal veritabanı yapılandırılır.
   - OCR ve AI düzeltme sonuçları cihazda saklanır, düzenlenebilir ve paylaşılabilir hale getirilir.

6. **State Management ve Routing:**

   - GetX kullanılarak uygulama genelinde durum yönetimi, bağımlılık enjeksiyonu ve ekranlar arası geçişler sağlanır.
   - Clean Architecture prensiplerine uygun olarak, controller ve repository yapıları oluşturulur.

7. **Responsive Tasarım:**

   - flutter_screenutil kullanılarak tüm UI elemanları farklı ekran boyutlarına göre optimize edilir.

8. **Kod Kalitesi ve Test:**

   - very_good_analysis linter'ı ve build_runner kullanılarak kod standartları sağlanır.
   - Unit, widget ve entegrasyon testleri yazılarak uygulamanın doğruluğu test edilir.

## 8. Detaylı Geliştirme Planı

### 1. Proje Yapısı ve Temel Kurulum

1. **Klasör yapısının oluşturulması**

   - PRD'de belirtilen klasör yapısını oluştur (lib/core, lib/data, lib/domain, lib/presentation vb.)
   - Gerekli boş dosyaları oluştur

2. **Bağımlılıkların eklenmesi**

   - pubspec.yaml dosyasına gerekli paketleri ekle:
     - get (state management)
     - tesseract_ocr veya google_ml_kit (OCR işlemi için)
     - image_picker (görsel seçimi için)
     - flutter_screenutil (responsive tasarım)
     - hive ve hive_flutter (lokal depolama)
     - drift (SQL tabanlı işlemler)
     - http (API istekleri)
     - permission_handler (izinler)
     - very_good_analysis (kod kalitesi)
     - build_runner, hive_generator, drift_dev (kod üretimi)

3. **Temel konfigürasyon dosyalarının oluşturulması**
   - analysis_options.yaml (very_good_analysis kuralları)
   - README.md (paket açıklaması)

### 2. Core Katmanı Geliştirme

1. **Sabitler ve Konfigürasyonlar**

   - API anahtarları, tema sabitleri, uygulama sabitleri
   - Rota tanımlamaları

2. **Yardımcı Sınıflar ve Fonksiyonlar**

   - Extension metodları
   - Yardımcı fonksiyonlar

3. **Servis Altyapısı**
   - Hata yönetimi servisi
   - Loglama servisi
   - API istek servisi (base_api_service)

### 3. Domain Katmanı Geliştirme

1. **Veri Modelleri**

   - OCR sonuç modeli
   - AI düzeltme sonuç modeli
   - Hata modelleri

2. **Repository Arayüzleri**
   - OCR repository interface
   - AI düzeltme repository interface
   - Lokal depolama repository interface

### 4. Data Katmanı Geliştirme

1. **Lokal Veri Kaynakları**

   - Hive kutuları ve adaptörleri
   - Drift veritabanı şemaları ve DAO'lar

2. **Uzak Veri Kaynakları**

   - DeepSeek API servisi
   - OCR servisi (Tesseract veya ML Kit)

3. **Repository Implementasyonları**
   - OCR repository implementasyonu
   - AI düzeltme repository implementasyonu
   - Lokal depolama repository implementasyonu

### 5. Presentation Katmanı - Temel Bileşenler

1. **Ortak Widget'lar**

   - Yükleme göstergesi
   - Hata mesajları
   - Özel butonlar
   - Kart bileşenleri

2. **GetX Controller'lar**

   - Ana controller
   - OCR controller
   - AI düzeltme controller
   - Sonuç controller

3. **Bağımlılık Enjeksiyonu**
   - GetX dependency injection kurulumu

### 6. Presentation Katmanı - Ekranlar

1. **Ana Ekran / Resim Seçim Ekranı**

   - Galeri ve kamera erişimi
   - Resim önizleme
   - İzin yönetimi

2. **OCR İşlem Ekranı**

   - Yükleme göstergesi
   - OCR işlemi
   - Sonuç gösterimi

3. **AI Düzeltme Ekranı**

   - Ham OCR sonucunun gösterimi
   - DeepSeek API entegrasyonu
   - Düzeltilmiş metin önizlemesi

4. **Sonuç Ekranı**
   - Düzeltilmiş metnin gösterimi
   - Düzenleme seçenekleri
   - Kaydetme ve paylaşma

### 7. Responsive Tasarım ve UI İyileştirmeleri

1. **ScreenUtil Entegrasyonu**

   - Tüm ekranlarda responsive tasarım
   - Farklı cihaz boyutlarına uyum

2. **Tema ve Stil İyileştirmeleri**
   - Tutarlı renk şeması
   - Tipografi
   - Animasyonlar

### 8. Test ve Kalite Kontrol

1. **Unit Testler**

   - Repository testleri
   - Servis testleri
   - Util fonksiyonları testleri

2. **Widget Testleri**

   - Ekran testleri
   - Ortak widget testleri

3. **Entegrasyon Testleri**
   - Uçtan uca akış testleri

### 9. Dokümantasyon ve Paket Yayınlama

1. **API Dokümantasyonu**

   - Tüm public API'ler için dokümantasyon

2. **Kullanım Kılavuzu**

   - README.md güncelleme
   - Örnek kullanım kodları

3. **Paket Yayınlama Hazırlıkları**
   - pub.dev için gerekli ayarlar
   - Lisans ekleme
