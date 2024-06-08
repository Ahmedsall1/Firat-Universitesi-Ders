using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp4
{
    public class Kure
    {
        public double Hacim(int r)
        {
            double sn;
            sn = 4 * Math.PI * r * r * r;
            sn = sn / 3;
            return sn;

        }
    }
}