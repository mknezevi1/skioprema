<%@ Page Title="KategorijeProizvodaci" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="KategorijeProizvodaci.aspx.cs" Inherits="skioprema.Protected.Admin.KategorijeProizvodaci" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Kategorije i proizvodači
    </h2>
    <h2>
        Kategorije</h2>
    <asp:SqlDataSource ID="dsKategorije" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [skioprema_kategorija] WHERE [id] = @original_id AND [naziv] = @original_naziv"
        InsertCommand="INSERT INTO [skioprema_kategorija] ([naziv]) VALUES (@naziv)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [skioprema_kategorija]"
        UpdateCommand="UPDATE [skioprema_kategorija] SET [naziv] = @naziv WHERE [id] = @original_id AND [naziv] = @original_naziv">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_naziv" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="naziv" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_naziv" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvKategorije" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="dsKategorije"
        ForeColor="#333333" GridLines="None" PageSize="5">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="id" />
            <asp:TemplateField HeaderText="Naziv" SortExpression="naziv">
                <EditItemTemplate>
                    <asp:TextBox ID="tbNaziv" runat="server" Text='<%# Bind("naziv") %>' />
                    <asp:RequiredFieldValidator runat='server' ID='requiredApp' ErrorMessage='Molimo unesite naziv'
                        ForeColor="White" ControlToValidate='tbNaziv' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblNaziv" runat="server" Text='<%# Bind("naziv") %>' />
                </ItemTemplate>
            </asp:TemplateField>
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
    <asp:TextBox ID="tbNovaKategorija" runat="server" Width="100px" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
    <asp:ImageButton ID="btnDodajKategoriju" runat="server" ImageUrl="~/Images/dodaj.png"
        OnClick="btnDodajKategoriju_Click" Style="position: relative; top: 7px; left: 0px"
        CausesValidation="true" ValidationGroup="vgKategorije" />
    <asp:RequiredFieldValidator ID="rfvKategorije" runat="server" ErrorMessage="Molimo unesite naziv"
        ForeColor="Red" ControlToValidate="tbNovaKategorija" ValidationGroup="vgKategorije"></asp:RequiredFieldValidator>
    <h2>
        Proizvođači</h2>
    <asp:SqlDataSource ID="dsProizvodaci" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [skioprema_proizvodac] WHERE [id] = @original_id AND [naziv] = @original_naziv"
        InsertCommand="INSERT INTO [skioprema_proizvodac] ([naziv]) VALUES (@naziv)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [skioprema_proizvodac]"
        UpdateCommand="UPDATE [skioprema_proizvodac] SET [naziv] = @naziv WHERE [id] = @original_id AND [naziv] = @original_naziv">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_naziv" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="naziv" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_naziv" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvProizvodaci" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="dsProizvodaci"
        ForeColor="#333333" GridLines="None" PageSize="5">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="id" />
            <asp:TemplateField HeaderText="Naziv" SortExpression="naziv">
                <EditItemTemplate>
                    <asp:TextBox ID="tbNaziv" runat="server" Text='<%# Bind("naziv") %>' />
                    <asp:RequiredFieldValidator runat='server' ID='requiredApp' ErrorMessage='Molimo unesite naziv'
                        ForeColor="White" ControlToValidate='tbNaziv' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblNaziv" runat="server" Text='<%# Bind("naziv") %>' />
                </ItemTemplate>
            </asp:TemplateField>
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
    <asp:TextBox ID="tbNoviProizvodac" runat="server" Width="100px" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
    <asp:ImageButton ID="btnDodajProizvodaca" runat="server" ImageUrl="~/Images/dodaj.png"
        OnClick="btnDodajProizvodaca_Click" Style="position: relative; top: 7px; left: 0px"
        CausesValidation="true" ValidationGroup="vgProizvodaci" />
    <asp:RequiredFieldValidator ID="rfvProizvodaci" runat="server" ErrorMessage="Molimo unesite naziv"
        ForeColor="Red" ControlToValidate="tbNoviProizvodac" ValidationGroup="vgProizvodaci"></asp:RequiredFieldValidator>
    <br /><br />
    * brisanjem kategorije briše se i sva oprema pod tom kategorijom te rezervacije koje opremu sadržavaju
    <br />
    * brisanjem proizvođača briše se i sva oprema pod tim proizvođačem te rezervacije koje opremu sadržavaju
</asp:Content>