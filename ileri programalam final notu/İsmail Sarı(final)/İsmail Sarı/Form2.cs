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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string şifre;
            şifre = textBox1.Text;
            if (şifre == "1234")
            {
                System.Diagnostics.Process.Start("www.ksu.edu.tr");
            }
            else
            {
                MessageBox.Show("Şifre Yanlış");
            }
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }
    }
}
