
namespace vize_sonrası_ders_bilmem_kaç_2
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.TreeNode treeNode1 = new System.Windows.Forms.TreeNode("ELEKTRONİK");
            System.Windows.Forms.TreeNode treeNode2 = new System.Windows.Forms.TreeNode("EEM", new System.Windows.Forms.TreeNode[] {
            treeNode1});
            System.Windows.Forms.TreeNode treeNode3 = new System.Windows.Forms.TreeNode("YAZILIM");
            System.Windows.Forms.TreeNode treeNode4 = new System.Windows.Forms.TreeNode("BM", new System.Windows.Forms.TreeNode[] {
            treeNode3});
            System.Windows.Forms.TreeNode treeNode5 = new System.Windows.Forms.TreeNode("MM");
            System.Windows.Forms.TreeNode treeNode6 = new System.Windows.Forms.TreeNode("İM");
            System.Windows.Forms.TreeNode treeNode7 = new System.Windows.Forms.TreeNode("MMF", new System.Windows.Forms.TreeNode[] {
            treeNode2,
            treeNode4,
            treeNode5,
            treeNode6});
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.treeView1 = new System.Windows.Forms.TreeView();
            this.ımageList1 = new System.Windows.Forms.ImageList(this.components);
            this.SuspendLayout();
            // 
            // treeView1
            // 
            this.treeView1.ImageIndex = 0;
            this.treeView1.ImageList = this.ımageList1;
            this.treeView1.Location = new System.Drawing.Point(26, 12);
            this.treeView1.Name = "treeView1";
            treeNode1.ImageKey = "1155242.png";
            treeNode1.Name = "Node8";
            treeNode1.SelectedImageIndex = 4;
            treeNode1.Text = "ELEKTRONİK";
            treeNode2.ImageKey = "400641.jpg";
            treeNode2.Name = "Node2";
            treeNode2.SelectedImageIndex = 1;
            treeNode2.Text = "EEM";
            treeNode3.ImageKey = "image1.jpg";
            treeNode3.Name = "Node9";
            treeNode3.SelectedImageIndex = 9;
            treeNode3.Text = "YAZILIM";
            treeNode4.ImageKey = "881566.jpg";
            treeNode4.Name = "Node5";
            treeNode4.SelectedImageIndex = 3;
            treeNode4.Text = "BM";
            treeNode5.ImageKey = "Adız.png";
            treeNode5.Name = "Node6";
            treeNode5.SelectedImageIndex = 7;
            treeNode5.Text = "MM";
            treeNode6.ImageKey = "1160337.png";
            treeNode6.Name = "Node7";
            treeNode6.SelectedImageIndex = 5;
            treeNode6.Text = "İM";
            treeNode7.ImageKey = "1160337.png";
            treeNode7.Name = "Node0";
            treeNode7.SelectedImageIndex = 5;
            treeNode7.Text = "MMF";
            this.treeView1.Nodes.AddRange(new System.Windows.Forms.TreeNode[] {
            treeNode7});
            this.treeView1.SelectedImageIndex = 0;
            this.treeView1.Size = new System.Drawing.Size(296, 284);
            this.treeView1.TabIndex = 0;
            // 
            // ımageList1
            // 
            this.ımageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("ımageList1.ImageStream")));
            this.ımageList1.TransparentColor = System.Drawing.Color.Transparent;
            this.ımageList1.Images.SetKeyName(0, "318384.png");
            this.ımageList1.Images.SetKeyName(1, "400641.jpg");
            this.ımageList1.Images.SetKeyName(2, "587453.jpg");
            this.ımageList1.Images.SetKeyName(3, "881566.jpg");
            this.ımageList1.Images.SetKeyName(4, "1155242.png");
            this.ımageList1.Images.SetKeyName(5, "1160337.png");
            this.ımageList1.Images.SetKeyName(6, "Adaaız.png");
            this.ımageList1.Images.SetKeyName(7, "Adız.png");
            this.ımageList1.Images.SetKeyName(8, "image0.jpg");
            this.ımageList1.Images.SetKeyName(9, "image1.jpg");
            this.ımageList1.Images.SetKeyName(10, "image2.jpg");
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.treeView1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TreeView treeView1;
        private System.Windows.Forms.ImageList ımageList1;
    }
}

