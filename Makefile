CC = cc
CFLAGS = -O3 -lcurl -pedantic-errors -Wall -std=c99
OBJ = test_network.o

test_network: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	@rm $(OBJ) test_network

# Always rebuild, for now
.PHONY: clean test_network
