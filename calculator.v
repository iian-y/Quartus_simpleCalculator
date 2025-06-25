//计算器
module calculator(
input clk,//时钟
input esc,//清零键
input add,//加
input sub,//减
input mul,//乘
input div,//除
input enter,//等于键
input cancel,//回退键

//数字按键
input key_0,
input key_1,
input key_2,
input key_3,
input key_4,
input key_5,
input key_6,
input key_7,
input key_8,
input key_9,
	
output [7:0] bit_sel,//数码管位选
output [7:0] segment//数码管段选
);

wire [2:0] current_state;//当前状态
wire [1:0] calcul;//计算
wire [15:0] OP_A;//输入的操作数A
wire [15:0] OP_B;//输入的操作数B
wire [31:0] OP_Result;//结果

wire key_0_p;
wire key_1_p;
wire key_2_p;
wire key_3_p;
wire key_4_p;
wire key_5_p;
wire key_6_p;
wire key_7_p;
wire key_8_p;
wire key_9_p;
wire cancel_p;
wire clk_1KHz;

//分频模块，时钟分频到1KHz
div_1K i_div_1K(
. clk(clk),//50MHz
. clk_1KHz(clk_1KHz)//时钟1KHz
);

//assign clk_1KHz=clk;//仿真时用该句,取消分频可以加快仿真速度,实际上板需要加上分频,屏蔽该句

//按键上升沿模块
key_rise i0_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_0),//按键输入
. key_out(key_0_p)//按键上升沿
);

//按键上升沿模块
key_rise i1_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_1),//按键输入
. key_out(key_1_p)//按键上升沿
);

//按键上升沿模块
key_rise i2_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_2),//按键输入
. key_out(key_2_p)//按键上升沿
);

//按键上升沿模块
key_rise i3_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_3),//按键输入
. key_out(key_3_p)//按键上升沿
);

//按键上升沿模块
key_rise i4_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_4),//按键输入
. key_out(key_4_p)//按键上升沿
);

//按键上升沿模块
key_rise i5_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_5),//按键输入
. key_out(key_5_p)//按键上升沿
);

//按键上升沿模块
key_rise i6_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_6),//按键输入
. key_out(key_6_p)//按键上升沿
);

//按键上升沿模块
key_rise i7_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_7),//按键输入
. key_out(key_7_p)//按键上升沿
);

//按键上升沿模块
key_rise i8_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_8),//按键输入
. key_out(key_8_p)//按键上升沿
);

//按键上升沿模块
key_rise i9_key_rise(
. clk(clk_1KHz),//时钟
. key_in(key_9),//按键输入
. key_out(key_9_p)//按键上升沿
);

//按键上升沿模块
key_rise i10_key_rise(
. clk(clk_1KHz),//时钟
. key_in(cancel),//按键输入
. key_out(cancel_p)//按键上升沿
);

//状态控制模块
state_ctrl i_state_ctrl(
. clk(clk_1KHz),//时钟
. esc(esc),//ESC键
. add(add),//加
. sub(sub),//减
. mul(mul),//乘
. div(div),//除
. enter(enter),//Enter键
. current_state(current_state),//当前状态
. calcul(calcul)//计算
);

//数字输入模块
num_in i_num_in(
. clk(clk_1KHz),//时钟
. esc(esc),//ESC键
. key_0(key_0_p),
. key_1(key_1_p),
. key_2(key_2_p),
. key_3(key_3_p),
. key_4(key_4_p),
. key_5(key_5_p),
. key_6(key_6_p),
. key_7(key_7_p),
. key_8(key_8_p),
. key_9(key_9_p),
. cancel(cancel_p),
. current_state(current_state),//当前状态
. calcul(calcul),//计算方式，//00表示加//01表示减//10表示乘//11表示除		
. OP_A(OP_A),//输入的操作数A
. OP_B(OP_B),//输入的操作数B
. OP_Result(OP_Result),//结果
. remainder(remainder)//余数
);

//数码管显示模块
display i_display(
. clk(clk_1KHz),//时钟
. OP_A(OP_A),//输入的操作数A
. OP_B(OP_B),//输入的操作数B
. OP_Result(OP_Result),//结果
. bit_sel(bit_sel),//数码管位选
. segment(segment)//数码管段选
);


endmodule

