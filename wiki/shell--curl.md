# Curl


## Time Response HTTP

```bash
curl -w "@curl.format.txt" -o /dev/null -s https://backend.spreadomat.net/production/api/batches/na/25382/printoutCatalog

```
Output:
```
    time_namelookup:  0.007
       time_connect:  0.113
    time_appconnect:  0.334
   time_pretransfer:  0.334
      time_redirect:  0.000
 time_starttransfer:  4.158
                    ----------
         time_total:  5.405
```

curl.format.txt:
```
    time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
    time_appconnect:  %{time_appconnect}\n
   time_pretransfer:  %{time_pretransfer}\n
      time_redirect:  %{time_redirect}\n
 time_starttransfer:  %{time_starttransfer}\n
                    ----------\n
         time_total:  %{time_total}\n
```

## Source

- http://stackoverflow.com/questions/18215389/how-do-i-measure-request-and-response-times-at-once-using-curl
