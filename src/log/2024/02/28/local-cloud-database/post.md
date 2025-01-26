Connecting To The Umbraco Cloud Database From Your Local Instance
=================================================================

<time data-slug="local-cloud-database" datetime="2024-02-28T21:44:00+0100">28 Feb, 2024</time>

Today I had a problem where part of the solution was to temporarily connect my local clone of
an Umbraco Cloud project to its online Development database, and run the project, and I was
immediately stuck on step 1 — how the hell do I do that???? 😂

(The reason for this was to trigger some migrations to run on the DEV database - but already I'm
just relaying information that I don't understand myself).

Of course I looked in the various `appsettings.*.json` files for something along the lines of
`UmbracoDSN` or `ConnectionString` but nothing turned up. The docs did say that I am able to
add the following to the JSON:

```json
"ConnectionStrings": {
	"UmbracoDbDSN": "<connection string here>"
}
```

But hey! it's me — I have no idea first of all, _what_ to put in that string (I know all the parts,
but I've also seen enough connection strings to know that they need to be in a very specific
format that I probably couldn't guess, or google (with Duck Duck Go, obviously), given I barely
know which SQL Server version it currently is, so...).

Secondly, I have no idea where this goes in the settings file (is it a top-level key, or does
it belong under "Umbraco"?). Luckily, there are kind people on the internet that one can ask
about such problems! (Thanks [Sebastiaan][SEB]!).

[SEB]: https://cultiv.social/@sebastiaan


Here's How You Do It
--------------------

In the Cloud portal you open the Connection details from the Settings dropdown and make sure that
your IP address is on the list of allowed IPs.

Then copy each of the four pieces of data, and insert them into this snippet in place of their
all-caps placeholders:

```json
  "ConnectionStrings": {
    "umbracoDbDSN": "Server=tcp:SERVER_NAME;Database=DATABASE;User ID=LOGIN;Password=PASSWORD;Trusted_Connection=False;Encrypt=True;",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
```

Then paste the snippet into either `appsettings.json` or `appsettings.Development.json` at the
root level, e.g.:

```json
{
	"$schema": "...",
	"Serilog": { ... },
	"Umbraco": { ... },

	"ConnectionStrings": { ... }
}
```

Now you can `dotnet run` your local instance and it will use the Cloud database, which — I must
say — **_you should probably only do if you have a very good reason, no?_**
