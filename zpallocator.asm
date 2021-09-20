#importonce
.filenamespace ZpAllocator

.var zpAddress = 0
.function @allocateZpByte() {
	.return zpAddress++
}

.function @allocateSpecificZpByte(requestedAddress) {
	.return requestedAddress
}
