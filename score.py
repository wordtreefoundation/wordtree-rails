import pg
import marisa_trie as trie
import sys
import os

DIR = os.path.dirname(os.path.realpath(__file__))

def get_book_archive_org_id(db, book_id):
  try:
    result = db.query("SELECT archive_org_id FROM books WHERE id = " + str(book_id))
  except pg.ProgrammingError:
    return None
  r = result.getresult()
  try:
    return r[0][0]
  except IndexError:
    return None

db = pg.connect(dbname='library', host='localhost', user='duane', passwd='duane313')

def load_trie_ngrams(filename):
  print "Loading " + filename
  t = trie.RecordTrie('<i')
  t.load(filename)
  return t

def load_freq_ngrams(filename):
  print "Loading " + filename
  f = os.popen("zcat " + filename + " || cat " + filename)
  #f = open(filename)
  pairs = {}
  line = f.readline()
  while line:
    try:
      key, value = str.split(line)
      pairs[unicode(key)] = [(int(value),)]
    except ValueError:
      pass

    line = f.readline()
  f.close()
  return pairs

def load_book_ngrams(aoid):
  try:
    return load_trie_ngrams(os.path.join(DIR, "library", aoid[0:2].lower(), aoid, aoid + ".trie.4grams"))
  except IOError:
    return load_freq_ngrams(os.path.join(DIR, "library", aoid[0:2].lower(), aoid, aoid + ".freq.4grams"))

def wordcount(aoid):
  f = open(os.path.join(DIR, "library", aoid[0:2].lower(), aoid, aoid + ".wordcount"))
  value = f.read()
  f.close
  return int(value)

#baseline = load_ngrams("baseline.trie.4grams+")
#book = load_ngrams("bom-1830.trie.4grams+")
#minus = load_ngrams("bible-kjv+dr.trie.4grams+")
# compare = load_ngrams("firstbooknapole00gruagoog.trie.4grams+")
#compare = load_ngrams("copiesofletterss00sout.trie.4grams+")
book_aoid = get_book_archive_org_id(db, sys.argv[1])
if book_aoid == None:
  book_aoid = sys.argv[1]
minus_aoid = get_book_archive_org_id(db, sys.argv[2])
if minus_aoid == None:
  minus_aoid = sys.argv[2]
compare_aoid = get_book_archive_org_id(db, sys.argv[3])
if compare_aoid == None:
  compare_aoid = sys.argv[3]

baseline = load_trie_ngrams(os.path.join(DIR, "baseline", "baseline.trie.4grams"))

book = load_book_ngrams(book_aoid)
minus = load_book_ngrams(minus_aoid)
compare = load_book_ngrams(compare_aoid)

phrases = []
total = 0.0
for key, value in book.items():
  #print "key", key, "value", value
  if not key in minus:
    #print "not in minus"
    if key in compare:
      #print "key in compare"
      if key in baseline:
        basev = float(baseline[key][0][0])
      else:
        basev = 4.0
      score = 1.0 / basev
      phrases.append((key, score))
      total += score
      # compv = float(compare[key][0][0])
      # bookv = float(value)
      # print key, basev, bookv, compv, score
    else:
      pass #print "key NOT in compare"

for phrase, score in sorted(phrases, key=lambda tup: (tup[1], tup[0])):
  print phrase, score
print "total", total
print "wc("+book_aoid+")", wordcount(book_aoid)
print "wc("+compare_aoid+")", wordcount(compare_aoid)

print "uniform-match-score", float(total*total)/(wordcount(book_aoid)*wordcount(compare_aoid))*1000000

# print t.prefixes(u'a-_-a-a-a-blah')
