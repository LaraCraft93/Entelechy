CC = cc
CFLAGS = -O3 -lcurl -pedantic-errors -Wall -std=c99
OBJ = scripts/conky/test_network.o
EXECUTABLE = scripts/conky/test_network

$(EXECUTABLE): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	@rm $(OBJ) $(EXECUTABLE)

# Always rebuild, for now
.PHONY: clean $(EXECUTABLE)
