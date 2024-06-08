using System;

namespace ders_hafta_3._2
{
    class Program
    {
        static void Main(string[] args)
        {
            int girilen;
            int toplam=0;
            int sayaç = 1;
            double ortalama;


            while(sayaç<=10)
            {
                Console.Write("Not Gir:");
                girilen = Convert.ToInt32(Console.ReadLine());
                toplam = toplam + girilen;
                sayaç = sayaç + 1;

            }
            ortalama = toplam / 10;
            Console.WriteLine("Sınıfın Ortalaması:{0}", ortalama);
            Console.ReadKey();


        }
    }
}
