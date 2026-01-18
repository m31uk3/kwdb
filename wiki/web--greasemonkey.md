# Greasemonkey


## Examples

### Select Multiple Check Boxes with the Shift Key

Lets you check or uncheck a range of checkboxes by clicking the first checkbox and then Shift+clicking the last checkbox.

```
// ==UserScript==
// @name          Check Range
// @namespace     http://squarefree.com/userscripts
// @description   Lets you check or uncheck a range of checkboxes by clicking the first checkbox and then Shift+clicking the last checkbox.
// @include       *
// @exclude       http://gmail.google.com/*
// @exclude       https://gmail.google.com/*
// ==/UserScript==

/*

  Author: Jesse Ruderman - http://www.squarefree.com/
  Suggested on http://69.90.152.144/collab/GreaseMonkeyUserScriptRequest at 2005-04-06 17:00:13 anonymously.
  
  Features:
   * Works with both mouse (shift+click) and keyboard (shift+space).
   * Use to select or deselect.
   * Use forwards or backwards.
  
  Tested with:
   * Hotmail, Yahoo! Mail, Google Personalized profile creation.
   * HTML loose, HTML strict, XHTML (with the XHTML mime type).
  
*/


(function()
{

var currentCheckbox = null;

function NSResolver(prefix) 
{
  if (prefix == 'html') {
    return 'http://www.w3.org/1999/xhtml';
  }
  else {
    //this shouldn't ever happen
    return null;
  }
}

function selectCheckboxRange(start, end)
{
  var xpath, i, checkbox, last;

  if (document.documentElement.namespaceURI) // XML
    xpath = "//html:input[@type='checkbox']";
  else // HTML
    xpath = "//input[@type='checkbox']";
    
  var checkboxes = document.evaluate(xpath, document, NSResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);

  for (i = 0; (checkbox = checkboxes.snapshotItem(i)); ++i) {
    if (checkbox == end) {
      last = start;
      break;
    }
    if (checkbox == start) {
      last = end;
      break;
    }
  }

  for (; (checkbox = checkboxes.snapshotItem(i)); ++i) {
    if (checkbox != start && checkbox != end && checkbox.checked != start.checked) {
      // Instead of modifying the checkbox's value directly, fire an onclick event.
      // This makes scripts that are part of Yahoo! Mail and Google Personalized pick up the change.
      // Doing it this way also triggers an onchange event, which is nice.
      var evt2 = document.createEvent("MouseEvents");
      evt2.initEvent("click", true, false);
      checkbox.dispatchEvent(evt2);
    }

    if (checkbox == last) {
      break;
    }
  }
}

function handleChange(event)
{
  var t = event.target;

  if (isCheckbox(t) && (event.button == 0 || event.keyCode == 32)) {
    if (event.shiftKey && currentCheckbox) {
      selectCheckboxRange(currentCheckbox, t);
    }

    currentCheckbox = t;
  }
}

function isCheckbox(elt)
{
  // tagName requires toUpperCase because of HTML vs XHTML
  return (elt.tagName.toUpperCase() == "INPUT" && elt.type == "checkbox");
}

// onchange always has event.shiftKey==true, so to tell whether
// shift was held, we have to use onkeyup and onclick instead.
document.documentElement.addEventListener("keyup", handleChange, true);
document.documentElement.addEventListener("click", handleChange, true);

})();
```

### Multiple Select Options with CSV

Automatically populate (set to selected) multiple select box options based on comma separated values equal to the values of the desired selected options.

```
// NOTE : Once you are on a webpage, you can invoke
//		  this script by pressing CTRL+SHIFT+F




// ================================ Set data here ============================= //



// Values for the fieldnames above, in the exact array order
//select = [6, 7, 8, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 72, 73, 74, 75, 76, 77, 79, 81, 82, 83, 84, 85, 87, 88, 89, 90, 91, 92, 93, 94, 95, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 134, 135, 136, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 162, 163, 164, 166, 167, 168, 169, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202];
//select = new Array ( '6', '7', '8', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '40', '41', '42', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '72', '73', '74', '75', '76', '77', '79', '81', '82', '83', '84', '85', '87', '88', '89', '90', '91', '92', '93', '94', '95', '97', '98', '99', '100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '134', '135', '136', '138', '139', '140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151', '152', '153', '154', '155', '156', '162', '163', '164', '166', '167', '168', '169', '173', '174', '175', '176', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '200', '201', '202' );
select = [48, 109, 121, 144, 171, 175, 210, 221, 288, 347];
// ================================= No need to alter below ==================== //


function doAutoFill() {

var allFields, currentField, fieldName, splitFields, test, luke;
allFields = document.getElementsByTagName('select');

//producttype_id[]
//productcolor_id[]

if(allFields.length > 1) {
	alert(allFields.length);
	alert(allFields[2].name);

}

//luke = allFields[3].name;

for (var h = 0; h < allFields[2].options.length; h++) {

for (var i = 0; i < select.length; i++) {
	
	if(allFields[2].options[h].value == select[i]) {
		allFields[2].options[h].selected = true;
		break;
	}
}
	
}

}

// =============================

// Track keypresses
function keyDown(e) {	
	if (e.shiftKey&&e.ctrlKey) {
		switch (e.keyCode) {
			case 70: // CTRL+SHIFT+F
				doAutoFill();
				break;
		}
	}
}

// =============================

// Add a handler for the keyboard shortcut
window.addEventListener("keydown", keyDown, true);

```

