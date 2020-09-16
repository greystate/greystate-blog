Trying Out the .NET Core Umbraco Alpha Release
==============================================

<time data-slug="umbraco-net-core-alpha" datetime="2020-09-04T22:11:11+0200"> 4 Sep, 2020</time>

Many times since I started using Umbraco (some 11 years ago), I've been in situations where it'd have been nice (read: not so risky) to be able to run a local development version of an Umbraco website. But it's never been possible on a Mac, unless you were using a VM or something similar. So I've had a Windows laptop on hand for these occasions.

So when I learned that now there was an alpha version available that people had apparently been able to run natively on macOS I was all "where do I sign my name and get a copy of it?"

## Hands on

Getting my hands on the actual alpha release was not difficult - [this blogpost on umbraco.com](https://umbraco.com/blog/net-core-alpha-release/) gave me the initial pointers. I didn't do the CLI stuff since I already had Visual Studio for Mac installed and figured I'd try using that.

The actual steps I followed were these:

1. Download and [install the .NET Core 3.1 installer](https://dotnet.microsoft.com/download) from Microsoft's site
2. Add the custom NuGet feed as described (running `dotnet nuget add source "https://www.myget.org/F/umbracoprereleases/api/v3/index.json" -n "Umbraco Prereleases"` in Terminal)
3. Install the Umbraco dotnet template (running `dotnet new -i Umbraco.Templates::0.5.0-alpha001` in Terminal)
4. Created a new empty solution (again, running the listed Terminal command: `dotnet new umbraco -n UmbraMaco` - yes, I chose a better name than *MyCustomUmbracoSolution* :-)) 

At this point, the blogpost boldly states that I can *"open the newly created project in [my] favourite IDE"* - while Visual Studio isn't exactly "my favourite", it's probably the only IDE I have that'll open a .NET project, so I went ahead and did just that.

## Roadblock(s) ahead

As soon as I opened the project, I could tell from the red messages that something wasn't all well. I managed to quite quickly (and I'm very proud of this, as I have no idea how stuff works in Visual Studio) figure out that even though I'd added the custom NuGet feed on the command-line, that Visual Studio wanted its own instruction about this. So I found out where to specify NuGet feeds and added it in. Then I hit reload (or what ever it says on the button that makes the project refresh its packages etc.)

Lo and behold, there was a total lack of red messages and I challenged myself to press the Play button...

I was treated with a pile of messages flying by, and eventually the familiar install screen opening in a web browser, and I typed my name and my email address and came up with "a very good password" (TM) and slammed my head into the next roadblock...

## It's a database. We base all our data on it.

I've installed Umbraco hundreds of times so I don't know why I was suddenly confused about the next screen, where I was tasked with the (seemingly) simple job of choosing whether to use **Microsoft SQL** or *something Azure'y*, or maybe I had a custom Connection String I'd like to use for the database to use for this Umbraco site?

I think I'd been counting on SQL-CE being available, but as I'd have know, had I read the rest of the blogpost, SQL-CE is a Windows-only requirement, so isn't installed by default.

I did some DuckDuckGo-ing (aka Google-ing, *ed.*) and saw the words **Docker** and **Container** and my mind went blank...

I closed the browser and shut down Visual Studio and went for a walk with the dog.

## When in doubt, read tweets

Returning from the walk, I saw [a tweet from René Pjengaard](https://twitter.com/pjengaard/status/1301617397900759040) and I replied that I was stuck. Of course, the friendly neighbourhood Spider-Men of Umbraco friends immediately rose to the rescue by confirming my earlier findings - to try using Docker and get an instance of MSSQL running in there. So I got back in the saddle and whipped open "the download program" (web browser, *ed.*).

## How did I get it to work?

From [a post](https://database.guide/how-to-install-sql-server-on-a-mac/) that's a couple of years old, I got the basics of how to use Docker and install MSSQL.

I also managed to launch the Docker image and then I had another "**Finding Nemo** After the End Credits Sequence" - "Now What?" moment (https://twitter.com/greystate/status/1301634901696020480)

But then I thought, "What the heck" - the thing is running (it says) so maybe I can try with **SQLPro**? (It's one of [a suite of native Mac apps](http://www.macsqlclient.com) for working with databases that I got from the Mac App Store). I've used the app for connecting to Umbraco Cloud databases on and off, so it just might work?

I tried connecting to it by specifying `localhost` as the server and providing the credentials and it worked! (Yes, I'm an experienced developer and I google stuff and I was utterly surprised to *actually* see this work).

All that was left was to create a database and then restart the Umbraco site from Visual Studio.

And then I got all the way to the familiar Umbraco Backoffice, but running locally on my Mac. Surreal for real.

