How To Get a QueryString Value in Razor
=======================================

<time data-slug="querystring-razor" datetime="2023-07-20T08:09:47">20 Jul, 2023</time>

A frequent pattern for me when dealing with articles or calendar events in Umbraco,
is to initially render a selection (e.g. the latest 10 articles), and then provide some kind
of filtering method to be able to access more (or a less) of these, subsequently.

I always use a QueryString parameter for this, e.g.:

`https://example.com/articles/` will get me the initial list

`https://example.com/articles/?tag=xslt` will get me only the articles tagged with `xslt`

In "old" Umbraco (ASP.NET, I think?) this was accomplished using the `Request.QueryString`
object - it was even "forwarded" to XSLT macros by way of `umbraco.library.RequestQueryString`,
so really a no-brainer (meaning someone like me could figure it out 😀) to "just" make your
view aware of some sort of config parameter.

When Umbraco switched from ASP.NET to .NET Core (or whatever it's called these days) this got
exponentially harder, at least for *me,* because of this thing called *dependency injection*
(though I _will_ admit that it's _fairly_ straight-forward to work with in a Razor view, as opposed
to a helper class where somehow I'm still unable to do the correct incantations).

If I need to get the "tag" parameter from the QueryString - here's how I do it currently:

```csharp
// Inject the HttpContextAccessor
@inject Microsoft.AspNetCore.Http.IHttpContextAccessor HttpContextAccessor;
@{
	// Get a context
	var httpContext = HttpContextAccessor.HttpContext;

	// Grab the value(s) you need
	var tag = httpContext.Request.Query["tag"].ToString();
}

```

I can't tell you how much I dislike that `.ToString()` there - but if you want to do practically
anything else than just render the value, you have to cast it because the actual value is not
a `string`... ¯\\_(ツ)_/¯

