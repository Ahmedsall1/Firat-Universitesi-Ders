using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ders_3.hafta._1
{
    public class Hesap
    {
        private decimal anapara;
        public Hesap(decimal ilkanapara)//Constructor
        {
            ANAPARA = ilkanapara;
        }
        public decimal ANAPARA
        {
            get { return anapara; }
            set {
                if (value > 0)
                    anapara = value;
            
            }
        }
    }
}
