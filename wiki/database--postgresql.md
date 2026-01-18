# PostgreSQL


## Install

postgresql-server-<VERSION>
postgresql-libs-<VERSION>
postgresql-devel-<VERSION>
postgresql-<VERSION>

On most linux systems you can install the above rpms via yum:

```bash
yum install postgresql-server postgresql-libs postgresql-devel postgresql

```
Configure PostgreSQL to be accessible from remote

The PostgreSQL database server configuration file is postgresql.conf. This file is located in the data directory of the server, typically /var/lib/postgres/data.

1. As root user edit the file

```bash
vi /var/lib/postgres/postgresql.conf

```
2. In the connections and authentications section uncomment or edit the listen_addresses line to your needs and take a careful look at the other lines.

```bash
listen_addresses = '*'

```
3. Hereafter insert the following line in the host-based authentication file pg_hba.conf. This file controls which hosts are allowed to connect, so be careful.

1. IPv4 local connections:

host    all         all         127.0.0.1         255.255.255.255   trust

4. After this you should restart the postmaster for the changes to take effect with

/etc/rc.d/postgresql restart

5. Please consider that the port 5432 should be open, so make sure to configure your firewall correctly.

6. For troubleshooting take a look in the server log file

```bash
tail -f /var/log/postgresql.log

```
## Create User

createdb

```
createuser creates a new PostgreSQL user.

Usage:
  createuser [OPTION]... [USERNAME]

Options:
  -a, --adduser             user can add new users
  -A, --no-adduser          user cannot add new users
  -d, --createdb            user can create new databases
  -D, --no-createdb         user cannot create databases
  -P, --pwprompt            assign a password to new user
  -E, --encrypted           encrypt stored password
  -N, --unencrypted         do no encrypt stored password
  -i, --sysid=SYSID         select sysid for new user
  -e, --echo                show the commands being sent to the server
  -q, --quiet               don't write any messages
  --help                    show this help, then exit
  --version                 output version information, then exit

Connection options:
  -h, --host=HOSTNAME       database server host or socket directory
  -p, --port=PORT           database server port
  -U, --username=USERNAME   user name to connect as (not the one to create)
  -W, --password            prompt for password to connect

If one of -a, -A, -d, -D, and USERNAME is not specified, you will
be prompted interactively.
```

You have to create the superuser as postgres:

```bash
su - postgres

```
One option is to create a super-user with something like:

```bash
postgres$ createuser -d -a -P ljackson

```
then:

```bash
ljackson$ createdb ibmadb

```
then do administrative tasks with that user. I would advise *NOT* using
root. If this is a tightly controlled (non-shared) machine, you could make
a super user as your normal unix login (which hopefull is not root).
Ideally you'll only need root to start the postgres service.

