using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace KotWButach
{
    public partial class Dodajklientow : Form
    {
        private string connstring;

        public Dodajklientow()
        {
            InitializeComponent();
            connstring = ConfigurationManager.ConnectionStrings["myconnection"].ConnectionString;
        }

        private void save_button2_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(connstring))
                {
                    sqlcon.Open();
                    using (SqlCommand cmd = new SqlCommand("Dodajadres", sqlcon))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Imie", imie_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@Nazwisko", nazwisko_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@Email", email_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@NumerTelefonu", telefon_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@NazwaMiasta", miasto_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@KodPocztowy", kodpocztowy_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@NazwaKraju", kraj_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@NazwaUlicy", ulica_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@NumerBudynku", numerbudynku_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@NumerLokalu", numerlokalu_textbox.Text.ToString());
                        cmd.Parameters.AddWithValue("@Login", login_textbox.Text.ToString());

                        int i = cmd.ExecuteNonQuery();
                        if (i > 0)
                        {
                            MessageBox.Show("Nowy klient został doodany");
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
                MessageBox.Show("Wystąpił błąd: " + ex.Message);
            }
        }

        private void close_button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Dodajklientow_Load(object sender, EventArgs e)
        {

        }
    }
}
