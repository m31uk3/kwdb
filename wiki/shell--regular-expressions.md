# Regular Expressions


## Summary

A regular expression is a pattern that describes a set of strings. Regular expressions are constructed analogously to arithmetic expressions, by using various operators to combine smaller expressions. Grep understands two different versions of regular expression syntax: “basic” and “extended.” In GNU grep, there is no difference in available functionality using either syntax. In other implementations, basic regular expres- sions are less powerful.

The following description applies to extended regular expressions; differences for basic regular expressions are summarized afterwards. The fundamental building blocks are the regular expressions that match a single character. Most characters, including all letters and digits, are regular expressions that match themselves.

Any metacharacter with special meaning may be quoted by preceding it with a backslash. A bracket expression is a list of characters enclosed by [ and ]. It matches any single character in that list; if the first character of the list is the caret ^ then it matches any character not in the list. For example, the regular expression [0123456789] matches any single digit. Within a bracket expression, a range expression consists of two characters separated by a hyphen. It matches any single character that sorts between the two characters, inclusive, using the locale’s collating sequence and char- acter set.

For example, in the default C locale, [a-d] is equivalent to [abcd]. Many locales sort characters in dictionary order, and in these locales [a-d] is typically not equivalent to [abcd]; it might be equivalent to [aBbCcDd], for example. To obtain the traditional interpretation of bracket expressions, you can use the C locale by setting the LC_ALL environment variable to the value C.

<nowiki>Finally, certain named classes of characters are predefined within bracket expressions, as follows. Their names are self explanatory, and they are [:alnum:], [:alpha:], [:cntrl:], [:digit:], [:graph:], [:lower:], [:print:], [:punct:], [:space:], [:upper:], and [:xdigit:]. For example, [alnum:::alnum:](misc--.md) means [0-9A-Za-z], except the latter form depends upon the C locale and the ASCII character encoding, whereas the former is independent of locale and character set. (Note that the brackets in these class names are part of the symbolic names, and must be included in addition to the brackets delimiting the bracket list.) Most metacharacters lose their special meaning inside lists. To include a literal ] place it first in the list. Similarly, to include a literal ^ place it anywhere but first. Finally, to include a literal - place it last.</nowiki>

<nowiki>The period . matches any single character. The symbol \w is a synonym for [alnum:::alnum:](misc--.md) and \W is a synonym for [^[:alnum]].</nowiki>

The caret ^ and the dollar sign $ are metacharacters that respectively match the empty string at the beginning and end of a line. The symbols \< and \> respectively match the empty string at the beginning and end of a word. The symbol \b matches the empty string at the edge of a word, and \B matches the empty string provided it’s not at the edge of a word.

A regular expression may be followed by one of several repetition operators:

? The preceding item is optional and matched at most once.

<nowiki>*</nowiki> The preceding item will be matched zero or more times.

+ The preceding item will be matched one or more times.

{n} The preceding item is matched exactly n times.

{n,} The preceding item is matched n or more times.

{n,m} The preceding item is matched at least n times, but not more than m times.

Two regular expressions may be concatenated; the resulting regular expression matches any string formed by concatenating two substrings that respectively match the concatenated subexpressions.

Two regular expressions may be joined by the infix operator |; the resulting regular expression matches any string matching either subexpression.

Repetition takes precedence over concatenation, which in turn takes precedence over alternation.   A  whole  subexpression may be enclosed in parentheses to override these precedence rules.
 
The backreference \n, where n is a single digit, matches the substring previously matched by the nth parenthesized
subexpression of the regular expression.

In basic regular expressions the metacharacters ?, +, {, |, (, and ) lose their special meaning;  instead  use  the
backslashed versions \?, \+, \{, \|, \(, and \).

Traditional  egrep  did  not  support  the  {  metacharacter, and some egrep implementations support \{ instead, so
portable scripts should avoid { in egrep patterns and should use [{] to match a literal {.

GNU egrep attempts to support traditional usage by assuming that { is not special if it would be the  start  of  an
invalid interval specification.  For example, the shell command egrep ’{1’ searches for the two-character string {1
instead of reporting a syntax error in the regular expression.  POSIX.2 allows this behavior as an  extension,  but
portable scripts should avoid it.


## Examples

### Return all file that are .jpg

```bash
ls -1 | grep '.\.jpg$'

```
### Return all files whose last letter of file name is a vowel

```
 find | grep '[aeiou][\.][alnum:::alnum:](misc--.md)\{3\}$'
 find | grep '^[\./]\{2\}[alpha:::alpha:](misc--.md)\+$'
```

### Return all files that are not .mp3 or .jpg

**Not so much....**'

```bash
ls -1 | grep '[^\.(mp3|jpg)]$'
for i in `find . -regex '.*[^\.(mp3|php)]$'`; do rm -f $i; done

```
### Return all items that do not start with /www

```bash
grep -E ^\/[^w]{3}

```
### Return all IP addresses within text

```bash
grep -E \(^\|.\)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\($\|.\)

```
### Return all files larger than 1024K

```bash
du -ah . | sort -n -r | grep -E ^[0-9]+[\.]*[0]*[M]+

```
### Return all files that start with a number and end with .eps

```bash
ls -1 | grep ^[0-9].*[^\.eps]$

```
= See Also =

- [Bash#Globbing](shell--bash.md#globbing) - Shell's filename expansion capabilities.
- [Bash#Brace_Expansion](shell--bash.md#braceexpansion) - Use regular expression like grouping to build a list of files to act on.

