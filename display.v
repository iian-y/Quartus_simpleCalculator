//数码管显示模块
module display(
input clk,//时钟
input [15:0] OP_A,//输入的操作数A
input [15:0] OP_B,//输入的操作数B
input [31:0] OP_Result,//结果
input [2:0] current_state,//当前状态
//所以数码管的段线、位线均为高电平时数码管方可点亮
output reg [7:0] bit_sel,//数码管位选
output reg [7:0] segment//数码管段选
);

parameter s_first=3'd0;
parameter s_calcul=3'd1;
parameter s_second=3'd2;
parameter s_enter=3'd3;
parameter s_result=3'd4;
parameter s_continue=3'd5;

reg [2:0] seg_select=3'd0;//数码管位号
always @(posedge clk )  
begin
	seg_select <= seg_select + 3'd1;//加1，0~7，扫描哪个管子的指示位
end

reg [3:0] number=4'd0;
always @(posedge clk )//位选切换
begin
if(current_state==s_result)//显示结果
	case (seg_select)  
		3'd7:
			begin
			bit_sel<=8'b10000000;
			number <= OP_Result/10000000%10;//OP_Result千万位
			end
		3'd6:
			begin 
			bit_sel<=8'b01000000;
			number <= OP_Result/1000000%10;//OP_Result百万位
			end 
		3'd5:
			begin
			bit_sel<=8'b00100000;
			number<= OP_Result/100000%10;//OP_Result十万位
			end
		3'd4:
			begin 
			bit_sel<=8'b00010000;
			number <=OP_Result/10000%10;//OP_Result万位
			end
		3'd3:
			begin
			bit_sel<=8'b00001000;
			number <= OP_Result/1000%10;//OP_Result千位
			end
		3'd2:
			begin 
			bit_sel<=8'b00000100;
			number <= OP_Result/100%10;//OP_Result百位
			end 
		3'd1:
			begin
			bit_sel<=8'b00000010;
			number<= OP_Result/10%10;//OP_Result十位
			end
		3'd0:
			begin 
			bit_sel<=8'b00000001;
			number <=OP_Result%10;//OP_Result个位
			end		
		default:
			begin
			bit_sel<=bit_sel;
			number <= 4'd0;
			end
	endcase

else//显示AB值
	case (seg_select)  
		3'd7:
			begin
			bit_sel<=8'b10000000;
			number <= OP_A/1000;//OP_A千位
			end
		3'd6:
			begin 
			bit_sel<=8'b01000000;
			number <= OP_A/100%10;//OP_A百位
			end 
		3'd5:
			begin
			bit_sel<=8'b00100000;
			number<= OP_A/10%10;//OP_A十位
			end
		3'd4:
			begin 
			bit_sel<=8'b00010000;
			number <=OP_A%10;//OP_A个位
			end
		3'd3:
			begin
			bit_sel<=8'b00001000;
			number <= OP_B/1000%10;//OP_B千位
			end
		3'd2:
			begin 
			bit_sel<=8'b00000100;
			number <= OP_B/100%10;//OP_B百位
			end 
		3'd1:
			begin
			bit_sel<=8'b00000010;
			number<= OP_B/10%10;//OP_B十位
			end
		3'd0:
			begin 
			bit_sel<=8'b00000001;
			number <=OP_B%10;//OP_B个位
			end		
		default:
			begin
			bit_sel<=bit_sel;
			number <= 4'd0;
			end
	endcase

end 

////////////////////////////////////////////////////段选输出///////////////////////////////////////////
always @(number)
begin
	case (number)  //数字显示码	
	4'd0: segment= ~8'b1100_0000;
	4'd1: segment= ~8'b1111_1001;
	4'd2: segment= ~8'b1010_0100;
	4'd3: segment= ~8'b1011_0000;
	4'd4: segment= ~8'b1001_1001;
	4'd5: segment= ~8'b1001_0010;
	4'd6: segment= ~8'b1000_0010;
	4'd7: segment= ~8'b1111_1000;
	4'd8: segment= ~8'b1000_0000;
	4'd9: segment= ~8'b1001_0000;
	default:;
	endcase
end


endmodule
