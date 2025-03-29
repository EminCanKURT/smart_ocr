# Smart OCR Örnek Uygulaması

Bu örnek uygulama, Smart OCR paketinin nasıl kullanılacağını göstermektedir. Uygulama, görüntülerden metin çıkarma, AI ile metin düzeltme ve sonuçları görüntüleme işlevlerini içerir.

## Başlangıç

Bu örnek uygulamayı çalıştırmak için aşağıdaki adımları izleyin:

1. Projeyi klonlayın:

```bash
git clone https://github.com/kullaniciadi/smart_ocr.git
cd smart_ocr/example
```

2. Bağımlılıkları yükleyin:

```bash
flutter pub get
```

3. Uygulamayı çalıştırın:

```bash
flutter run
```

## Özellikler

- **Görüntü Yükleme**: Kamera veya galeriden görüntü yükleme
- **OCR İşlemi**: Görüntüden metin çıkarma
- **AI Düzeltme**: Çıkarılan metni AI ile düzeltme
- **Sonuç Görüntüleme**: Düzeltilmiş metni görüntüleme ve paylaşma

## Ekran Görüntüleri

![Ana Ekran](screenshots/home_screen.png)
![OCR İşlemi](screenshots/ocr_process_screen.png)
![AI Düzeltme](screenshots/ai_correction_screen.png)
![Sonuç Ekranı](screenshots/result_screen.png)

## Kullanım

1. Ana ekrandan "Görüntü Yükle" butonuna tıklayın.
2. Kamera veya galeriden bir görüntü seçin.
3. OCR işlemi otomatik olarak başlayacaktır.
4. OCR işlemi tamamlandıktan sonra, AI düzeltme ekranına yönlendirileceksiniz.
5. AI düzeltme işlemi tamamlandıktan sonra, sonuç ekranına yönlendirileceksiniz.
6. Sonuç ekranında düzeltilmiş metni görüntüleyebilir ve paylaşabilirsiniz.

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Daha fazla bilgi için [LICENSE](../LICENSE) dosyasına bakın.
