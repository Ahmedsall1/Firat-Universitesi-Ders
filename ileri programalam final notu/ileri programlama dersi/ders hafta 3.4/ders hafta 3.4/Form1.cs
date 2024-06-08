using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ders_hafta_3._4
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            decimal anapara;
            decimal biriken;
            double f_oran;

            anapara = Convert.ToDecimal(textBox1.Text);
            f_oran = Convert.ToDouble(textBox2.Text);

            for (int yıl = 1; yıl <= 12; yıl++) 
            {
                biriken = anapara * ((decimal)Math.Pow(1.0 + f_oran,yıl));
                    listBox1.Items.Add ( string.Format("{0,4}{1,20:C}\n",yıl, biriken));
            }

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
