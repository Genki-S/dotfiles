CC := g++
WARNCPPFLAGS := -Wall -W -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wold-style-cast -Woverloaded-virtual
LDFLAGS := -g
# LOADLIBS := -lefence
LOADLIBS :=

SRCS := main.cpp
OBJS := $(SRCS:.cpp=.o)
EXE := a.out

build: $(EXE)

execute:
	./$(EXE) < in.txt > out.txt

$(EXE): $(OBJS)
	$(CC) $(LOADLIBS) $(OBJS) -o $@

%.o: %.cpp
	$(CC) -c $(LDFLAGS) $(WARNCPPFLAGS) $< -o $@

.PHONY: clean cleanest

clean:
	rm -f $(OBJ)

cleanest: clean
	rm -f $(EXE)
