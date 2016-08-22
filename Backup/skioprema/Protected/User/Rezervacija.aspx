<%@ Page Title="Rezervacija" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Rezervacija.aspx.cs" Inherits="skioprema.Protected.User.Rezervacija" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Rezervacija
    </h2>
    <asp:SqlDataSource ID="dsOpremaDetalji" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT o.id, o.naziv, o.cijena, p.naziv as proizvodac FROM skioprema_oprema o JOIN skioprema_proizvodac p ON p.id = o.proizvodac_id;">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsRezervacija" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [skioprema_rezervacija] WHERE [id] = @original_id AND [user_id] = @original_user_id AND [datum_od] = @original_datum_od AND [datum_do] = @original_datum_do AND [odobreno] = @original_odobreno AND (([napomena] = @original_napomena) OR ([napomena] IS NULL AND @original_napomena IS NULL)) AND [ukupna_cijena] = @original_ukupna_cijena"
        InsertCommand="INSERT INTO [skioprema_rezervacija] ([user_id], [datum_od], [datum_do], [odobreno], [napomena], [ukupna_cijena]) VALUES (CONVERT(UNIQUEIDENTIFIER,@user_id), @datum_od, @datum_do, @odobreno, @napomena, @ukupna_cijena);SET @NewId = Scope_Identity()"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [skioprema_rezervacija]"
        UpdateCommand="UPDATE [skioprema_rezervacija] SET [user_id] = @user_id, [datum_od] = @datum_od, [datum_do] = @datum_do, [odobreno] = @odobreno, [napomena] = @napomena, [ukupna_cijena] = @ukupna_cijena WHERE [id] = @original_id AND [user_id] = @original_user_id AND [datum_od] = @original_datum_od AND [datum_do] = @original_datum_do AND [odobreno] = @original_odobreno AND (([napomena] = @original_napomena) OR ([napomena] IS NULL AND @original_napomena IS NULL)) AND [ukupna_cijena] = @original_ukupna_cijena"
        OnInserted="dsRezervacija_Inserted">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_user_id" Type="Object" />
            <asp:Parameter DbType="Date" Name="original_datum_od" />
            <asp:Parameter DbType="Date" Name="original_datum_do" />
            <asp:Parameter Name="original_odobreno" Type="Int32" />
            <asp:Parameter Name="original_napomena" Type="String" />
            <asp:Parameter Name="original_ukupna_cijena" Type="Double" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="user_id" Type="Object" />
            <asp:Parameter DbType="Date" Name="datum_od" />
            <asp:Parameter DbType="Date" Name="datum_do" />
            <asp:Parameter Name="odobreno" Type="Int32" />
            <asp:Parameter Name="napomena" Type="String" />
            <asp:Parameter Name="ukupna_cijena" Type="Double" />
            <asp:Parameter Name="NewId" Type="Int32" Direction="Output" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="user_id" Type="Object" />
            <asp:Parameter DbType="Date" Name="datum_od" />
            <asp:Parameter DbType="Date" Name="datum_do" />
            <asp:Parameter Name="odobreno" Type="Int32" />
            <asp:Parameter Name="napomena" Type="String" />
            <asp:Parameter Name="ukupna_cijena" Type="Double" />
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_user_id" Type="Object" />
            <asp:Parameter DbType="Date" Name="original_datum_od" />
            <asp:Parameter Name="original_datum_do" DbType="Date" />
            <asp:Parameter Name="original_odobreno" Type="Int32" />
            <asp:Parameter Name="original_napomena" Type="String" />
            <asp:Parameter Name="original_ukupna_cijena" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsStavkaRezervacije" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [skioprema_stavka_rezervacije] WHERE [rezervacija_id] = @original_rezervacija_id AND [oprema_id] = @original_oprema_id"
        InsertCommand="INSERT INTO [skioprema_stavka_rezervacije] ([rezervacija_id], [oprema_id]) VALUES (@rezervacija_id, @oprema_id)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [skioprema_stavka_rezervacije]">
        <DeleteParameters>
            <asp:Parameter Name="original_rezervacija_id" Type="Int32" />
            <asp:Parameter Name="original_oprema_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="rezervacija_id" Type="Int32" />
            <asp:Parameter Name="oprema_id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Text="Od datuma"></asp:Label>
    <asp:TextBox ID="tbDatumOd" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="tbDatumOd_TextChanged"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="tbDatumOd"
        ErrorMessage="Molimo odaberite datum iznajmljivanja." ForeColor="Red">
    </asp:RequiredFieldValidator>
    <br />
    <asp:Label ID="Label2" runat="server" Text="Do datuma"></asp:Label>
    <asp:TextBox ID="tbDatumDo" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="tbDatumDo_TextChanged"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="tbDatumDo"
        ErrorMessage="Molimo odaberite datum vraćanja." ForeColor="Red">
    </asp:RequiredFieldValidator>
    <br />
    <asp:CompareValidator ID="cv1" ControlToCompare="tbDatumOd" ControlToValidate="tbDatumDo"
        Type="Date" Operator="GreaterThanEqual" ErrorMessage="Datum vraćanja ne može biti ranije od datuma iznajmljivanja"
        ForeColor="Red" runat="server"></asp:CompareValidator>
    <br />
    <asp:CompareValidator ID="cv2" runat="server" ControlToValidate="tbDatumOd" Operator="GreaterThanEqual"
        Display="Dynamic" ValueToCompare="<%# DateTime.Today.ToShortDateString() %>"
        Type="Date" ErrorMessage="Datum posudbe može biti veći ili jednak današnjem" ForeColor="Red" />
    <br />
    <asp:TextBox ID="tbNapomena" runat="server" Height="92px" TextMode="MultiLine" Width="420px"
        placeholder="Vaša napomena"></asp:TextBox>
    <h2>
        Košarica:</h2>
    <asp:GridView ID="gvKosarica" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
        CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Id" SortExpression="id" ItemStyle-Width="50px">
                <ItemStyle Width="50px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="proizvodac" HeaderText="Proizvođač" SortExpression="proizvodac"
                ItemStyle-Width="100px">
                <ItemStyle Width="100px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" ItemStyle-Width="180px">
                <ItemStyle Width="180px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="cijena" HeaderText="Cijena/dan" SortExpression="cijena"
                ItemStyle-Width="50px">
                <ItemStyle Width="50px"></ItemStyle>
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
    <asp:Button ID="btnOdustani" runat="server" Text="Odustani" OnClick="btnOdustani_Click"
        CausesValidation="false" />
    <asp:Button ID="btnPotvrdi" runat="server" Text="Potvrdi rezervaciju" OnClick="btnPotvrdi_Click"
        CausesValidation="true" />
    <asp:UpdatePanel ID="upUkupnaCijena" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="tbDatumOd" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="tbDatumDo" EventName="TextChanged" />
        </Triggers>
        <ContentTemplate>
            <asp:TextBox ID="tbUkupnaCijena" runat="server" Style="position: relative; top: -21px;
                left: 339px; width: 64px;" ReadOnly="True"></asp:TextBox>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:Label ID="Label3" runat="server" Text="*ukupna cijena u izračun uzima cijene/dan i ukupni broj dana"></asp:Label>
</asp:Content>