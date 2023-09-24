This example is the same "Hello world" as 05-uart.  
It uses the exchange between memory areas X & Y.
  
Pin 0 (D0) -> RX USB-UART  
Pin 3 (D3) -> TX USB-UART  

```
$ make
$ make load
```
```
$ minicom -b 38400 -D /dev/ttyUSB0
```
You press any key & get something else but "Hello world!". Enjoy!

