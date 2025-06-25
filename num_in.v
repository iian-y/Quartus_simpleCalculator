//数字输入模块
module num_in(
input clk,//时钟
input esc,//ESC键
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
input cancel,//回退键

input [2:0] current_state,//当前状态
input [1:0] calcul,//计算方式，//00表示加//01表示减//10表示乘//11表示除		
output [15:0] OP_A,//输入的操作数A
output [15:0] OP_B,//输入的操作数B
output [31:0] OP_Result,//结果
output [15:0] remainder//余数
);

parameter s_first=3'd0;
parameter s_calcul=3'd1;
parameter s_second=3'd2;
parameter s_enter=3'd3;
parameter s_result=3'd4;
parameter s_continue=3'd5;

reg [15:0] input_A=16'd0;
reg [15:0] input_B=16'd0;

reg [15:0] OP_A_reg;//输入的操作数A
reg [15:0] OP_B_reg;//输入的操作数B
reg [31:0] OP_Result_reg;//结果
reg [15:0] remainder_reg;//余数

assign OP_A=OP_A_reg;
assign OP_B=OP_B_reg;
assign OP_Result=OP_Result_reg;
assign remainder=remainder_reg;

always@(posedge clk)
	if(esc)
		input_A<=16'd0;
	else
		if(current_state==s_first)//输入第一个操作数
			if(key_0)
				input_A<={input_A[11:0],4'd0};//输入0
			else if(key_1)
				input_A<={input_A[11:0],4'd1};//输入1
			else if(key_2)
				input_A<={input_A[11:0],4'd2};//输入2
			else if(key_3)
				input_A<={input_A[11:0],4'd3};//输入3
			else if(key_4)
				input_A<={input_A[11:0],4'd4};//输入4
			else if(key_5)
				input_A<={input_A[11:0],4'd5};//输入5
			else if(key_6)
				input_A<={input_A[11:0],4'd6};//输入6
			else if(key_7)
				input_A<={input_A[11:0],4'd7};//输入7
			else if(key_8)
				input_A<={input_A[11:0],4'd8};//输入8
			else if(key_9)
				input_A<={input_A[11:0],4'd9};//输入9
			else if(cancel)//回退
				input_A<={4'b0,input_A[15:4]};//回退
			else
				input_A<=input_A;
		else if(current_state==s_continue)
			begin
				input_A[3:0]<=OP_Result_reg%10;
				input_A[7:4]<=OP_Result_reg/10%10;
				input_A[11:8]<=OP_Result_reg/100%10;
				input_A[15:12]<=OP_Result_reg/1000%10;
			end
		else
			input_A<=input_A;

always@(posedge clk)
	OP_A_reg<=input_A[15:12]*1000+input_A[11:8]*100+ input_A[7:4]*10+ input_A[3:0];//将百位乘以100，十位乘以10加个位，转为十进制便于计算

always@(posedge clk)
	if(esc)
		input_B<=16'd0;
	else
		if(current_state==s_second)//输入第2个操作数
			if(key_0)
				input_B<={input_B[11:0],4'd0};//输入0
			else if(key_1)
				input_B<={input_B[11:0],4'd1};//输入1
			else if(key_2)
				input_B<={input_B[11:0],4'd2};//输入2
			else if(key_3)
				input_B<={input_B[11:0],4'd3};//输入3
			else if(key_4)
				input_B<={input_B[11:0],4'd4};//输入4
			else if(key_5)
				input_B<={input_B[11:0],4'd5};//输入5
			else if(key_6)
				input_B<={input_B[11:0],4'd6};//输入6
			else if(key_7)
				input_B<={input_B[11:0],4'd7};//输入7
			else if(key_8)
				input_B<={input_B[11:0],4'd8};//输入8
			else if(key_9)
				input_B<={input_B[11:0],4'd9};//输入9
			else if(cancel)//回退
				input_B<={4'b0,input_B[15:4]};//回退
			else
				input_B<=input_B;
		else if(current_state==s_continue)
			input_B<=16'd0;
		else
			input_B<=input_B;

always@(posedge clk)
	OP_B_reg<=input_B[15:12]*1000+input_B[11:8]*100+ input_B[7:4]*10+ input_B[3:0];//将百位乘以100，十位乘以10加个位，转为十进制便于计算


always@(posedge clk)
	if(esc)
		begin
		OP_Result_reg<=32'd0;//结果
		remainder_reg<=16'd0;//余数
		end
	else if(current_state==s_enter)
		case(calcul)//计算方式，//00表示加//01表示减//10表示乘//11表示除		
			2'b00:
				begin
				OP_Result_reg<=OP_A+OP_B;
				remainder_reg<=16'd0;
				end
			2'b01:
				begin
				OP_Result_reg<=OP_A-OP_B;
				remainder_reg<=16'd0;
				end
			2'b10:
				begin
				OP_Result_reg<=OP_A*OP_B;
				remainder_reg<=16'd0;
				end
			2'b11:
				begin
				OP_Result_reg<=OP_A/OP_B;//商
				remainder_reg<=OP_A%OP_B;//余数
				end
			default:;
		endcase
	else
		begin
		OP_Result_reg<=OP_Result_reg;
		remainder_reg<=remainder_reg;
		end
		
endmodule

