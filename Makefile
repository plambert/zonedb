.PHONY: install
install:
	go install ./build/cmd/zonedb

.PHONY: test
test:
	go run ./build/cmd/zonedb/main.go
	go test ./...

zones.go: zones.txt metadata/*.json build/*.go build/*/*/*.go
	go generate

.PHONY: update
update:
	go run ./build/cmd/zonedb/main.go -update -w -c 100
	make zones.go
	make test

.PHONY: normalize
normalize:
	go run build/cmd/zonedb/main.go -w
	make zones.go
