using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace vize_sonrası_2.ders_1
{
    public partial class Form1 : Form
    {
        private int imageNum = -1;

        public Form1()
        {
            InitializeComponent();
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            imageNum = (ImageNum + 1) % 3;

            pictureBox1.Image = (Image)(Properties.Resources.ResourceManager.GetObject(string.Format("image{0}", imageNum)));

        }
    }
}
