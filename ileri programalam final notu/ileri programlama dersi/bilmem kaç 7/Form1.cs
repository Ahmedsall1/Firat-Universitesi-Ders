using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace bilmem_kaç_7
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void ironmanToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form2 cc = new Form2();
            cc.MdiParent = this;
            cc.Show();

        }

        private void castleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form3 dfs = new Form3();
            dfs.MdiParent = this;
            dfs.Show();

        }

        private void computerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form4 tt = new Form4();
            tt.MdiParent = this;
            tt.Show();
        }

        private void cascadeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.LayoutMdi(MdiLayout.Cascade);
        }

        private void tileHozrizantalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.LayoutMdi(MdiLayout.TileHorizontal);
        }

        private void tileVerticalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.LayoutMdi(MdiLayout.TileVertical);
        }

        private void ironmanToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            Form2 cc = new Form2();
            cc.MdiParent = this;
            cc.Show();
        }
    }
}
