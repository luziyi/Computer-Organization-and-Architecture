#include "helper.h"
#include "monitor.h"

extern char assembly[80];

/* invalid opcode */
make_helper(inv) {

	uint32_t temp;
	temp = instr_fetch(pc, 4);

	uint8_t *p = (void *)&temp;
	printf("invalid opcode(pc = 0x%08x): %02x %02x %02x %02x ...\n\n", 
			pc, p[3], p[2], p[1], p[0]);

	printf("There are two cases which will trigger this unexpected exception:\n\
1. The instruction at pc = 0x%08x is not implemented.\n\
2. Something is implemented incorrectly.\n", pc);
	printf("Find this pc value(0x%08x) in the disassembling result to distinguish which case it is.\n\n", pc);

	assert(0);
}

/* stop temu */
make_helper(temu_trap) {
	printf("\33[1;31mtemu: HIT GOOD TRAP\33[0m at $pc = 0x%08x\n\n", cpu.pc);
	sprintf(assembly, "\n");
	temu_state = END;
}

make_helper(break_){
  cpu.cp0.cause.ExcCode = Bp;
  cpu.cp0.status.EXL = 1;
  cpu.cp0.EPC = cpu.pc;
  cpu.pc = TRAP_ADDR;
  sprintf(assembly,"break");
}

make_helper(syscall){
  cpu.cp0.cause.ExcCode = Sys;
  cpu.cp0.status.EXL = 1;
  cpu.cp0.EPC = cpu.pc;
  cpu.pc = TRAP_ADDR;
  sprintf(assembly,"syscall");
}

make_helper(nop) {
	sprintf(assembly, "NOP");
}

make_helper(bad_temu_trap){
    printf("\33[1;31mtemu: HIT BAD TRAP\33[0m at $pc = 0x%08x\n\n", cpu.pc);
	temu_state = END;
}