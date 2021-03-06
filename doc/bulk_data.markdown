# Catalog of Government Publications Bulk Data

The [bulk data here](.) is generated by the Sunlight Labs <a href="http://github.com/sunlightlabs/cgp_crawler">Catalog of Government Publications Crawler</a>.

## Background

The Catalog of Government Publications is a collection of all federal publications, administered by the [Government Printing Office](http://www.gpo.gov). The CGP includes descriptive records and links to those available online.

There is a [web search interface](http://catalog.gpo.gov) for the CGP. However, to our knowledge, there is no public way to access the CGP in bulk. As a result, the public cannot run queries against the data unless they are built into the CGP web search interface. That's why we (the Sunlight Foundation) crawl the CGP and share the resulting CGP bulk data publicly.

## File Format and Structure

The XML files you will find here are formatted as [MARCXML](http://www.loc.gov/standards/marcxml/) and encoded as [UTF-8](http://en.wikipedia.org/wiki/UTF-8).

The crawler that generates these files stores them in a nested directory structure that looks like this:

     system number      revision
                 |      |
                 v      v
    /000/111/000111222-000.xml
    /000/111/000111222-001.xml
    /000/111/000111222-002.xml

These files are grouped into folders in order to reduce the number of files per directory. Note that we keep old revisions of the documents, making it possible to see how the documents change over time.

Please refer to the [MARC documentation](http://www.loc.gov/marc/marcdocz.html) to interpret the fields in the XML output files. In particular, I recommend the [MARC 21 Format for Holdings Data Documentation](http://www.loc.gov/marc/holdings/).

## Uses and Interpretation

Now what do you do with these hundreds of thousands of government documents? We hope you explore them and let us know.

## Community

This is a project of the [Sunlight Labs](http://sunlightlabs.com), the technical arm of the [Sunlight Foundation](http://sunlightfoundation.com). If you would like to to discuss the project or anything related to government transparency, please contact us on our [mailing list](http://groups.google.com/group/sunlightlabs).

The [source code](http://github.com/sunlightlabs/cgp_crawler) was written by [David James](http://sunlightfoundation.com/people/djames/) of the Sunlight Labs. [Ed Summers](http://inkdroid.org/journal/about/) offered help (and consolation) regarding [Z39.50](http://en.wikipedia.org/wiki/Z39.50) and MARC. The idea for putting the CGP bulk data online originated from [John Wonderlich](http://sunlightfoundation.com/people/jwonderlich/) and [Daniel Schuman](http://sunlightfoundation.com/people/dschuman/), both on Sunlight's policy team.
