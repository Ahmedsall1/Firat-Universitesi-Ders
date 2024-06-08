using System;

namespace hafta_5_ders_1
{
    class Program
    {
        static void Main(string[] args)
        { 
            //ÖRNEK1

            //int[] dizi = { 87, 68, 94, 100, 83, 78, 85, 91, 76, 87 };
            //int toplam = 0;

            //foreach (int sayı in dizi)
            //    toplam += sayı;
            //Console.WriteLine("Dizi elemanları toplama :{0}", toplam);
            //Console.ReadKey();


            /////////////////////////////////////////
            /////////////////////////////////////////
            ///

            //ÖRNEK 2

            //var= her tipe uygundur

            //var array = new[] { 32, 27, 64, 18, 95, 14, 90, 70, 60, 37 };
            //int toplam = 0;

            //foreach (int sayı in array)
            //   toplam += sayı;
            //Console.WriteLine("Dizi elemanları toplamı :{0}", toplam);

            /////////////////////////////////////////
            /////////////////////////////////////////
            ///

            //ÖRNEK 3 ÖNEMLİ ////////

            int[,] dikdörtgen = { { 1, 2, 3, }, { 4, 5, 6, } };

            int[][] karışık = {new int [] { 1,2},
                new int [] {3},
                new int[] {4,5,6,}
            };

            

            DiziÇıktısı(dikdörtgen);
            Console.WriteLine();
            DiziÇıktısı(karışık);

            Console.ReadKey();

            
        
        }
        public static void DiziÇıktısı(int[,] dizi)
        {
            Console.WriteLine("Dikdörtgensel tanımlanan dizi elemanları");

            for (int row =0; row<dizi.GetLength(0);row++)
            {
                for (int column = 0; column < dizi.GetLength(1); column++)
                    Console.Write("{0}",dizi[row,column]);
                Console.WriteLine();
            }
        }

        public static void DiziÇıktısı(int[][] dizi)
        {
            Console.WriteLine("Karışık tanımlanan dizi elemanları");

            foreach (var row in dizi)
            {
                foreach (var element in row)
                    Console.Write("{0}", element);
                Console.WriteLine();
            }
        }
    }
}
