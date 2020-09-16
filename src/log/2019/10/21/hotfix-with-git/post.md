Hotfixing on Umbraco Cloud with Git
===================================

<time datetime="2019-10-21T10:22:06+0200">21 Oct, 2019</time>

Today I needed to fix something on the production site though
the development site wasn’t in a deployable state. What to do?

Prerequisites
-------------

I’m pretty much using a standard setup when working with [Umbraco Cloud][UMBCLOUD] these days:

  [UMBCLOUD]: https://umbraco.com/cloud/

I setup both a **Development** and a **Live** environment and when I clone the site,
I specifically name the *origin* `DEV` instead of the default `origin`:

```bash
git clone --origin DEV "<URL>" "<ProjectName>.Web"
```

I also add a second remote pointing to the Live environment:

```bash
git remote add LIVE "<URL>"
```

This way I can see the environment’s name in the GitHub Desktop client and
I (ideally) won’t accidentally push to the live environment 😱.

![GitHub Desktop Client showing the remote's name as 'DEV'][screenshot]

[screenshot]: /images/github-dev-remote.png "The GitHub Desktop Client shows the remote's name on the 'Pull' button"

Hotfixing
---------

So, back to my problem...

The [Umbraco Documentation][UMBDOCS] actually has some very detailed information about this,
and a couple of examples of how to go about it. If you're using [GitKraken][KRAKEN] or a similar
client, you may just have a look at those first. I happen to use the GitHub Desktop client and
a fair share of command line git, so I went about my own way to solve this.

  [UMBDOCS]: https://our.umbraco.com/documentation/Umbraco-Cloud/Deployment/Hotfixes/Using-Git/
  [KRAKEN]: https://www.gitkraken.com

<data data-slug="hotfix-with-git"></data>
