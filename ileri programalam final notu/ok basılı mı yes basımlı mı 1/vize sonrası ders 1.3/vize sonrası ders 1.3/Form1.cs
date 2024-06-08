using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace vize_sonrası_ders_1._3
{
    public partial class Form1 : Form

    {
        private MessageBoxIcon IconType;


        private MessageBoxButtons ButtonType;

        public Form1()
        {
            InitializeComponent();
        }

        private void radioButton12_CheckedChanged(object sender, EventArgs e)
        {
            if (sender == radioButton12)
                IconType = MessageBoxIcon.Asterisk;
            else if (sender == radioButton11)
                IconType = MessageBoxIcon.Error;
            else if (sender == radioButton10)
                IconType = MessageBoxIcon.Exclamation;
            else if (sender == radioButton9)
                IconType = MessageBoxIcon.Hand;
            else if (sender == radioButton8)
                IconType = MessageBoxIcon.Information;
            else if (sender == radioButton7)
                IconType = MessageBoxIcon.Question;
            else if (sender == radioButton18)
                IconType = MessageBoxIcon.Stop;
            else if (sender == radioButton17)
                IconType = MessageBoxIcon.Warning;
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (sender == radioButton1)
                ButtonType = MessageBoxButtons.OK;
            else if (sender == radioButton2)
                ButtonType = MessageBoxButtons.OKCancel;
            else if (sender == radioButton3)
                ButtonType = MessageBoxButtons.AbortRetryIgnore;
            else if (sender == radioButton4)
                ButtonType = MessageBoxButtons.YesNoCancel;
            else if (sender == radioButton5)
                ButtonType = MessageBoxButtons.YesNo;
            else if (sender == radioButton6)
                ButtonType = MessageBoxButtons.RetryCancel;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Bu sizin özelleştirilmiş mesaj kutunuzdur ","Özel mesaj kutusu",
                ButtonType,IconType);
            switch(result)
            {
                case DialogResult.OK:
                    label1.Text = "OK basıldı.";
                    break;
                case DialogResult.Abort:
                    label1.Text = "Cancel basıldı.";
                    break;
                case DialogResult.Retry:
                    label1.Text = "Retry basıldı.";
                    break;
                case DialogResult.Ignore:
                    label1.Text = "Ignore basıldı.";
                    break;
                case DialogResult.Yes:
                    label1.Text = "Yes basıldı.";
                    break;
                case DialogResult.No:
                    label1.Text = "No basıldı.";
                    break;
            }
        }

    }
}
