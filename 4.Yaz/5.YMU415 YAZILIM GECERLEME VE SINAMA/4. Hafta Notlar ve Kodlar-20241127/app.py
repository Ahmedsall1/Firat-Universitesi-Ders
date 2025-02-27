# Flask web framework'ünü ve diğer gerekli kütüphaneleri içe aktaralım.
from flask import Flask, render_template, request, redirect, url_for, session

# Flask uygulamasını başlatalım.
app = Flask(__name__)
app.secret_key = "secret_key"  # Flask uygulaması için gizli anahtar (session için gereklidir).

# Basit bir veritabanı simülasyonu olarak ürün listesi oluşturalım.
urunler = [
    {"id": 1, "name": "Laptop", "fiyat": 5000},
    {"id": 2, "name": "Mouse", "fiyat": 150}
]
sepet = []  # Sepetimizi temsil eden boş bir liste oluşturalım.

# Ana sayfamızı tanımlayalım. Bu sayfada ürünler listelenecek.
@app.route('/')
def index():
    return render_template('index.html', urunler=urunler)

# Bir ürünü sepete eklemek için kullanılacak rota.
@app.route('/sepete_ekle/<int:urun_id>')
def sepete_ekle(urun_id):
    urun = next((u for u in urunler if u["id"] == urun_id), None)
    if urun:
        sepet.append(urun)
    return redirect(url_for('index'))

# Sepetteki ürünleri gösteren ve ödeme işleminin yapıldığı sayfa.
@app.route('/odeme')
def odeme():
    toplam = sum(urun["fiyat"] for urun in sepet)
    return render_template('checkout.html', sepet=sepet, toplam=toplam)

# Stok yönetimi için ek modül
class StokModulu:
    def __init__(self):
        self.stok = {urun["id"]: 100 for urun in urunler}

    def stok_azalt(self, urun_id, miktar):
        if self.stok[urun_id] >= miktar:
            self.stok[urun_id] -= miktar
            return True
        return False

# İndirim yönetimi için ek modül
class IndirimModulu:
    def __init__(self):
        self.indirimler = {1: 0.1, 2: 0.05}

    def indirim_uygula(self, urun_id, fiyat):
        return fiyat * (1 - self.indirimler.get(urun_id, 0))

# Uygulamamızı başlatalım. (debug=True, geliştirme sırasında hataları görmemizi sağlar.)
if __name__ == '__main__':
    app.run(debug=True)
