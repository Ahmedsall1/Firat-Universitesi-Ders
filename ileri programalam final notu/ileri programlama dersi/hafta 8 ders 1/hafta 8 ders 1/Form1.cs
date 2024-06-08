using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace hafta_8_ders_1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MessageBox.Show("TEXT KUTUSUNU SEÇTİNİZ");

            textBox1.Select();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            button1.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            button1.Show();
        }
    }
}
