namespace WindowsFormsApp3
{
    partial class Form1
    {
        /// <summary>
        ///Gerekli tasarımcı değişkeni.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///Kullanılan tüm kaynakları temizleyin.
        /// </summary>
        ///<param name="disposing">yönetilen kaynaklar dispose edilmeliyse doğru; aksi halde yanlış.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer üretilen kod

        /// <summary>
        /// Tasarımcı desteği için gerekli metot - bu metodun 
        ///içeriğini kod düzenleyici ile değiştirmeyin.
        /// </summary>
        private void InitializeComponent()
        {
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.dosyaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.yeniToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.çıkışToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pencereToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cascadeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tileHorizontalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tileVerticalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.wpp1ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.wpp2ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.wpp3ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.wpp1ToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.wpp2ToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.wpp3ToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.dosyaToolStripMenuItem,
            this.pencereToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(800, 28);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // dosyaToolStripMenuItem
            // 
            this.dosyaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.yeniToolStripMenuItem,
            this.çıkışToolStripMenuItem});
            this.dosyaToolStripMenuItem.Name = "dosyaToolStripMenuItem";
            this.dosyaToolStripMenuItem.Size = new System.Drawing.Size(64, 24);
            this.dosyaToolStripMenuItem.Text = "Dosya";
            // 
            // yeniToolStripMenuItem
            // 
            this.yeniToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.wpp1ToolStripMenuItem1,
            this.wpp2ToolStripMenuItem1,
            this.wpp3ToolStripMenuItem1});
            this.yeniToolStripMenuItem.Name = "yeniToolStripMenuItem";
            this.yeniToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.yeniToolStripMenuItem.Text = "Yeni";
            // 
            // çıkışToolStripMenuItem
            // 
            this.çıkışToolStripMenuItem.Name = "çıkışToolStripMenuItem";
            this.çıkışToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.çıkışToolStripMenuItem.Text = "Çıkış";
            // 
            // pencereToolStripMenuItem
            // 
            this.pencereToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cascadeToolStripMenuItem,
            this.tileHorizontalToolStripMenuItem,
            this.tileVerticalToolStripMenuItem,
            this.toolStripMenuItem1,
            this.wpp1ToolStripMenuItem,
            this.wpp2ToolStripMenuItem,
            this.wpp3ToolStripMenuItem});
            this.pencereToolStripMenuItem.Name = "pencereToolStripMenuItem";
            this.pencereToolStripMenuItem.Size = new System.Drawing.Size(74, 24);
            this.pencereToolStripMenuItem.Text = "Pencere";
            // 
            // cascadeToolStripMenuItem
            // 
            this.cascadeToolStripMenuItem.Name = "cascadeToolStripMenuItem";
            this.cascadeToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.cascadeToolStripMenuItem.Text = "Cascade";
            this.cascadeToolStripMenuItem.Click += new System.EventHandler(this.cascadeToolStripMenuItem_Click);
            // 
            // tileHorizontalToolStripMenuItem
            // 
            this.tileHorizontalToolStripMenuItem.Name = "tileHorizontalToolStripMenuItem";
            this.tileHorizontalToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.tileHorizontalToolStripMenuItem.Text = "Tile Horizontal";
            this.tileHorizontalToolStripMenuItem.Click += new System.EventHandler(this.tileHorizontalToolStripMenuItem_Click);
            // 
            // tileVerticalToolStripMenuItem
            // 
            this.tileVerticalToolStripMenuItem.Name = "tileVerticalToolStripMenuItem";
            this.tileVerticalToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.tileVerticalToolStripMenuItem.Text = "Tile Vertical";
            this.tileVerticalToolStripMenuItem.Click += new System.EventHandler(this.tileVerticalToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(221, 6);
            // 
            // wpp1ToolStripMenuItem
            // 
            this.wpp1ToolStripMenuItem.Name = "wpp1ToolStripMenuItem";
            this.wpp1ToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.wpp1ToolStripMenuItem.Text = "wpp1";
            // 
            // wpp2ToolStripMenuItem
            // 
            this.wpp2ToolStripMenuItem.Name = "wpp2ToolStripMenuItem";
            this.wpp2ToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.wpp2ToolStripMenuItem.Text = "wpp2";
            // 
            // wpp3ToolStripMenuItem
            // 
            this.wpp3ToolStripMenuItem.Name = "wpp3ToolStripMenuItem";
            this.wpp3ToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.wpp3ToolStripMenuItem.Text = "wpp3";
            // 
            // wpp1ToolStripMenuItem1
            // 
            this.wpp1ToolStripMenuItem1.Name = "wpp1ToolStripMenuItem1";
            this.wpp1ToolStripMenuItem1.Size = new System.Drawing.Size(224, 26);
            this.wpp1ToolStripMenuItem1.Text = "wpp1";
            this.wpp1ToolStripMenuItem1.Click += new System.EventHandler(this.wpp1ToolStripMenuItem1_Click);
            // 
            // wpp2ToolStripMenuItem1
            // 
            this.wpp2ToolStripMenuItem1.Name = "wpp2ToolStripMenuItem1";
            this.wpp2ToolStripMenuItem1.Size = new System.Drawing.Size(224, 26);
            this.wpp2ToolStripMenuItem1.Text = "wpp2";
            this.wpp2ToolStripMenuItem1.Click += new System.EventHandler(this.wpp2ToolStripMenuItem1_Click);
            // 
            // wpp3ToolStripMenuItem1
            // 
            this.wpp3ToolStripMenuItem1.Name = "wpp3ToolStripMenuItem1";
            this.wpp3ToolStripMenuItem1.Size = new System.Drawing.Size(224, 26);
            this.wpp3ToolStripMenuItem1.Text = "wpp3";
            this.wpp3ToolStripMenuItem1.Click += new System.EventHandler(this.wpp3ToolStripMenuItem1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.menuStrip1);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "Form1";
            this.Text = "Form1";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem dosyaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem yeniToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem wpp1ToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem wpp2ToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem wpp3ToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem çıkışToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pencereToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cascadeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem tileHorizontalToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem tileVerticalToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem wpp1ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem wpp2ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem wpp3ToolStripMenuItem;
    }
}

