using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace vize_sonrası_ders_2._3
{
    public partial class Form1 : Form
    {
        bool boyansınmı = false;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            boyansınmı = true;

        }

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            boyansınmı = false;

        }

        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            if (boyansınmı == true)
            {
                using(Graphics graphics= CreateGraphics())
                {
                    graphics.FillRectangle(
                        new SolidBrush(Color.Blue), e.X, e.Y, 8, 8 );
                }
            }
        }
    }
}
