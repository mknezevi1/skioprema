<%@ Page Title="Kontakt" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Kontakt.aspx.cs" Inherits="skioprema.Kontakt" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="https://maps.google.com/maps/api/js?v=3.5&sensor=true"></script>
    <script>
        function initialize() {
            var pozicijaIN2 = new google.maps.LatLng(45.793075, 15.970258);
            var mapProp = {
                center: pozicijaIN2,
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
            var marker = new google.maps.Marker({ position: pozicijaIN2 });
            marker.setMap(map);
        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Kontakt
    </h2>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Vaš e-mail"></asp:Label>
    <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Label ID="Label2" runat="server" Text="Vaše ime"></asp:Label>
    <asp:TextBox ID="tbIme" runat="server" Style="position: relative; top: 0px; left: 8px"></asp:TextBox>
    <br />
    <br />
    <asp:Label ID="Label3" runat="server" Text="Poruka" Style="position: relative"></asp:Label>
    <br />
    <asp:TextBox ID="tbPoruka" runat="server" Style="position: relative; top: -13px;
        left: 62px; width: 168px" TextMode="MultiLine"></asp:TextBox>
    <br />
    <asp:Button ID="btnPosalji" runat="server" Text="Pošalji" Style="position: relative;
        top: 0px; left: 182px" CausesValidation="true" OnClick="btnPosalji_Click" />
    <br />
    <asp:RequiredFieldValidator ID="rfEmail" runat="server" ErrorMessage="Molimo upišite Vaš email."
        ControlToValidate="tbEmail" ForeColor="Red" Display="none"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="rfIme" runat="server" ErrorMessage="Molimo upišite Vaše ime."
        ControlToValidate="tbIme" ForeColor="Red" Display="none"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="rfPoruka" runat="server" ErrorMessage="Molimo upišite poruku."
        ControlToValidate="tbPoruka" ForeColor="Red" Display="none"></asp:RequiredFieldValidator>
    <asp:Label ID="lblObavijest" runat="server" ForeColor="Green"></asp:Label>
    <asp:ValidationSummary ID="vs" ForeColor="Red" runat="server" />
    <br />
    <br />
    <h2>
        Gdje se nalazimo
        <h3>
            adresa: Marohnićeva 1/1
            <br />
            grad: 10000 Zagreb
        </h3>
    </h2>
    <div id="googleMap" style="width: 500px; height: 380px;">
    </div>
</asp:Content>