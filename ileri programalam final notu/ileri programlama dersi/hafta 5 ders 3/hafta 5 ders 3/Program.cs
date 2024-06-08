using System;
using System.Linq;

namespace hafta_5_ders_3
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] dizi = { 2, 9, 5, 0, 3, 7, 1, 4, 8, 5 };

            Console.Write("Original dizi:");
            foreach(var eleman in dizi)
                Console.Write(" {0},",eleman);
            Console.WriteLine();

            var filtre =
                from değer in dizi
                where değer < 5
                orderby değer ascending
                select değer;

            Console.WriteLine("\n4 ten buyuk olanlar:");
            foreach (var eleman in filtre)
                Console.Write(" {0}", eleman);
            Console.ReadKey();
        }
    }
}
