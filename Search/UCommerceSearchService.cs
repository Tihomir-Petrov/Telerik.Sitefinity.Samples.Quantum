using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Sitefinity.Services.Search;
using Telerik.Sitefinity.Services.Search.Data;
using Telerik.Sitefinity.Services;
using Telerik.Sitefinity.Services.Search;
using Telerik.Sitefinity.Services.Search.Data;
using Telerik.Sitefinity.Services.Search.Model;
using Telerik.Sitefinity.Services.Search.Publishing;
using UCommerce.Extensions;
using Telerik.Sitefinity.News.Model;
using UCommerce.Infrastructure.Globalization;
using System.Globalization;
using Telerik.Sitefinity.Web;
using System.Text.RegularExpressions;
using UCommerce.Runtime;
using System.Threading;

namespace SitefinityWebApp.Search
{
    public class UCommerceSearchService : LuceneSearchService
    {
        private static string productDetailsPageId = "6958675d-c257-4e46-a868-676411bee5e2";

        public override void CreateIndex(string name, IEnumerable<IFieldDefinition> fieldDefinitions)
        {
            base.CreateIndex(name, fieldDefinitions);

            this.IndexProducts(name);
        }

        private void IndexProducts(string name)
        {
            var productDocs = new List<Document>();
            var products = UCommerce.EntitiesV2.Product.All().Where(p => p.DisplayOnSite == true && p.ProductDefinition.Deleted == false).ToList();

            var currentUiCulture = Thread.CurrentThread.CurrentUICulture;
            
            foreach (var lang in SystemManager.CurrentContext.AppSettings.AllLanguages)
            {
                string baseUrl = GetUrlByPageNodeIdAlternative(Guid.Parse(productDetailsPageId), lang.Value, true);

                foreach (var p in products)
                {
                    productDocs.Add(this.IndexProduct(p, lang.Value, baseUrl));
                }
            }

            this.UpdateIndex(name, productDocs);
        }

        private string GetUrlByPageNodeIdAlternative(Guid pageNodeId, CultureInfo lang, bool resolveAsAbsolutUrl)
        {
            var siteMap = SiteMapBase.GetCurrentProvider();
            
            var siteMapNode = siteMap.FindSiteMapNodeFromKey(pageNodeId.ToString()) as PageSiteNode;

            var url = String.Empty;

            if (siteMapNode != null)
            {
                url = siteMapNode.GetUrl(lang, false);

                var urlService = Telerik.Sitefinity.Abstractions.ObjectFactory.Resolve<Telerik.Sitefinity.Localization.UrlLocalizationStrategies.UrlLocalizationService>();
                url = urlService.ResolveUrl(url, lang);

                if (resolveAsAbsolutUrl)
                {
                    url = UrlPath.ResolveUrl(url, true, true);
                }
            }

            return url;
        }

        private Document IndexProduct(UCommerce.EntitiesV2.Product uProduct, CultureInfo cInfo, string baseUrl)
        {
            var prodDescr = uProduct.GetDescription(cInfo.TwoLetterISOLanguageName);

            var fields = new List<IField>();
            
            var identityFld = new Field();
            identityFld.Name = Telerik.Sitefinity.Publishing.PublishingConstants.FieldIdentifier;
            identityFld.Value = uProduct.ProductId.ToString() + "_" + cInfo.TwoLetterISOLanguageName;
            fields.Add(identityFld);
            
            var myTitleField = new Field();
            myTitleField.Name = Telerik.Sitefinity.Publishing.PublishingConstants.FieldTitle;
            myTitleField.Value = prodDescr.DisplayName;
            fields.Add(myTitleField);
            
            var contentField = new Field();
            contentField.Name = Telerik.Sitefinity.Publishing.PublishingConstants.FieldContent;
            contentField.Value = HttpUtility.HtmlDecode(Regex.Replace(prodDescr.LongDescription, "<(.|\n)*?>", ""));
            fields.Add(contentField);

            var lastModifiedField = new Field();
            lastModifiedField.Name = Telerik.Sitefinity.Publishing.PublishingConstants.FieldLastModified;
            lastModifiedField.Value = uProduct.ModifiedOn;
            fields.Add(lastModifiedField);

            string category = null;
            var cat = uProduct.GetCategories().FirstOrDefault();
            if (cat !=null)
            {
                category = cat.DisplayName();
            }
            else
            {
                category = SiteContext.Current.CatalogContext.CurrentCategory.DisplayName();
            }
            
            fields.Add(new Telerik.Sitefinity.Services.Search.Publishing.Field()
            {
                Name = Telerik.Sitefinity.Publishing.PublishingConstants.FieldLink,
                Value = baseUrl + "/" + category + "/" + uProduct.Id
            });

            fields.Add(new Telerik.Sitefinity.Services.Search.Publishing.Field()
            {
                Name = Telerik.Sitefinity.Publishing.PublishingConstants.LanguageField,
                Value = Telerik.Sitefinity.Model.Localization.LocalizationHelper.GetLanguageKey(cInfo)
            });

            fields.Add(new Telerik.Sitefinity.Services.Search.Publishing.Field()
            {
                Name = Telerik.Sitefinity.Publishing.PublishingConstants.FieldContentType,
                Value = typeof(UCommerce.EntitiesV2.Product).FullName
            });

            var doc = new Document(fields, Telerik.Sitefinity.Publishing.PublishingConstants.FieldIdentifier);
            return doc;
        }
    }
}