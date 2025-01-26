10 things XML can do
====================

1️⃣ Support for multi-language content
-------------------------------------

While I've seen plenty XML files used for translation, it's _extremely rare_ to see one that
takes advantage of the built-in support for languages, i.e. the `xml:lang` attribute:

```xml
<keys group="labels">
	<key name="color" xml:lang="en-US">color</key>
	<key name="color" xml:lang="en-GB">colour</key>
	<key name="color" xml:lang="da">farve</key>

	<key name="favorite" xml:lang="en-US">favorite</key>
	<key name="favorite" xml:lang="en-GB">favourite</key>
	<key name="favorite" xml:lang="da">favorit</key>
</keys>
```

At first glance, you could say that that's no different than using an ordinary attribute like, say,
`lang` or `language`, but as the `xml:lang` attribute comes paired with an XPath function
(`lang()`) for selecting content, it has a few advantages.

Let's say we restructured the keys like this:

```xml
<keys group="labels">
	<group xml:lang="en-US">
		<key name="color">color</key>
		<key name="favorite">favorite</key>
	</group>

	<group xml:lang="en-GB">
		<key name="color">colour</key>
		<key name="favorite">favourite</key>
	</group>

	<group xml:lang="da">
		<key name="color">farve</key>
		<key name="favorite">favorit</key>
	</group>
</keys>
```

2️⃣ Embed code samples without having to escape everything

By wrapping code in a CDATA Section, it becomes plain text:

```xml
<sample syntax="html">
	<description>The structure of an HTML document</description>
	<code><![CDATA[
<!DOCTYPE html>
<html>
	<head>...</head>
	<body>...</body>
</html>]]></code>
</sample>
```
