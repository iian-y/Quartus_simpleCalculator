//控制模块
module state_ctrl(
input clk,//时钟
input esc,//ESC键
input add,//加
input sub,//减
input mul,//乘
input div,//除
input enter,//Enter键
output [2:0] current_state,//当前状态
output reg [1:0] calcul//计算
);
reg [2:0] state=3'd0;//定义状态
parameter s_first=3'd0;
parameter s_calcul=3'd1;
parameter s_second=3'd2;
parameter s_enter=3'd3;
parameter s_result=3'd4;
parameter s_continue=3'd5;

assign current_state=state;//输出当前状态

always@(posedge clk)
	if(esc)
		state<=s_first;
	else
		case(state)
			s_first://输入第一个数状态
				if(add | sub | mul | div)//输入计算符号
					state<=s_calcul;
				else
					state<=s_first;
			s_calcul://输入计算符号
				state<=s_second;
			s_second://输入第二个数状态
				if(enter)//输入enter
					state<=s_enter;
				else
					state<=s_second;
			s_enter://输入enter
				state<=s_result;
			s_result://输出计算结果
				if(add | sub | mul | div)//输入计算符号
					state<=s_continue;
				else
					state<=s_result;
			s_continue:
				state<=s_second;
			default:;
		endcase
	
always@(posedge clk)
	if(esc)
		calcul<=2'b00;
	else if(add)//输入+号
		calcul<=2'b00;//00表示加
	else if(sub)//输入-号
		calcul<=2'b01;//01表示减
	else if(mul)//输入*号
		calcul<=2'b10;	//10表示乘	
	else if(div)//输入/号
		calcul<=2'b11;	//11表示除	
	else
		;	
		
endmodule

