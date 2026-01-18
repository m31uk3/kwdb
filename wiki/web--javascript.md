# JavaScript


## XPath

```bash
count(//td[text() ="Men's XL"])
//td[text() ="Men's XL"]
//td[8]
//option/@value | //select/@id | //input/@id | //select/optgroup/@label | //option/text()

```
### Chrome, Firefox Xpath

Open developer tools to access the console and use the xpath function call to iterate the array of option items for the select object. Log them to the console using a for each function loop.

```bash
$x('//*[@id="miles"]/option/text()').forEach(function(el){console.log(el)});

```
Export p element text

```bash
$x('//p/text()').forEach(function(el){console.log(el)});

```
### Target iFrame Firefox Xpath Developer Console

You can point the developer tools at a specific iframe within a document. This will solve the issue of attempting to iterate the document object with Xpath and getting "undefined" results. The Console always defaults to the top level page and not the iFrame thus the desired elements are likely out of scope and because of that "undefined" is a valid return.

- You'll see a "cell with dark boarders" like button in the toolbar
- Click it, and you'll see a popup listing all the iframes in the document, as well as the main document itself.
- If you select an entry in the list, all the tools in the toolbox - the Inspector, the Console, the Debugger and so on - will now target only that iframe, and will essentially behave as if the rest of the page does not exist.


**Sources:**

- https://developers.google.com/web/tools/chrome-devtools/console/command-line-reference#xpath
- https://developer.mozilla.org/en-US/docs/Tools/Working_with_iframes
