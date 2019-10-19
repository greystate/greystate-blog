# CSS Variables TextMate Bundle

<time data-slug="css-variables-bundle" datetime="2008-05-06T02:09:38+0200"> 6 May, 2008</time>

So a couple of weeks ago, I'm discussing with my good friend and colleague
[Sebastian][SEB], that I'd been trying
(again, for the umpteenth time) to come up with a *usable* "Dynamic CSS" solution,
and I quickly jot the latest syntax down on the whiteboard next to us.

This time I was eager to use "proper" CSS syntax, and then
solve the dynamicness with some kind of server-side processing, so I'd chosen to use a
special at-rule **@variables** (though I shortened it to @vars on the whiteboard) for
the declaration of variables and then a **var()** function for retrieving a variable
where needed…

Mere **two** days later [this document][CSSVARS]
shows up in my RSS Reader and I'm **completely** baffled!

So then I thought: "Well, if others have conjured up the **exact** same syntax,
then it's definitely the way to go. But how do we get to use it now? No-one (save Webkit in a
nightly, possibly) is going to actually implement this anytime soon…"

"Well—no harm done, creating a couple of Snippets for TextMate," I figured, and
then I just went ahead and clumsied up a pair of Commands also, so now I'm actually able to use
it as an everyday tool when developing CSS.

Go ahead and [check it out][BUNDLE].

And by all means, [let me know][MAIL]
if you're using/hating it…


[SEB]: http://www.dammark.net
[CSSVARS]: http://disruptive-innovations.com/zoo/cssvariables/
[BUNDLE]: https://greystate.dk/resources/css-variables/ "TextMate Bundle for CSS Variables"
[MAIL]: mailto:chriztian@SP@M@steinmeier.dk "- or just say 'Hi'..."
