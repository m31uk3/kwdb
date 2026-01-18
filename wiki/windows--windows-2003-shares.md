# Windows 2003 Shares


At home we have a Windows 2003 Server running as a domain controller and file server. Whilst this does its job pretty nicely for Windows clients, I’ve never been able to connect to it successfully with my Mac running OS X 10.3 Panther. Browsing the network I have always been able to see the server, but any attempt to authenticate simply returned a error along the lines of “the original item cannot be found”. Frustrating.

Despite much searching over the last six months, I’d not found the solution – until today. Allow me to share the solution again, for the benefit of those searching with the same problem.

In a nutshell, the cause of the problem is the default security policy on Windows 2003 Server being set to always encrypt network connections under all circumstances. Whilst this is fine for most clients (especially Windows clients, understandably), the version of SMB that Panther uses doesn’t support encrypted connections. Apparently this support exists in Samba 3, but not on the version OS X uses. The solution is to change the security policy to use encryption when it’s available and not otherwise. Here’s how.

From Administrative Tools, open Domain Controller Security Settings.
Go to Local Policies then Security Options.

Scroll down to find the entry Microsoft network server: Digitally sign communications (always). Set this to Disabled.

The only thing left to do is to reload the security policy, as changes don’t otherwise take effect for some time. Open up a command window and type:

gpupdate

This will buzz and whirr for a few moments before confirming that the policy has been reloaded. With a bit of luck you should now be able to mount a network share from the Windows 2003 Server on your Mac. As I say, I’ve been searching for this information periodically for more than six months, so if you find it helpful pass it on.

