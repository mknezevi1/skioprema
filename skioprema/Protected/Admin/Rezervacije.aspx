<%@ Page Title="Rezervacije" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Rezervacije.aspx.cs" Inherits="skioprema.Protected.Admin.Rezervacije" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Rezervacije
    </h2>
    <asp:SqlDataSource ID="dsRezervacije" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT r.id, r.datum_od, r.datum_do, r.odobreno, r.napomena, r.ukupna_cijena, u.UserName FROM skioprema_rezervacija r JOIN aspnet_Users u ON r.user_id = u.UserId;"
        UpdateCommand="UPDATE [skioprema_rezervacija] SET [odobreno] = @odobreno WHERE [id] = @id;">
        <UpdateParameters>
            <asp:Parameter Name="odobreno" Type="Int32" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsStavkeRezervacije" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT p.naziv as proizvodac, o.naziv as oprema, o.id as oprema_id, o.cijena as cijena FROM skioprema_oprema o JOIN skioprema_proizvodac p ON p.id = o.proizvodac_id JOIN skioprema_stavka_rezervacije sr ON sr.oprema_id = o.id WHERE sr.rezervacija_id = @rezervacijaID">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvRezervacije" Name="rezervacijaID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMail" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT m.Email FROM aspnet_Membership m JOIN aspnet_Users u ON u.UserId = m.UserId JOIN skioprema_rezervacija r ON r.user_id = u.UserId WHERE r.id = @id; ">
        <SelectParameters>
            <asp:Parameter Name="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsProvjera" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT r.id FROM skioprema_rezervacija r JOIN skioprema_stavka_rezervacije sr ON r.id = sr.rezervacija_id WHERE r.datum_od &lt;= @datum_do AND r.datum_do &gt;= @datum_od AND r.odobreno = 1 AND sr.oprema_id = @oprema_id AND r.id <> @rezervacija_id; ">
        <SelectParameters>
            <asp:Parameter Name="datum_do" />
            <asp:Parameter Name="datum_od" />
            <asp:Parameter Name="oprema_id" />
            <asp:Parameter Name="rezervacija_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="gvRezervacije" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="dsRezervacije"
        ForeColor="#333333" GridLines="None" OnRowCommand="gvRezervacije_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/detalji.png" CommandName="detalji" />
            <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/prihvati.png" CommandName="potvrdi" />
            <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/odbij.png" CommandName="odbij" />
            <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/preklapanja.png" CommandName="preklapanja" />
            <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="id" />
            <asp:BoundField DataField="datum_od" HeaderText="Datum posudbe" DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="datum_od" />
            <asp:BoundField DataField="datum_do" HeaderText="Datum vraćanja" DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="datum_do" />
            <asp:BoundField DataField="odobreno" HeaderText="Odobreno" SortExpression="odobreno" />
            <asp:BoundField DataField="napomena" HeaderText="Napomena" SortExpression="napomena" />
            <asp:TemplateField HeaderText="Broj dana">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblBrojDana" Text='<%# (((DateTime)Eval("datum_do") - (DateTime)Eval("datum_od")).TotalDays + 1).ToString() %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:BoundField DataField="ukupna_cijena" HeaderText="Cijena" SortExpression="ukupna_cijena" />
            <asp:BoundField DataField="UserName" HeaderText="Korisnik" SortExpression="UserName" />
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
    <asp:Label ID="lblProvjeraPreklapanja" runat="server" Text="_________________" BackColor="#CCCCCC"></asp:Label>
    *provjera preklapanja rezervacija (oprema/datum)
    <br />
    <br />
    <asp:GridView ID="gvRezervacijaStavke" runat="server" AutoGenerateColumns="False"
        DataSourceID="dsStavkeRezervacije" CellPadding="4" ForeColor="#333333" GridLines="None"
        Width="300px">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="proizvodac" HeaderText="Proizvođač" SortExpression="proizvodac" />
            <asp:BoundField DataField="oprema" HeaderText="Oprema" SortExpression="oprema" />
            <asp:BoundField DataField="cijena" HeaderText="Cijena" SortExpression="cijena" />
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
</asp:Content>
