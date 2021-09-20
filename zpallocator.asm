#importonce
.filenamespace ZpAllocator

.var freeZpAddresses = Hashtable()
.for(var i=0; i<256; i++) {
	.eval freeZpAddresses.put(i, true)
}

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
