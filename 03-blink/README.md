This example has three samples.
The first  one doesn't use a stack. Because this sample demonstrates the problem - if you don't use a stack, you can't use "reti" instruction.  
The second one uses a timer overflow interrupt.  
The third  one uses a timer compare  interrupt.
```
$ make blink3_1
$ make load 
or
$ make blink3_2
$ make load
or 
$ make blink3_3
$ make load 
`````
