#import "zpallocator.asm"

.var A = allocateZpByte()
.var B = allocateZpByte()
.errorif A==B, "A and B should be distinct."

.var zpfb = allocateSpecificZpByte($fb)
.errorif zpfb!=$fb, "It should be possible to allocate specific ZP bytes."

// .var zpfb2 = allocateSpecificZpByte($fb)
// .errorif zpfb2==$fb, "Subsequent allocations of the same address should fail."

.print "All compile time tests passed."
