Include=-I$(INODE) -I$(INDK)
Linker=-L$(LNODE) -L$(LNDK) -L$(LNDK)/$(API)

all: prebuild CopyLib program

program: main.o
	$(CXX) $(Include) $(CFLAGS) $(LDFLAGS) --sysroot=$(SYSROOT) -lm -o $(OUT)/node main.o $(OUT)/libnode.so
main.o: main.cpp
	$(CXX) $(Include) $(CFLAGS) $(LDFLAGS) --sysroot=$(SYSROOT) -c main.cpp

CopyLib: $(OUT)
	cp $(LNODE)/libnode.so $(OUT)/libnode.so
	cp $(LNDK)/libc++_shared.so $(OUT)/libc++_shared.so
	cp $(LNDK)/$(API)/liblog.so $(OUT)/liblog.so

$(OUT):
	mkdir -p $(OUT)

prebuild:
	rm -f *.o
	rm -f *.gch

clean: prebuild
	rm -d -f -r $(Out)