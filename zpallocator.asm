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

.function @allocateSpecificZpByte(requestedAddress) {
	.errorif !freeZpAddresses.containsKey(requestedAddress), "Address $"+toHexString(requestedAddress)+" is taken."
	.eval freeZpAddresses.remove(requestedAddress)
	.return requestedAddress
}
