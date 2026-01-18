# Airport Config


## Bugs

### Your network settings have been changed by another application

This currently reported problem, which manifests after applying Security Update 2008-06, can be fixed permanently by removing the following preferences files:

Go to Library/Preferences/SystemConfiguration and delete the following (suggest make copies to the desktop first if in doubt):

com.apple.airport.preferences.plist
NetworkInterfaces.plist
preferences.plist
com.apple.nat.plist

All these files will regenerate as necessary when the associated system features are accessed. If you're using Airport or Internet Sharing you'll have to reestablish the appropriate settings, because these will have been lost when the preferences files are removed. Small price to pay, however for a permanent, and very simple solution to this irritating problem.

- http://discussions.apple.com/thread.jspa?threadID=1730909&tstart=0
