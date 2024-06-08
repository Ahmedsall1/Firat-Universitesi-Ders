using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace vize_sonrası_ders_1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            label1.Font = new Font(label1.Font,label1.Font.Style ^ FontStyle.Bold);
        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            label1.Font = new Font(label1.Font, label1.Font.Style ^ FontStyle.Italic);
        }

        private void checkBox3_CheckedChanged(object sender, EventArgs e)
        {
            label1.Font = new Font(label1.Font, label1.Font.Style ^ FontStyle.Underline);
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s;
            s = comboBox1.Text;
            int p;
            p = Convert.ToInt32(comboBox2.Text);
            label1.Font = new System.Drawing.Font(s,p, System.Drawing.FontStyle.Regular);
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s;
            s = comboBox1.Text;
            int p;
            p = Convert.ToInt32(comboBox2.Text);
            label1.Font = new System.Drawing.Font(s, p, System.Drawing.FontStyle.Regular);
        }
    }
}
