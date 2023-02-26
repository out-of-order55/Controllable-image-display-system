`timescale  1ns/1ns
module	tb_vga_ctrl();

reg			vga_clk,sys_rst_n;
reg	[9:0]	x,y,w,h;
reg	[15:0]	pix_data;
wire	[11:0]	pix_x,pix_y;
reg				key_flag;

wire            pix_data_req;
wire            hsync       ;
wire            vsync       ;
wire            rgb_valid   ;
wire	[15:0]	pix_data1	;
wire			frame		;
wire			frame_begin	;
wire			frame_end	;
                            
wire	[15:0]	rgb			;


initial begin
        vga_clk    = 1'b1;
        sys_rst_n <= 1'b0;
		key_flag<=1'b0;
        #20;
        sys_rst_n <= 1'b1;
		key_flag<=1'b1;
		#20;
		key_flag<=1'b0;
end

always  #20 vga_clk =   ~vga_clk;

initial	begin

		x<=1'b0;
		y<=1'b0;
		w<=1'b0;
		h<=1'b0;
		
end

always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <=  16'h0;
    else
        pix_data    <=  16'hffff;
		
		
vga_ctrl  vga_ctrl_inst
(
	.vga_clk    	(vga_clk)	 ,
	.sys_rst_n   	(sys_rst_n)	,
	.pix_data    	(pix_data)	,
	.x				(x)	,
	.y				(y)	,
	.w				(w)	,
	.h				(h)	,
	.key_flag		(key_flag),
	
	.pix_data_req	(pix_data_req)	,
	.pix_x       	(pix_x)	,
	.pix_y       	(pix_y)	,
	.hsync      	(hsync)	 ,
	.vsync      	(vsync)	 ,
	.rgb_valid  	(rgb_valid)	 ,
	.pix_data1		(pix_data1)	,
	.frame			(frame)	,
	.frame_begin	(frame_begin)	,
	.frame_end		(frame_end)	,
	.rgb			(rgb)


 
);
endmodule
