using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace İsmail_Sarı
{
    public partial class Form4 : Form
    {
        public Form4()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            listBox2.Items.Clear();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string kişi;
            kişi = textBox1.Text;
            int vize;
            vize = Convert.ToInt32(textBox2.Text);
            int final;
            final = Convert.ToInt32(textBox3.Text);
            int ortalama;
            ortalama = Convert.ToInt32(vize * 0.4 + final * 0.6);
            string insan;
            insan = kişi + " " + Convert.ToString(ortalama);
            if (ortalama < 50)
                listBox2.Items.Add(insan);
            else
                listBox1.Items.Add(insan);
                
        }
    }
}
