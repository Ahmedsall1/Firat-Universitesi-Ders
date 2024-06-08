using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp5
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Graphics grafik = base.CreateGraphics();
            Pen kalem = new Pen(Color.DarkBlue);
            SolidBrush fırça = new SolidBrush(Color.DarkBlue);
            kalem.Width = 5;


            grafik.Clear(Color.White);

            switch (comboBox1.SelectedIndex)
            {
                case 0: 
                    break;
                case 1:
                    grafik.DrawRectangle(kalem, 150, 150, 150, 150);
                    break;
                case 2:
                    grafik.DrawPie(kalem,150, 150, 150,150,0,45);
                    break;
                case 3:
                    grafik.FillEllipse(fırça, 150, 150, 150, 150);
                    break;
                case 4:
                    for (int i = 0; i < 400; i += 5)
                    {
                        
                       
                    }
                   
                    break;

                case 5:
                    grafik.FillPie(fırça, 150, 150,150,150, 0, 45 );
                    break;
                    
            }

        }
        int x = 0;
        private void timer1_Tick(object sender, EventArgs e)
        {
            Graphics grafik = base.CreateGraphics();
            Pen kalem = new Pen(Color.DarkBlue);
            SolidBrush fırça = new SolidBrush(Color.DarkBlue);
            x += 5;
            grafik.FillRectangle(fırça, x, 150, 150, 150);
            System.Threading.Thread.Sleep(100);
            grafik.Clear(Color.White);
        }
    }
}
