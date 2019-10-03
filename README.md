# Greystate Blog

This is the source repo for the (probably) 13th version of my blog's files...

This time, I'm using some wonderful tooling:

- I write a blogpost as a `post.md` file
- [CodeKit][CK] initially compiles this into a `post.html` file in the build folder (not in source control, btw.)
- A CodeKit hook kicks in and runs an *XSLT transform* on the HTML file to produce the final `index.html` file
- Deploy script copies the blog structure to the greystate.github.io repo for publication with **Github Pages**

[CK]: https://codekitapp.com

The XSLT file is of course the real beauty of it all, since it enables me to do *whatever* I want with the final HTML output.
(Oh, and before you run away screaming: I have just about 20 years of experience with XSLT so I'll be fine :-)

Feel free to poke around :)

— Chriztian Steinmeier, October 2019.
