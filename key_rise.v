//按键上升沿模块
module key_rise(
input clk,//时钟
input key_in,//按键输入
output key_out//按键上升沿
);

reg key_in_buf0;
reg key_in_buf1;
//按键打2拍
always@(posedge clk)
begin
	key_in_buf0<=key_in;
	key_in_buf1<=key_in_buf0;
end

assign key_out=key_in_buf0 & ~key_in_buf1;//按键上升沿
		
endmodule

