
CREATE DATABASE ders3;

CREATE TABLE `ogrenciler` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT 'kullanıcı adı saklanır',
  `surname` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `ogrenciler`
--

INSERT INTO `ogrenciler` (`id`, `name`, `surname`, `email`) VALUES
(2, 'burak', 'dursun', '210290001@firat.edu.tr'),
(3, 'Servan', 'Karakurt', '210290008@firat.edu.tr'),
(4, 'Muhammed', 'Osman', '210290009@firat.edu.tr');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `ogrenciler`
--
ALTER TABLE `ogrenciler`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `ogrenciler`
--
ALTER TABLE `ogrenciler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;
