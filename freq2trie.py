import marisa_trie as trie
import fileinput as fi
import sys

output_filename = sys.argv.pop()

pairs = []
for line in fi.input():
  try:
    key, value = str.split(line)
    pairs.append((unicode(key), (int(value),)))
  except ValueError:
    pass

t = trie.RecordTrie('<i', pairs)
t.save(output_filename)
