A Razor ‘@helper’ block for .NET Core
=====================================

<time data-slug="razor-helper" datetime="2023-11-18T01:01:24">18 Nov, 2023</time>

Joe Glombek [asked me][REPLY] to elaborate on [this toot][TOOT]:

> W000T!!
>
> TIL: The “holy-cow-I-used-that-a-lot” `@​helper` feature in Razor that was removed
> [at some point], does in fact still exist, albeit a whole lot more anonymously (which of
> course means that I would never find out about it on my own).
>
> #Umbraco

What I was referring to was this Razor feature that I've been using a lot:

```razor
<section>
	@sayHello("Joe")
	@sayHello("Chriztian")
</section>

@helper sayHello(string name) {
	var greeting = name == "Joe" ? "Hello!" : "Hi there!";
	<article>
		<h2>@(name)</h2>
		<cite>Hello!</cite>
	</article>
}
```

The idea being that you could create what's essentially a function, but instead of returning a
value, it renders markup directly from within; i.e. no `HtmlString`-futzing necessary to build
a return value.

But this was no longer possible in .NET Core, and I've been back to creating real functions,
returning `HTMLString`s, when I saw something very similar in a C# View Partial:

```razor
@{
	void QuoteMe(string message, string source) {
		<q cite="@(source)">@(message)</q>
	}
}
```

Apparently that's been possible since .NET Core 3/4-ish?




[TOOT]: https://mastodon.social/@greystate/111426018693788843
[REPLY]: https://umbracocommunity.social/@joe/111426429003754029
