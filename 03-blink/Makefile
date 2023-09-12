BASEMAKE=../t88.mk
PRJNAME=blink3

include ${BASEMAKE}

blink3_1:
	cp -v blink3_1.asm blink3.asm
	make 

blink3_2:
	cp -v blink3_2.asm blink3.asm
	make

blink3_3:
	cp -v blink3_3.asm blink3.asm
	make

.PHONY: blink3_1 blink3_2 blink3_3 myclean

myclean: clean
	rm -v blink3.asm

override clean: myclean


