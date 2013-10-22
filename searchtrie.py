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
    return load_trie_ngrams(os.path.join(DIR, "library", aoid[0:2].lower(), aoid, aoid + ".trie.4grams+"))
  except IOError:
    return load_freq_ngrams(os.path.join(DIR, "library", aoid[0:2].lower(), aoid, aoid + ".freq.4grams+"))

book = load_book_ngrams(sys.argv[1])
#baseline = load_trie_ngrams(os.path.join(DIR, "baseline", "baseline.trie.4grams+"))
print sys.argv[2]
print book[sys.argv[2]]

