using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace KotWButach
{
    public partial class oknoglowne : Form
    {
        public oknoglowne()
        {
            InitializeComponent();
        }

        private void dodajprodukt_button_Click(object sender, EventArgs e)
        {
            Dodawanieproduktu dodawanieproduktu = new Dodawanieproduktu();
            dodawanieproduktu.ShowDialog();
        }

        private void pokazprodukty_button_Click(object sender, EventArgs e)
        {
            // Tworzenie nowego okna Pokazprodukty
            Pokazprodukty pokazproduktyForm = new Pokazprodukty();

            // Pokazanie okna
            pokazproduktyForm.ShowDialog();
        }

        private void pokazklientow_button_Click(object sender, EventArgs e)
        {
            pokazklientow pokazklientowForm = new pokazklientow();

            pokazklientowForm.ShowDialog();
        }

        private void dodajcene_button_Click(object sender, EventArgs e)
        {
            dodajcene dodajceneForm = new dodajcene();
            dodajceneForm.ShowDialog();
        }

        private void dodajklientow_button_Click(object sender, EventArgs e)
        {
            Dodajklientow dodajklientowForm = new Dodajklientow();
            dodajklientowForm.ShowDialog();
        }

        private void oknoglowne_Load(object sender, EventArgs e)
        {

        }

        private void zamowienia_button_Click(object sender, EventArgs e)
        {
            SprawdzZamowienia sprawdzZamowieniaForm = new SprawdzZamowienia();
            sprawdzZamowieniaForm.ShowDialog();
        }

        private void podsumowaniesprzedazy_button_Click(object sender, EventArgs e)
        {
            podsumowaniesprzedazy podsumowaniesprzedazyForm = new podsumowaniesprzedazy();
            podsumowaniesprzedazyForm.ShowDialog();
        }
    }
}
