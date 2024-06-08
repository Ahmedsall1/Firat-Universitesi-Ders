using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double num1 = 0, num2 = 0, top;
            double ortalama;
            string sonuc = "";
            num1 = Convert.ToDouble(textBox1.Text);
            num2 = Convert.ToDouble(textBox2.Text);

            ortalama = (num2 + num1) / 2;
            sonuc = string.Format("iki sayının toplamı={0:N2}",ortalama);

            MessageBox.Show(sonuc);
        }
    }
}
