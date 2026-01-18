# Temperature Conversion


## Celsius to Fahrenheit

The metric system uses the Celsius scale to measure temperature. However, temperatures are still measured on the Fahrenheit scale in the U.S.

- Water freezes at 0&deg; Celsius and boils at 100&deg; Celsius which is a difference of 100&deg;.
- Water freezes at 32&deg; Fahrenheit and boils at 212&deg; Fahrenheit which is a difference of 180&deg;.

Therefore each degree on the Celsius scale is equal to 180/100 or 9/5 degrees on the Fahrenheit scale.

How to convert Celsius temperatures to Fahrenheit:

1. Multiply the Celsius temperature by 9/5.
1. Add 32&deg; to adjust for the offset in the Fahrenheit scale.

Example: Convert 37&deg; Celsius to Fahrenheit:

```bash
37 * 9/5 = 333/5 = 66.6
66.6 + 32 = 98.6&deg; Fahrenheit 

```
There is a mental math method to convert from Celsius to Fahrenheit. The ratio of 9/5 is equal to 1.8 and 1.8 is equivalent to 2 - 0.2

- How to convert Celsius temperatures to Fahrenheit with mental math. Double the Celsius temperature:

```bash
(x * 2)

```
- Take 1/10 (0.1) of "x" and then multiply that by 2 and subtract it from the result above:

```bash
((x * 2) - ((x * 2) * 0.1))

```
- Lastly add 32&deg; to adjust for the offset in the Fahrenheit scale.

```bash
((x * 2) - ((x * 2) * 0.1)) + 32

```
Example: Convert 37&deg; Celsius to Fahrenheit:

```bash
37 * 2 = 74
74 * 1/10 = 7.4
74 - 7.4 = 66.6
66.6 + 32 = 98.6&deg; Fahrenheit

```
## Example

