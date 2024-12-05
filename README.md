# 计算机组成与体系结构课程

### 课程简介

主要学习和CPU设计有关的一些内容，参考书目有《计算机组成与设计/硬件软件接口》，《CPU设计实战》等。

课上讲解部分主要分为4个内容，计算机性能，指令集架构，经典五级流水线CPU的设计，存储器及其结构层次。

### 实验介绍

实验主要分为两部分，第一部分是TEMU，和NJU的NEMU很像，目标是设计一个可以模拟MIPS指令的模拟器，环境为LINUX，Windows应该也没问题，可能需要重写一下makefile。

第二部分，需要使用vivado实现一个基于5级流水线的CPU，需要考虑执行时的数据相关问题，流水线暂停，分支跳转指令的实现，以及精确异常。

仓库中SoC是最后实现所有功能后用于验证和上板的vivado工程。



### 仓库目录

```
.
├── README.md
├── homework
│   ├── 第一次作业答案.pdf
│   ├── 第三次作业答案.pdf
│   ├── 第二次作业答案.pdf
│   └── 第四次作业答案.pdf
├── lab
│   ├── CPU
│   │   ├── MiniMIPS32.cache
│   │   ├── MiniMIPS32.hw
│   │   ├── MiniMIPS32.ip_user_files
│   │   ├── MiniMIPS32.runs
│   │   ├── MiniMIPS32.sim
│   │   ├── MiniMIPS32.srcs
│   │   ├── MiniMIPS32.xpr
│   │   └── MiniMIPS32_SYS_tb_behav.wcfg
│   ├── README.md
│   ├── SoC
│   │   ├── README.md
│   │   ├── cpu132_gettrace
│   │   ├── soc_axi_func
│   │   ├── soc_sram_func
│   │   ├── soft_c
│   │   ├── soft_func
│   │   └── test
│   └── TEMU
│       ├── Makefile
│       ├── README.md
│       ├── build
│       ├── data.bin
│       ├── golden_trace.txt
│       ├── inst.bin
│       ├── log.txt
│       ├── mips_sc
│       └── temu
└── slides
    ├── COA_CH0_intro.pptx
    ├── COA_CH1_performance.pptx
    ├── COA_CH2_ISA.pptx
    ├── COA_CH3_CPU（1）.pptx
    ├── COA_CH3_CPU（2）.pptx
    ├── COA_CH3_CPU（3）.pptx
    ├── COA_CH4_Mem（1）.pptx
    └── 包含式多级Cache示例.ppt
```

