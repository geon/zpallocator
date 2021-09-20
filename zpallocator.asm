#importonce
.filenamespace ZpAllocator

.var freeZpAddresses = Hashtable()
.for(var i=0; i<256; i++) {
	.eval freeZpAddresses.put(i, true)
}
// Allocate unsafe zp addresses.
// Hardwired port registers
.eval allocateSpecificZpByte($00)
.eval allocateSpecificZpByte($01)

.function @allocateZpByte() {
	.var address = freeZpAddresses.keys().get(0).asNumber()
	.eval freeZpAddresses.remove(address)
	.print "Allocated $"+toHexString(address)
	.return address
}

.function @allocateZpWord() {
	.for(var i=0; i<256; i+=2) {
		.if(freeZpAddresses.containsKey(i) && freeZpAddresses.containsKey(i+1)) {
			.eval freeZpAddresses.remove(i)
			.eval freeZpAddresses.remove(i+1)
			.return i
		}
	}

	.errorif true, "No free words available in zero page."
}

.function @allocateSpecificZpByte(requestedAddress) {
	.errorif !freeZpAddresses.containsKey(requestedAddress), "Address $"+toHexString(requestedAddress)+" is taken."
	.eval freeZpAddresses.remove(requestedAddress)
	.return requestedAddress
}

.function @deallocateZpByte(freeAddress) {
	.errorif freeZpAddresses.containsKey(freeAddress), "Address $"+toHexString(freeAddress)+" is aldready free."
	.eval freeZpAddresses.put(freeAddress, true)
}
