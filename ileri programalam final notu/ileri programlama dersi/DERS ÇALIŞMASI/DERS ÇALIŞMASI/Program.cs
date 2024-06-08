using System;
using System.Linq;


namespace DERS_ÇALIŞMASI
{
    class Program
    {
        static void Main(string[] args)
        {
            personel[] işçiler = { 
                                  new personel("Zeynep","purple", 5000M),
                                  new personel("Rüveyda","Black", 7600M),
                                  new personel("Ceren","Blue", 3587.5M),
                                  new personel("Safiye","White", 4700.77M),
                                  new personel("Ayşegül","Brown", 3200M),
                                  new personel("Zehra","Indigo", 4236.4M )
            
            
            };
            Console.WriteLine("orginal dizi:");
            foreach (var eleman in işçiler) 
                Console.WriteLine(eleman);

            var DörtAltıArasında =
             from e in işçiler
             where e.AYLIK >= 4000M && e.AYLIK <= 6000M
             select e;

            Console.WriteLine(string.Format(
                "\nAylık {0:C}-{1:c} arasında para kazananlar:",
                4000, 6000));
            foreach (var eleman in DörtAltıArasında)
                Console.WriteLine(eleman);

            Console.ReadKey();

        }
    }
}
