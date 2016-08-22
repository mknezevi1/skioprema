<%@ Page Title="Detalji" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Detalji.aspx.cs" Inherits="skioprema.Protected.User.Detalji" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Detalji
        <asp:SqlDataSource ID="dsOpremaDetalji" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT o.id, p.naziv as proizvodac, o.naziv, o.cijena, o.velicina, o.godina, o.slika, o.opis FROM skioprema_oprema o JOIN skioprema_proizvodac p ON p.id = o.proizvodac_id WHERE o.id = @opremaID;">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="opremaID" QueryStringField="id" />
            </SelectParameters>
        </asp:SqlDataSource>
    </h2>
    <asp:DetailsView ID="dvOpremaDetalji" runat="server" DataSourceID="dsOpremaDetalji"
        Height="50px" Width="400px" AutoGenerateRows="False" DataKeyNames="id">
        <Fields>
            <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" 
                ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="proizvodac" HeaderText="Proizvođač" 
                SortExpression="proizvodac" />
            <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
            <asp:BoundField DataField="velicina" HeaderText="Veličina" 
                SortExpression="velicina" />
            <asp:BoundField DataField="cijena" HeaderText="Cijena/dan" 
                SortExpression="cijena" />
            <asp:BoundField DataField="godina" HeaderText="Godina" 
                SortExpression="godina" />
            <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
        </Fields>
    </asp:DetailsView>
    <br />
    <asp:Image ID="imSlika" runat="server" Width="400px" Style="position: relative; top: 0px; left: 1px" />
    <br />
    <h2>
        <asp:HyperLink ID="hl1" runat="server" NavigateUrl="~/Protected/User/Oprema.aspx">Povratak</asp:HyperLink>
    </h2>
</asp:Content>