This example is just "Hello world"  
  
Pin 0 (D0) -> RX USB-UART  
Pin 3 (D3) -> TX USB-UART  

```
$ make
$ make load
```
```
$ minicom -b 38400 -D /dev/ttyUSB0
```
You press any key & get "Hello world!". Enjoy!

