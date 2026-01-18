# MediaWiki BreadCrumbs


### Description

This extension allows you to dynamically create a "trace" of the pages you
have visited so far. This trace is displayed as a small list of links that
can typically be positionned at the top of a page. Additional parameters
can be specified to control the layout of the list and specify how many pages
should be "remembered".

### Requirements

- Mediawiki 1.53 +

### Parameters

```bash
 <kw_bread_crumbs>max_nb_crumbs=value|max_title_len=value|prefix=string|trim_prefix=string|separator=string|bgcolor=string|small=boolean|on_top_hack=boolean|session_key=string</kw_bread_crumbs>

```
- max_nb_crumbs=value: max number of page titles this extension should remember
- max_title_len=value: max length for each page title (will crop otherwise)
- prefix=string: string to use in front of the list of titles.
- trim_prefix=string: if this prefix is found, remove it from each page title.
- separator=string: string to use between each page title.
- bgcolor=string: in hex format (ex: FF22AA), color of the table background.
- small=[0|1]: if true, use a smaller font. True by default.
- on_top_hack=[0|1]: if true, try to put titles on top of page.
- session_key=string: explicitly specify the key the trace should be saved in

Note that trim_prefix can be specified multiple times so that different
prefixes can be trimmed.

You may have to use HTML entities for the prefix and separator parameters to
work properly.

The session_key parameter specificies the name of the key that is used to
save and retrieve the trace in the user session. It defaults to the site name
of the Wiki ($wgSitename) and the version of the MediaWiki running the site.
If you share multiple wikis with the same name (say, for testing purposes),
you may need to explicitly define a different session_key for each one.

The on_top_hack option is a hack. I mean, really. It will try to put the
trace on top of the page, before the page title. This is achieved by 
piggy-backing on top of the wgSiteNotice variable, and will work only 
for the monobook skin. See 'Positioning' below for more options.

### Installation

To activate the extension, copy the file to the Wiki/extensions directory
and include its contents from your Wiki/LocalSettings.php with: 
```bash
 include("extensions/kwBreadCrumbs.php");

```
### Positioning

There are 3 ways to position the trace:

1) inline: insert the tag in your page at the specific location you want the
trace to be rendered. I recommend you test your trace in this mode first.

2) on top: insert the tag anywhere in the page and use on_top_hack=1; the
extension will attempt to place the trace on top of the page, before the
page title. This is hack, and it works only for MediaWiki 1.3.

3) anywhere in the layout: you can use this extension as a template element. 

PHPTAL is not included by default anymore. Including the 
trace is there just a matter of editing one of the PHP file in the skins/
directory and invoke the kwBreadCrumbs() function with options. You may also
call the parameter-less kwBreadCrumbsTAL() function and assign any option to
a wgKwBreadCrumbs variable in LocalSettings.php:

Monobook.php:

```
  <div><?php echo kwBreadCrumbs("prefix=Trace: |bgcolor=F9F9F9") ?></div></pre>

'''or'''

Monobook.php:

```
  <div><?php echo kwBreadCrumbsTAL() ?></div></pre>

LocalSettings.php:

```
  $wgKwBreadCrumbs = "prefix=Trace: |small=1|bgcolor=F9F9F9";</pre>

===Issues===

The Wiki engine caches pages to achieve better performance. Sadly, this
makes extensions relying on dynamic or external contents pretty much useless.
To prevent pages using this extension from being cached, the 'cur_touched'
field in the 'cur' table is set slightly ahead in the future, so that the
page cache is automatically invalidated. The side-effects should be minimal :)

===PHP-Code===


```

<?php

$wgExtensionFunctions[] = "kwBreadCrumbsExtension";
 
// ------------------------------------------------------------------------ 
function kwBreadCrumbsExtension() 
{
  global $wgParser;
  $wgParser->setHook( "kw_bread_crumbs", "kwBreadCrumbs");
}
 
