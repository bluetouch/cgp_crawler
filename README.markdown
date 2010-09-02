# Catalog of Government Publications Crawler

This code crawls the Catalog of Government Publications (CGP) using a protocol called [Z39.50](http://en.wikipedia.org/wiki/Z39.50).

## Background

The Catalog of Government Publications is a collection of all federal publications, administered by the [Government Printing Office](http://www.gpo.gov). The CGP includes descriptive records and links to those available online.

There is a [Web search interface](http://catalog.gpo.gov) for the CGP. However, as of this writing, there is not an easy way to get bulk access to the CGP. That's we (of the Sunlight Foundation) are crawling the CGP and making the bulk data available.

## Prerequisites

You will need access credentials to access the CGP. Create a file called `config/access.yml` based on `access.yml.example`.

This crawler depends on [Ruby ZOOM](http://ruby-zoom.rubyforge.org/), a Ruby binding to [YAZ](http://www.indexdata.com/yaz), a programing toolkit that supports writing [Z39.50](http://en.wikipedia.org/wiki/Z39.50) clients and servers. (ZOOM stands for [Z39.50 Object-Orientation Model](http://zoom.z3950.org/).)

For Mac OS X, I recommend installing YAZ with [homebrew](http://github.com/mxcl/homebrew):

    brew install yaz

For linux, I recommend installing YAZ using APT:

    apt-get install libyaz-dev

Run bundler to make sure your gem dependencies are in order:

    bundle

## Running

To start crawling:

    rake crawl
    
Please note that this runs continuously. Using conservative delay times between requests, it will take perhaps 2 weeks to pull down the entire CGP.

At the time of this writing, the CGP contains approximately 700,000 documents. This crawler stores these documents as XML files on the filesystem. These files are grouped into folders.

## Formats

Ruby ZOOM converts the original CGP records to XML.

* The original records are in the [MARC 21](http://www.loc.gov/marc/) format and encoded in the [MARC-8](http://www.loc.gov/marc/specifications/speccharmarc8.html).

* The resulting XML files are formatted as [MARCXML](http://www.loc.gov/standards/marcxml/) in the [UTF-8](http://en.wikipedia.org/wiki/UTF-8) character encoding.

Please bear with us; with all of these conversions, don't be surprised if some things go strangely wrong.

Please refer to the [MARC documentation](http://www.loc.gov/marc/marcdocz.html) to interpret the fields in the XML output files. In particular, I recommend the [MARC 21 Format for Holdings Data Documentation](http://www.loc.gov/marc/holdings/).

## Uses and Interpretation

Now what do you do with these hundreds of thousands of government documents? We hope you explore them and let us know.

## Community

This is a project of the [Sunlight Labs](http://sunlightlabs.com), the technical arm of the [Sunlight Foundation](http://sunlightfoundation.com). If you would like to to discuss the project or anything related to government transparency, please contact us on our [mailing list](http://groups.google.com/group/sunlightlabs).

This code was written by [David James](http://sunlightfoundation.com/people/djames/) of the Sunlight Labs. [Ed Summers](http://inkdroid.org/journal/about/) offered help (and consolation ) regarding Z39.50 and MARC. The idea for putting the CGP bulk data online originated from [John Wonderlich](http://sunlightfoundation.com/people/jwonderlich/) and [Daniel Schuman](http://sunlightfoundation.com/people/dschuman/), both on Sunlight's policy team.
