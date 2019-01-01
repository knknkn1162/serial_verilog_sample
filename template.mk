VC=iverilog

WORKDIR=..

INCLUDE_OPTION=$(addprefix -I$(WORKDIR)/, $(INCLUDES))
OPTION=$(INCLUDE_OPTION)

# extract all *.v files and remove extention.
FILES=$(shell find . -type f -name "*_tb.v" | sed 's!^.*/!!' | tr '.v\n' ' ')

all: $(FILES) clean

%: %.o
	vvp -N $^

%.o: %.v
	$(VC) ${OPTION} -o $@ $<

open:
	open out.vcd

clean:
	rm -rf *.o *.vcd **/*.o **/*.vcd
