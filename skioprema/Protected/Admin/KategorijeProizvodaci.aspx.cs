using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace skioprema.Protected.Admin
{
    public partial class KategorijeProizvodaci : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDodajKategoriju_Click(object sender, ImageClickEventArgs e)
        {
            if (tbNovaKategorija.Text != null)
            {
                dsKategorije.InsertParameters["naziv"].DefaultValue = tbNovaKategorija.Text;
                dsKategorije.Insert();
                tbNovaKategorija.Text = "";
            }
        }

        protected void btnDodajProizvodaca_Click(object sender, ImageClickEventArgs e)
        {
            if (tbNoviProizvodac.Text != null)
            {
                dsProizvodaci.InsertParameters["naziv"].DefaultValue = tbNoviProizvodac.Text;
                dsProizvodaci.Insert();
                tbNoviProizvodac.Text = "";
            }
        }
    }
}