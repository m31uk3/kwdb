# Strototime


## PHP

### strtotime() switches or mixes month, year, day

```
I've had a little trouble with this function in the past because (as some people have pointed out) you can't really set a locale for strtotime. If you're American, you see 11/12/10 and think "12 November, 2010". If you're Australian (or European), you think it's 11 December, 2010. If you're a sysadmin who reads in ISO, it looks like 10th December 2011.

The best way to compensate for this is by modifying your joining characters. Forward slash (/) signifies American M/D/Y formatting, a dash (-) signifies European D-M-Y and a period (.) signifies ISO Y.M.D.

Observe:

<?php
echo date("jS F, Y", strtotime("11.12.10"));
// outputs 10th December, 2011

echo date("jS F, Y", strtotime("11/12/10"));
// outputs 12th November, 2010

echo date("jS F, Y", strtotime("11-12-10"));
// outputs 11th December, 2010 
?>

Hope this helps someone!
```

### Sources

- http://php.net/manual/en/function.strtotime.php#100144
