Hotfixing on Umbraco Cloud with Git
===================================

<time data-slug="hotfix-with-git" datetime="2021-04-22T18:59:00+0200">22 Apr, 2021</time>

Today I needed to fix something on the production site though
the development site wasn’t in a deployable state. What to do?

TL;DR: [Go to the recap][RECAP] with the essential steps.

  [RECAP]: #recap

Prerequisites
-------------

I’m pretty much using a standard setup when working with [Umbraco Cloud][UMBCLOUD] these days:

  [UMBCLOUD]: https://umbraco.com/cloud/

I setup both a **Development** and a **Live** environment and when I clone the site,
I specifically name the *origin* `DEV` instead of the default `origin`:

```bash
git clone --origin DEV <URL> "<ProjectName>.Web"
```

I also add a second remote pointing to the Live environment:

```bash
git remote add LIVE <URL>
```

This way I can see the environment’s name in the GitHub Desktop client and
I (ideally) won’t accidentally push to the live environment 😱.

![GitHub Desktop Client showing the remote's name as 'DEV'][screenshot]

[screenshot]: /images/github-dev-remote.png "The GitHub Desktop Client shows the remote's name on the 'Pull' button"

Hotfixing
---------

So, back to my problem...

The [Umbraco Documentation][UMBDOCS] actually has some (very) detailed information about this,
and a couple of examples of how to go about it. If you're using [GitKraken][KRAKEN] or a similar
client, you may just have a look at those first. I happen to use the GitHub Desktop client and
a fair share of command line git, so I went about my own way to solve this.

  [UMBDOCS]: https://our.umbraco.com/documentation/Umbraco-Cloud/Deployment/Hotfixes/Using-Git/
  [KRAKEN]: https://www.gitkraken.com

### Separate commit(s)

First off, I fixed the actual problem **on the local clone** (DEV) to make sure I wouldn't
accidentally remove it again, whenever the in-development version eventually gets deployed to
LIVE. I also make sure to make separate commits that can later be [cherry-picked][CHERRY] for
inclusion on the LIVE site.

  [CHERRY]: https://git-scm.com/docs/git-cherry-pick

Using either GitHub Desktop or the command line, I grab the hash of the commit(s) I've just
created.

### Transfer to the LIVE remote

Next up, I'll fetch the latest changes from Umbraco Cloud and create a new `hotfix` branch
from LIVE's `master`:

```bash
git fetch LIVE
git checkout LIVE/master # << You'll be notified about a detached HEAD - don't panic :)
git checkout -b hotfix
```

All set to add the changes to the `hotfix` branch now:

```bash
git cherry-pick <HASH>
```

Now comes the scary part -- we want to push the `hotfix` branch directly into the LIVE remote's
`master` branch (!)

```bash
git push LIVE hotfix:master
```

And there we have it; a hotfix deployed to the LIVE site and we can continue work on DEV until
we're ready, and not worry about forgetting to get that hotfix in as well.

## Recap

So, in short:

- Make sure to have a LIVE remote
- Fix the bug locally and commit to DEV
- Fetch the LIVE remote
- Checkout LIVE/master
- Create `hotfix` branch
- Cherry pick the commit(s)
- Push to `LIVE hotfix:master`
