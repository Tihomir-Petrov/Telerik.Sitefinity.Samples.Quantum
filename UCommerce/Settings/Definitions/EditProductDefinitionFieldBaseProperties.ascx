<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProductDefinitionFieldBaseProperties.ascx.cs" Inherits="UCommerce.Web.UI.Settings.Definitions.EditProductDefinitionFieldBaseProperties" %>
<%@ Register tagPrefix="commerce" tagName="ValidationSummary" src="../../Controls/ValidationSummaryDisplay.ascx" %>

<commerce:ValidationSummary ID="ValidationSummary1" runat="server" />
<div class="propertyPane">
    <h2 class="propertyPaneTitel"><asp:Localize runat="server" meta:resourceKey="ProductDefinitionFieldProperties" /></h2>
    <div class="propertyItem">
        <div class="propertyItemHeader"><asp:Localize ID="Localize2" runat="server" meta:resourceKey="DataType" /></div>
        <div class="propertyItemContent">
            <asp:DropDownList runat="server" ID="DataTypeDropDown" DataSource="<%# View.DataTypes %>" DataValueField="DataTypeId" DataTextField="TypeName" OnDataBound="DataTypeDropDown_DataBound" CssClass="mediumWidth" />
        </div>
    </div>
    <div class="propertyItem">
        <div class="propertyItemHeader"><asp:Localize ID="Localize3" runat="server" meta:resourceKey="Multilingual" /></div>
        <div class="propertyItemContent">
            <asp:CheckBox runat="server" ID="MultilingualCheckBox" class="ucommerce-toggle-check-box" Checked="<%# View.ProductDefinitionField.Multilingual %>" />
        </div>
    </div>
    <div class="propertyItem">
        <div class="propertyItemHeader"><asp:Localize ID="Localize4" runat="server" meta:resourceKey="DisplayOnSite" /></div>
        <div class="propertyItemContent">
            <asp:CheckBox runat="server" ID="DisplayOnSiteCheckBox" class="ucommerce-toggle-check-box" Checked="<%# View.ProductDefinitionField.DisplayOnSite %>" />
        </div>
    </div>
    <div class="propertyItem">
        <div class="propertyItemHeader"><asp:Localize ID="Localize5" runat="server" meta:resourceKey="VariantProperty" /></div>
        <div class="propertyItemContent">
            <asp:CheckBox runat="server" ID="VariantPropertyCheckBox" class="ucommerce-toggle-check-box" Checked="<%# View.ProductDefinitionField.IsVariantProperty %>" />
        </div>
    </div>
    <div class="propertyItem">
        <div class="propertyItemHeader"><asp:Localize ID="Localize6" runat="server" meta:resourceKey="RenderInEditor" /></div>
        <div class="propertyItemContent">
            <asp:CheckBox runat="server" ID="RenderInEditorCheckBox" class="ucommerce-toggle-check-box" Checked="<%# View.ProductDefinitionField.RenderInEditor %>" />
        </div>
    </div>
	<div class="propertyItem">
        <div class="propertyItemHeader"><asp:Localize ID="Localize7" runat="server" meta:resourceKey="IndexForFaceted" /></div>
        <div class="propertyItemContent">
            <asp:CheckBox runat="server" ID="IndexForFacetedSearchCheckBox" class="ucommerce-toggle-check-box" Checked="<%# View.ProductDefinitionField.Facet %>" />
			<asp:CustomValidator runat="server" CssClass="validator" id="FacetedSearchLicenseValidator" OnServerValidate="FacetedSearchLicenseValidator_Validate" meta:resourcekey="FacetedSearchLicenseValidator" Text="*" ErrorMessage="Faceted search not availble with current license.(*)"></asp:CustomValidator>
        </div>
    </div>
    <div class="propertyPaneFooter"></div>
</div>