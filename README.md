An open source textual analysis web app and framework.

Summary
-------

CompareTexts is a web app that can be used to download and compare hundreds of
thousands of scanned books for similarity and analysis.

Workers
-------

CompareTexts uses Qless, a redis-based queue, to handle background tasks.
Workers are defined in lib/workers:

- store: Moves a text file from wherever it is currently being stored into the library
- clean: Cleans a text file by removing non-alphabetic characters
- ngram: Converts a cleaned text file into ngrams using a cpp library
- trieify: Converts ngram frequency files into a more compact Trie data structure



[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/wordtreefoundation/wordtree/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

