# Xmlstarlet


## Check Printout Catalog

```bash
wget -qO- https://backend.spreadomat.net/production/api/batches/na/25394/printoutCatalog | xmlstarlet sel -N x="http://api.spreadshirt.net" -t -v "//x:transaction/@id" | sort | uniq | wc -l

wget -qO- https://backend.spreadomat.net/production/api/batches/na/27614/printoutCatalog | xmlstarlet sel -N x="http://api.spreadshirt.net" -t -v "count(//x:transaction/@id)" -n

wget -qO- https://backend.spreadomat.net/production/api/batches/na/28756/printoutCatalog | xmlstarlet sel -N x="http://api.spreadshirt.net" -t -v //x:file/x:name -n

wget -qO- https://backend.spreadomat.net/production/api/batches/na/28756/printoutCatalog | xmlstarlet sel -N x="http://api.spreadshirt.net" -t -m //x:file -v "concat(x:name,',',x:contentList/x:content/x:orderItem/@id,',',x:contentList/x:content/x:orderItem/x:transaction/@id)" -n

```
## SKUs

```bash
wget -qO- 'http://api.spreadshirt.net/api/v1/shops/40000/productTypes?locale=en_GB&fullData=true' | xmlstarlet sel -N x="http://api.spreadshirt.net" -t -m //x:productType -v "concat(@id,'-',x:appearances/x:appearance/@id,'-',x:sizes/x:size/@id)" -n

```
## Namespace Declaration Problems

```
	

Unfortunately, XMLStarlet is very picky about the default namespace. If the document has it declared (xmlns=), you have to declare it for XMLStarlet too, and prefix the elements with the name you have chosen (see here):

    xml sel -N my=http://maven.apache.org/POM/4.0.0 -t -m my:project -v my:groupId -o : -v my:artifactId -o : -v my:version pom.xml

Running the above command gives the expected output:

org.something.apps:app-acct:5.4

However, if the document does NOT have the default namespace declared (or the namespace has a slightly different URL), the above command will NOT work, which is a real PITA. A more universal solution is to remove the default namespace declaration before selecting the elements. As of XMLStarlet 1.3.1, converting the XML to PYX format and back removes the namespace declarations:

    xml pyx pom.xml | xml p2x | xml sel -t -m project -v groupId -o : -v artifactId -o : -v version 2>nul

UPDATE (2014-02-12): as of XMLStarlet 1.4.2 the PYX <-> XML conversion is fixed (does not remove namespace declarations), so the above command will NOT work (thanks for Peter Gluck for the tip). Use the following command instead:

    xml pyx pom.xml | grep -v ^A | xml p2x | xml sel -t -m project -v groupId -o : -v artifactId -o : -v version

Note: the grep above removes ALL attributes from the document, not just namespace declarations. For this specific case (selecting element values from pom.xml where elements with non-default namespaces are not expected) it is Ok, but for a general XML you would remove just the default namespace declaration(s) and nothing else:

    xml pyx pom.xml | grep -v "^Axmlns " | xml p2x | xml sel -t -m project -v groupId -o : -v artifactId -o : -v version

Note (obsolete): the error redirection (2>nul) is necessary to hide the complaint about the (now) unknown namespace xsi:

    -:1.28: Namespace prefix xsi for schemaLocation on project is not defined

Another way of getting rid of the complaint is to remove the schemaLocation attribute (actually, this command removes all attributes from the PYX document, not just xsi:schemaLocation):

    xml pyx pom.xml | grep -v ^A | xml p2x | xml sel -t -m project -v groupId -o : -v artifactId -o : -v version

```

## Man Page

```
XMLStarlet Toolkit: Select from XML document(s)
Usage: xml sel <global-options> {<template>} [ <xml-file> ... ]
where
  <global-options> - global options for selecting
  <xml-file> - input XML document file name/uri (stdin is used if missing)
  <template> - template for querying XML document with following syntax:

<global-options> are:
  -C or --comp       - display generated XSLT
  -R or --root       - print root element <xsl-select>
  -T or --text       - output is text (default is XML)
  -I or --indent     - indent output
  -D or --xml-decl   - do not omit xml declaration line
  -B or --noblanks   - remove insignificant spaces from XML tree
  -N <name>=<value>  - predefine namespaces (name without 'xmlns:')
                       ex: xsql=urn:oracle-xsql
                       Multiple -N options are allowed.
  --net              - allow fetch DTDs or entities over network
  --help             - display help

Syntax for templates: -t|--template <options>
where <options>
  -c or --copy-of <xpath>  - print copy of XPATH expression
  -v or --value-of <xpath> - print value of XPATH expression
  -o or --output <string>  - output string literal
  -n or --nl               - print new line
  -f or --inp-name         - print input file name (or URL)
  -m or --match <xpath>    - match XPATH expression
  -i or --if <test-xpath>  - check condition <xsl:if test="test-xpath">
  -e or --elem <name>      - print out element <xsl:element name="name">
  -a or --attr <name>      - add attribute <xsl:attribute name="name">
  -b or --break            - break nesting
  -s or --sort op xpath    - sort in order (used after -m) where
  op is X:Y:Z,
      X is A - for order="ascending"
      X is D - for order="descending"
      Y is N - for data-type="numeric"
      Y is T - for data-type="text"
      Z is U - for case-order="upper-first"
      Z is L - for case-order="lower-first"

There can be multiple --match, --copy-of, --value-of, etc options
in a single template. The effect of applying command line templates
can be illustrated with the following XSLT analogue

xml sel -t -c "xpath0" -m "xpath1" -m "xpath2" -v "xpath3" \
        -t -m "xpath4" -c "xpath5"

is equivalent to applying the following XSLT

<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <xsl:call-template name="t1"/>
  <xsl:call-template name="t2"/>
</xsl:template>
<xsl:template name="t1">
  <xsl:copy-of select="xpath0"/>
  <xsl:for-each select="xpath1">
    <xsl:for-each select="xpath2">
      <xsl:value-of select="xpath3"/>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>
<xsl:template name="t2">
  <xsl:for-each select="xpath4">
    <xsl:copy-of select="xpath5"/>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)

Current implementation uses libxslt from GNOME codebase as XSLT processor
(see http://xmlsoft.org/ for more details)
```

## Sources

- http://xmlstar.sourceforge.net/doc/UG/xmlstarlet-ug.html
- http://stackoverflow.com/questions/9025492/xmlstarlet-does-not-select-anything
