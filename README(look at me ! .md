# Quartus_simpleCalculator
基于FPGA的简易计算器Verilog代码Quartus仿真
软件：Quartus
语言：Verilog

代码功能：

（1）完成 0~9999 之内的数的加减乘除计算，9999 的二进制表示为 1001100001111,在

这一部分中，可以将每一个数均表示成 16 位二进制数统一进行运算，各个计算数之间的

计算可以直接使用 VHDL 语言中的运算符来实现。

（2）在显示时，必须将个位、十位、百位，千位分开显示，设计时使用比较的方法来

实现计算器的功能要求。

（3）按键必须包括 0-9 数字按键、加减乘除四键、等号键以及清零键，其余功能可自

行添加。


2024 - 2025 学年第 1 学期
《数字电子技术B》 课程设计报告

设计题目：  简易计算器                                      

2023级美丽学姐

2024年12月

目录
第一章 设计任务	2
1.1 基本要求功能	2
1.2  扩展功能	2
1.3  完成设计所用时间	2
第二章  总体设计	3
2.1  设计原理	3
2.1.1 设计原理	3
2.1.2 总体方案	3
2.2  各模块设计与仿真分析	4
2.3  仿真分析	6
第三章  心得体会	7
3.1  数字电路基础与状态机概念	7
3.2  开发过程中的技术难点与解决方案	7
3.3  设计思维的锻炼	8
3.4  未来改进展望	8
3.5  总结与感悟	9
第四章 参考文献	9
第五章 附件：Quartus  工程文件夹	10

第一章 设计任务 

1.1 基本要求功能 

简易计算器项目的基本功能要求如下： 
（1）完成 0~9999 之内的数的加减乘除计算，9999 的二进制表示为 1001100001111,在 这一部分中，可以将每一个数均表示成 16 位二进制数统一进行运算，各个计算数之间的 计算可以直接使用 VHDL 语言中的运算符来实现。 
（2）在显示时，必须将个位、十位、百位，千位分开显示，设计时使用比较的方法来实现计算器的功能要求。 
（3）按键必须包括 0‐9 数字按键、加减乘除四键、等号键以及清零键

1.2  扩展功能 
可实现回退到上一位重新输入的功能

1.3  完成设计所用时间 
约2周。 


第二章  总体设计 

2.1  设计原理 

2.1.1 设计原理 
	
简易计算器的原理基于输入、处理和输出三个核心功能。首先，输入部分通常由一系列按键组成，用户通过按下数字键（0-9）和操作符键（如加、减、乘、除等）来输入数据。当用户按下数字键时，输入的数字会被存储在计算器的内存寄存器中，等待后续运算；当用户按下操作符键时，计算器记录下此操作符，准备执行相应的数学运算。接着，运算处理部分负责根据用户输入的数字和操作符执行相应的计算。计算器通常将第一个数字存储为操作数1，当用户输入第二个数字并按下等号键时，计算器会根据输入的操作符（如加法或减法）将两个操作数进行计算，并将结果存储在另一个寄存器中。简单的加法操作，如“3 + 5”，就是通过寄存器存储数字3和5，然后计算其和，最后输出结果。在计算的过程中，计算器内部会通过硬件电路（如加法器）执行运算，而对于更复杂的计算器，可能会有更加复杂的计算模块来支持多种数学运算。最后，输出部分通过显示器将计算结果呈现给用户，通常使用七段显示器将数字以清晰的方式展示出来，用户可以直接看到结果。如果用户需要重新开始计算，可以按下清除键，这样所有显示和存储的数据会被清除，计算器准备好进行新的输入和运算。整个过程的核心是通过输入数据、执行运算和输出结果三个步骤高效完成计算任务，简易计算器的设计原理基于这一流程，确保其能够在简洁的硬件和软件设计中实现基本的数学计算功能。 

2.1.2 总体方案 

为了实现以上功能，设计将被划分为多个模块，每个模块负责不同的功能。核心模块包括输入处理模块、运算模块、显示模块和控制模块。 
输入模块： 接收来自用户的数字和操作符输入。输入：0-9 的数字按键。
四个运算符：加法、减法、乘法、除法。等号（=）按键用于触发计算。清零（C）按键用于清除所有输入。输出： 数字和操作符按键输入信号，转换为二进制数据。
运算模块： 执行加法、减法、乘法和除法运算。输入：当前输入的数字。上一个数字（操作数）。当前选择的操作符。等号信号用于触发运算。输出： 计算结果，支持 16 位的计算结果，适应 0-9999 范围。
显示模块： 将计算结果转化为显示格式，并分解为千位、百位、十位和个位。输入：计算结果（16 位数）。输出：分解的千位、百位、十位、个位数字输出，供显示模块使用。
控制模块： 管理各个模块之间的交互，包括状态机的控制、输入、计算和输出的切换。输入：用户按键输入（数字、操作符、等号、清零等）。时钟信号。重置信号。输出：控制信号，决定当前模块的状态（例如，是否处于计算状态、显示状态、输入状态等）。
时钟和复位模块： 负责时钟信号的生成，以及系统复位。输入：外部时钟信号。重置信号。输出：驱动所有模块的时钟信号。提供同步复位信号，初始化计算器。 

2.1.3 顶层框图 

![image](https://github.com/user-attachments/assets/89e4bfee-9a0f-44bc-a412-9da5b0c45831)


2.2  各模块设计与仿真分析 

2.2.1 输入模块设计 
输入模块负责接收用户的数字、运算符以及回退命令。
输入信号：包括数字（digit_input）、操作符（operator_input）和回退（backspace_input）。
设计思路：输入信号通过控制逻辑发送到输入寄存器中，同时进行去抖动处理，确保输入的稳定


2.2.2 控制模块设计 
控制模块是整个系统的核心，负责管理输入、回退、计算逻辑和状态转移。状态机设计：使用有限状态机（FSM）来管理输入、回退和计算过程。
状态：IDLE（空闲状态）、INPUT（输入状态）、BACKSPACE（回退状态）、EQUAL（计算状态）

2.2.3 显示模块设计
显示模块负责将当前的输入状态以及计算结果反馈给用户。输入和结果显示：输入的数字会被显示在屏幕上，计算的结果也会实时更新显示。

2.2.4 计算模块设计 
计算模块负责执行基本的数学运算，接收输入的数据和操作符。

2.2.5 回退功能模块设计 
回退功能模块是一个简单的控制模块，用来处理撤销最近的输入。 


2.2.6 状态机

当前状态	输出信号
IDLE	clear_display
NUM_INPUT	display (数字输入)
OP_INPUT	display (操作符显示)
RESULT	show_result
CLEAR	reset, clear_display
UNDO	history_restore, display
![image](https://github.com/user-attachments/assets/ea5b21ed-64f6-4607-a653-b00ac74512c2)

2.2.7 RTL图 

![image](https://github.com/user-attachments/assets/c8c5c1a8-f35e-41cc-9a13-d9bcbcb17d87)

 
2.3  仿真分析 
![image](https://github.com/user-attachments/assets/e846d242-66ce-433d-9a49-1f0dc63db3e1)

![image](https://github.com/user-attachments/assets/b938c634-9b82-4fa7-becd-c674f5cae88d)

系统的功能仿真通过ModelSim平台进行验证，主要包括以下测试项目：仿真波形分析表明，系统各个模块能够按照设计要求正常工作，计算输入与结果显示正常，完全满足设计指标的要求。 



第三章  心得体会 
通过这次数字计算器的状态机设计课设，我不仅掌握了数字电路设计中的一些重要概念，也提高了自己的工程设计能力。这是一次非常宝贵的学习经历，给我提供了将理论与实践相结合的机会，同时也让我认识到自己在设计和调试过程中需要不断学习和提升的地方。我将继续努力，不断完善自己的知识体系和动手能力，以应对未来更具挑战性的项目。 

3.1  数字电路基础与状态机概念 
在设计数字计算器的过程中，我再次深入理解了数字电路中的核心概念，特别是**状态机（State Machine）**的应用。状态机作为一种重要的设计工具，在很多复杂的数字系统中都得到了广泛应用。数字计算器的状态机通过合理的设计，能够在不同的输入条件下，根据当前状态作出适当的响应，从而实现各种计算功能。

3.2  开发过程中的技术难点与解决方案 
在开发过程中遇到了若干技术难点，通过查阅资料和反复实验得以解决：
1. 状态机设计与状态转移问题： 在设计数字计算器的状态机时，最初的状态图并不完全符合功能需求。由于计算器需要处理复杂的运算（如加法、减法、乘法等），状态转移的设计变得异常复杂，尤其是如何准确描述不同输入条件下的状态转移。
解决方案：优化状态图和状态转换表，分阶段设计不仅减少了设计的复杂度，还提高了电路的可维护性。
2.  逻辑门电路的实现与优化：状态机的输出和状态转移需要通过逻辑门来实现。电路中使用了大量的与门、或门、非门等基本逻辑门，导致电路复杂且难以调试，尤其在时序上也存在不稳定的现象。
解决方案：使用触发器简化设计：在设计中，我使用了D触发器来存储状态信息，并结合适当的时钟信号控制状态转移。触发器的使用使得时序控制更加稳定，同时也简化了电路设计。优化逻辑电路：使用逻辑简化算法（如卡诺图法）来最小化布尔表达式，减少了所需的逻辑门数量。 
3.   调试与仿真问题：在实际仿真过程中，出现了不少不符合预期的行为。特别是电路的时序问题和逻辑转换错误，不仅导致了仿真失败，还增加了调试的难度。
解决方案：逐步调试与模块化仿真，逐个验证其功能。功能仿真与波形分析通过仿真工具查看波形图，详细分析每个信号的时序变化，定位到具体的错误位置。通过反复修改状态机设计和逻辑电路，最终解决了时序不稳定和输出不准确的问题。

3.3  设计思维的锻炼
数字计算器的设计需要在不同的输入和状态之间进行合理的转换，确保计算器的每个功能都能够正常运行。在设计状态机时，我学会了如何通过状态图和状态转换表来系统地分析问题，设计出合适的状态机结构。这种设计思维不仅仅适用于计算器项目，也能在其他数字电路设计中派上用场。在过程中，我逐步学会如何把复杂的任务分解为小的模块，然后逐个解决，最后再整合成一个完整的系统。

3.4  未来改进展望 
通过本次项目实践，我也发现了系统还有以下可改进之处： 
1.  并行处理：如果硬件条件允许，可以考虑在设计中引入并行计算模块（如使用多个运算单元），以提高多个计算任务的并行处理能力，进一步提高整体性能。
2.  增加显示功能：可以设计一个更为丰富的显示界面，提供更好的输入反馈。例如，支持多行显示、历史记录或计算步骤回溯。 
3.  低功耗设计：可以进一步优化电路设计，使用低功耗的集成电路（IC）和器件，例如采用更低功耗的逻辑门、时钟门控技术和动态电压频率调整（DVFS）技术。 
4.  增加错误检测与校正：可以在设计中加入更多的错误检测机制，如奇偶校验、冗余数据存储等。通过错误检测与自动修正机制，增强计算器对硬件故障和运算错误的容忍能力


3.5  总结与感悟 
本项目的开发过程是理论与实践相结合的良好实例。通过独立完成从需求分
析、方案设计到具体实现的完整流程，不仅加深了对数字系统设计的理解，也培
养了解决工程实际问题的能力。这些经验对今后的学习和工作都具有重要的指导意义。 
同时，项目开发过程中遇到的各种问题也让我认识到，在数字系统设计中，
不仅要有扎实的理论基础，更要有实践经验的积累和创新思维的培养。这次的项
目经历，对我的专业能力提升和工程素养培养都起到了重要的促进作用。 



第四章 参考文献 

①　M. Morris Mano, Michael D. Ciletti, Digital Design: With an Introduction to the Verilog HDL, 5th Edition, Pearson, 2013.
Verilog的基础及应用，学习数字逻辑设计与数码管控制。
② Samir Palnitkar, Verilog HDL: A Guide to Digital Design and Synthesis, 2nd Edition, Prentice Hall, 2003.
对数字系统设计的详细解释，适用于学习FPGA和数码管显示的设计。
③　John F. Wakerly, Digital Design: Principles and Practices, 4th Edition, Pearson, 2005.
　数字电路设计的基本原则，包括数码管显示、时序分析等。
④　Xilinx DocumentationAltera (Intel), Quartus Prime Handbook, Intel, 2021.
如何在Altera FPGA上实现Verilog代码并进行数字设计的详细指南。
⑤ Intel Quartus Prime　N. Weste, D. Harris, CMOS VLSI Design: A Circuits and Systems Perspective, 4th Edition, Pearson, 2011.
　CMOS电路和系统的设计，尤其是对FPGA和数码管显示控制的设计。
⑥ Texas Instruments, 7-Segment LED Display Driver Datasheet, Texas Instruments, 2021.
介绍数码管驱动的工作原理和设计要求。


第五章附件：Quartus  工程文件夹
Quartus中相关内容

5.1  编译成功截图

![image](https://github.com/user-attachments/assets/4d81c7fe-6242-45e1-b4d0-cb61dba13eb6)

5.2  引脚绑定

![image](https://github.com/user-attachments/assets/eccdd6b5-067f-4308-9896-8ac9518a621f)

5.3  部分代码展示

![image](https://github.com/user-attachments/assets/a338d2d1-2210-4b58-b8ab-bde4f9140d6a)

5.4  面包板按键明示图

![image](https://github.com/user-attachments/assets/b049d07c-3e46-4afb-b353-278ac00a8ea0)

5.5  源文件

核心源代码文件 
• 	所有.v文件均为Verilog HDL源代码 
• 	每个模块都有独立的功能定义和清晰的接口 
• 	源代码采用层次化设计，便于维护和修改 
项目配置文件 
• 	.qpf和.qsf文件包含完整的项目配置信息 
• 	包括引脚分配、时序约束等工程配置 
编译输出文件 
• 	.sof文件用于FPGA配置 
各类报告文件(.rpt)提供详细的编译信息时序和资源使用报告用于性能评估 
其他支持文件 
• 	work/目录包含ModelSim仿真所需文件 
	db/和incremental_db/目录包含编译过程数
