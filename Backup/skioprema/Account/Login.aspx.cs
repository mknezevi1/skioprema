using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace skioprema.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //forsiranje secure konekcije (https)
            /*
            if (!Request.IsSecureConnection)
            {
                string url = "https://localhost:44301/Account/Login.aspx";
                Response.Redirect(url);
            }
            */
            //info: u glavni web.config u <forms> dodat atribut requireSSL="true"
            //info: ako se ovo koristi, mozda ce biti potrebno prilagodit port u gornjem linku

            RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);

            this.LoginUser.FailureText = "Prijava nije bila uspješna, molimo provjerite unesene podatke";

            LoginUser.FindControl("UserName").Focus();
        }
    }
}