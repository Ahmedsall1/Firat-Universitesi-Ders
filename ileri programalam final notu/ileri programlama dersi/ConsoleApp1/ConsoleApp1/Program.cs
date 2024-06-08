using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            int num1;
            int num2;
            int top;

            Console.WriteLine("Birinci sayıyı girin");
            num1 = Convert.ToInt16(Console.ReadLine());

            Console.WriteLine("İkinci sayıyı girin");
            num2 = Convert.ToInt16(Console.ReadLine());

            top = num1 + num2;

            Console.WriteLine("İki sayının toplamı:{0} ", top);

            Console.ReadKey();
        }
    }
}
