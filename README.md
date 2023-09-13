# board-mh-tiny-examples
Examples of assembly language code for the mh-tiny board (attiny88)

To use the examples you need:
1. board mh-tiny (attiny 88)
2. usb-isp programmer
3. avra
4. avrdude
5. some luck, git, magic & Linux distributive based on Debian or Ubuntu (I prefer Linux Mint)

To install avra & avrdude you need to do ~~magic~~:
$ sudo apt-get install avra
$ sudo apt-get install avrdude

How to try examples?
$ git clone https://github.com/somebyte/board-mh-tiny-examples.git
$ cd board-mh-tiny-examples
choose any example & then
$ cd nn-exmpl
$ make
$ make load 

I hope you became happier now & Good luck my friend.

![mh-tiny](/images/mh-tiny.png)
