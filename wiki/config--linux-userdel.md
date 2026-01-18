# Linux userdel


## Mass User Delete

```bash
cat <user_file> | while read USER; do userdel -r $USER; done

```
