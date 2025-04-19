# Yegitek Todo

Yegitek Todo projesi

## Kurulum

### Ortam Değişkenleri

Bu proje Firebase kullanıyor ve API anahtarları için envied kullanılıyor. Projeyi çalıştırmak için:

1. `.env.example` dosyasını kopyalayıp `.env` adıyla kaydedin:
   ```
   cp .env.example .env
   ```

2. `.env` dosyasını gerçek Firebase yapılandırma değerlerinizle güncelleyin.

3. Envied kodlarını oluşturmak için aşağıdaki komutu çalıştırın:
   ```
   flutter pub run build_runner build
   ```

4. Artık projeyi çalıştırabilirsiniz:
   ```
   flutter run
   ```