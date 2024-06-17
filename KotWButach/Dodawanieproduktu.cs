using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace KotWButach
{
    public partial class Dodawanieproduktu : Form
    {
        private string connstring;

        public Dodawanieproduktu()
        {
            InitializeComponent();
            connstring = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
            populateCombo();
        }

        private void save_button_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(connstring))
                {
                    sqlcon.Open();
                    using (SqlCommand cmd = new SqlCommand("InsertProduktow", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Producent", producent_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@Model", model_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@Rozmiar", rozmiar_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@Kolor", kolor_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@DostepnaIlosc", int.Parse(dostepnailosc_textbox.Text.ToString()));
                        cmd.Parameters.AddWithValue("@KategoriaProduktu", Wybor_Kategorii.Text.ToString());

                        int i = cmd.ExecuteNonQuery();
                        if (i > 0)
                        {
                            MessageBox.Show("Produkt został dodany");
                        }
                        else
                        {
                            MessageBox.Show("Wystąpił błąd");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Wystąpił błąd " + ex.Message);
            }
        }

        private void populateCombo()
        {
            try
            {
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(connstring))
                {
                    using (SqlCommand cmd = new SqlCommand("WybierzKategorieProduktu", con))
                    {
                        con.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        SqlDataReader reader = cmd.ExecuteReader();
                        dt.Load(reader);
                        con.Close();
                    }
                }
                Wybor_Kategorii.DataSource = dt;
                Wybor_Kategorii.DisplayMember = "NazwaKategorii";
                Wybor_Kategorii.ValueMember = "KategoriaProduktuID";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Wystąpił błąd " + ex.Message);
            }
        }

        private void close_button_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void label1_Click(object sender, EventArgs e)
        {
           
        }

        private void Dodawanieproduktu_Load(object sender, EventArgs e)
        {

        }
    }
}
