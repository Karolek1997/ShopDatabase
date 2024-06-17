using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace KotWButach
{
    public partial class pokazklientow : Form
    {
        private string connstring;

        public pokazklientow()
        {
            InitializeComponent();
            connstring = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;

            // Wywołanie funkcji do wykonania zapytania i wyświetlenia wyników
            ExecuteQuery();
        }

        private void pokazklientow_Load(object sender, EventArgs e)
        {
            // Kod do wykonania podczas ładowania formularza
            ExecuteQuery();
        }

        private void ExecuteQuery()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(connstring))
                {
                    sqlcon.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM WidokKlienci", sqlcon))
                    {
                        cmd.CommandType = CommandType.Text;

                        DataTable dt = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);

                        // Ustawienie danych do wyświetlenia w dataGridView1
                        dataGridView1.DataSource = dt;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred while executing the query: " + ex.Message);
            }
        }
    }
}
