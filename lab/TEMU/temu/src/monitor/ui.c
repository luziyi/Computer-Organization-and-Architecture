#include "monitor.h"
#include "temu.h"
#include "watchpoint.h"

#include <stdlib.h>
#include <readline/readline.h>
#include <readline/history.h>
#include<expr.h>

void cpu_exec(uint32_t);

void display_reg();

/* We use the `readline' library to provide more flexibility to read from stdin. */
char* rl_gets() {
	static char *line_read = NULL;

	if (line_read) {
		free(line_read);
		line_read = NULL;
	}

	line_read = readline("(temu) ");

	if (line_read && *line_read) {
		add_history(line_read);
	}

	return line_read;
}

static int cmd_c(char *args) {
	cpu_exec(-1);
	return 0;
}

static int cmd_q(char *args) {
	return -1;
}

static int cmd_help(char *args);

//单步调试
static int cmd_si(char* args)
{	
	char *arg = strtok(NULL, " ");
	int i = 1;
	if (arg != NULL)
	{
		int step = atoi(arg);
		if(step<1) {
			fprintf(stderr, "usage: n must be greater than 1\n");
			return -1;
		}
		else {
		sscanf(arg, "%d", &i);
		}
	}
	cpu_exec(i);
	return 0;
}

//打印程序状态
static int cmd_info(char*args)
{
	char* arg = strtok(args, " ");
	if(args==NULL)
		{
			printf("usage: info r or info w\n");
			return 0;
		}
	else if(strcmp(arg,"r")==0)
		{
			for (int i = R_ZERO; i <= R_RA;i++)
			{
				printf("%s\t 0x%08x\n", regfile[i], reg_w(i));

			}
		}
	else if(strcmp(arg, "w") == 0)
		{
			list_watchpoint();
		}
	else 
		{
			fprintf(stderr, "unknown command\n");
			return -1;
		}
	return 0;
}
//表达式求职
static int cmd_p(char* args){
    uint32_t num;
    bool success;
    num = expr(args, &success);
    if (success)
    {
        printf("Expression %s:\t0x%x\t%d\n", args, num, num);
    }
//    else assert(0);
    return 0;
}




//扫描内存
static int cmd_x(char* args){
    if (args == NULL)//x后面的参数
    {
        printf("usage: x n addr(0x)\n");
        return 0;
    }

    char *arg = strtok(args, " ");

    int n = atoi(arg);
    char *EXPR = strtok(NULL, " ");
    if (EXPR == NULL)
    {
        printf("usage: x n addr(0x)\n");
        return 0;
    }

    uint32_t address;
    bool success;
    address = expr(EXPR, &success);
    if (success)
    {
        for (int i=0;i<n;i++){
            uint32_t data= mem_read(address+i*4,4);
            printf("0x%08x: ",address + i*4);
            for(int j=0;j<4;j++){
                printf("0x%02x ",data&0xff);
                data = data >> 8;
            }
            printf("\n");
        }
    }
    else {
        assert(0);
    }
    return 0;
}

//设置监视点
static int cmd_w(char*args)
{
if (args)
	{
		int NO = set_watchpoint(args);
		if (NO != -1)
		{
			printf("Set watchpoint #%d\n", NO);
		}
		else
		{
			printf("Bad expression\n");
		}
	}
	return 0;

}
//删除监视点
static int cmd_d(char *args)
{
	int NO;
	sscanf(args, "%d", &NO);
	if (!delete_watchpoint(NO))
	{
		printf("Watchpoint #%d does not exist\n", NO);
	}
	printf("Watchpoint #%d has been deleted successfully\n", NO);
	return 0;
}

static struct
{
	char *name;
	char *description;
	int (*handler)(char *);
} cmd_table [] = {
	{ "help", "Display informations about all supported commands", cmd_help },
	{ "c", "Continue the execution of the program", cmd_c },
	{ "q", "Exit TEMU", cmd_q },
	{"si","Single instruction execute",cmd_si},
	{"info","Printf state of registers(r) or watchpoint(w)",cmd_info},
	{"x","Scan memory",cmd_x},
	{"p","Evaluate expression", cmd_p},
	{"w","Create WatchPoint", cmd_w},
	{"d","Delete WatchPoint", cmd_d},
 
	/* TODO: Add more commands */

};

#define NR_CMD (sizeof(cmd_table) / sizeof(cmd_table[0]))

static int cmd_help(char *args) {
	/* extract the first argument */
	char *arg = strtok(NULL, " ");
	int i;

	if(arg == NULL) {
		/* no argument given */
		for(i = 0; i < NR_CMD; i ++) {
			printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
		}
	}
	else {
		for(i = 0; i < NR_CMD; i ++) {
			if(strcmp(arg, cmd_table[i].name) == 0) {
				printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
				return 0;
			}
		}
		printf("Unknown command '%s'\n", arg);
	}
	return 0;
}

void ui_mainloop() {
	while(1) {
		char *str = rl_gets();
		char *str_end = str + strlen(str);

		/* extract the first token as the command */
		char *cmd = strtok(str, " ");
		if(cmd == NULL) { continue; }

		/* treat the remaining string as the arguments,
		 * which may need further parsing
		 */
		char *args = cmd + strlen(cmd) + 1;
		if(args >= str_end) {
			args = NULL;
		}

		int i;
		for(i = 0; i < NR_CMD; i ++) {
			if(strcmp(cmd, cmd_table[i].name) == 0) {
				if(cmd_table[i].handler(args) < 0) { return; }
				break;
			}
		}

		if(i == NR_CMD) { printf("Unknown command '%s'\n", cmd); }
	}
}
