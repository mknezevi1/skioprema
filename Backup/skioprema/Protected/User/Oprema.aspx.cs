using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace skioprema.Protected.User
{
    public partial class Oprema : System.Web.UI.Page
    {
        List<int> stateList;
        DataTable dt = null;
        float ukupnaCijena = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["stateList"] == null)
            {
                stateList = new List<int>();
                Session["stateList"] = stateList;
            }
            else
            {
                //punjenje kosarice podacima o odabranoj opremi iz sesije
                stateList = (List<int>)Session["stateList"];
                if (stateList != null)
                {
                    foreach (int el in stateList)
                    {
                        dodajRedak(el);
                    }
                }
            }
        }

        protected void gvOprema_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalji")
            {
                //prikaz detalja opreme
                int index = Convert.ToInt32(e.CommandArgument);
                int opremaID = Convert.ToInt32(gvOprema.DataKeys[index].Value);
                Page.Response.Redirect("Detalji.aspx?id=" + opremaID);
            }
            else if (e.CommandName == "dodaj")
            {
                //dodavanje opreme u kosaricu i sesiju
                int id = Convert.ToInt32(gvOprema.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
                if (!stateList.Contains(id))
                {
                    stateList.Add(id);
                    dodajRedak(id);
                }
            }
        }

        private void dodajRedak(int id)
        {
            //umetanje retka odabrane opreme u kosaricu
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

            //azuriranje ukupne cijene/dan
            ukupnaCijena += Convert.ToInt32(detalji["cijena"]);
            tbUkupnaCijena.Text = ukupnaCijena.ToString();

            //omogucavanje buttona kosarice kada je dodana barem jedna stavka
            btnOcisti.Enabled = true;
            btnNastavi.Enabled = true;
        }

        protected void btnOcisti_Click(object sender, EventArgs e)
        {
            //praznjenje sesije i ciscenje kosarice
            stateList.Clear();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnNastavi_Click(object sender, EventArgs e)
        {
            //nastavljanje na sljedeci korak rezervacije
            Page.Response.Redirect("Rezervacija.aspx");
        }
    }
}