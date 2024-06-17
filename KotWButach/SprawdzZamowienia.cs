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
    public partial class SprawdzZamowienia : Form
    {
        private string connstring;

        public SprawdzZamowienia()
        {
            InitializeComponent();
            connstring = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;

            ExecuteQuery();
        }

        private void ExecuteQuery()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(connstring))
                {
                    sqlcon.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM Zamowienia", sqlcon))
                    {
                        cmd.CommandType = CommandType.Text;

                        DataTable dt = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);

                     
                        Widokzamowienia.DataSource = dt;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Wystąpił błąd" + ex.Message);
            }
        }

        private void SprawdzZamowienia_Load(object sender, EventArgs e)
        {

        }
    }
}