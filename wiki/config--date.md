# Date


### Echo date values current, past, future based on SYSTIME

```
date --date='5 minutes ago'
date --date='24 hours ago'
date --date='24 hours ago' '+%b %d %T'
date --date='1 day ago' '+%b %d %T'
```

```
date -d '-1 day' '+%b %d %T'
date -d '-1 day' '+%b'
date -d '-24h' '+%b'
date -d '-24 h' '+%b'
date -d '-24 hours' '+%b'
```

### Convert 3 Char month text to integer

```bash
echo "Jan" | awk 'BEGIN{months="  JanFebMarAprMayJunJulAugSepOctNovDec"}{print index(months,$0)/3}'
```
