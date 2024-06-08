using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace deneme
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Int64 sayı1;
            Int64 sayı2;
            Int64 toplam;

            sayı1 =Convert.ToInt64( textBox1.Text);
            sayı2 = Convert.ToInt64(textBox2.Text);
            toplam = sayı1 + sayı2;
            MessageBox.Show(Convert.ToString(toplam));
            
        }
    }
}