<table width="100%" align="center" cellpadding="3" cellspacing="1">
```bash
 <tr bgcolor="#CCCCCC">
   <td class="s_b_row_hdr" align="center">Celcius</td>
   <td class="s_b_row_hdr" align="center">(x * 2) + 30</td>
   <td class="s_b_row_hdr" align="center">(x * 1.8) + 32</td>
   <td class="s_b_row_hdr" align="center">((x * 2) - ((x * 2) * 0.1)) + 32</td>
   <td class="s_b_row_hdr" align="center">Math</td>

 </tr>

  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">0° C</td>
   <td class="s_row_text" align="center">30° F</td>
   <td class="s_row_text" align="center">32° F</td>
   <td class="s_row_text" align="center">32 °F</td>

   <td class="s_row_text" align="center">0° C * 2 = 0 - 0 = 0 + 32 = 32° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">1° C</td>
   <td class="s_row_text" align="center">32° F</td>
   <td class="s_row_text" align="center">33.8° F</td>
   <td class="s_row_text" align="center">33.8 °F</td>

   <td class="s_row_text" align="center">1° C * 2 = 2 - 0.2 = 1.8 + 32 = 33.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">2° C</td>
   <td class="s_row_text" align="center">34° F</td>
   <td class="s_row_text" align="center">35.6° F</td>
   <td class="s_row_text" align="center">35.6 °F</td>

   <td class="s_row_text" align="center">2° C * 2 = 4 - 0.4 = 3.6 + 32 = 35.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">3° C</td>
   <td class="s_row_text" align="center">36° F</td>
   <td class="s_row_text" align="center">37.4° F</td>
   <td class="s_row_text" align="center">37.4 °F</td>

   <td class="s_row_text" align="center">3° C * 2 = 6 - 0.6 = 5.4 + 32 = 37.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">4° C</td>
   <td class="s_row_text" align="center">38° F</td>
   <td class="s_row_text" align="center">39.2° F</td>
   <td class="s_row_text" align="center">39.2 °F</td>

   <td class="s_row_text" align="center">4° C * 2 = 8 - 0.8 = 7.2 + 32 = 39.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">5° C</td>
   <td class="s_row_text" align="center">40° F</td>
   <td class="s_row_text" align="center">41° F</td>
   <td class="s_row_text" align="center">41 °F</td>

   <td class="s_row_text" align="center">5° C * 2 = 10 - 1 = 9 + 32 = 41° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">6° C</td>
   <td class="s_row_text" align="center">42° F</td>
   <td class="s_row_text" align="center">42.8° F</td>
   <td class="s_row_text" align="center">42.8 °F</td>

   <td class="s_row_text" align="center">6° C * 2 = 12 - 1.2 = 10.8 + 32 = 42.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">7° C</td>
   <td class="s_row_text" align="center">44° F</td>
   <td class="s_row_text" align="center">44.6° F</td>
   <td class="s_row_text" align="center">44.6 °F</td>

   <td class="s_row_text" align="center">7° C * 2 = 14 - 1.4 = 12.6 + 32 = 44.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">8° C</td>
   <td class="s_row_text" align="center">46° F</td>
   <td class="s_row_text" align="center">46.4° F</td>
   <td class="s_row_text" align="center">46.4 °F</td>

   <td class="s_row_text" align="center">8° C * 2 = 16 - 1.6 = 14.4 + 32 = 46.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">9° C</td>
   <td class="s_row_text" align="center">48° F</td>
   <td class="s_row_text" align="center">48.2° F</td>
   <td class="s_row_text" align="center">48.2 °F</td>

   <td class="s_row_text" align="center">9° C * 2 = 18 - 1.8 = 16.2 + 32 = 48.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">10° C</td>
   <td class="s_row_text" align="center">50° F</td>
   <td class="s_row_text" align="center">50° F</td>
   <td class="s_row_text" align="center">50 °F</td>

   <td class="s_row_text" align="center">10° C * 2 = 20 - 2 = 18 + 32 = 50° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">11° C</td>
   <td class="s_row_text" align="center">52° F</td>
   <td class="s_row_text" align="center">51.8° F</td>
   <td class="s_row_text" align="center">51.8 °F</td>

   <td class="s_row_text" align="center">11° C * 2 = 22 - 2.2 = 19.8 + 32 = 51.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">12° C</td>
   <td class="s_row_text" align="center">54° F</td>
   <td class="s_row_text" align="center">53.6° F</td>
   <td class="s_row_text" align="center">53.6 °F</td>

   <td class="s_row_text" align="center">12° C * 2 = 24 - 2.4 = 21.6 + 32 = 53.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">13° C</td>
   <td class="s_row_text" align="center">56° F</td>
   <td class="s_row_text" align="center">55.4° F</td>
   <td class="s_row_text" align="center">55.4 °F</td>

   <td class="s_row_text" align="center">13° C * 2 = 26 - 2.6 = 23.4 + 32 = 55.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">14° C</td>
   <td class="s_row_text" align="center">58° F</td>
   <td class="s_row_text" align="center">57.2° F</td>
   <td class="s_row_text" align="center">57.2 °F</td>

   <td class="s_row_text" align="center">14° C * 2 = 28 - 2.8 = 25.2 + 32 = 57.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">15° C</td>
   <td class="s_row_text" align="center">60° F</td>
   <td class="s_row_text" align="center">59° F</td>
   <td class="s_row_text" align="center">59 °F</td>

   <td class="s_row_text" align="center">15° C * 2 = 30 - 3 = 27 + 32 = 59° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">16° C</td>
   <td class="s_row_text" align="center">62° F</td>
   <td class="s_row_text" align="center">60.8° F</td>
   <td class="s_row_text" align="center">60.8 °F</td>

   <td class="s_row_text" align="center">16° C * 2 = 32 - 3.2 = 28.8 + 32 = 60.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">17° C</td>
   <td class="s_row_text" align="center">64° F</td>
   <td class="s_row_text" align="center">62.6° F</td>
   <td class="s_row_text" align="center">62.6 °F</td>

   <td class="s_row_text" align="center">17° C * 2 = 34 - 3.4 = 30.6 + 32 = 62.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">18° C</td>
   <td class="s_row_text" align="center">66° F</td>
   <td class="s_row_text" align="center">64.4° F</td>
   <td class="s_row_text" align="center">64.4 °F</td>

   <td class="s_row_text" align="center">18° C * 2 = 36 - 3.6 = 32.4 + 32 = 64.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">19° C</td>
   <td class="s_row_text" align="center">68° F</td>
   <td class="s_row_text" align="center">66.2° F</td>
   <td class="s_row_text" align="center">66.2 °F</td>

   <td class="s_row_text" align="center">19° C * 2 = 38 - 3.8 = 34.2 + 32 = 66.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">20° C</td>
   <td class="s_row_text" align="center">70° F</td>
   <td class="s_row_text" align="center">68° F</td>
   <td class="s_row_text" align="center">68 °F</td>

   <td class="s_row_text" align="center">20° C * 2 = 40 - 4 = 36 + 32 = 68° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">21° C</td>
   <td class="s_row_text" align="center">72° F</td>
   <td class="s_row_text" align="center">69.8° F</td>
   <td class="s_row_text" align="center">69.8 °F</td>

   <td class="s_row_text" align="center">21° C * 2 = 42 - 4.2 = 37.8 + 32 = 69.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">22° C</td>
   <td class="s_row_text" align="center">74° F</td>
   <td class="s_row_text" align="center">71.6° F</td>
   <td class="s_row_text" align="center">71.6 °F</td>

   <td class="s_row_text" align="center">22° C * 2 = 44 - 4.4 = 39.6 + 32 = 71.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">23° C</td>
   <td class="s_row_text" align="center">76° F</td>
   <td class="s_row_text" align="center">73.4° F</td>
   <td class="s_row_text" align="center">73.4 °F</td>

   <td class="s_row_text" align="center">23° C * 2 = 46 - 4.6 = 41.4 + 32 = 73.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">24° C</td>
   <td class="s_row_text" align="center">78° F</td>
   <td class="s_row_text" align="center">75.2° F</td>
   <td class="s_row_text" align="center">75.2 °F</td>

   <td class="s_row_text" align="center">24° C * 2 = 48 - 4.8 = 43.2 + 32 = 75.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">25° C</td>
   <td class="s_row_text" align="center">80° F</td>
   <td class="s_row_text" align="center">77° F</td>
   <td class="s_row_text" align="center">77 °F</td>

   <td class="s_row_text" align="center">25° C * 2 = 50 - 5 = 45 + 32 = 77° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">26° C</td>
   <td class="s_row_text" align="center">82° F</td>
   <td class="s_row_text" align="center">78.8° F</td>
   <td class="s_row_text" align="center">78.8 °F</td>

   <td class="s_row_text" align="center">26° C * 2 = 52 - 5.2 = 46.8 + 32 = 78.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">27° C</td>
   <td class="s_row_text" align="center">84° F</td>
   <td class="s_row_text" align="center">80.6° F</td>
   <td class="s_row_text" align="center">80.6 °F</td>

   <td class="s_row_text" align="center">27° C * 2 = 54 - 5.4 = 48.6 + 32 = 80.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">28° C</td>
   <td class="s_row_text" align="center">86° F</td>
   <td class="s_row_text" align="center">82.4° F</td>
   <td class="s_row_text" align="center">82.4 °F</td>

   <td class="s_row_text" align="center">28° C * 2 = 56 - 5.6 = 50.4 + 32 = 82.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">29° C</td>
   <td class="s_row_text" align="center">88° F</td>
   <td class="s_row_text" align="center">84.2° F</td>
   <td class="s_row_text" align="center">84.2 °F</td>

   <td class="s_row_text" align="center">29° C * 2 = 58 - 5.8 = 52.2 + 32 = 84.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">30° C</td>
   <td class="s_row_text" align="center">90° F</td>
   <td class="s_row_text" align="center">86° F</td>
   <td class="s_row_text" align="center">86 °F</td>

   <td class="s_row_text" align="center">30° C * 2 = 60 - 6 = 54 + 32 = 86° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">31° C</td>
   <td class="s_row_text" align="center">92° F</td>
   <td class="s_row_text" align="center">87.8° F</td>
   <td class="s_row_text" align="center">87.8 °F</td>

   <td class="s_row_text" align="center">31° C * 2 = 62 - 6.2 = 55.8 + 32 = 87.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">32° C</td>
   <td class="s_row_text" align="center">94° F</td>
   <td class="s_row_text" align="center">89.6° F</td>
   <td class="s_row_text" align="center">89.6 °F</td>

   <td class="s_row_text" align="center">32° C * 2 = 64 - 6.4 = 57.6 + 32 = 89.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">33° C</td>
   <td class="s_row_text" align="center">96° F</td>
   <td class="s_row_text" align="center">91.4° F</td>
   <td class="s_row_text" align="center">91.4 °F</td>

   <td class="s_row_text" align="center">33° C * 2 = 66 - 6.6 = 59.4 + 32 = 91.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">34° C</td>
   <td class="s_row_text" align="center">98° F</td>
   <td class="s_row_text" align="center">93.2° F</td>
   <td class="s_row_text" align="center">93.2 °F</td>

   <td class="s_row_text" align="center">34° C * 2 = 68 - 6.8 = 61.2 + 32 = 93.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">35° C</td>
   <td class="s_row_text" align="center">100° F</td>
   <td class="s_row_text" align="center">95° F</td>
   <td class="s_row_text" align="center">95 °F</td>

   <td class="s_row_text" align="center">35° C * 2 = 70 - 7 = 63 + 32 = 95° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">36° C</td>
   <td class="s_row_text" align="center">102° F</td>
   <td class="s_row_text" align="center">96.8° F</td>
   <td class="s_row_text" align="center">96.8 °F</td>

   <td class="s_row_text" align="center">36° C * 2 = 72 - 7.2 = 64.8 + 32 = 96.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">37° C</td>
   <td class="s_row_text" align="center">104° F</td>
   <td class="s_row_text" align="center">98.6° F</td>
   <td class="s_row_text" align="center">98.6 °F</td>

   <td class="s_row_text" align="center">37° C * 2 = 74 - 7.4 = 66.6 + 32 = 98.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">38° C</td>
   <td class="s_row_text" align="center">106° F</td>
   <td class="s_row_text" align="center">100.4° F</td>
   <td class="s_row_text" align="center">100.4 °F</td>

   <td class="s_row_text" align="center">38° C * 2 = 76 - 7.6 = 68.4 + 32 = 100.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">39° C</td>
   <td class="s_row_text" align="center">108° F</td>
   <td class="s_row_text" align="center">102.2° F</td>
   <td class="s_row_text" align="center">102.2 °F</td>

   <td class="s_row_text" align="center">39° C * 2 = 78 - 7.8 = 70.2 + 32 = 102.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">40° C</td>
   <td class="s_row_text" align="center">110° F</td>
   <td class="s_row_text" align="center">104° F</td>
   <td class="s_row_text" align="center">104 °F</td>

   <td class="s_row_text" align="center">40° C * 2 = 80 - 8 = 72 + 32 = 104° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">41° C</td>
   <td class="s_row_text" align="center">112° F</td>
   <td class="s_row_text" align="center">105.8° F</td>
   <td class="s_row_text" align="center">105.8 °F</td>

   <td class="s_row_text" align="center">41° C * 2 = 82 - 8.2 = 73.8 + 32 = 105.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">42° C</td>
   <td class="s_row_text" align="center">114° F</td>
   <td class="s_row_text" align="center">107.6° F</td>
   <td class="s_row_text" align="center">107.6 °F</td>

   <td class="s_row_text" align="center">42° C * 2 = 84 - 8.4 = 75.6 + 32 = 107.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">43° C</td>
   <td class="s_row_text" align="center">116° F</td>
   <td class="s_row_text" align="center">109.4° F</td>
   <td class="s_row_text" align="center">109.4 °F</td>

   <td class="s_row_text" align="center">43° C * 2 = 86 - 8.6 = 77.4 + 32 = 109.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">44° C</td>
   <td class="s_row_text" align="center">118° F</td>
   <td class="s_row_text" align="center">111.2° F</td>
   <td class="s_row_text" align="center">111.2 °F</td>

   <td class="s_row_text" align="center">44° C * 2 = 88 - 8.8 = 79.2 + 32 = 111.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">45° C</td>
   <td class="s_row_text" align="center">120° F</td>
   <td class="s_row_text" align="center">113° F</td>
   <td class="s_row_text" align="center">113 °F</td>

   <td class="s_row_text" align="center">45° C * 2 = 90 - 9 = 81 + 32 = 113° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">46° C</td>
   <td class="s_row_text" align="center">122° F</td>
   <td class="s_row_text" align="center">114.8° F</td>
   <td class="s_row_text" align="center">114.8 °F</td>

   <td class="s_row_text" align="center">46° C * 2 = 92 - 9.2 = 82.8 + 32 = 114.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">47° C</td>
   <td class="s_row_text" align="center">124° F</td>
   <td class="s_row_text" align="center">116.6° F</td>
   <td class="s_row_text" align="center">116.6 °F</td>

   <td class="s_row_text" align="center">47° C * 2 = 94 - 9.4 = 84.6 + 32 = 116.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">48° C</td>
   <td class="s_row_text" align="center">126° F</td>
   <td class="s_row_text" align="center">118.4° F</td>
   <td class="s_row_text" align="center">118.4 °F</td>

   <td class="s_row_text" align="center">48° C * 2 = 96 - 9.6 = 86.4 + 32 = 118.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">49° C</td>
   <td class="s_row_text" align="center">128° F</td>
   <td class="s_row_text" align="center">120.2° F</td>
   <td class="s_row_text" align="center">120.2 °F</td>

   <td class="s_row_text" align="center">49° C * 2 = 98 - 9.8 = 88.2 + 32 = 120.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">50° C</td>
   <td class="s_row_text" align="center">130° F</td>
   <td class="s_row_text" align="center">122° F</td>
   <td class="s_row_text" align="center">122 °F</td>

   <td class="s_row_text" align="center">50° C * 2 = 100 - 10 = 90 + 32 = 122° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">51° C</td>
   <td class="s_row_text" align="center">132° F</td>
   <td class="s_row_text" align="center">123.8° F</td>
   <td class="s_row_text" align="center">123.8 °F</td>

   <td class="s_row_text" align="center">51° C * 2 = 102 - 10.2 = 91.8 + 32 = 123.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">52° C</td>
   <td class="s_row_text" align="center">134° F</td>
   <td class="s_row_text" align="center">125.6° F</td>
   <td class="s_row_text" align="center">125.6 °F</td>

   <td class="s_row_text" align="center">52° C * 2 = 104 - 10.4 = 93.6 + 32 = 125.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">53° C</td>
   <td class="s_row_text" align="center">136° F</td>
   <td class="s_row_text" align="center">127.4° F</td>
   <td class="s_row_text" align="center">127.4 °F</td>

   <td class="s_row_text" align="center">53° C * 2 = 106 - 10.6 = 95.4 + 32 = 127.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">54° C</td>
   <td class="s_row_text" align="center">138° F</td>
   <td class="s_row_text" align="center">129.2° F</td>
   <td class="s_row_text" align="center">129.2 °F</td>

   <td class="s_row_text" align="center">54° C * 2 = 108 - 10.8 = 97.2 + 32 = 129.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">55° C</td>
   <td class="s_row_text" align="center">140° F</td>
   <td class="s_row_text" align="center">131° F</td>
   <td class="s_row_text" align="center">131 °F</td>

   <td class="s_row_text" align="center">55° C * 2 = 110 - 11 = 99 + 32 = 131° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">56° C</td>
   <td class="s_row_text" align="center">142° F</td>
   <td class="s_row_text" align="center">132.8° F</td>
   <td class="s_row_text" align="center">132.8 °F</td>

   <td class="s_row_text" align="center">56° C * 2 = 112 - 11.2 = 100.8 + 32 = 132.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">57° C</td>
   <td class="s_row_text" align="center">144° F</td>
   <td class="s_row_text" align="center">134.6° F</td>
   <td class="s_row_text" align="center">134.6 °F</td>

   <td class="s_row_text" align="center">57° C * 2 = 114 - 11.4 = 102.6 + 32 = 134.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">58° C</td>
   <td class="s_row_text" align="center">146° F</td>
   <td class="s_row_text" align="center">136.4° F</td>
   <td class="s_row_text" align="center">136.4 °F</td>

   <td class="s_row_text" align="center">58° C * 2 = 116 - 11.6 = 104.4 + 32 = 136.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">59° C</td>
   <td class="s_row_text" align="center">148° F</td>
   <td class="s_row_text" align="center">138.2° F</td>
   <td class="s_row_text" align="center">138.2 °F</td>

   <td class="s_row_text" align="center">59° C * 2 = 118 - 11.8 = 106.2 + 32 = 138.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">60° C</td>
   <td class="s_row_text" align="center">150° F</td>
   <td class="s_row_text" align="center">140° F</td>
   <td class="s_row_text" align="center">140 °F</td>

   <td class="s_row_text" align="center">60° C * 2 = 120 - 12 = 108 + 32 = 140° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">61° C</td>
   <td class="s_row_text" align="center">152° F</td>
   <td class="s_row_text" align="center">141.8° F</td>
   <td class="s_row_text" align="center">141.8 °F</td>

   <td class="s_row_text" align="center">61° C * 2 = 122 - 12.2 = 109.8 + 32 = 141.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">62° C</td>
   <td class="s_row_text" align="center">154° F</td>
   <td class="s_row_text" align="center">143.6° F</td>
   <td class="s_row_text" align="center">143.6 °F</td>

   <td class="s_row_text" align="center">62° C * 2 = 124 - 12.4 = 111.6 + 32 = 143.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">63° C</td>
   <td class="s_row_text" align="center">156° F</td>
   <td class="s_row_text" align="center">145.4° F</td>
   <td class="s_row_text" align="center">145.4 °F</td>

   <td class="s_row_text" align="center">63° C * 2 = 126 - 12.6 = 113.4 + 32 = 145.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">64° C</td>
   <td class="s_row_text" align="center">158° F</td>
   <td class="s_row_text" align="center">147.2° F</td>
   <td class="s_row_text" align="center">147.2 °F</td>

   <td class="s_row_text" align="center">64° C * 2 = 128 - 12.8 = 115.2 + 32 = 147.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">65° C</td>
   <td class="s_row_text" align="center">160° F</td>
   <td class="s_row_text" align="center">149° F</td>
   <td class="s_row_text" align="center">149 °F</td>

   <td class="s_row_text" align="center">65° C * 2 = 130 - 13 = 117 + 32 = 149° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">66° C</td>
   <td class="s_row_text" align="center">162° F</td>
   <td class="s_row_text" align="center">150.8° F</td>
   <td class="s_row_text" align="center">150.8 °F</td>

   <td class="s_row_text" align="center">66° C * 2 = 132 - 13.2 = 118.8 + 32 = 150.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">67° C</td>
   <td class="s_row_text" align="center">164° F</td>
   <td class="s_row_text" align="center">152.6° F</td>
   <td class="s_row_text" align="center">152.6 °F</td>

   <td class="s_row_text" align="center">67° C * 2 = 134 - 13.4 = 120.6 + 32 = 152.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">68° C</td>
   <td class="s_row_text" align="center">166° F</td>
   <td class="s_row_text" align="center">154.4° F</td>
   <td class="s_row_text" align="center">154.4 °F</td>

   <td class="s_row_text" align="center">68° C * 2 = 136 - 13.6 = 122.4 + 32 = 154.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">69° C</td>
   <td class="s_row_text" align="center">168° F</td>
   <td class="s_row_text" align="center">156.2° F</td>
   <td class="s_row_text" align="center">156.2 °F</td>

   <td class="s_row_text" align="center">69° C * 2 = 138 - 13.8 = 124.2 + 32 = 156.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">70° C</td>
   <td class="s_row_text" align="center">170° F</td>
   <td class="s_row_text" align="center">158° F</td>
   <td class="s_row_text" align="center">158 °F</td>

   <td class="s_row_text" align="center">70° C * 2 = 140 - 14 = 126 + 32 = 158° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">71° C</td>
   <td class="s_row_text" align="center">172° F</td>
   <td class="s_row_text" align="center">159.8° F</td>
   <td class="s_row_text" align="center">159.8 °F</td>

   <td class="s_row_text" align="center">71° C * 2 = 142 - 14.2 = 127.8 + 32 = 159.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">72° C</td>
   <td class="s_row_text" align="center">174° F</td>
   <td class="s_row_text" align="center">161.6° F</td>
   <td class="s_row_text" align="center">161.6 °F</td>

   <td class="s_row_text" align="center">72° C * 2 = 144 - 14.4 = 129.6 + 32 = 161.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">73° C</td>
   <td class="s_row_text" align="center">176° F</td>
   <td class="s_row_text" align="center">163.4° F</td>
   <td class="s_row_text" align="center">163.4 °F</td>

   <td class="s_row_text" align="center">73° C * 2 = 146 - 14.6 = 131.4 + 32 = 163.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">74° C</td>
   <td class="s_row_text" align="center">178° F</td>
   <td class="s_row_text" align="center">165.2° F</td>
   <td class="s_row_text" align="center">165.2 °F</td>

   <td class="s_row_text" align="center">74° C * 2 = 148 - 14.8 = 133.2 + 32 = 165.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">75° C</td>
   <td class="s_row_text" align="center">180° F</td>
   <td class="s_row_text" align="center">167° F</td>
   <td class="s_row_text" align="center">167 °F</td>

   <td class="s_row_text" align="center">75° C * 2 = 150 - 15 = 135 + 32 = 167° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">76° C</td>
   <td class="s_row_text" align="center">182° F</td>
   <td class="s_row_text" align="center">168.8° F</td>
   <td class="s_row_text" align="center">168.8 °F</td>

   <td class="s_row_text" align="center">76° C * 2 = 152 - 15.2 = 136.8 + 32 = 168.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">77° C</td>
   <td class="s_row_text" align="center">184° F</td>
   <td class="s_row_text" align="center">170.6° F</td>
   <td class="s_row_text" align="center">170.6 °F</td>

   <td class="s_row_text" align="center">77° C * 2 = 154 - 15.4 = 138.6 + 32 = 170.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">78° C</td>
   <td class="s_row_text" align="center">186° F</td>
   <td class="s_row_text" align="center">172.4° F</td>
   <td class="s_row_text" align="center">172.4 °F</td>

   <td class="s_row_text" align="center">78° C * 2 = 156 - 15.6 = 140.4 + 32 = 172.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">79° C</td>
   <td class="s_row_text" align="center">188° F</td>
   <td class="s_row_text" align="center">174.2° F</td>
   <td class="s_row_text" align="center">174.2 °F</td>

   <td class="s_row_text" align="center">79° C * 2 = 158 - 15.8 = 142.2 + 32 = 174.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">80° C</td>
   <td class="s_row_text" align="center">190° F</td>
   <td class="s_row_text" align="center">176° F</td>
   <td class="s_row_text" align="center">176 °F</td>

   <td class="s_row_text" align="center">80° C * 2 = 160 - 16 = 144 + 32 = 176° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">81° C</td>
   <td class="s_row_text" align="center">192° F</td>
   <td class="s_row_text" align="center">177.8° F</td>
   <td class="s_row_text" align="center">177.8 °F</td>

   <td class="s_row_text" align="center">81° C * 2 = 162 - 16.2 = 145.8 + 32 = 177.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">82° C</td>
   <td class="s_row_text" align="center">194° F</td>
   <td class="s_row_text" align="center">179.6° F</td>
   <td class="s_row_text" align="center">179.6 °F</td>

   <td class="s_row_text" align="center">82° C * 2 = 164 - 16.4 = 147.6 + 32 = 179.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">83° C</td>
   <td class="s_row_text" align="center">196° F</td>
   <td class="s_row_text" align="center">181.4° F</td>
   <td class="s_row_text" align="center">181.4 °F</td>

   <td class="s_row_text" align="center">83° C * 2 = 166 - 16.6 = 149.4 + 32 = 181.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">84° C</td>
   <td class="s_row_text" align="center">198° F</td>
   <td class="s_row_text" align="center">183.2° F</td>
   <td class="s_row_text" align="center">183.2 °F</td>

   <td class="s_row_text" align="center">84° C * 2 = 168 - 16.8 = 151.2 + 32 = 183.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">85° C</td>
   <td class="s_row_text" align="center">200° F</td>
   <td class="s_row_text" align="center">185° F</td>
   <td class="s_row_text" align="center">185 °F</td>

   <td class="s_row_text" align="center">85° C * 2 = 170 - 17 = 153 + 32 = 185° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">86° C</td>
   <td class="s_row_text" align="center">202° F</td>
   <td class="s_row_text" align="center">186.8° F</td>
   <td class="s_row_text" align="center">186.8 °F</td>

   <td class="s_row_text" align="center">86° C * 2 = 172 - 17.2 = 154.8 + 32 = 186.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">87° C</td>
   <td class="s_row_text" align="center">204° F</td>
   <td class="s_row_text" align="center">188.6° F</td>
   <td class="s_row_text" align="center">188.6 °F</td>

   <td class="s_row_text" align="center">87° C * 2 = 174 - 17.4 = 156.6 + 32 = 188.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">88° C</td>
   <td class="s_row_text" align="center">206° F</td>
   <td class="s_row_text" align="center">190.4° F</td>
   <td class="s_row_text" align="center">190.4 °F</td>

   <td class="s_row_text" align="center">88° C * 2 = 176 - 17.6 = 158.4 + 32 = 190.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">89° C</td>
   <td class="s_row_text" align="center">208° F</td>
   <td class="s_row_text" align="center">192.2° F</td>
   <td class="s_row_text" align="center">192.2 °F</td>

   <td class="s_row_text" align="center">89° C * 2 = 178 - 17.8 = 160.2 + 32 = 192.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">90° C</td>
   <td class="s_row_text" align="center">210° F</td>
   <td class="s_row_text" align="center">194° F</td>
   <td class="s_row_text" align="center">194 °F</td>

   <td class="s_row_text" align="center">90° C * 2 = 180 - 18 = 162 + 32 = 194° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">91° C</td>
   <td class="s_row_text" align="center">212° F</td>
   <td class="s_row_text" align="center">195.8° F</td>
   <td class="s_row_text" align="center">195.8 °F</td>

   <td class="s_row_text" align="center">91° C * 2 = 182 - 18.2 = 163.8 + 32 = 195.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">92° C</td>
   <td class="s_row_text" align="center">214° F</td>
   <td class="s_row_text" align="center">197.6° F</td>
   <td class="s_row_text" align="center">197.6 °F</td>

   <td class="s_row_text" align="center">92° C * 2 = 184 - 18.4 = 165.6 + 32 = 197.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">93° C</td>
   <td class="s_row_text" align="center">216° F</td>
   <td class="s_row_text" align="center">199.4° F</td>
   <td class="s_row_text" align="center">199.4 °F</td>

   <td class="s_row_text" align="center">93° C * 2 = 186 - 18.6 = 167.4 + 32 = 199.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">94° C</td>
   <td class="s_row_text" align="center">218° F</td>
   <td class="s_row_text" align="center">201.2° F</td>
   <td class="s_row_text" align="center">201.2 °F</td>

   <td class="s_row_text" align="center">94° C * 2 = 188 - 18.8 = 169.2 + 32 = 201.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">95° C</td>
   <td class="s_row_text" align="center">220° F</td>
   <td class="s_row_text" align="center">203° F</td>
   <td class="s_row_text" align="center">203 °F</td>

   <td class="s_row_text" align="center">95° C * 2 = 190 - 19 = 171 + 32 = 203° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">96° C</td>
   <td class="s_row_text" align="center">222° F</td>
   <td class="s_row_text" align="center">204.8° F</td>
   <td class="s_row_text" align="center">204.8 °F</td>

   <td class="s_row_text" align="center">96° C * 2 = 192 - 19.2 = 172.8 + 32 = 204.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">97° C</td>
   <td class="s_row_text" align="center">224° F</td>
   <td class="s_row_text" align="center">206.6° F</td>
   <td class="s_row_text" align="center">206.6 °F</td>

   <td class="s_row_text" align="center">97° C * 2 = 194 - 19.4 = 174.6 + 32 = 206.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">98° C</td>
   <td class="s_row_text" align="center">226° F</td>
   <td class="s_row_text" align="center">208.4° F</td>
   <td class="s_row_text" align="center">208.4 °F</td>

   <td class="s_row_text" align="center">98° C * 2 = 196 - 19.6 = 176.4 + 32 = 208.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">99° C</td>
   <td class="s_row_text" align="center">228° F</td>
   <td class="s_row_text" align="center">210.2° F</td>
   <td class="s_row_text" align="center">210.2 °F</td>

   <td class="s_row_text" align="center">99° C * 2 = 198 - 19.8 = 178.2 + 32 = 210.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">100° C</td>
   <td class="s_row_text" align="center">230° F</td>
   <td class="s_row_text" align="center">212° F</td>
   <td class="s_row_text" align="center">212 °F</td>

   <td class="s_row_text" align="center">100° C * 2 = 200 - 20 = 180 + 32 = 212° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">101° C</td>
   <td class="s_row_text" align="center">232° F</td>
   <td class="s_row_text" align="center">213.8° F</td>
   <td class="s_row_text" align="center">213.8 °F</td>

   <td class="s_row_text" align="center">101° C * 2 = 202 - 20.2 = 181.8 + 32 = 213.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">102° C</td>
   <td class="s_row_text" align="center">234° F</td>
   <td class="s_row_text" align="center">215.6° F</td>
   <td class="s_row_text" align="center">215.6 °F</td>

   <td class="s_row_text" align="center">102° C * 2 = 204 - 20.4 = 183.6 + 32 = 215.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">103° C</td>
   <td class="s_row_text" align="center">236° F</td>
   <td class="s_row_text" align="center">217.4° F</td>
   <td class="s_row_text" align="center">217.4 °F</td>

   <td class="s_row_text" align="center">103° C * 2 = 206 - 20.6 = 185.4 + 32 = 217.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">104° C</td>
   <td class="s_row_text" align="center">238° F</td>
   <td class="s_row_text" align="center">219.2° F</td>
   <td class="s_row_text" align="center">219.2 °F</td>

   <td class="s_row_text" align="center">104° C * 2 = 208 - 20.8 = 187.2 + 32 = 219.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">105° C</td>
   <td class="s_row_text" align="center">240° F</td>
   <td class="s_row_text" align="center">221° F</td>
   <td class="s_row_text" align="center">221 °F</td>

   <td class="s_row_text" align="center">105° C * 2 = 210 - 21 = 189 + 32 = 221° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">106° C</td>
   <td class="s_row_text" align="center">242° F</td>
   <td class="s_row_text" align="center">222.8° F</td>
   <td class="s_row_text" align="center">222.8 °F</td>

   <td class="s_row_text" align="center">106° C * 2 = 212 - 21.2 = 190.8 + 32 = 222.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">107° C</td>
   <td class="s_row_text" align="center">244° F</td>
   <td class="s_row_text" align="center">224.6° F</td>
   <td class="s_row_text" align="center">224.6 °F</td>

   <td class="s_row_text" align="center">107° C * 2 = 214 - 21.4 = 192.6 + 32 = 224.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">108° C</td>
   <td class="s_row_text" align="center">246° F</td>
   <td class="s_row_text" align="center">226.4° F</td>
   <td class="s_row_text" align="center">226.4 °F</td>

   <td class="s_row_text" align="center">108° C * 2 = 216 - 21.6 = 194.4 + 32 = 226.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">109° C</td>
   <td class="s_row_text" align="center">248° F</td>
   <td class="s_row_text" align="center">228.2° F</td>
   <td class="s_row_text" align="center">228.2 °F</td>

   <td class="s_row_text" align="center">109° C * 2 = 218 - 21.8 = 196.2 + 32 = 228.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">110° C</td>
   <td class="s_row_text" align="center">250° F</td>
   <td class="s_row_text" align="center">230° F</td>
   <td class="s_row_text" align="center">230 °F</td>

   <td class="s_row_text" align="center">110° C * 2 = 220 - 22 = 198 + 32 = 230° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">111° C</td>
   <td class="s_row_text" align="center">252° F</td>
   <td class="s_row_text" align="center">231.8° F</td>
   <td class="s_row_text" align="center">231.8 °F</td>

   <td class="s_row_text" align="center">111° C * 2 = 222 - 22.2 = 199.8 + 32 = 231.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">112° C</td>
   <td class="s_row_text" align="center">254° F</td>
   <td class="s_row_text" align="center">233.6° F</td>
   <td class="s_row_text" align="center">233.6 °F</td>

   <td class="s_row_text" align="center">112° C * 2 = 224 - 22.4 = 201.6 + 32 = 233.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">113° C</td>
   <td class="s_row_text" align="center">256° F</td>
   <td class="s_row_text" align="center">235.4° F</td>
   <td class="s_row_text" align="center">235.4 °F</td>

   <td class="s_row_text" align="center">113° C * 2 = 226 - 22.6 = 203.4 + 32 = 235.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">114° C</td>
   <td class="s_row_text" align="center">258° F</td>
   <td class="s_row_text" align="center">237.2° F</td>
   <td class="s_row_text" align="center">237.2 °F</td>

   <td class="s_row_text" align="center">114° C * 2 = 228 - 22.8 = 205.2 + 32 = 237.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">115° C</td>
   <td class="s_row_text" align="center">260° F</td>
   <td class="s_row_text" align="center">239° F</td>
   <td class="s_row_text" align="center">239 °F</td>

   <td class="s_row_text" align="center">115° C * 2 = 230 - 23 = 207 + 32 = 239° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">116° C</td>
   <td class="s_row_text" align="center">262° F</td>
   <td class="s_row_text" align="center">240.8° F</td>
   <td class="s_row_text" align="center">240.8 °F</td>

   <td class="s_row_text" align="center">116° C * 2 = 232 - 23.2 = 208.8 + 32 = 240.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">117° C</td>
   <td class="s_row_text" align="center">264° F</td>
   <td class="s_row_text" align="center">242.6° F</td>
   <td class="s_row_text" align="center">242.6 °F</td>

   <td class="s_row_text" align="center">117° C * 2 = 234 - 23.4 = 210.6 + 32 = 242.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">118° C</td>
   <td class="s_row_text" align="center">266° F</td>
   <td class="s_row_text" align="center">244.4° F</td>
   <td class="s_row_text" align="center">244.4 °F</td>

   <td class="s_row_text" align="center">118° C * 2 = 236 - 23.6 = 212.4 + 32 = 244.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">119° C</td>
   <td class="s_row_text" align="center">268° F</td>
   <td class="s_row_text" align="center">246.2° F</td>
   <td class="s_row_text" align="center">246.2 °F</td>

   <td class="s_row_text" align="center">119° C * 2 = 238 - 23.8 = 214.2 + 32 = 246.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">120° C</td>
   <td class="s_row_text" align="center">270° F</td>
   <td class="s_row_text" align="center">248° F</td>
   <td class="s_row_text" align="center">248 °F</td>

   <td class="s_row_text" align="center">120° C * 2 = 240 - 24 = 216 + 32 = 248° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">121° C</td>
   <td class="s_row_text" align="center">272° F</td>
   <td class="s_row_text" align="center">249.8° F</td>
   <td class="s_row_text" align="center">249.8 °F</td>

   <td class="s_row_text" align="center">121° C * 2 = 242 - 24.2 = 217.8 + 32 = 249.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">122° C</td>
   <td class="s_row_text" align="center">274° F</td>
   <td class="s_row_text" align="center">251.6° F</td>
   <td class="s_row_text" align="center">251.6 °F</td>

   <td class="s_row_text" align="center">122° C * 2 = 244 - 24.4 = 219.6 + 32 = 251.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">123° C</td>
   <td class="s_row_text" align="center">276° F</td>
   <td class="s_row_text" align="center">253.4° F</td>
   <td class="s_row_text" align="center">253.4 °F</td>

   <td class="s_row_text" align="center">123° C * 2 = 246 - 24.6 = 221.4 + 32 = 253.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">124° C</td>
   <td class="s_row_text" align="center">278° F</td>
   <td class="s_row_text" align="center">255.2° F</td>
   <td class="s_row_text" align="center">255.2 °F</td>

   <td class="s_row_text" align="center">124° C * 2 = 248 - 24.8 = 223.2 + 32 = 255.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">125° C</td>
   <td class="s_row_text" align="center">280° F</td>
   <td class="s_row_text" align="center">257° F</td>
   <td class="s_row_text" align="center">257 °F</td>

   <td class="s_row_text" align="center">125° C * 2 = 250 - 25 = 225 + 32 = 257° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">126° C</td>
   <td class="s_row_text" align="center">282° F</td>
   <td class="s_row_text" align="center">258.8° F</td>
   <td class="s_row_text" align="center">258.8 °F</td>

   <td class="s_row_text" align="center">126° C * 2 = 252 - 25.2 = 226.8 + 32 = 258.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">127° C</td>
   <td class="s_row_text" align="center">284° F</td>
   <td class="s_row_text" align="center">260.6° F</td>
   <td class="s_row_text" align="center">260.6 °F</td>

   <td class="s_row_text" align="center">127° C * 2 = 254 - 25.4 = 228.6 + 32 = 260.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">128° C</td>
   <td class="s_row_text" align="center">286° F</td>
   <td class="s_row_text" align="center">262.4° F</td>
   <td class="s_row_text" align="center">262.4 °F</td>

   <td class="s_row_text" align="center">128° C * 2 = 256 - 25.6 = 230.4 + 32 = 262.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">129° C</td>
   <td class="s_row_text" align="center">288° F</td>
   <td class="s_row_text" align="center">264.2° F</td>
   <td class="s_row_text" align="center">264.2 °F</td>

   <td class="s_row_text" align="center">129° C * 2 = 258 - 25.8 = 232.2 + 32 = 264.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">130° C</td>
   <td class="s_row_text" align="center">290° F</td>
   <td class="s_row_text" align="center">266° F</td>
   <td class="s_row_text" align="center">266 °F</td>

   <td class="s_row_text" align="center">130° C * 2 = 260 - 26 = 234 + 32 = 266° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">131° C</td>
   <td class="s_row_text" align="center">292° F</td>
   <td class="s_row_text" align="center">267.8° F</td>
   <td class="s_row_text" align="center">267.8 °F</td>

   <td class="s_row_text" align="center">131° C * 2 = 262 - 26.2 = 235.8 + 32 = 267.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">132° C</td>
   <td class="s_row_text" align="center">294° F</td>
   <td class="s_row_text" align="center">269.6° F</td>
   <td class="s_row_text" align="center">269.6 °F</td>

   <td class="s_row_text" align="center">132° C * 2 = 264 - 26.4 = 237.6 + 32 = 269.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">133° C</td>
   <td class="s_row_text" align="center">296° F</td>
   <td class="s_row_text" align="center">271.4° F</td>
   <td class="s_row_text" align="center">271.4 °F</td>

   <td class="s_row_text" align="center">133° C * 2 = 266 - 26.6 = 239.4 + 32 = 271.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">134° C</td>
   <td class="s_row_text" align="center">298° F</td>
   <td class="s_row_text" align="center">273.2° F</td>
   <td class="s_row_text" align="center">273.2 °F</td>

   <td class="s_row_text" align="center">134° C * 2 = 268 - 26.8 = 241.2 + 32 = 273.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">135° C</td>
   <td class="s_row_text" align="center">300° F</td>
   <td class="s_row_text" align="center">275° F</td>
   <td class="s_row_text" align="center">275 °F</td>

   <td class="s_row_text" align="center">135° C * 2 = 270 - 27 = 243 + 32 = 275° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">136° C</td>
   <td class="s_row_text" align="center">302° F</td>
   <td class="s_row_text" align="center">276.8° F</td>
   <td class="s_row_text" align="center">276.8 °F</td>

   <td class="s_row_text" align="center">136° C * 2 = 272 - 27.2 = 244.8 + 32 = 276.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">137° C</td>
   <td class="s_row_text" align="center">304° F</td>
   <td class="s_row_text" align="center">278.6° F</td>
   <td class="s_row_text" align="center">278.6 °F</td>

   <td class="s_row_text" align="center">137° C * 2 = 274 - 27.4 = 246.6 + 32 = 278.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">138° C</td>
   <td class="s_row_text" align="center">306° F</td>
   <td class="s_row_text" align="center">280.4° F</td>
   <td class="s_row_text" align="center">280.4 °F</td>

   <td class="s_row_text" align="center">138° C * 2 = 276 - 27.6 = 248.4 + 32 = 280.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">139° C</td>
   <td class="s_row_text" align="center">308° F</td>
   <td class="s_row_text" align="center">282.2° F</td>
   <td class="s_row_text" align="center">282.2 °F</td>

   <td class="s_row_text" align="center">139° C * 2 = 278 - 27.8 = 250.2 + 32 = 282.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">140° C</td>
   <td class="s_row_text" align="center">310° F</td>
   <td class="s_row_text" align="center">284° F</td>
   <td class="s_row_text" align="center">284 °F</td>

   <td class="s_row_text" align="center">140° C * 2 = 280 - 28 = 252 + 32 = 284° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">141° C</td>
   <td class="s_row_text" align="center">312° F</td>
   <td class="s_row_text" align="center">285.8° F</td>
   <td class="s_row_text" align="center">285.8 °F</td>

   <td class="s_row_text" align="center">141° C * 2 = 282 - 28.2 = 253.8 + 32 = 285.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">142° C</td>
   <td class="s_row_text" align="center">314° F</td>
   <td class="s_row_text" align="center">287.6° F</td>
   <td class="s_row_text" align="center">287.6 °F</td>

   <td class="s_row_text" align="center">142° C * 2 = 284 - 28.4 = 255.6 + 32 = 287.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">143° C</td>
   <td class="s_row_text" align="center">316° F</td>
   <td class="s_row_text" align="center">289.4° F</td>
   <td class="s_row_text" align="center">289.4 °F</td>

   <td class="s_row_text" align="center">143° C * 2 = 286 - 28.6 = 257.4 + 32 = 289.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">144° C</td>
   <td class="s_row_text" align="center">318° F</td>
   <td class="s_row_text" align="center">291.2° F</td>
   <td class="s_row_text" align="center">291.2 °F</td>

   <td class="s_row_text" align="center">144° C * 2 = 288 - 28.8 = 259.2 + 32 = 291.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">145° C</td>
   <td class="s_row_text" align="center">320° F</td>
   <td class="s_row_text" align="center">293° F</td>
   <td class="s_row_text" align="center">293 °F</td>

   <td class="s_row_text" align="center">145° C * 2 = 290 - 29 = 261 + 32 = 293° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">146° C</td>
   <td class="s_row_text" align="center">322° F</td>
   <td class="s_row_text" align="center">294.8° F</td>
   <td class="s_row_text" align="center">294.8 °F</td>

   <td class="s_row_text" align="center">146° C * 2 = 292 - 29.2 = 262.8 + 32 = 294.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">147° C</td>
   <td class="s_row_text" align="center">324° F</td>
   <td class="s_row_text" align="center">296.6° F</td>
   <td class="s_row_text" align="center">296.6 °F</td>

   <td class="s_row_text" align="center">147° C * 2 = 294 - 29.4 = 264.6 + 32 = 296.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">148° C</td>
   <td class="s_row_text" align="center">326° F</td>
   <td class="s_row_text" align="center">298.4° F</td>
   <td class="s_row_text" align="center">298.4 °F</td>

   <td class="s_row_text" align="center">148° C * 2 = 296 - 29.6 = 266.4 + 32 = 298.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">149° C</td>
   <td class="s_row_text" align="center">328° F</td>
   <td class="s_row_text" align="center">300.2° F</td>
   <td class="s_row_text" align="center">300.2 °F</td>

   <td class="s_row_text" align="center">149° C * 2 = 298 - 29.8 = 268.2 + 32 = 300.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">150° C</td>
   <td class="s_row_text" align="center">330° F</td>
   <td class="s_row_text" align="center">302° F</td>
   <td class="s_row_text" align="center">302 °F</td>

   <td class="s_row_text" align="center">150° C * 2 = 300 - 30 = 270 + 32 = 302° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">151° C</td>
   <td class="s_row_text" align="center">332° F</td>
   <td class="s_row_text" align="center">303.8° F</td>
   <td class="s_row_text" align="center">303.8 °F</td>

   <td class="s_row_text" align="center">151° C * 2 = 302 - 30.2 = 271.8 + 32 = 303.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">152° C</td>
   <td class="s_row_text" align="center">334° F</td>
   <td class="s_row_text" align="center">305.6° F</td>
   <td class="s_row_text" align="center">305.6 °F</td>

   <td class="s_row_text" align="center">152° C * 2 = 304 - 30.4 = 273.6 + 32 = 305.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">153° C</td>
   <td class="s_row_text" align="center">336° F</td>
   <td class="s_row_text" align="center">307.4° F</td>
   <td class="s_row_text" align="center">307.4 °F</td>

   <td class="s_row_text" align="center">153° C * 2 = 306 - 30.6 = 275.4 + 32 = 307.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">154° C</td>
   <td class="s_row_text" align="center">338° F</td>
   <td class="s_row_text" align="center">309.2° F</td>
   <td class="s_row_text" align="center">309.2 °F</td>

   <td class="s_row_text" align="center">154° C * 2 = 308 - 30.8 = 277.2 + 32 = 309.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">155° C</td>
   <td class="s_row_text" align="center">340° F</td>
   <td class="s_row_text" align="center">311° F</td>
   <td class="s_row_text" align="center">311 °F</td>

   <td class="s_row_text" align="center">155° C * 2 = 310 - 31 = 279 + 32 = 311° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">156° C</td>
   <td class="s_row_text" align="center">342° F</td>
   <td class="s_row_text" align="center">312.8° F</td>
   <td class="s_row_text" align="center">312.8 °F</td>

   <td class="s_row_text" align="center">156° C * 2 = 312 - 31.2 = 280.8 + 32 = 312.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">157° C</td>
   <td class="s_row_text" align="center">344° F</td>
   <td class="s_row_text" align="center">314.6° F</td>
   <td class="s_row_text" align="center">314.6 °F</td>

   <td class="s_row_text" align="center">157° C * 2 = 314 - 31.4 = 282.6 + 32 = 314.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">158° C</td>
   <td class="s_row_text" align="center">346° F</td>
   <td class="s_row_text" align="center">316.4° F</td>
   <td class="s_row_text" align="center">316.4 °F</td>

   <td class="s_row_text" align="center">158° C * 2 = 316 - 31.6 = 284.4 + 32 = 316.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">159° C</td>
   <td class="s_row_text" align="center">348° F</td>
   <td class="s_row_text" align="center">318.2° F</td>
   <td class="s_row_text" align="center">318.2 °F</td>

   <td class="s_row_text" align="center">159° C * 2 = 318 - 31.8 = 286.2 + 32 = 318.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">160° C</td>
   <td class="s_row_text" align="center">350° F</td>
   <td class="s_row_text" align="center">320° F</td>
   <td class="s_row_text" align="center">320 °F</td>

   <td class="s_row_text" align="center">160° C * 2 = 320 - 32 = 288 + 32 = 320° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">161° C</td>
   <td class="s_row_text" align="center">352° F</td>
   <td class="s_row_text" align="center">321.8° F</td>
   <td class="s_row_text" align="center">321.8 °F</td>

   <td class="s_row_text" align="center">161° C * 2 = 322 - 32.2 = 289.8 + 32 = 321.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">162° C</td>
   <td class="s_row_text" align="center">354° F</td>
   <td class="s_row_text" align="center">323.6° F</td>
   <td class="s_row_text" align="center">323.6 °F</td>

   <td class="s_row_text" align="center">162° C * 2 = 324 - 32.4 = 291.6 + 32 = 323.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">163° C</td>
   <td class="s_row_text" align="center">356° F</td>
   <td class="s_row_text" align="center">325.4° F</td>
   <td class="s_row_text" align="center">325.4 °F</td>

   <td class="s_row_text" align="center">163° C * 2 = 326 - 32.6 = 293.4 + 32 = 325.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">164° C</td>
   <td class="s_row_text" align="center">358° F</td>
   <td class="s_row_text" align="center">327.2° F</td>
   <td class="s_row_text" align="center">327.2 °F</td>

   <td class="s_row_text" align="center">164° C * 2 = 328 - 32.8 = 295.2 + 32 = 327.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">165° C</td>
   <td class="s_row_text" align="center">360° F</td>
   <td class="s_row_text" align="center">329° F</td>
   <td class="s_row_text" align="center">329 °F</td>

   <td class="s_row_text" align="center">165° C * 2 = 330 - 33 = 297 + 32 = 329° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">166° C</td>
   <td class="s_row_text" align="center">362° F</td>
   <td class="s_row_text" align="center">330.8° F</td>
   <td class="s_row_text" align="center">330.8 °F</td>

   <td class="s_row_text" align="center">166° C * 2 = 332 - 33.2 = 298.8 + 32 = 330.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">167° C</td>
   <td class="s_row_text" align="center">364° F</td>
   <td class="s_row_text" align="center">332.6° F</td>
   <td class="s_row_text" align="center">332.6 °F</td>

   <td class="s_row_text" align="center">167° C * 2 = 334 - 33.4 = 300.6 + 32 = 332.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">168° C</td>
   <td class="s_row_text" align="center">366° F</td>
   <td class="s_row_text" align="center">334.4° F</td>
   <td class="s_row_text" align="center">334.4 °F</td>

   <td class="s_row_text" align="center">168° C * 2 = 336 - 33.6 = 302.4 + 32 = 334.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">169° C</td>
   <td class="s_row_text" align="center">368° F</td>
   <td class="s_row_text" align="center">336.2° F</td>
   <td class="s_row_text" align="center">336.2 °F</td>

   <td class="s_row_text" align="center">169° C * 2 = 338 - 33.8 = 304.2 + 32 = 336.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">170° C</td>
   <td class="s_row_text" align="center">370° F</td>
   <td class="s_row_text" align="center">338° F</td>
   <td class="s_row_text" align="center">338 °F</td>

   <td class="s_row_text" align="center">170° C * 2 = 340 - 34 = 306 + 32 = 338° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">171° C</td>
   <td class="s_row_text" align="center">372° F</td>
   <td class="s_row_text" align="center">339.8° F</td>
   <td class="s_row_text" align="center">339.8 °F</td>

   <td class="s_row_text" align="center">171° C * 2 = 342 - 34.2 = 307.8 + 32 = 339.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">172° C</td>
   <td class="s_row_text" align="center">374° F</td>
   <td class="s_row_text" align="center">341.6° F</td>
   <td class="s_row_text" align="center">341.6 °F</td>

   <td class="s_row_text" align="center">172° C * 2 = 344 - 34.4 = 309.6 + 32 = 341.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">173° C</td>
   <td class="s_row_text" align="center">376° F</td>
   <td class="s_row_text" align="center">343.4° F</td>
   <td class="s_row_text" align="center">343.4 °F</td>

   <td class="s_row_text" align="center">173° C * 2 = 346 - 34.6 = 311.4 + 32 = 343.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">174° C</td>
   <td class="s_row_text" align="center">378° F</td>
   <td class="s_row_text" align="center">345.2° F</td>
   <td class="s_row_text" align="center">345.2 °F</td>

   <td class="s_row_text" align="center">174° C * 2 = 348 - 34.8 = 313.2 + 32 = 345.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">175° C</td>
   <td class="s_row_text" align="center">380° F</td>
   <td class="s_row_text" align="center">347° F</td>
   <td class="s_row_text" align="center">347 °F</td>

   <td class="s_row_text" align="center">175° C * 2 = 350 - 35 = 315 + 32 = 347° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">176° C</td>
   <td class="s_row_text" align="center">382° F</td>
   <td class="s_row_text" align="center">348.8° F</td>
   <td class="s_row_text" align="center">348.8 °F</td>

   <td class="s_row_text" align="center">176° C * 2 = 352 - 35.2 = 316.8 + 32 = 348.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">177° C</td>
   <td class="s_row_text" align="center">384° F</td>
   <td class="s_row_text" align="center">350.6° F</td>
   <td class="s_row_text" align="center">350.6 °F</td>

   <td class="s_row_text" align="center">177° C * 2 = 354 - 35.4 = 318.6 + 32 = 350.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">178° C</td>
   <td class="s_row_text" align="center">386° F</td>
   <td class="s_row_text" align="center">352.4° F</td>
   <td class="s_row_text" align="center">352.4 °F</td>

   <td class="s_row_text" align="center">178° C * 2 = 356 - 35.6 = 320.4 + 32 = 352.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">179° C</td>
   <td class="s_row_text" align="center">388° F</td>
   <td class="s_row_text" align="center">354.2° F</td>
   <td class="s_row_text" align="center">354.2 °F</td>

   <td class="s_row_text" align="center">179° C * 2 = 358 - 35.8 = 322.2 + 32 = 354.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">180° C</td>
   <td class="s_row_text" align="center">390° F</td>
   <td class="s_row_text" align="center">356° F</td>
   <td class="s_row_text" align="center">356 °F</td>

   <td class="s_row_text" align="center">180° C * 2 = 360 - 36 = 324 + 32 = 356° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">181° C</td>
   <td class="s_row_text" align="center">392° F</td>
   <td class="s_row_text" align="center">357.8° F</td>
   <td class="s_row_text" align="center">357.8 °F</td>

   <td class="s_row_text" align="center">181° C * 2 = 362 - 36.2 = 325.8 + 32 = 357.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">182° C</td>
   <td class="s_row_text" align="center">394° F</td>
   <td class="s_row_text" align="center">359.6° F</td>
   <td class="s_row_text" align="center">359.6 °F</td>

   <td class="s_row_text" align="center">182° C * 2 = 364 - 36.4 = 327.6 + 32 = 359.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">183° C</td>
   <td class="s_row_text" align="center">396° F</td>
   <td class="s_row_text" align="center">361.4° F</td>
   <td class="s_row_text" align="center">361.4 °F</td>

   <td class="s_row_text" align="center">183° C * 2 = 366 - 36.6 = 329.4 + 32 = 361.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">184° C</td>
   <td class="s_row_text" align="center">398° F</td>
   <td class="s_row_text" align="center">363.2° F</td>
   <td class="s_row_text" align="center">363.2 °F</td>

   <td class="s_row_text" align="center">184° C * 2 = 368 - 36.8 = 331.2 + 32 = 363.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">185° C</td>
   <td class="s_row_text" align="center">400° F</td>
   <td class="s_row_text" align="center">365° F</td>
   <td class="s_row_text" align="center">365 °F</td>

   <td class="s_row_text" align="center">185° C * 2 = 370 - 37 = 333 + 32 = 365° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">186° C</td>
   <td class="s_row_text" align="center">402° F</td>
   <td class="s_row_text" align="center">366.8° F</td>
   <td class="s_row_text" align="center">366.8 °F</td>

   <td class="s_row_text" align="center">186° C * 2 = 372 - 37.2 = 334.8 + 32 = 366.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">187° C</td>
   <td class="s_row_text" align="center">404° F</td>
   <td class="s_row_text" align="center">368.6° F</td>
   <td class="s_row_text" align="center">368.6 °F</td>

   <td class="s_row_text" align="center">187° C * 2 = 374 - 37.4 = 336.6 + 32 = 368.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">188° C</td>
   <td class="s_row_text" align="center">406° F</td>
   <td class="s_row_text" align="center">370.4° F</td>
   <td class="s_row_text" align="center">370.4 °F</td>

   <td class="s_row_text" align="center">188° C * 2 = 376 - 37.6 = 338.4 + 32 = 370.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">189° C</td>
   <td class="s_row_text" align="center">408° F</td>
   <td class="s_row_text" align="center">372.2° F</td>
   <td class="s_row_text" align="center">372.2 °F</td>

   <td class="s_row_text" align="center">189° C * 2 = 378 - 37.8 = 340.2 + 32 = 372.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">190° C</td>
   <td class="s_row_text" align="center">410° F</td>
   <td class="s_row_text" align="center">374° F</td>
   <td class="s_row_text" align="center">374 °F</td>

   <td class="s_row_text" align="center">190° C * 2 = 380 - 38 = 342 + 32 = 374° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">191° C</td>
   <td class="s_row_text" align="center">412° F</td>
   <td class="s_row_text" align="center">375.8° F</td>
   <td class="s_row_text" align="center">375.8 °F</td>

   <td class="s_row_text" align="center">191° C * 2 = 382 - 38.2 = 343.8 + 32 = 375.8° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">192° C</td>
   <td class="s_row_text" align="center">414° F</td>
   <td class="s_row_text" align="center">377.6° F</td>
   <td class="s_row_text" align="center">377.6 °F</td>

   <td class="s_row_text" align="center">192° C * 2 = 384 - 38.4 = 345.6 + 32 = 377.6° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">193° C</td>
   <td class="s_row_text" align="center">416° F</td>
   <td class="s_row_text" align="center">379.4° F</td>
   <td class="s_row_text" align="center">379.4 °F</td>

   <td class="s_row_text" align="center">193° C * 2 = 386 - 38.6 = 347.4 + 32 = 379.4° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">194° C</td>
   <td class="s_row_text" align="center">418° F</td>
   <td class="s_row_text" align="center">381.2° F</td>
   <td class="s_row_text" align="center">381.2 °F</td>

   <td class="s_row_text" align="center">194° C * 2 = 388 - 38.8 = 349.2 + 32 = 381.2° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">195° C</td>
   <td class="s_row_text" align="center">420° F</td>
   <td class="s_row_text" align="center">383° F</td>
   <td class="s_row_text" align="center">383 °F</td>

   <td class="s_row_text" align="center">195° C * 2 = 390 - 39 = 351 + 32 = 383° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">196° C</td>
   <td class="s_row_text" align="center">422° F</td>
   <td class="s_row_text" align="center">384.8° F</td>
   <td class="s_row_text" align="center">384.8 °F</td>

   <td class="s_row_text" align="center">196° C * 2 = 392 - 39.2 = 352.8 + 32 = 384.8° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">197° C</td>
   <td class="s_row_text" align="center">424° F</td>
   <td class="s_row_text" align="center">386.6° F</td>
   <td class="s_row_text" align="center">386.6 °F</td>

   <td class="s_row_text" align="center">197° C * 2 = 394 - 39.4 = 354.6 + 32 = 386.6° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">198° C</td>
   <td class="s_row_text" align="center">426° F</td>
   <td class="s_row_text" align="center">388.4° F</td>
   <td class="s_row_text" align="center">388.4 °F</td>

   <td class="s_row_text" align="center">198° C * 2 = 396 - 39.6 = 356.4 + 32 = 388.4° F</td>
 </tr>  
 <tr bgcolor="#EAEAEA">
   <td class="s_row_text" align="center">199° C</td>
   <td class="s_row_text" align="center">428° F</td>
   <td class="s_row_text" align="center">390.2° F</td>
   <td class="s_row_text" align="center">390.2 °F</td>

   <td class="s_row_text" align="center">199° C * 2 = 398 - 39.8 = 358.2 + 32 = 390.2° F</td>
 </tr>  
 <tr bgcolor="#F4F4F4">
   <td class="s_row_text" align="center">200° C</td>
   <td class="s_row_text" align="center">430° F</td>
   <td class="s_row_text" align="center">392° F</td>
   <td class="s_row_text" align="center">392 °F</td>

   <td class="s_row_text" align="center">200° C * 2 = 400 - 40 = 360 + 32 = 392° F</td>
 </tr>
```
</table>


