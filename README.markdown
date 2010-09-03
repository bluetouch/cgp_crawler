# Catalog of Government Publications Crawler

This code crawls the Catalog of Government Publications (CGP) using a protocol called [Z39.50](http://en.wikipedia.org/wiki/Z39.50) and saves the results as XML files.

## Background

The Catalog of Government Publications is a collection of all federal publications, administered by the [Government Printing Office](http://www.gpo.gov). The CGP includes descriptive records and links to those available online.

There is a [web search interface](http://catalog.gpo.gov) for the CGP. However, to our knowledge, there is no public way to access the CGP in bulk. As a result, the public cannot run queries against the data unless they are built into the CGP web search interface.

That's why we (the Sunlight Foundation) use this code to crawl the CGP and share the resulting [CGP bulk data](http://sunlightlabs.com/cgp_data) publicly.

## Access Credentials

In order to run this code, you will need access credentials to access the CGP. Create a file called `config/access.yml` based on `access.yml.example`.

Practically speaking, most people probably will not have direct access to the CGP. This is why we share the results of our crawl at [http://sunlightlabs.com/cgp_data](http://sunlightlabs.com/cgp_data).

## Software Dependencies

This crawler depends on [Ruby ZOOM](http://ruby-zoom.rubyforge.org/), a Ruby binding to [YAZ](http://www.indexdata.com/yaz), a programing toolkit that supports writing [Z39.50](http://en.wikipedia.org/wiki/Z39.50) clients and servers. (ZOOM stands for [Z39.50 Object-Orientation Model](http://zoom.z3950.org/).)

For Mac OS X, I recommend installing YAZ with [homebrew](http://github.com/mxcl/homebrew):

    brew install yaz

For linux, I recommend installing YAZ using APT:

    apt-get install libyaz-dev

Run bundler to make sure your gem dependencies are in order:

    bundle

## Configuration

Create a file called `config/config.yml` based on `config.yml.example`. The defaults should work just fine.

You might want to the `delay` value which controls the delay (in seconds) between requests to the GPO's Z39.50 CGP server.

If you have to stop the crawl midway and want to restart where you left off, you will find the `start_at` setting useful.

## Running

To start crawling:

    rake crawl

Please note that this process will run continuously. Assuming 700,000 documents and a 1 second delay time between record requests, it takes approximately 8 days to pull down the entire set of records from the CGP.

The crawl does not overwrite files; instead, it keeps a history of all records that is has seen.

## Resulting Files

This crawler stores the resulting documents as XML files on the filesystem. The filenames are a combination of the CGP system number and the revision number. For example:

     system number      revision
                 |      |
                 v      v
    /000/111/000111222-000.xml
    /000/111/000111222-001.xml
    /000/111/000111222-002.xml

These files are grouped into folders in order to reduce the number of files per directory.

## Formats

Ruby ZOOM converts the original CGP records to XML.

* The original records are in the [MARC 21](http://www.loc.gov/marc/) format and encoded as  [MARC-8](http://www.loc.gov/marc/specifications/speccharmarc8.html).

* The resulting XML files are formatted as [MARCXML](http://www.loc.gov/standards/marcxml/) and encoded as [UTF-8](http://en.wikipedia.org/wiki/UTF-8).

Please bear with us; with all of these conversions, don't be surprised if some things go strangely wrong.

Please refer to the [MARC documentation](http://www.loc.gov/marc/marcdocz.html) to interpret the fields in the XML output files. In particular, I recommend the [MARC 21 Format for Holdings Data Documentation](http://www.loc.gov/marc/holdings/).

## Uses and Interpretation

Now what do you do with these hundreds of thousands of government documents? We hope you explore them and let us know.

## Community

This is a project of the [Sunlight Labs](http://sunlightlabs.com), the technical arm of the [Sunlight Foundation](http://sunlightfoundation.com). If you would like to to discuss the project or anything related to government transparency, please contact us on our [mailing list](http://groups.google.com/group/sunlightlabs).

This code was written by [David James](http://sunlightfoundation.com/people/djames/) of the Sunlight Labs. [Ed Summers](http://inkdroid.org/journal/about/) offered help (and consolation) regarding Z39.50 and MARC. The idea for putting the CGP bulk data online originated from [John Wonderlich](http://sunlightfoundation.com/people/jwonderlich/) and [Daniel Schuman](http://sunlightfoundation.com/people/dschuman/), both on Sunlight's policy team.
