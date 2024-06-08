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
    public partial class Form3 : Form
    {
        public Form3()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

            Graphics grafik = base.CreateGraphics();
            Pen kalem = new Pen(Color.Black);
            SolidBrush fırça = new SolidBrush(Color.Black);


            grafik.Clear(Color.White);
            switch (comboBox1.SelectedIndex)
            {
                case 0:
                    grafik.DrawRectangle(kalem, 50, 50, 150, 150);
                    grafik.FillRectangle(fırça, 50, 200, 150, 150);
                    break;

                case 1:
                    grafik.FillEllipse(fırça, 50, 50, 150, 150);
                    break;

                case 2:
                    grafik.FillPie(fırça, 50, 50, 150, 150, 0, 270);
                    break;


            }
        }
    }
}
