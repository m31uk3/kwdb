# SELinux


## FAQ

### How do I turn SELinux off at boot?

Add selinux=0 to your kernel command line.

**Be careful when disabling SELinux**

Be very careful using this option. If you boot with selinux=0, any files you create while SELinux is disabled will not have SELinux context information. At the least you may need to relabel the file system, and it's possible you will be unable to boot with selinux=1, requiring a boot to single-user mode for recovery.

As an alternative to selinux=0, try using SELINUX=disabled in /etc/selinux/config.

### How do I turn enforcing on/off at boot?

You can specify the SELinux mode using the configuration file /etc/sysconfig/selinux.

```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= type of policy in use. Possible values are:
#       targeted - Only targeted network daemons are protected.
#       strict - Full SELinux protection.
SELINUXTYPE=targeted
```

Setting the value to enforcing is the same as adding enforcing=1 to your command line when booting the kernel to turn enforcing on, while setting the value to permissive is the same as adding enforcing=0 to turn enforcing off. Note that the command line kernel parameter overrides the configuration file.

However, setting the value to disabled is not the same as the selinux=0 kernel boot parameter. Rather than fully disabling SELinux in the kernel, the disabled setting instead turns enforcing off and skips loading a policy.	

### How do I temporarily turn off enforcing mode without having to reboot?

This situation usually arises when you can't perform an action that is being prevented by policy. Run the command setenforce 0 to turn off enforcing mode in real time. When you are finished, run setenforce 1 to turn enforcing back on.

**sysadm_r role required**

You must issue the setenforce command with the sysadm_r role; to do so, use the newrole command. Alternately, if you switch to root using su -, you gain the sysadm_r role automatically.

### How do I turn system-call auditing on/off at boot?

Add audit=1 to your kernel command line to turn system-call auditing on. Add audit=0 to your kernel command line to turn system-call auditing off.

System-call auditing is off by default. When on, it provides information about the system-call that was executing when SELinux generated a denied message. This may be helpful when debugging policy.

### How do I temporarily turn off system-call auditing without having to reboot?

This is not supported at this time. In the future, a utility will be provided to tune auditing.

### How do I get status info about my SELinux installation?

As root, execute the command

```bash
/usr/sbin/sestatus -v

```
For more information, refer to the sestatus(8) manual page.

