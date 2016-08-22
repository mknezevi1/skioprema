<%@ Page Title="O nama" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="O_nama.aspx.cs" Inherits="skioprema.O_nama" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        O nama
    </h2>
    <br />
    <asp:Image ID="Image1" runat="server" Height="235px" ImageUrl="~/Images/inside2.jpg"
        Width="353px" />
    <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/inside1.jpg" Style="position: relative;
        top: 258px; left: -356px; height: 228px; width: 356px" />
    <div style="position: relative; top: -229px; left: 371px; width: 400px; height: 240px;
        text-align: justify">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ut facilisis tellus.
        Quisque fringilla, tortor et efficitur ultrices, lorem lorem mattis ipsum, quis
        dapibus sem tellus vel justo. Suspendisse luctus nisl urna. Donec posuere tortor
        neque, faucibus posuere turpis pharetra sed. Maecenas sed volutpat arcu. Morbi fringilla
        ultrices orci, et dapibus eros ultricies ut. Nullam eu lectus sapien. Curabitur
        auctor tellus a feugiat luctus. Donec at urna vitae mauris volutpat viverra sed
        in neque. Vestibulum vel accumsan velit. Praesent feugiat, ligula ornare aliquam
        interdum, diam ligula luctus turpis, nec ullamcorper sapien purus sed ante. Quisque
        eu diam pellentesque, rutrum eros eget, vestibulum orci. Phasellus feugiat felis
        et lectus pulvinar ultrices. Vivamus posuere sodales augue.
    </div>
    <div style="position: relative; top: -213px; left: 374px; width: 394px; height: 222px;
        text-align: justify">
        Nullam egestas gravida magna, ut pretium massa placerat sed. Donec eleifend gravida
        eros, ac sagittis tellus sollicitudin pulvinar. Etiam id elementum neque. Curabitur
        facilisis suscipit leo, sit amet fermentum magna mollis id. Morbi porta scelerisque
        magna, elementum feugiat sapien ullamcorper pulvinar. Integer pulvinar porttitor
        lacus, quis cursus sapien viverra sit amet. Morbi sed nibh in tellus pulvinar ultrices.
        Suspendisse interdum vel enim quis eleifend. Aliquam sed ipsum dapibus, aliquam
        dolor sed, congue.<asp:Image ID="Image3" runat="server" 
            ImageUrl="~/Images/proizvodaci.jpg" Width="200px" 
            style="position: relative; top: 37px; left: 104px" />
    </div>
</asp:Content>