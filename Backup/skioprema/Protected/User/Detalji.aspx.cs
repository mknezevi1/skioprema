using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace skioprema.Protected.User
{
    public partial class Detalji : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //pokusaj dohvacanja putanje slike za prikaz 
                DataView dview = (DataView)dsOpremaDetalji.Select(DataSourceSelectArguments.Empty);
                string nazivSlike = (String)dview.Table.Rows[0]["slika"];
                imSlika.ImageUrl = "~/Images/oprema/" + nazivSlike;
            }
            catch
            {
                imSlika.ImageUrl = "~/Images/oprema/noPhoto.png";
            }
        }
    }
}