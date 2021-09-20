#import "zpallocator.asm"
.eval zpAllocatorInit(List().add(hardwiredPortRegisters))

.macro setColors (backgroundColor, borderColor) {
	setBackgroundColor(backgroundColor)
	setborderColor(borderColor)     
}

.macro setBackgroundColor (backgroundColor) {
	lda backgroundColor
	sta $d020
}

.macro setborderColor (borderColor) {
	lda borderColor
	sta $d021
}

*=4096


{
	.var backgroundColor = allocateZpByte()
	.var borderColor = allocateZpByte()

	lda #BROWN
	sta backgroundColor

	lda #YELLOW
	sta borderColor

	setColors(backgroundColor, borderColor)

	.eval deallocateZpByte(backgroundColor)
	.eval deallocateZpByte(borderColor)
}

rts
