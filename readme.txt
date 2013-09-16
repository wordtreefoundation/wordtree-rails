1. epub to text conversion
2. clean the text, word wrap
3. create ngrams 1 thru 5

https://code.google.com/p/ngrams/wiki/NGrams

4. split output file into .1grams, .2grams, etc.

cd ngrams/words/freq-split/
ls -1 | LC_ALL=C sort -n | parallel --gnu --jobs 6 echo {}\; ../../splitdashes {}

mv *.1grams ../1gr
mv *.2grams ../2gr
mv *.3grams ../3gr
mv *.4grams ../4gr
mv *.5grams ../5gr

5. merge files

LC_ALL=C sort --merge --batch-size=1000 *.1grams | pv -cN sorted | ../sum >n0.freq.1grams

pv n0.freq.1grams | grep -v 'aa\|bbb\|ccc\|ddd\|eee\|fff\|ggg\|hh\|ii\|jj\|kk\|lll\|mmm\|nnn\|ooo\|ppp\|qq\|rrr\|sss\|ttt\|uuu\|vvv\|ww\|xx\|yy\|zzz' | tail -n +3 >../1grams.freq

6. use sgrep for lookup

7. calculate ngram frequency in bom, text, baseline (triples)

8. get wordcounts for texts

ls -1 *.triple | sed 's/\.freq\.triple//' | parallel --gnu --jobs 1 wc -l ~/ngrams/words/{}.txt | sed 's|/home/duane/ngrams/words/||' | sed 's/\.txt/.freq.triple.wordcount/' | awk '{ print $1 > $2 }'

9. calculate proximity score from (triples) and wordcount

ls -1 *.triple | parallel --gnu --jobs 1 ../../score {}

10. get archive.org years and titles from book IDs

ls -1 1gr | awk -F . '{print $2}' | sed 's/-words//' | ruby archiveorg.rb | tee archive.catalog.txt

11. Combine BoM with ngrams frequency index:

ls -1 | sort -n | parallel --gnu ../ofrequency {} ../bom/1992-4grams/{.}.triple.4grams


