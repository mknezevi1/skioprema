using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace skioprema.Protected.Admin
{
    public partial class Rezervacije : System.Web.UI.Page
    {
        SmtpClient client = null;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvRezervacije_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalji")
            {
                //prikaz stavki rezervacije
                int index = Convert.ToInt32(e.CommandArgument);
                gvRezervacije.SelectRow(index);
            }
            else if (e.CommandName == "potvrdi" || e.CommandName == "odbij")
            {
                //postavljanje vrijednosti odobreno(1=potvrdeno/0=odbijeno) i slanje maila korisniku
                int index = Convert.ToInt32(e.CommandArgument);
                int rezervacijaID = Convert.ToInt32(gvRezervacije.DataKeys[index].Value);
                dsRezervacije.UpdateParameters["id"].DefaultValue = rezervacijaID.ToString();

                //dohvacanje emaila korisnika 
                DataView dv = new DataView();
                dsMail.SelectParameters["id"].DefaultValue = rezervacijaID.ToString();
                dv = dsMail.Select(DataSourceSelectArguments.Empty) as DataView;
                string adresaPrimatelja = dv.Table.Rows[0]["email"].ToString();

                string poruka = "";
                if (e.CommandName == "potvrdi")
                {
                    dsRezervacije.UpdateParameters["odobreno"].DefaultValue = "1";
                    poruka = "Poštovani, ovim putem Vas želimo obavijestiti kako je Vaša rezervacija potvrđena.";
                }
                else if (e.CommandName == "odbij")
                {
                    dsRezervacije.UpdateParameters["odobreno"].DefaultValue = "0";
                    poruka = "Poštovani, ovim putem Vas želimo obavijestiti kako Vaša rezervacija nažalost nije moguća.";
                }

                try
                {
                    posaljiMail(adresaPrimatelja, poruka);
                    dsRezervacije.Update();
                }
                catch 
                { 
                
                }
            }
            else if (e.CommandName == "preklapanja")
            {
                //automatsko selektiranje tog retka
                int index = Convert.ToInt32(e.CommandArgument);
                gvRezervacije.SelectedIndex = index;

                //provjera postoji li vec odobreno rezervacija koja se opremom i datumom preklapa sa ovom
                provjeriPreklapanje(e);
            }
        }

        private void provjeriPreklapanje(GridViewCommandEventArgs e)
        {
            DataView dv = new DataView();
            DataView dvStavke = new DataView();
            int index = Convert.ToInt32(e.CommandArgument);
            int rezervacijaID = Convert.ToInt32(gvRezervacije.DataKeys[index].Value);
            dsProvjera.SelectParameters["rezervacija_id"].DefaultValue = rezervacijaID.ToString();
            dsProvjera.SelectParameters["datum_od"].DefaultValue = DateTime.Parse(gvRezervacije.Rows[index].Cells[5].Text).ToString("yyyy-MM-dd");
            dsProvjera.SelectParameters["datum_do"].DefaultValue = DateTime.Parse(gvRezervacije.Rows[index].Cells[6].Text).ToString("yyyy-MM-dd");

            dsStavkeRezervacije.SelectParameters["rezervacijaID"].DefaultValue = rezervacijaID.ToString();
            dvStavke = dsStavkeRezervacije.Select(DataSourceSelectArguments.Empty) as DataView;
            bool preklapanje = false;
            foreach (DataRow r in dvStavke.Table.Rows)
            {
                dsProvjera.SelectParameters["oprema_id"].DefaultValue = r["oprema_id"].ToString();
                dv = dsProvjera.Select(DataSourceSelectArguments.Empty) as DataView;
                try
                {
                    int zauzetiID = (int)dv.Table.Rows[0]["id"];
                    preklapanje = true;
                    break;
                }
                catch
                {

                }
            }
            if (preklapanje == true)
            {
                lblProvjeraPreklapanja.BackColor = Color.Red;
            }
            else
            {
                lblProvjeraPreklapanja.BackColor = Color.Green;
            }
        }

        private void posaljiMail(string primatelj, string poruka)
        {
            MailAddress adrPosiljatelj = new MailAddress("skioprema@test.hr", "skioprema");
            MailAddress adrPrimatelj = new MailAddress(primatelj);
            MailMessage email = new MailMessage(adrPosiljatelj, adrPrimatelj);
            email.Subject = "Skioprema obavijest";
            email.Body = poruka;
            if (client == null)
            {
                client = new SmtpClient("localhost");
            }
            client.Send(email);
        }
    }
}