// ------------------------------------------------------------------------ 
function kwBreadCrumbs($input) 
{
  global $wgUser, $wgTitle, $wgOut;

  kwBreadCrumbsNoCache();

  // Initialize parameters

  $max_nb_crumbs = 5;
  $max_title_len = 30;
  $separator = ' » ';
  $trim_prefixes = array();
  $prefix = NULL;
  $on_top_hack = 0;
  $class = 'kwBreadCrumbs';
  $id = 'kwBreadCrumbs';
  $session_key = NULL;

  // Parse each parameter

  $params = explode('|', $input);
  foreach ($params as $param) 
    {
    $param_components = explode("=", $param, 2);
    $param_name = strtolower(trim($param_components[0]));
    $param_value = isset($param_components[1]) ? $param_components[1] : NULL;

    // max_nb_crumbs

    if ($param_name == 'max_nb_crumbs')
      {
      if (!strlen($param_value))
        {
        return kwBreadCrumbsError("missing value for parameter '$param_name'");
        }
      $value = (int)$param_value;
      if ($value >= 1 && $value <= 50)
        {
        $max_nb_crumbs = $value;
        }
      }

    // max_title_len

    else if ($param_name == 'max_title_len')
      {
      if (!strlen($param_value))
        {
        return kwBreadCrumbsError("missing value for parameter '$param_name'");
        }
      $value = (int)$param_value;
      if ($value >= 0 && $value <= 150)
        {
        $max_title_len = $value;
        }
      }

    // trim_prefix

    else if ($param_name == 'trim_prefix')
      {
      if (!strlen($param_value))
        {
        return kwSiteMapError("missing value for parameter '$param_name'");
        }
      $trim_prefixes[] = $param_value;
      }

    // prefix

    else if ($param_name == 'prefix')
      {
      if (!strlen($param_value))
        {
        return kwSiteMapError("missing value for parameter '$param_name'");
        }
      $prefix = $param_value;
      }

    // separator

    else if ($param_name == 'separator')
      {
      if (!strlen($param_value))
        {
        return kwBreadCrumbsError("missing value for parameter '$param_name'");
        }
      $separator = $param_value;
      }

    // on_top_hack

    else if ($param_name == 'on_top_hack')
      {
      if (!strlen($param_value))
        {
        return kwBreadCrumbsError("missing value for parameter '$param_name'");
        }
      $on_top_hack = $param_value ? 1 : 0;;
      }

    // session_key

    else if ($param_name == 'session_key')
      {
      if (!strlen($param_value))
        {
        return kwSiteMapError("missing value for parameter '$param_name'");
        }
      $session_key = $param_value;
      }

    // unknown parameter

    else if ($param_name)
      {
      return kwBreadCrumbsError("unknown parameter '$param_name'");
      }
    }

  // Make sure we started a session

  @session_start();

  global $wgSitename, $wgVersion;
  if (is_null($session_key))
    {
    $session_key = "kw_bread_crumbs: $wgSitename ($wgVersion)";
    }
  if (!isset($_SESSION[$session_key])) 
    { 
    $_SESSION[$session_key] = array(); 
    }

  // Remove duplicates

  $current_title = $wgTitle->getPrefixedText();

  $titles = array();
  foreach ($_SESSION[$session_key] as $title)
    {
    if ($title != $current_title)
      {
      $titles[] = $title;
      }
    }
  $_SESSION[$session_key] = $titles;
  $_SESSION[$session_key][] = $current_title;

  // Shrink the list

  $nb_titles = count($_SESSION[$session_key]);
  while ($nb_titles > $max_nb_crumbs)
    {
    array_shift($_SESSION[$session_key]);
    $nb_titles--;
    }

  // Create the trace

  $skin =& $wgUser->getSkin();

  $urls = array();
  foreach ($_SESSION[$session_key] as $title)
    {
    $text = $title;
    if (count($trim_prefixes))
      {
      foreach ($trim_prefixes as $trim_prefix)
        {
        if (strpos($text, $trim_prefix) === 0)
          {
          $text = substr($text, strlen($trim_prefix));
          }
        }
      }
    if ($max_title_len > 0)
      {
      $text_len = strlen($text);
      if ($text_len > $max_title_len)
        {
        $half = (int)($max_title_len / 2);
        $text = substr($text, 0, $max_title_len - $half - 1) . '&hellip;' . 
           substr($text, -$half);
        }
      }
    $urls[] = 
       ($title == $current_title ? $text : $skin->makeLink($title, $text));
    }

  $output = '<div id="' . $id . '" class="' . $class . '"';
  $output .= '>';

  $output .= 
     htmlentities(html_entity_decode($prefix)) . 
     implode(htmlentities(html_entity_decode($separator)), $urls);

  $output .= '</div>';

  // Hack to display the titles on top:
  // - only for version 1.3
  // - only if monobook
  // - piggy-back after the site notice (wgSiteNotice)
  // - remove border if <= 1.3.0 beta, alpha, etc.

  if ($on_top_hack)
    {
    if (preg_match("/^(\d+)\.(\d+)\.(\d+)(\w*)$/", $wgVersion, $ver))
      {
      if ($ver[1] == 1 && $ver[2] == 3)
        {
        $user_skin_name = $wgUser->getOption('skin');
        if ($user_skin_name == "monobook")
          {
          global $wgSiteNotice;
          if (!$wgSiteNotice || !strpos($wgSiteNotice, $class))
            {
            $new_notice = NULL;
            if ($ver[3] == 0 && isset($ver[4]))
              {
              $new_notice .= '<div style="margin: -1px -1px -1px -1px; border: 1px solid #FFFFFF; font-weight: bold;"></div>';
              }
            $new_notice .= '</div>' . $output;
            if ($wgSiteNotice)
              {
              $new_notice .= '<div id="siteNotice">' . $wgSiteNotice;
              }
            else
              {
              $new_notice .= '<div>';
              }
            $wgSiteNotice = $new_notice;
            }
          }
        }
      }
    return '';
    }

  return $output;
}

