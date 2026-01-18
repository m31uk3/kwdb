# Tr Command


## Examples

Convert tab delimited data into comma delimited:

```bash
tr '\t' ',' <input_file> <output_file>

```
Replace "New Line Character" (Return) with comma:

```bash
cat fontprds.txt | tr -s "\r\n" ","

```
Convert string from upper case to lower case:

```bash
tr '[:upper:]' '[:lower:]'

```
Convert Windows Line Break to Unix

```bash
tr -d "\r"
```
