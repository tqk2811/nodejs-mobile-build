
all: prebuild CopyLib program

program: main.o
	$(CXX) -I$(INODE) -L$(LNODE) $(CFLAGS) $(LDFLAGS) --sysroot=$(SYSROOT) -lm -o $(OUT)/node main.o $(OUT)/libnode.so
main.o: main.cpp
	$(CXX) -I$(INODE) -L$(LNODE) $(CFLAGS) $(LDFLAGS) --sysroot=$(SYSROOT) -c main.cpp

CopyLib: $(OUT)
	cp $(LNODE)/libnode.so $(OUT)/libnode.so
	cp $(NDK_LINK)/libc++_shared.so $(OUT)/libc++_shared.so
	cp $(NDK_LINK)/$(API)/liblog.so $(OUT)/liblog.so

$(OUT):
	mkdir -p $(OUT)

prebuild:
	rm -f *.o
	rm -f *.gch

clean: prebuild
	rm -d -f -r $(Out)