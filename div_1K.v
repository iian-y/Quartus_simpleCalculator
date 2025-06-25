//分频模块，时钟分频到1KHz
module div_1K(
input clk,//50MHz
output reg clk_1KHz//时钟1KHz
);

reg [31:0] cnt=32'd0;
always@(posedge clk)
	if(cnt>=32'd100000)//计数--d100000
		cnt<=32'd0;
	else
		cnt<=cnt+32'd1;//计数0~50000

//输出1KHz		
always@(posedge clk)
	if(cnt>=32'd50000)//--d50000
		clk_1KHz<=1;//输出1KHz	
	else
		clk_1KHz<=0;

endmodule
