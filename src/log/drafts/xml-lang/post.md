How To Add Language Information To An XML File
==============================================

<!-- <time data-slug="xml-lang" datetime="xdate">15 Mar, 2022</time> -->

For context, here's a tweet of mine where I do the "obligatory complaining
thing", assuming everyone else knows exactly what I'm talking about :)

> Today, I *think* I've seen the 113th implementation of an XML file with
> multiple languages support... and no, this one (together with 111 of the others)
> did not use the built-in `xml:lang` attribute for this either 😓😬
>
> #TheyNeverDo #XML #XPath #XSLT

([Here's the actual tweet][TWEET])

[TWEET]: https://twitter.com/greystate/status/1492116692473991175


Built-in Support
----------------

What I'm referring to with "built-in" is the way of annotating an XML element
with a language code, so that the reader (could be you, could be a robot) knows
which language its contents are expressed in:

```xml
<text xml:lang="en-GB">
	I asked them which colour they saw, to which the Danish woman
	replied: <quote xml:lang="da">Den dér? Den ser temmelig rød ud?</quote>,
	while pointing towards the red square.
	The Italian guy just shouted <quote xml:lang="it">È marrone!</quote> but did
	not point at any of the coloured squares.
</text>
```

Looks good, right?

Not actually being used though
------------------------------

Yeah - as much as we like that, it's not widely known — or, at least not very
frequently seen in the wild. Before learning why I think it's the better option,
let's have a look at the one I've seen the most (in a couple of different
variations):

```xml
<strings>
	<string lang="en-US">Thank you</string>
	<string lang="da">Tak</string>
	<string lang="es">Gracias</string>
	<!-- etc... -->
</strings>
```




***

We have three instances of this special attribute here; the first one — `en-GB`
— is valid for the entire `<text>` element, stating British English.

The two `<quote>` elements each have their own attribute but they're using only
the more general 2-letter codes for their respective languages.



