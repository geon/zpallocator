#import "zpallocator.asm"

.var A = allocateZpByte()
.var B = allocateZpByte()
.errorif A==B, "A and B should be distinct."

.print "All compile time tests passed."
