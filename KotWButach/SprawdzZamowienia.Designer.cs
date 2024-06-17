namespace KotWButach
{
    partial class SprawdzZamowienia
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
            this.Widokzamowienia = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.Widokzamowienia)).BeginInit();
            this.SuspendLayout();
            // 
            // Widokzamowienia
            // 
            this.Widokzamowienia.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.Widokzamowienia.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.Widokzamowienia.GridColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.Widokzamowienia.Location = new System.Drawing.Point(12, 12);
            this.Widokzamowienia.Name = "Widokzamowienia";
            this.Widokzamowienia.Size = new System.Drawing.Size(654, 438);
            this.Widokzamowienia.TabIndex = 0;
            // 
            // SprawdzZamowienia
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.ClientSize = new System.Drawing.Size(671, 450);
            this.Controls.Add(this.Widokzamowienia);
            this.Name = "SprawdzZamowienia";
            this.Text = "SprawdzZamowienia";
            this.Load += new System.EventHandler(this.SprawdzZamowienia_Load);
            ((System.ComponentModel.ISupportInitialize)(this.Widokzamowienia)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView Widokzamowienia;

    }
}