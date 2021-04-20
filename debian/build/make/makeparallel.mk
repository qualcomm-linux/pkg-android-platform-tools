NAME = makeparallel
SOURCES = makeparallel.cpp
SOURCES := $(foreach source, $(SOURCES), tools/makeparallel/$(source))

build: $(SOURCES)
	$(CXX) $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME)