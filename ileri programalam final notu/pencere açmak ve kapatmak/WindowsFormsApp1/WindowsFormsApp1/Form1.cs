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
            MessageBox.Show("ilk dersimize hoşgeldiniz.","uyarı",
                MessageBoxButtons.YesNoCancel,MessageBoxIcon.Warning);
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
          
            this.Close();
           
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Class1 nesne = new Class1();
            nesne.MesajGoster();
        }
    }
}
