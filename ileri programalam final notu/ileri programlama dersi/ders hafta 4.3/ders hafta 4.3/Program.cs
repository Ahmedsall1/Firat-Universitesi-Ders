using System;

namespace ders_hafta_4._3
{
    class Program
    {
        static void Main(string[] args)
        {
            //int sayaç;
            //for(sayaç=1;sayaç<=10;sayaç++)
            //{
            //    if (sayaç <= 5)
            //        continue;
            //    Console.WriteLine("{0}", sayaç);

            //}


            //int sayı = 127;

            int[] dizi = { 30, 80, 90, 12, 46, 8, 98, 45, 34, 56, 80, 32, 78 };
            Console.WriteLine("{0}{1,8}","indesks","değer");

            for (int i = 0; dizi.Length < 12; i++) 
            {
                dizi[i] = i;
                Console.WriteLine("c[{0}]={1}",i, dizi[i]);
                
            }

            Console.ReadKey();
        }
    }
}
