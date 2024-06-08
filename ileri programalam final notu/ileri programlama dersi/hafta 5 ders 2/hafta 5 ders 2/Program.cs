using System;

namespace hafta_5_ders_2
{
    class Program
    {
        static void Main(string[] args)
        {


            int[,] A;
            A= new int [3,3];

            int[,] B;
            B = new int[3, 3];

            int[,] C;
            C = new int[3, 3];
            
            Console.WriteLine( "A Martrisnin Elemanlarını Girin " );

            for (int row = 0; row < A.GetLength(0); row++)
            {
                for (int column = 0; column < A.GetLength(1); column++)
                {
                    Console.WriteLine("A[{0}][{1}]:",row,column);
                    A[row, column] = Convert.ToInt32(Console.ReadLine());
                }
                

            }
            DiziÇıktısı(A);
            Console.WriteLine();

            Console.WriteLine("B Martrisnin Elemanlarını Girin ");

            for (int row = 0; row < B.GetLength(0); row++)
            {
                for (int column = 0; column < B.GetLength(1); column++)
                {
                    Console.WriteLine("A[{0}][{1}]:", row, column);
                    B[row, column] = Convert.ToInt32(Console.ReadLine());
                }
      

            }
            DiziÇıktısı(B);
            Console.WriteLine();


            Console.WriteLine("C Martrisnin Elemanları ");

            for (int row = 0; row < C.GetLength(0); row++)
            {
                for (int column = 0; column < C.GetLength(1); column++)
                {
                    Console.WriteLine("C[{0}][{1}]:", row, column);
                    C[row, column] = A[row, column] + B[row, column];
                }
                

            }
            DiziÇıktısı(C);
            Console.WriteLine();

        }

        
        public static void DiziÇıktısı(int[,] dizi)
        {
            Console.WriteLine(" dizi elemanları");

            for (int row=0; row<dizi.GetLength(0);row++)
            {
                for (int column = 0; column < dizi.GetLength(1); column++)
                {
                    Console.Write("{0,2}", dizi[row, column]);
                    

                }
                Console.WriteLine();
            }
        }
    }
}

