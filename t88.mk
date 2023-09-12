INCLUDEPATH=/usr/share/avra

all:
	avra ${PRJNAME}.asm --includepath ${INCLUDEPATH}

load:
	avrdude -p t88 -c usbasp -P usb -v -U flash:w:${PRJNAME}.hex

dump:
	avrdude -p t88 -c usbasp -P usb -v -U flash:r:${@}.hex

clean:
	rm -v ${PRJNAME}.cof
	rm -v ${PRJNAME}.*hex
	rm -v ${PRJNAME}.obj

rmdump:
	rm -v dump.hex

cleanall: clean rmdump
	echo

.PHONY: load dump clean cleanall

