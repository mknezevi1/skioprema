<%@ Page Title="Oprema" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Oprema.aspx.cs" Inherits="skioprema.Protected.User.Oprema" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Oprema
    </h2>
    <asp:SqlDataSource ID="dsOprema" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT o.id, o.naziv, o.cijena, o.godina, o.dostupno, o.velicina, k.naziv as kategorija, p.naziv as proizvodac FROM skioprema_oprema o JOIN skioprema_kategorija k ON k.id = o.kategorija_id JOIN skioprema_proizvodac p ON p.id = o.proizvodac_id WHERE k.id = @kategorijaID AND o.dostupno > 0;">
        <SelectParameters>
            <asp:ControlParameter Name="kategorijaID" ControlID="ddlKategorija" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsOpremaDetalji" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT o.id, o.naziv, o.cijena, p.naziv as proizvodac FROM skioprema_oprema o JOIN skioprema_proizvodac p ON p.id = o.proizvodac_id;">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKategorija" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [skioprema_kategorija]"></asp:SqlDataSource>
    <br />
    <asp:DropDownList ID="ddlKategorija" AutoPostBack="true" runat="server" DataSourceID="dsKategorija"
        DataTextField="naziv" DataValueField="id">
    </asp:DropDownList>
    <asp:UpdatePanel ID="upOprema" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlKategorija" EventName="SelectedIndexChanged" />
        </Triggers>
        <ContentTemplate>
            <asp:GridView ID="gvOprema" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="dsOprema" OnRowCommand="gvOprema_RowCommand"
                CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="proizvodac" HeaderText="Proizvodač" SortExpression="proizvodac"
                        ItemStyle-Width="100px">
                        <ItemStyle Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" 
                        ItemStyle-Width="180px">
                        <ItemStyle Width="180px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="cijena" HeaderText="Cijena/dan" SortExpression="cijena"
                        ItemStyle-Width="50px">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="velicina" HeaderText="Veličina" 
                        SortExpression="velicina">
                    </asp:BoundField>
                    <asp:BoundField DataField="godina" HeaderText="Godina" SortExpression="godina" 
                        ItemStyle-Width="50px">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/detalji.png" CommandName="detalji" />
                    <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/dodaj.png" CommandName="dodaj" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <br />
            Košarica:
            <asp:GridView ID="gvKosarica" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="Id" SortExpression="id" 
                        ItemStyle-Width="50px">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="proizvodac" HeaderText="Proizvođač" SortExpression="proizvodac"
                        ItemStyle-Width="100px">
                        <ItemStyle Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" 
                        ItemStyle-Width="180px">
                        <ItemStyle Width="180px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="cijena" HeaderText="Cijena/dan" SortExpression="cijena"
                        ItemStyle-Width="50px">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:Button ID="btnOcisti" runat="server" Text="Očisti" OnClick="btnOcisti_Click"
                Enabled="False" />
            <asp:Button ID="btnNastavi" runat="server" Text="Nastavi rezervaciju" OnClick="btnNastavi_Click"
                Enabled="False" />
            <asp:TextBox ID="tbUkupnaCijena" runat="server" Style="position: relative; top: 0px;
                left: 153px; width: 65px;" ReadOnly="True"></asp:TextBox>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>