Creating a highlightable SVG map
================================

<!-- <time data-slug="datalist-svg" datetime="2022-04-26T15:34:00">26 Apr, 2022</time> -->

Earlier this year, I carelessly tweeted something which prompted a few requests for an
explainer blogpost...

> Shoutout to @leekelleher for his amazing Contentment package! 🎉🚀🙌
>
> Had an SVG map of Europe where we needed the client to easily highlight individual countries...
>
> Using Contentment's DataList to look inside the SVG (XML) file we get some handy little buttons to click [cont'd]

> [2/2]
> ... and using a pinch of lovely XSLT when rendering the SVG (again, it's XML) everything's already highlighted right from the server. No JS necessary for that.
> #Umbraco

(Actual tweets: [1st][TWEET1] and [2nd][TWEET2])

  [TWEET1]: https://twitter.com/greystate/status/1518894428693442561
  [TWEET2]: https://twitter.com/greystate/status/1518894596469792769

The Map
-------

The task at hand was to display a map of Europe where some of the countries
would be highlighted - but also to make it easy from within Umbraco to change
the selected countries, so editors wouldn't have to create a new map image every
time there was an update.

So first off we'd obviously need an SVG of Europe - preferably with each of the
countries in separate shapes. Turns out that was very easy to find.



In Umbraco, my first thought was then to build a "repository" tree with the
selected countries. That way, the editor(s) could add a new content node for any
new country, and/or delete any node for a country that should no longer be highlighted.

If we could match up the ids (or more likely the _aliases_) with `<path>` / `<polygon>`
in the SVG, it would be possible to switch them on and off in the SVG.

But then I realised that the SVG really has all the info - so why not do some
kind of lookup in that, and then just record the on/off state in Umbraco?


Buttons
-------

Well, an SVG file is an XML file, and let's just say that I have some experience
in that area :) So I immediately thought of [Lee Kelleher][LEE]'s nothing short of
brilliant [**DataList** property editor][DATA] in his [Contentment package][PKG].

  [LEE]: https://twitter.com/leekelleher
  [DATA]: https://github.com/leekelleher/umbraco-contentment/blob/develop/docs/editors/data-list.md#data-list
  [PKG]: https://github.com/leekelleher/umbraco-contentment

One of the (many) options for specifying a data source here is **XML Data** where
you specify a file and then use XPath to grab the label + value, plus maybe even
an icon and a description.

![The Data Source configuration screen for XML Data][screenshot-datasource]

***

So we amended the SVG with `id` and `aria-label` attributes for each country and
then pointed the Data source at the file... and got nice buttons for each of the
countries in the file!

![The Data Type configuration screen][screenshot-datatype]


  [screenshot-datasource]: /images/data-source-config.jpg
  "The XML Data Source's configuration screen"

  [screenshot-datatype]: /images/data-type-config.jpg
  "The Data Type's configuration screen"

Rendering
---------

Now, I know many would render the selected countries' IDs into a JSON/JavaScript
`Array` and grab those when the page has loaded, and then flip on some classes
in the SVG - but that's not really my preference; I much prefer to use no
JavaScript at all, if possible - and because I've done so much with it, I knew
the perfect tool for pre-rendering the SVG would be (_drum roll, ed._) XSLT.

### OK, but seriously, why XSLT?

When you have an XML file that you need to




