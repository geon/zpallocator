#import "zpallocator.asm"

.eval zpAllocatorInit(List().add(hardwiredPortRegisters))

.var A = allocateZpByte()
.var B = allocateZpByte()
.assert "A and B should be distinct.", A!=B, true 

.var zpfb = allocateSpecificZpByte($fb)
.assert "It should be possible to allocate specific ZP bytes.", toHexString(zpfb), toHexString($fb)

.asserterror "Subsequent allocations of the same address should fail.", allocateSpecificZpByte($fb)

.eval deallocateZpByte($fb)
.var zpfb3 = allocateSpecificZpByte($fb)
.assert "After deallocation, addresses should be free again.", toHexString(zpfb3), toHexString($fb)

.eval deallocateZpByte(zpfb3)
.asserterror "Double deallocations of the same address should fail.", deallocateZpByte(zpfb3)

.var word = allocateZpWord()
.assert "Allocating a word alloctes 2 adjecent bytes.", deallocateZpByte(word), deallocateZpByte(word+1)
