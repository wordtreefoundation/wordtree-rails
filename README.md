An open source textual analysis web app and framework.

Summary
-------

CompareTexts is a web app that can be used to download and compare hundreds of
thousands of scanned books for similarity and analysis.

Workers
-------

Qless is a redis-based queue that handles background tasks. Workers are defined
in lib/workers:

- store.rb: Moves a text file from wherever it is currently being stored into the library
- clean.rb: Cleans a text file by removing non-alphabetic characters
- ngram.rb: Converts a cleaned text file into ngrams using a cpp library
- trieify.rb: Converts ngram frequency files into a more compact Trie data structure

