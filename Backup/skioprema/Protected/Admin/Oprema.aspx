<%@ Page Title="Oprema" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Oprema.aspx.cs" Inherits="skioprema.Protected.Admin.Oprema" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Oprema
    </h2>
    <asp:SqlDataSource ID="dsKategorije" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [skioprema_kategorija]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsProizvodaci" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [skioprema_proizvodac]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsOprema" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT o.id, o.naziv, k.naziv AS kategorija, p.naziv AS proizvodac FROM skioprema_oprema o JOIN skioprema_kategorija k ON k.id = o.kategorija_id JOIN skioprema_proizvodac p ON p.id = o.proizvodac_id WHERE k.id = @kategorijaID;">
        <SelectParameters>
            <asp:ControlParameter Name="kategorijaID" ControlID="ddlKategorije" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsOpremaDetalji" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [skioprema_oprema] WHERE ([id] = @id)" DeleteCommand="DELETE FROM [skioprema_oprema] WHERE [id] = @original_id"
        InsertCommand="INSERT INTO [skioprema_oprema] ([naziv], [opis], [cijena], [godina], [kategorija_id], [dostupno], [proizvodac_id], [velicina]) VALUES (@naziv, @opis, @cijena, @godina, @kategorija_id, @dostupno, @proizvodac_id, @velicina)"
        OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [skioprema_oprema] SET [naziv] = @naziv, [opis] = @opis, [cijena] = @cijena, [godina] = @godina, [kategorija_id] = @kategorija_id, [dostupno] = @dostupno, [proizvodac_id] = @proizvodac_id, [velicina] = @velicina WHERE [id] = @original_id">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="opis" Type="String" />
            <asp:Parameter Name="cijena" Type="Double" />
            <asp:Parameter Name="godina" Type="Int32" />
            <asp:Parameter Name="kategorija_id" Type="Int32" />
            <asp:Parameter Name="dostupno" Type="Int32" />
            <asp:Parameter Name="slika" Type="String" />
            <asp:Parameter Name="proizvodac_id" Type="Int32" />
            <asp:Parameter Name="velicina" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvOprema" Name="id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="naziv" Type="String" />
            <asp:Parameter Name="opis" Type="String" />
            <asp:Parameter Name="cijena" Type="Double" />
            <asp:Parameter Name="godina" Type="Int32" />
            <asp:Parameter Name="kategorija_id" Type="Int32" />
            <asp:Parameter Name="dostupno" Type="Int32" />
            <asp:Parameter Name="slika" Type="String" />
            <asp:Parameter Name="proizvodac_id" Type="Int32" />
            <asp:Parameter Name="velicina" Type="String" />
            <asp:Parameter Name="original_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsOpremaSlika" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [skioprema_oprema] WHERE [id] = @id" InsertCommand="INSERT INTO [skioprema_oprema] ([slika]) VALUES (@slika)"
        SelectCommand="SELECT [id], [slika] FROM [skioprema_oprema]" UpdateCommand="UPDATE [skioprema_oprema] SET [slika] = @slika WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="slika" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="slika" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:DropDownList ID="ddlKategorije" runat="server" AutoPostBack="true" DataSourceID="dsKategorije"
        DataTextField="naziv" DataValueField="id">
    </asp:DropDownList>
    <asp:UpdatePanel ID="upOprema" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlKategorije" EventName="SelectedIndexChanged" />
        </Triggers>
        <ContentTemplate>
            <asp:GridView ID="gvOprema" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="dsOprema"
                ForeColor="#333333" GridLines="None" OnRowCommand="gvOprema_RowCommand">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:ButtonField ButtonType="Image" ImageUrl="~/Images/detalji.png" CommandName="detalji" />
                    <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                        SortExpression="id" />
                    <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                    <asp:BoundField DataField="kategorija" HeaderText="Kategorija" SortExpression="kategorija" />
                    <asp:BoundField DataField="proizvodac" HeaderText="Proizvođač" SortExpression="proizvodac" />
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
            <h2>
                <asp:DetailsView ID="dvOpremaDetalji" runat="server" Height="50px" Width="300px"
                    AutoGenerateRows="False" DataKeyNames="id" DataSourceID="dsOpremaDetalji" OnItemDeleted="dvOpremaDetalji_ItemDeleted"
                    OnItemInserted="dvOpremaDetalji_ItemInserted" OnItemUpdated="dvOpremaDetalji_ItemUpdated"
                    OnItemDeleting="dvOpremaDetalji_ItemDeleting">
                    <Fields>
                        <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                            SortExpression="id" />
                        <asp:BoundField DataField="naziv" HeaderText="Naziv" SortExpression="naziv" />
                        <asp:BoundField DataField="opis" HeaderText="Opis" SortExpression="opis" />
                        <asp:BoundField DataField="cijena" HeaderText="Cijena" SortExpression="cijena" />
                        <asp:BoundField DataField="godina" HeaderText="Godina" SortExpression="godina" />
                        <asp:TemplateField HeaderText="Kategorija">
                            <ItemTemplate>
                                <asp:DropDownList ID="kategorija" runat="server" Enabled="False" DataSourceID="dsKategorije"
                                    DataTextField="naziv" DataValueField="id" SelectedValue='<%# Bind("kategorija_id") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="kategorija" runat="server" Enabled="True" DataSourceID="dsKategorije"
                                    DataTextField="naziv" DataValueField="id" SelectedValue='<%# Bind("kategorija_id") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="kategorija" runat="server" Enabled="True" DataSourceID="dsKategorije"
                                    DataTextField="naziv" DataValueField="id" SelectedValue='<%# Bind("kategorija_id") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="dostupno" HeaderText="Dostupno" SortExpression="dostupno" />
                        <asp:TemplateField HeaderText="Proizvođač">
                            <ItemTemplate>
                                <asp:DropDownList ID="proizvodac" runat="server" Enabled="False" DataSourceID="dsProizvodaci"
                                    DataTextField="naziv" DataValueField="id" SelectedValue='<%# Bind("proizvodac_id") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="proizvodac" runat="server" Enabled="True" DataSourceID="dsProizvodaci"
                                    DataTextField="naziv" DataValueField="id" SelectedValue='<%# Bind("proizvodac_id") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="proizvodac" runat="server" Enabled="True" DataSourceID="dsProizvodaci"
                                    DataTextField="naziv" DataValueField="id" SelectedValue='<%# Bind("proizvodac_id") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="velicina" HeaderText="Veličina" SortExpression="velicina" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True"
                            CancelText="Odustani" DeleteText="Pobriši" EditText="Ažuriraj" InsertText="Unesi"
                            NewText="Novo" UpdateText="Spremi" />
                    </Fields>
                </asp:DetailsView>
            </h2>
            <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:FileUpload ID="fuSlika" runat="server" />
    <asp:ImageButton ID="btnUpload" runat="server" ImageUrl="~/Images/spremi.png" OnClick="btnUpload_Click"
        Style="position: relative; top: 9px; left: -20px" />
    <br />
    <br />
    * odaberite prethodno unesenu opremu prije uploada njene slike
    <br />
    * poslovno pravilo je da atribut dostupno mora imati vrijednost >= 0
</asp:Content>