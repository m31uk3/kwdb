# Network Time Protocol


## NTP Cron Script

```
#!/bin/bash

ntpdate -b clock.psu.edu >>/dev/null 2>>/dev/null
```

