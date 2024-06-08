using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ders_3.hafta._1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string str1,str2;
            int a = 127;
            Hesap hesap1 = new Hesap(50.00M);
            Hesap hesap2 = new Hesap(-7.53M);

            str1 =string.Format( "hesap1.ANAPARA miktarı: {0:C} ",hesap1.ANAPARA);
            str2 = string.Format("\nhesap2.ANAPARA miktarı: {0:C} ", hesap2.ANAPARA);
            MessageBox.Show(str1 + str2);

        }
    }
}