// ------------------------------------------------------------------------ 
function kwBreadCrumbsError($msg) 
{
  return "[kw_bread_crumbs] <b>Error</b>: " . htmlspecialchars($msg);
}

// ------------------------------------------------------------------------ 
function kwBreadCrumbsNoCache() 
{
  global $wgTitle, $wgOut;
  if (!isset($wgTitle) || !isset($wgOut))
    {
    return;
    }

  /*
    Let's 'touch' the page to invalidate its cache.
    The code below is slightly identical to Title::invalidateCache().
    Even though invalidateCache() sets cur_touched to 'now', we are still
    in the process of creating and rendering the page itself and the 
    page will be cached only once it is done. At the end of the day the
    cache would always end up newer than cur_touched, defeating the whole
    purpose of calling invalidateCache().
    The trick here is to set cur_touched in the future, something not too
    intrusive, say 'now' + 120 seconds, provided that we expect the cached
    page to be created within 120 secs after this extension code has been
    executed. That way, cur_touched remains 'fresher' than the cache, and
    the page is always re-created dynamically.
  */

  $ts = mktime();
  $now = gmdate("YmdHis", $ts + 120);
  $ns = $wgTitle->getNamespace();
  $ti = wfStrencode($wgTitle->getDBkey());
  $sql = "UPDATE page SET page_touched='$now' WHERE page_namespace=$ns AND page_title='$ti'";
  wfQuery($sql, DB_WRITE, "kwBreadCrumbsNoCache");

  // This does not seem to do anything. I assume once it's called here
  // in the extension, it's already too late.

  $wgOut->enableClientCache(false);

  // The followings should prevent browsers to cache too long

  /*
  $wgOut->addMeta("http:Pragma", "no-cache");
  $wgOut->addMeta("http:no-cache", NULL);
  $wgOut->addMeta("http:EXPIRES", "TUES, 31 DEC 1996 12:00:00 GMT");
  */

  // HTTP_IF_MODIFIED_SINCE ? // see OutputPage: checkLastModified
}

// ------------------------------------------------------------------------ 
function kwBreadCrumbsTAL() 
{
  global $wgKwBreadCrumbs;
  return kwBreadCrumbs(is_null($wgKwBreadCrumbs) ? '' : $wgKwBreadCrumbs);
}

?>

```

### CSS-Styles

```

.kwBreadCrumbs{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 0.95em;
}

.kwBreadCrumbs a:link, .kwBreadCrumbs a:visited, .kwBreadCrumbs a:active, .kwBreadCrumbs a:hover {
	color: #336699;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: normal;
	text-decoration:none;
}
.kwBreadCrumbs a:hover {
	text-decoration:underline;
}

```

### External Links

- http://www.mediawiki.org/wiki/Extension_talk:BreadCrumbs

