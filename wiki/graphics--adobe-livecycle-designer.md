# Adobe LiveCycle Designer


## Summary

Included with Adobe Acrobat 8 is designed to make the creation of dynamic forms simple.

## FormCalc

Internal scripting language used to manipulate data within the PDF.

=== Examples === 

Set a date object to the current date when a user opens the PDF file.

```bash
xfa.form.form1.newWorkstationForm.user.date = Num2Date(Date(), "MMM DD, YYYY")

```
Set a date object to a specific date when a user opens the PDF file.

```bash
xfa.form.form1.newWorkstationForm.user.date = Num2Date((Date() + 5), "MMM DD, YYYY")

```
Set the fill color of a text field to black.

```bash
xfa.form.form1.newWorkstationForm.user.employee.fillColor = "0,0,0"

```
