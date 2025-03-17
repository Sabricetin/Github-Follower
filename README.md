# GitHub Takipçi Uygulaması (GFollower)

Bu uygulama, GitHub kullanıcılarının takipçilerini görüntülemelerini, favorilere eklemelerini ve detaylarını incelemelerini sağlar. **Swift** programlama dili ile **UIKit** kullanılarak geliştirilmiştir. Uygulama, **MVVM (Model-View-ViewModel)** tasarım desenine uygun olarak yapılandırılmıştır.

## Özellikler

- GitHub kullanıcılarını arama
- Kullanıcıların takipçilerini listeleme
- Takipçileri favorilere ekleyip çıkarma
- Kullanıcı detaylarını gösterme
- Yerel veri depolama (UserDefaults kullanımı)

## Proje Yapısı

### **Modeller (Models)**
- **Follower.swift**: GitHub takipçilerini temsil eden model.
- **User.swift**: Kullanıcı bilgilerini içeren model.

### **Ağ Yönetimi (Networking)**
- **NetworkManager.swift**: GitHub API’si ile veri alışverişini sağlayan HTTP istek yöneticisi.

### **Veri Depolama (Persistence)**
- **PersistenceManager.swift**: Kullanıcının favori takipçilerini **UserDefaults** ile saklayan yönetici.

### **Kullanıcı Arayüzü Bileşenleri (UI Components)**
Özel bileşenler:
- **GFTitleLabel.swift, GFBodyLabel.swift, GFSecondaryTitleLabel.swift**: Uygulamada kullanılan özel metin etiketleri.
- **GFAvatarImageView.swift**: Kullanıcıların profil fotoğraflarını yükleyen özel bileşen.
- **GFTextField.swift**: Arama alanı için özelleştirilmiş metin kutusu.
- **GFButton.swift**: Kullanıcı etkileşimleri için tasarlanmış özel butonlar.
- **GFEmptyStateView.swift**: Veri olmadığında gösterilen özel bileşen.
- **GFItemInfoView.swift**: Kullanıcı detay sayfasındaki bilgi bölümleri.
- **GFAlertContainerView.swift**: Özel uyarı mesajlarını içeren görüntü bileşeni.

### **Ekran Denetleyicileri (ViewControllers)**
- **SearchVC.swift**: Kullanıcıların GitHub hesaplarını aramalarını sağlar.
- **FollowerListVC.swift**: Seçilen kullanıcının takipçilerini listeleyen ekran.
- **FavoritesListVC.swift**: Kullanıcının favori takipçilerini gösteren ekran.
- **UserInfoVC.swift**: Seçilen kullanıcının detaylarını içeren sayfa.
- **GFITemInfoVC.swift, GfRepoItemVC.swift, GFFollowerItemVC.swift**: Kullanıcı detay ekranındaki alt bölümler.
- **GFAlertVC.swift**: Uyarı mesajlarını yönetir ve gösterir.
- **GFUserInfoHeaderVC.swift**: Kullanıcı detaylarının başlık kısmını gösterir.
- **GFDataLoadingVC.swift**: Veri yükleme sürecini yöneten yapı.

### **Uzantılar (Extensions)**
Yardımcı işlevler içeren ek kodlar:
- **UIViewController+Ext.swift**: UIViewController ile ilgili yardımcı metotlar.
- **Data+Ext.swift**: Veri dönüşümleri için uzantılar.
- **String+Ext.swift**: String işlemleri için ek fonksiyonlar.
- **UIView+Ext.swift, UITableView+Ext.swift**: UI bileşenlerine yönelik ek işlevler.

### **Yardımcı Dosyalar (Utilities)**
- **UIHelper.swift**: UI bileşenlerinin yönetimini kolaylaştıran yardımcı sınıf.
- **Constants.swift**: Uygulama genelinde kullanılan sabit değerler.
- **ErrorMessage.swift**: Hata mesajlarını yönetmek için kullanılan yapı.

## Kullanılan Teknolojiler

- **Swift & UIKit**
- **MVVM Tasarım Deseni**
- **Ağ Yönetimi (URLSession, Alamofire ile genişletilebilir)**
- **Yerel Depolama (UserDefaults)**
- **AutoLayout & Programatik Arayüz Tasarımı**

## Kurulum

1. **Projeyi klonlayın:**
   ```sh
   git clone https://github.com/kullanici/gfollower.git
   ```
2. **Bağımlılıkları yükleyin (eğer varsa):**
   ```sh
   pod install
   ```
3. **Projeyi çalıştırın:**
   - `GFollower.xcworkspace` dosyasını Xcode ile açın.
   - Bir iOS simülatöründe veya fiziksel cihazda çalıştırın.

## Ekran Görüntüleri


## Katkıda Bulunma
Projeye katkıda bulunmak için **pull request** gönderebilirsiniz. Hata bildirimi ve öneriler için **issue** açabilirsiniz.

