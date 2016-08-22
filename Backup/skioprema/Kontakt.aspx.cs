using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Drawing;

namespace skioprema
{
    public partial class Kontakt : System.Web.UI.Page
    {
        SmtpClient client = null;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPosalji_Click(object sender, EventArgs e)
        {
            try
            {
                MailAddress adrPosiljatelj = new MailAddress(tbEmail.Text, tbIme.Text);
                MailAddress adrPrimatelj = new MailAddress("skioprema@test.hr");
                MailMessage email = new MailMessage(adrPosiljatelj, adrPrimatelj);
                email.Subject = "Upit sa kontakt stranice";
                email.Body = tbPoruka.Text;
                if (client == null)
                {
                    client = new SmtpClient("localhost");
                }
                client.Send(email);
                lblObavijest.ForeColor = Color.Green;
                lblObavijest.Text = "Poruka poslana.";
            }
            catch
            {
                lblObavijest.ForeColor = Color.Red;
                lblObavijest.Text = "Poruka nije poslana. Molimo provjerite unesene podatke.";
            }
            tbEmail.Text = "";
            tbIme.Text = "";
            tbPoruka.Text = "";
        }
    }
}