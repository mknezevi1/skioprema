using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.IO;

namespace skioprema.Protected.Admin
{
    public partial class Oprema : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
        }

        protected void dvOpremaDetalji_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            gvOprema.DataBind();
        }

        protected void dvOpremaDetalji_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            e.ExceptionHandled = true;
            if (e.AffectedRows == 0)
            {
                lblError.Text = "Podaci nisu pohranjeni jer nisu prošli validaciju.";
            }
            else
            {
                lblError.Text = "";
            }
            gvOprema.DataBind();
        }

        protected void dvOpremaDetalji_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            e.ExceptionHandled = true;
            if (e.AffectedRows == 0)
            {
                lblError.Text = "Podaci nisu pohranjeni jer nisu prošli validaciju.";
            }
            else 
            {
                lblError.Text = "";
            }
            gvOprema.DataBind();
        }

        protected void gvOprema_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalji")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                gvOprema.SelectRow(index);
            }
        }

        protected void btnUpload_Click(object sender, ImageClickEventArgs e)
        {
            //moze se uploadati slika samo za selektiranu opremu (koja je vec zapisana u bazi podataka) 
            if (dvOpremaDetalji.SelectedValue != null && dvOpremaDetalji.CurrentMode != DetailsViewMode.Insert)
            {
                int OpremaID = (int)dvOpremaDetalji.SelectedValue;
                string nazivSlike = OpremaID + ".jpg";
                if (fuSlika.HasFile)
                {
                    string path = Server.MapPath("~/Images/oprema/" + nazivSlike);
                    try
                    {
                        //ako vec postoji slika za tu opremu, tada se ona zamjenjuje ovom novom
                        if (File.Exists(path))
                        {
                            File.Delete(path);
                        }

                        dsOpremaSlika.UpdateParameters["id"].DefaultValue = OpremaID.ToString();
                        dsOpremaSlika.UpdateParameters["slika"].DefaultValue = nazivSlike;
                        dsOpremaSlika.Update();
                        fuSlika.SaveAs(path);
                    }
                    catch
                    {

                    }
                }
            }
        }

        protected void dvOpremaDetalji_ItemDeleting(object sender, DetailsViewDeleteEventArgs e)
        {
            //kada se brise oprema, pobrisi i sliku te opreme sa servera
            try
            {
                string path = Server.MapPath("~/Images/oprema/" + e.Keys["id"] + ".jpg");
                File.Delete(path);
            }
            catch
            {

            }

            gvOprema.DataBind();
        }
    }
}