namespace KotWButach
{
    partial class podsumowaniesprzedazy
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
            this.WidokPodsumowaniaSprzedazy = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.WidokPodsumowaniaSprzedazy)).BeginInit();
            this.SuspendLayout();
            // 
            // WidokPodsumowaniaSprzedazy
            // 
            this.WidokPodsumowaniaSprzedazy.BackgroundColor = System.Drawing.Color.IndianRed;
            this.WidokPodsumowaniaSprzedazy.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.WidokPodsumowaniaSprzedazy.Location = new System.Drawing.Point(12, 12);
            this.WidokPodsumowaniaSprzedazy.Name = "WidokPodsumowaniaSprzedazy";
            this.WidokPodsumowaniaSprzedazy.Size = new System.Drawing.Size(452, 426);
            this.WidokPodsumowaniaSprzedazy.TabIndex = 0;
            // 
            // podsumowaniesprzedazy
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.IndianRed;
            this.ClientSize = new System.Drawing.Size(464, 450);
            this.Controls.Add(this.WidokPodsumowaniaSprzedazy);
            this.Name = "podsumowaniesprzedazy";
            this.Text = "podsumowaniesprzedazy";
            this.Load += new System.EventHandler(this.podsumowaniesprzedazy_Load);
            ((System.ComponentModel.ISupportInitialize)(this.WidokPodsumowaniaSprzedazy)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView WidokPodsumowaniaSprzedazy;
    }
}