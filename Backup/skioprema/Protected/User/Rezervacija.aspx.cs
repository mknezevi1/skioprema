using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

namespace skioprema.Protected.User
{
    public partial class Rezervacija : System.Web.UI.Page
    {
        List<int> stateList;
        DataTable dt = null;
        float cijenaDan = 0;
        float cijenaUkupna = 0;
        int rezervacijaNoviId;
        int brojDana;

        protected void Page_Load(object sender, EventArgs e)
        {
            //punjenje kosarice odabranom opremom iz sesije
            stateList = (List<int>)Session["stateList"];
            if (stateList != null)
            {
                foreach (int el in stateList)
                {
                    dodajRedak(el);
                }
            }

            //poziv zbog dohvacanja danasnjeg datum za provjeru datuma posudbe
            Page.DataBind();
        }

        protected void btnOdustani_Click(object sender, EventArgs e)
        {
            //ciscenje sesije i povratak na pregled opreme
            stateList.Clear();
            Page.Response.Redirect("Oprema.aspx");
        }

        protected void btnPotvrdi_Click(object sender, EventArgs e)
        {
            if (provjeraPodataka())
            {
                //upis podataka o rezervaciji u tablicu skioprema_rezervacija
                izracunUkupneCijene();
                dsRezervacija.InsertParameters["user_id"].DefaultValue = ((Guid)Membership.GetUser().ProviderUserKey).ToString();
                dsRezervacija.InsertParameters["datum_od"].DefaultValue = tbDatumOd.Text;
                dsRezervacija.InsertParameters["datum_do"].DefaultValue = tbDatumDo.Text;
                dsRezervacija.InsertParameters["odobreno"].DefaultValue = null;
                dsRezervacija.InsertParameters["napomena"].DefaultValue = tbNapomena.Text;
                dsRezervacija.InsertParameters["ukupna_cijena"].DefaultValue = cijenaUkupna.ToString();
                dsRezervacija.Insert();

                //upis podataka o rezervaciji u tablicu skioprema_stavka_rezervacije
                dsStavkaRezervacije.InsertParameters["rezervacija_id"].DefaultValue = rezervacijaNoviId.ToString();
                foreach (int oprema in stateList)
                {
                    dsStavkaRezervacije.InsertParameters["oprema_id"].DefaultValue = oprema.ToString();
                    dsStavkaRezervacije.Insert();
                }

                //ciscenje sesije nakon upisa u bazu podatak te redirektanje na stranicu zahvale
                stateList.Clear();
                Page.Response.Redirect("Potvrda.aspx");
            }
        }

        private bool provjeraPodataka()
        {
            //server-side provjera podataka
            if (tbDatumOd.Text == null || tbDatumDo.Text == null) 
            {
                return false;
            }
            DateTime datum_od = DateTime.Parse(tbDatumOd.Text);
            DateTime datum_do = DateTime.Parse(tbDatumDo.Text);
            if (datum_od > datum_do || datum_od < DateTime.Today)
            {
                return false;
            }

            return true;
        }

        private void dodajRedak(int id)
        {
            //dodavanje retka odabrane stavke opreme u kosaricu
            if (dt == null)
            {
                dt = new DataTable();
            }

            if (dt.Columns.Count == 0)
            {
                dt.Columns.Add("id", typeof(int));
                dt.Columns.Add("proizvodac", typeof(string));
                dt.Columns.Add("naziv", typeof(string));
                dt.Columns.Add("cijena", typeof(string));
            }

            DataView tablicaOprema = (DataView)dsOpremaDetalji.Select(DataSourceSelectArguments.Empty);
            tablicaOprema.RowFilter = "id = " + id;
            DataRowView detalji = (DataRowView)tablicaOprema[0];

            DataRow NewRow = dt.NewRow();
            NewRow[0] = id;
            NewRow[1] = detalji["proizvodac"];
            NewRow[2] = detalji["naziv"];
            NewRow[3] = detalji["cijena"];
            dt.Rows.Add(NewRow);
            gvKosarica.DataSource = dt;
            gvKosarica.DataBind();

            //azuriranje cijene
            cijenaDan += Convert.ToInt32(detalji["cijena"]);
        }

        protected void dsRezervacija_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //dohvacanje zadnje unesenog id-a rezervacije 
            rezervacijaNoviId = (Int32)e.Command.Parameters["@NewId"].Value;
        }

        private void izracunUkupneCijene()
        {
            //izracun ukupne cijene (sve cijene/dan * broj dana)
            if (tbDatumOd.Text != "" && tbDatumDo.Text != "")
            {
                DateTime datum_od = DateTime.Parse(tbDatumOd.Text);
                DateTime datum_do = DateTime.Parse(tbDatumDo.Text);
                brojDana = (int)(datum_do - datum_od).TotalDays + 1;

                if (brojDana > 0)
                {
                    cijenaUkupna = cijenaDan * brojDana;
                    tbUkupnaCijena.Text = cijenaUkupna.ToString();
                }
            }
        }

        protected void tbDatumOd_TextChanged(object sender, EventArgs e)
        {
            izracunUkupneCijene();
        }

        protected void tbDatumDo_TextChanged(object sender, EventArgs e)
        {
            izracunUkupneCijene();
        }
    }
}