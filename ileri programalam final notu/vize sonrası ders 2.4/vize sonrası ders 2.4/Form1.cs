using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace vize_sonrası_ders_2._4
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

        private void Form1_KeyPress(object sender, KeyPressEventArgs e)
        {
            label2.Text = "key pressed :" + e.KeyChar;
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)
            {
                DialogResult rt;
                rt = MessageBox.Show("Çıkmak istediğinize emin misiniz",
                    "Mesaj Kutusu", MessageBoxButtons.YesNo);
                if (rt == DialogResult.Yes) 
                    Close();
            }




            label1.Text = "Alt"+(e.Alt ? "Yes " : "No") + '\n' +
                          "Shift :"+(e.Shift ? "Yes " : "No") + '\n' +
                          "Ctrl"+(e.Control ? "Yes " : "No") + '\n' +
                          "Keycode:" + e.KeyCode + '\n' +
                          "Keydata:" + e.KeyData + '\n' +
                          "KeyValue:" + e.KeyValue;

        }

        private void Form1_KeyUp(object sender, KeyEventArgs e)
        {
            label1.Text = "";

            label2.Text = "";
        }
    }
}
