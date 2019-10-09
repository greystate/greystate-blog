# Regex, The (2008)

<time data-slug="regex-2008" datetime="2008-12-18T22:43:05+0100">18 Dec, 2008</time>
	
So I have this list of movies I've seen - it's a plain text file accumulated from roughly the
steps outlined here - let's say I just saw the movie "Cloverfield" on DVD...
	
1. Fire up [Opera][OPERA]
1. Type <kbd>g imdb cloverfield</kbd>
1. Click the first link in the results to go to the [IMDb][IMDB] entry for that movie (to verify that it's indeed the one I saw)
1. Select the movie's title on that page</li>
1. Hit <kbd title="Control+Option+Space">⌃ ⌥ SPACE</kbd> to open selected text in [Quicksilver][QS]
1. Type <kbd>AP</kbd> to get the command "Append to file..."
1. Hit <kbd>TAB</kbd> and hold <kbd>F</kbd> (for "filmlisten.txt")

[OPERA]: https://www.opera.com
[IMDB]: https://www.imdb.com "The Internet Movie Database"
[QS]: http://docs.blacktree.com/quicksilver/quicksilver "Awesome tool"

That's it — the movie has been added to my list.
	
The problem is: At some point in time between the inauguration of my sacred file
and *now*, they (IMDb) changed the format of the title for movies starting with "The ...".
You see, before (back in the day, once upon a time, etc.) — Kubrick's 1980 movie
was listed as **Shining, The (1980)** whereas now, it's listed as [The Shining (1980)][SHINING].

[SHINING]: https://www.imdb.com/title/tt0081505/

Being so darn picky about that, my textfile was a mess... you see, I like a *certain* kind of
order in the universe (at least in my part of it) so once in while, I'd follow that last step
with an additional <kbd title="Control+Space, then Return">⌃ SPACE + ↩</kbd> to open the textfile in
[TextMate][TM], then <kbd>F5</kbd> to sort the lines alphabetically.

[TM]: https://www.macromates.com

But alphabetically just wasn't good enough anymore, because some movies we're listed in the old format
while others were in the new one. And there were just about a couple of hundred titles pending a fix
so I needed a command of some sort — and no, doing a simple *Find & Replace* wouldn't
be able to fix this.
	
## Enter Regex — Regular Expression(s)

A Regular Expression is the perfect solution here, because you can easily match something, store it and
then come back and fetch it again. TextMate lets you do this in the Find & Replace dialog, so I
hammered this in:

<figure>
	<picture>
		<source srcset="/images/Regex-The-2008-dark.png" media="(prefers-color-scheme: dark)" />
		<img src="/images/Regex-The-2008.png" width="710" height="364" alt="Regular Expression: ^(.*)(,) (The)( \(\d{4}\))\s*$ - Replacement: $3 $1$4" />
	</picture>
	<figcaption>Regular Expression: <code>^(.*)(,) (The)( \(\d{4}\))\s*$</code> - Replacement: <code>$3 $1$4</code></figcaption>
</figure>
	
\- and there you have it. All titles properly titled and order has once again been restored to *The Galaxy*.
