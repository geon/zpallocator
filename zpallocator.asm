#importonce
.filenamespace ZpAllocator

.var freeZpAddresses

.var hardwiredPortRegisters = List().add($00, $01)

.function @zpAllocatorInit() {
	.eval freeZpAddresses = Hashtable()

	.for(var i=0; i<256; i++) {
		.eval freeZpAddresses.put(i, true)
	}

	.eval reserveUnsafeAddresses(hardwiredPortRegisters)
}

.function reserveUnsafeAddresses(addressList) {
	.for(var i=0; i<addressList.size(); i++) {
		.eval allocateSpecificZpByte(addressList.get(i))
	}
}

.function @allocateZpByte() {
	.for(var i=255; i>=0; i-=1) {
		.if(freeZpAddresses.containsKey(i)) {
			.return @allocateSpecificZpByte(i)
		}
	}

	.errorif true, "No free bytes available in zero page."
}

.function @allocateZpWord() {
	.for(var i=0; i<256; i+=2) {
		.if(freeZpAddresses.containsKey(i) && freeZpAddresses.containsKey(i+1)) {
			.var lowByte = @allocateSpecificZpByte(i)
			.eval @allocateSpecificZpByte(i+1)
			.return lowByte
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
