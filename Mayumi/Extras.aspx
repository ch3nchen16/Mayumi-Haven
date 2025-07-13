<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Extras.aspx.cs" Inherits="Mayumi.Extras" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Extras Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
     <div class="container mt-5">
           <div class="progress">
             <div class="progress-bar progress-bar-striped progress-bar-animated"
                  role="progressbar" 
                 aria-valuenow="75" 
                 aria-valuemin="0" 
                 aria-valuemax="100" 
                 style="width: 66%">

             </div>
           </div>
     </div>
        <div class="content-choose">
           <h1>
               Personalise Your Stay
           </h1>
        </div>
       
        <div id="feature-container">
            <div class="table-feature">
                <table class="table feature">
                    <tbody>
                           <asp:Repeater ID="rptFeatures" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <h2><%# Eval("featureName") %></h2>
                                            <br/>
                                            <img class="addon-image" src='<%# Eval("featureImage") %>'
                                                 alt='<%# Eval("featureName") %>'/>
                                        </td>
                                        <td>
                                            <p><%# Eval("featureName")%> for €<%# Eval("featurePrice") %></p>
                                            <br/>
                                            <p><%# Eval("description")%></p>
                                            <button id='btnAdd-<%# Eval("featureId") %>' class='btn-add'
                                                    data-price='<%# Eval("featurePrice") %>'
                                                    onclick='addFeature(<%# Eval("featurePrice") %>, <%# Eval("featureId") %>);'>
                                                Add
                                            </button>

                                            <button id='btnRemove-<%# Eval("featureId") %>' class='btn btn-danger'
                                                    data-price='<%# Eval("featurePrice") %>'
                                                    style='display:none;'
                                                    onclick='removeFeature(<%# Eval("featurePrice") %>, <%# Eval("featureId") %>);'>
                                                Remove
                                            </button>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                    </tbody>
                </table>
            </div>
        
        <!-- Feature Price Display -->
            <div class="table-total">
                <h2>Total:</h2> 
                <asp:Label ID="lblFeaturePrice" runat="server" Text=""></asp:Label><br /><br />
                
            </div>
    <form runat="server">
          <asp:HiddenField ID="hiddenFeaturePrice" runat="server" />
                    
          <asp:Button ID="btnNextConfirm" runat="server" Text="Next" CssClass="btnNextConfirm" OnClick="btnNextConfirm_Click" /> 
    </form>
        </div>             
    
    </body>

</asp:Content>
 