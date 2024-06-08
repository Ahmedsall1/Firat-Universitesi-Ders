using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DERS_ÇALIŞMASI
{
    public class personel
    {
                private decimal aylık_ücret;   // parasal tip decimal  aylık ücret değişikkeni 
        public string Adı { get; set; } // değişken değerini alıp atarken get set ile yaparız 
        public string Soyadı { get; set; } 

        public personel ( string isim, string soyisim, decimal ücret ) // clasıın ismi ile metod tanımlanırsa yapılandırıcı olur 
        {
            Adı = isim;
            Soyadı = soyisim; // soyismi soyadı nesnesine 
            AYLIK = ücret;

        }// personel  sonu 
        public decimal AYLIK
        {
            get { return aylık_ücret; } // aylık ücreti retun la geri döndüryor


            set { if (value >= 0M) aylık_ücret = value; }   // o değeri atamamk için if değişkeni 

            
        }
        public override string ToString()
        {
            return string.Format("{0,-10} { 1,-10} {2,10:C}",Adı,Soyadı, AYLIK);

        } // tostring sonu 
    }

    
}
