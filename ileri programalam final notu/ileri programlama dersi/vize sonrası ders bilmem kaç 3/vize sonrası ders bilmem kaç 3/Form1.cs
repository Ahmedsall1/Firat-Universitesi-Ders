using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace vize_sonrası_ders_bilmem_kaç_3
{
    public partial class Form1 : Form
    {
        string klasöraltyolu;

        public Form1()
        {
            InitializeComponent();
        }

        public void TreeViewGöster(string klasördeğeri, TreeNode anaklasör)
        {
            string[] klasörDizisi = Directory.GetDirectories(klasördeğeri);
            try
            {
                if (klasörDizisi.Length!=0)
                {
                    foreach (string directory in klasörDizisi)
                    {
                        klasöraltyolu = Path.GetFileNameWithoutExtension(directory);
                        TreeNode myNode = new TreeNode(klasöraltyolu);
                        anaklasör.Nodes.Add( myNode);
                        TreeViewGöster(directory, myNode);

                    }
                }
            }
            catch(UnauthorizedAccessException)
            {
                anaklasör.Nodes.Add("Erişim engellendi!");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            treeView1.Nodes.Clear();
            if (Directory.Exists(textBox1.Text))
            {
                treeView1.Nodes.Add(textBox1.Text);
                TreeViewGöster(textBox1.Text,treeView1.Nodes[0]);
            }
            else
            {
                MessageBox.Show(textBox1.Text + "Bulunamadı",
                "Klasör Bulunamadı", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