### Parse URLs with Xpath and Fetch Contents

```
// ==UserScript==
// @name        Links
// @namespace   All
// @version     1
// @grant       none
// ==/UserScript==

var links = document.evaluate("//tr/@href", document, null, 
XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null);

var i = 0;                     //  set your counter to 1

function myLoop () {           //  create a loop function
   setTimeout(function () {    //  call a 3s setTimeout when the loop is called



  var thisLink = links.snapshotItem(i);
  var lSplit = thisLink.value.split("/");
  var batchID = lSplit.pop();
  var rootURL = "https://server.com/";
  var gURL = rootURL + thisLink.value;
  
      //your code to be executed after 1 second
  
      // Replace URL
      //thisLink.setAttribute("href", "https://server.com/" + thisLink.getAttribute("href"));

      var ReqText;
      $.get(gURL, function(ReqText) {

          
        
           
        
          var RMdoc = new DOMParser().parseFromString(ReqText,'text/html');
          var lja = RMdoc.evaluate("//td/text()", RMdoc, null, 
          XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
        
          var rowCSV = [];
          var fileCSV = [];

          for (var p=0; p < lja.snapshotLength; p++) {

              var thisTable = lja.snapshotItem(p);
              rowCSV.push(thisTable.nodeValue);
            
              if (rowCSV.length == 7) {
                 
                  //fileCSV.push(rowCSV.join(","));
                  console.log(batchID + "," + rowCSV.join(","));
                  rowCSV = [];
              }
          }
        
        //console.log(batchID + ": " + csvData.join(","));
          
          

      });
      //console.log(batchID);


      //console.log('hello' + i);          //  your code here
      i++;                     //  increment the counter
      if (i < 3) {            //  if the counter < 10, call the loop function
         myLoop();             //  ..  again which will trigger another 
      }                        //  ..  setTimeout()
   }, 2000)
}


//links.snapshotLength
myLoop();                      //  start the loop
```

### Xpath HTML Source

```
// ==UserScript==
// @name        Batch
// @namespace   All
// @version     1
// @grant       none
// @include https://waffle.woot.com/home/filter*
// ==/UserScript==

function nsResolver(prefix) {
  var ns = {
    '' : 'http://www.w3.org/1999/xhtml'
  };
  return ns[prefix] || null;
};

//var lja = document.evaluate("//option/@value | //select/@id | //input/@id | //select/optgroup/@label | //td/text()", document, null, 
//var lja = document.evaluate("//select/@id | //input/@id | //td/text()", document, null, 
//XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null);

var RMdoc = new DOMParser().parseFromString(document.documentElement.outerHTML,'text/html');
var lja = RMdoc.evaluate("//option/text()", RMdoc, null, 
XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null);

var i = 0;                     //  set your counter to 1

function myLoop () {           //  create a loop function
   setTimeout(function () {    //  call a 3s setTimeout when the loop is called



  var thisLink = lja.snapshotItem(i);
  var lSplit = thisLink.value.split("/");
  var batchID = lSplit.pop();
  console.log(thisLink);
     
     
/*  var rootURL = "https://waffle.woot.com/";
  var gURL = rootURL + thisLink.value;
  
      //your code to be executed after 1 second
  
      // Replace URL
      //thisLink.setAttribute("href", "https://waffle.woot.com/" + thisLink.getAttribute("href"));

      var ReqText;
      $.get(gURL, function(ReqText) {

          
        
           
        
          var RMdoc = new DOMParser().parseFromString(ReqText,'text/html');
          var lja = RMdoc.evaluate("//td/text()", RMdoc, null, 
          XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
        
          var rowCSV = [];
          var fileCSV = [];

          for (var p=0; p < lja.snapshotLength; p++) {

              var thisTable = lja.snapshotItem(p);
              rowCSV.push(thisTable.nodeValue);
            
              if (rowCSV.length == 7) {
                 
                  //fileCSV.push(rowCSV.join(","));
                  console.log(batchID + "," + rowCSV.join(","));
                  rowCSV = [];
              }
          }
        
        //console.log(batchID + ": " + csvData.join(","));
          
          

      });
      //console.log(batchID);

*/

      //console.log('hello' + i);          //  your code here
      i++;                     //  increment the counter
      if (i < 500) {            //  if the counter < 10, call the loop function
         myLoop();             //  ..  again which will trigger another 
      }                        //  ..  setTimeout()
   }, 150)
}


//links.snapshotLength
myLoop();                      //  start the loop
```


