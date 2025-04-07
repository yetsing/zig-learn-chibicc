
chibicc: zig-out/bin/zig_learn_chibicc
	zig build

test: chibicc
	./test.sh

clean:
	rm -rf zig-out

.PHONY: test clean