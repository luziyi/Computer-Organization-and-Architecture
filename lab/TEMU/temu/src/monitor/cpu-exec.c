#include "expr.h"
#include "helper.h"
#include "monitor.h"
#include "watchpoint.h"

/* The assembly code of instructions executed is only output to the screen
 * when the number of instructions executed is less than this value.
 * This is useful when you use the `si' command.
 * You can modify this value as you want.
 */
#define MAX_INSTR_TO_PRINT 100

int temu_state = STOP;

void exec(uint32_t);

char assembly[80];
char asm_buf[128];

void print_bin_instr(uint32_t pc) {
    int i;
    if (temu_state != END) {
        int l = sprintf(asm_buf, "%8x:   ", pc | (ENTRY_START&0xe0000000));
        for (i = 3; i >= 0; i--) {
            l += sprintf(asm_buf + l, "%02x ", instr_fetch(pc + i, 1));
        }
        sprintf(asm_buf + l, "%*.s", 8, "");
    }
}

/* Simulate how the MiniMIPS32 CPU works. */
void cpu_exec(volatile uint32_t n) {
    uint32_t pc;
    if (temu_state == END) {
        printf(
            "Program execution has ended. To restart the program, exit TEMU "
            "and run again.\n");
        return;
    }
    temu_state = RUNNING;

#ifdef DEBUG
    volatile uint32_t n_temp = n;
#endif

    for (; n > 0; n--) {
        pc = cpu.pc &
             0x1fffffff;  // map the virtual address to the physical address,
                          // e.g. high 3 bits in cpu.pc are cleared

#ifdef DEBUG
        uint32_t pc_temp = pc;
        if ((n & 0xffff) == 0) {
            fputc('.', stderr);
        }
#endif

        /* Execute one instruction, including instruction fetch,
         * instruction decode, and the actual execution. */
        exec(pc);

        cpu.pc += 4;

#ifdef DEBUG
        print_bin_instr(pc_temp);
        strcat(asm_buf, assembly);
        Log_write("%s\n", asm_buf);
        if (n_temp < MAX_INSTR_TO_PRINT && temu_state == RUNNING) {  //
            printf("%s\n", asm_buf);
        }
#endif

        /* TODO: check watchpoints here. */

        WP *wp = scan_watchpoint();
        if (wp != NULL) {
            // puts(asm_buf);
            bool success;
            uint32_t address;
            address = expr(wp->expr, &success);
            printf("\n\nHint watchpoint %d at address 0x%08x, expr = %s\n",
                   wp->NO, address, wp->expr);
            printf("old value = %#08x\nnew value = %#08x\n", wp->old_val,
                   wp->new_val);
            wp->old_val = wp->new_val;
            return;
        }
        if (temu_state != RUNNING) {
            return;
        }
    }

    if (temu_state == RUNNING) {
        temu_state = STOP;
    }
}
