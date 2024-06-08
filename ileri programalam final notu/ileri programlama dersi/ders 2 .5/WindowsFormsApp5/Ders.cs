using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp5
{
   public class Ders
    {
        private string dersinadı;//değişken
        public string DersinAdı //nesne
        {
            get
            {
                return dersinadı;
            }
            set
            {
                dersinadı = value;
            }
        }
        public void mesajgoster()
        {
            string st;
            st = string.Format("Dersimizin ismi:{0}", dersinadı);
            MessageBox.Show(st);
        }
    }
}
