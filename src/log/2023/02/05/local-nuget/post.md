Testing a NuGet Package Locally
===============================

<time data-slug="local-nuget" datetime="2023-02-05T09:06:24">5 Feb, 2023</time>

Recently I've been upgrading a few of [my packages][PKGS] for use with Umbraco 10, and have thus had
to learn how to build a NuGet package, since — well - that's a requirement now if I want to be
able to install the thing.

While the packages themselves were pretty straightforward upgrades (i.e. no changes required -
they “just worked”), the process wasn't a smooth one - so let's have a look at why that was.

As always, [here's a TL;DR link][TLDR] for your next visit (our mine, probably!).


Types of Testing
----------------

### Developing

So first off, I should explain what kind of testing I'm talking about here, because there are a
couple of different scenarios. While you're _developing_ a package (or in my case, converting an
existing one) we want to use it in Umbraco and we want our changes to be reflected right away,
so we can iterate and make everything work.

Umbraco has a special dotnet CLI invocation for this, creating an Umbraco solution specifically
referencing (in the `.csproj` file) your package's files instead of its NuGet reference. This
way, you're only a `dotnet run` command away from testing any changes to your package.

You do this by adding the `--PackageTestSiteName` (or `-p` for short) parameter when creating a
new Umbraco project:

```bash
dotnet new umbraco -n <ProjectName> -p <PackageProjectName>
```

### Installing

Now, the _other kind_ of testing is to make sure that your package actually installs correctly,
because the above does not make any such guarantees. If you're like me and you don't know what
you're doing (!) you could easily waste an hour or more trying to figure out why your package
doesn't work for _anyone else but yourself!._

This happens because the `PackageName.targets` file format is _a little difficult_ to understand
when your package needs to install files other than a built DLL (that's _all_ my packages).

So you don't want to publish a package to NuGet before you know it works (you can't delete a
faulty package from NuGet) - but the `dotnet add package` command _immediately_ goes to nuget.org
looking for the package ... ¯\\\_(ツ)\_/¯.

That is, until you do a little digging and find out that you can specify a "source" when adding
a package to a project.


Then you do a lot more digging and trying out things before you realise that you don't need to
set up your own private NuGet server, <del>but you can "just" add your package to the "locals" source
and install it from there.</del> <ins>in fact, you can add your package using the `--source`
parameter pointing to the directory of your `.nupkg` file. Thanks for the tip [Sebastiaan][SEB]!</ins>

The Steps
---------

When you've built your `.nupkg` package, start a command prompt in your test site's project
folder and add the package using the path to the directory that holds your local `.nupkg` file:

```bash
dotnet add package Package.Name --source ../path/to/nupkg-files
```

That's it!

* * *

Alternatively, you can use a "locals" source, in which case there's an extra step for adding
the package to the "locals" source first:

```bash
nuget add ../path-to-package/Package.Name.1.2.3.nupkg -Source locals
```

Then you add it to your project, this way:

```bash
dotnet add package Package.Name --source locals
```

* * *

Whichever process you choose, the last step is to run the project:

```bash
dotnet run
```

Oh, and remember to increase the package version every time, because even though it looks like it
grabs your `.nupkg` file from a folder inside your project, there's definitely some
caching going on that will trip you up. Trust me :)


[TLDR]: #the-steps
[PKGS]: https://marketplace.umbraco.com/search/Vokseværk
[SEB]: https://cultiv.social/@sebastiaan/109811220485601783
