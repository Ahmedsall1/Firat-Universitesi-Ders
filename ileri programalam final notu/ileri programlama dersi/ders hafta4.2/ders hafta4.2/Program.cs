using System;

namespace ders_hafta4._2
{
    class Program
    {
        static void Main(string[] args)
        {
            char ch;
            Console.WriteLine("Klavyeden bir tuşa basın");

            ch = Convert.ToChar(Console.ReadLine());
            switch(ch)
            {
                case 'a':
                    Console.WriteLine("a tuşuna bastınız");
                    break;
                case 'q':
                    Console.WriteLine("q tuşuna bastınız");
                    break;
                case '\t':
                    Console.WriteLine("TAB tuşuna basınız");
                    break;
                default:
                    Console.WriteLine("a,q,TAB hariç bir tuşa bastnız");
                    break;



            }
            Console.ReadKey();

        }
    }
}
