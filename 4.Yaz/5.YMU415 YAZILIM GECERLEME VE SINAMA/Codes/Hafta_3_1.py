def topla(x, y):
    return x - y  # Hata: Toplama işlemi yerine çıkarma yapılıyor.

# Test
assert topla(5, 3) == 8, f"Hata: Beklenen sonuç 8, alınan sonuç {topla(5, 3)}"
