Using UserSecrets for Connection Strings
=========================================

<time data-slug="secrets" datetime="2022-02-05T00:10:49">05 Feb, 2022</time>

(Here's [the TL;DR](#tldr) if you're in a hurry)

I'm fairly new to using Umbraco 9 _regularly,_ but over the last couple of months
I've made a habit of starting up the "whale" (_Docker.app_, —ed.) and hitting
<kbd>CMD</kbd>+<kbd>R</kbd> in [Nova][] to run the `dotnet` command that starts
the local instance of whichever Umbraco site I'm currently working on. But one
thing has bothered me since I got this new setup running - and that's the thing
with the _connection string_...

New territory - new behaviors
-----------------------------

We use Umbraco Cloud almost exclusively, so what I have is a local clone of the
repository using an MSSQL Database that's somehow magically working on my Mac,
inside the belly of the aforementioned whale (still Docker, —ed.) - and for that
to work, I have had to provide a connection string inside of `appsettings.Development.json`,
for it to only apply to my local environment. And there's the problem: That
connection string contains a password that we certainly don't want to accidentally
have committed to the repository.


Changes not staged for commit
-----------------------------

So up until now, I've just always had that one change in the git repo that was
never committed; but as is the case with a scrambled Rubik's Cube, casually left
on your desk by a coworker (in this case also my brother): You can only walk past
it a finite amount of times before you have to fix the situation, so I set out
to do just that.

So I went straight to the docs on [Our][] and found this section about
[Managing Configuration][MANCFG] which conveniently lists the various places .NET
looks for configuration keys, and in which order they're searched. "Perfect", I
thought, "I can use environment variables".

Iteration 1: Edit task
----------------------

The Run command I mentioned earlier is a custom task I've made for the project in
Nova, and one thing that's possible for those, is to specify some environment
variables that should be set prior to running the command(s).

The good news was that the `appsettings.Development.json` no longer had unstaged
changes. The bad news was that now I'd just moved the problem over to the Nova
config file instead.

Iteration 2: UserSecrets
-------------------------

Ok, so next up was that 3rd entry in the list on Our: "UserSecrets", and I started
to look for how that worked... but lo and behold, no one has managed to write
that section (yet). It just wasn't there.

<div class="note"><strong>Update:</strong> It is there now (I wrote and submitted pull request which has been merged)</div>

So I took the problem up with DuckDuckGo and found some docs on how to get
that working (I fully admit that I was half-expecting to have to install a tool
or three just to get this going). It was actually pretty easy - here's a link to
[the section I found about setting up UserSecrets][SECR].

TL;DR
-----

Turns out you just do two things:

1. You enable UserSecrets for the project
2. You store a secret in the storage

The first one is done by issuing an init command **inside** the directory that has
the `.csproj` file:

```bash
dotnet user-secrets init
```

The other one is done like this:

```bash
dotnet user-secrets set "ConnectionStrings:umbracoDbDSN" "CONNECTION_STRING_IN_HERE"
```

Cool - that's it. Thanks to [Nik][] & [Tim][] for [poking me][POKE] for a [post about it][POST].

[Nova]: https://nova.app
[Our]: https://our.umbraco.com
[MANCFG]: https://our.umbraco.com/documentation/Reference/V9-Config/#managing-configuration
[SECR]: https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-6.0&tabs=windows#enable-secret-storage
[Nik]: https://twitter.com/HotChilliCode
[Tim]: https://twitter.com/attack_monkey
[POKE]: https://twitter.com/attack_monkey/status/1489591448815218696
[POST]: https://twitter.com/HotChilliCode/status/1489587847455727618
