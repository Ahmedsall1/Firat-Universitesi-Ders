using System;

namespace ders_hafta4._1
{
    class Program
    {
        static void Main(string[] args)
        {
            int a = 0, b = 0, c = 0, d = 0, f = 0;
            int girilen;
            int toplam=0;
            b = 10;

            for (int i=0; i<10;i++)
            {
                
                Console.Write("{0} tane 0-100 arası sayı girin:  ",b);
                girilen = Convert.ToInt32(Console.ReadLine());
                toplam += girilen;

                b--;
                switch (girilen/10)
                {
                    case 9:
                    case 10:
                        ++a;
                        break;
                    case 8:
                        ++b;
                        break;
                    case 7:
                        ++c;
                        break;
                    case 6:
                        ++d;
                        break;
                    default:
                        ++f;
                        break;

                }


            }

            double ortalama = (double)toplam / 10;
            Console.WriteLine("Sınıfın toplam notu: {0}", toplam);
            Console.WriteLine("Sınıfın ortalaması: {0:F}",ortalama);
            Console.WriteLine("\nA:{0} \nB:{1} \nC:{2} \nD:{3} \nF:{4}", a,b,c,d,f);
            Console.ReadKey();

        }
    }
}
