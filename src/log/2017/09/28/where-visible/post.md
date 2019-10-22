Where Visible???
================

<time datetime="2017-09-28T07:53:00+0200">28 Sep, 2017</time>

Umbraco has (to my knowledge) always had a way to skip rendering certain documents in lists etc., by way of a property with the alias `umbracoNaviHide`. Not as part of the core code, mind you, but rather just a convention that's been adhered to in the templates you choose from, when creating a new macro (or a partial view) in the Backoffice.

Here's how the Razor and XSLT templates use this convention:

### XSLT

The XSLT version does this:

```xml
<xsl:for-each select="$currentPage/* [@isDoc and string(umbracoNaviHide) != '1']">
	...
</xsl:for-each>
```

### Razor

The Razor snippet puts the selection in a variable first, like this:

```csharp
var selection = CurrentPage.Children.Where("Visible");
```

Ways in which I think the XSLT version better tells what's going on:

1. It uses the actual alias of the property that's causing the exclusion, instead of a magic string.


Rewrite
-------

OK, turns out both of these can be improved - the XSLT can do without the string conversion and the Razor snippet apparently is using *dynamics* which is no-one's favorite, these days. Or so I'm told :-)

### XSLT, take 2

```xml
<xsl:for-each select="$currentPage/*[@isDoc][not(umbracoNaviHide = 1)]">
	...
</xsl:for-each>
```

(If we were *really* doing XSLT and not just a version that's friendlier to developers who hasn't tried something like that, we'd just use apply-templates here and let the match templates do the rest :-)

### Razor, take 2

```clike
var selection = Model.Content.Children.Where(x => x.IsVisible());
```
	
This is using what's called "strongly typed" access and instead of a magic string we now have a magic method...

As I said in a Slack channel recently, when asking about this:

> [The Razor snippets are] using "magic" if you don't know anything about how you "hide" a page in Umbraco :-)

<data data-slug="where-visible"></data>
