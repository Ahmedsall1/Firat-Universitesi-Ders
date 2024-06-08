using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace hafta_8._2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string kullanıcı, sifre;

            kullanıcı = textBox1.Text;
            sifre = textBox2.Text;

            if (kullanıcı == "ömer" && sifre == "qwerty")
            {
                Form2 frm2= new Form2();
                frm2.Show();
            }
            else
                MessageBox.Show("Kullanıcı adı veya şifre yanlış");


        }
    }
}
