using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace vize_sonrası_ders_2._2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            int anapara;
            double oran;
            int yıl;
            decimal biriken;
            string metin;


            anapara = Convert.ToInt32(textBox1.Text);
            oran = Convert.ToDouble(textBox2.Text);
            yıl = Convert.ToInt32(numericUpDown1.Value);

            metin = "Yıl\tDepozit miktarı\r\n";

            for (int ysayı = 1; ysayı < yıl; ysayı++)
            {
                biriken=anapara*((decimal)Math.Pow((1+oran/100),ysayı));
                metin += (ysayı + "\t" + string.Format("{0:C}", biriken) + "\r\n");
            }

            textBox3.Text = metin;

        }
    }
}
