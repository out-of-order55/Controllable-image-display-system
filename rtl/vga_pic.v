`timescale  1ns/1ns


module  vga_pic
(
    input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
    input   wire    [11:0]  pix_x       ,   //输入VGA有效显示区域像素点X轴坐标
    input   wire    [11:0]  pix_y       ,   //输入VGA有效显示区域像素点Y轴坐标
	input	wire	[15:0]	pix_data0	,
	input	wire	[9:0]	x			,
	input	wire	[9:0]	y			,
	input	wire	[9:0]	w			,
	input	wire	[9:0]	h			,


    output  reg     [15:0]  pix_data        //输出像素点色彩信息
);


// //********************************************************************//
// //***************************** Main Code ****************************//
// //********************************************************************//
// parameter	x=10'd110,
			// y=10'd110,
			// w=10'd110,
			// h=10'd110;

		//parameter define
parameter   H_VALID =   10'd1280 ,   //行有效数据
            V_VALID =   10'd720 ;   //场有效数据
parameter	H_1		=	10'd110	,
			H_2		=	10'd550	,
			V_1		=	10'd110	,
			V_2		=	10'd480	;
parameter   RED     =   16'hF800,    //红色
			ORANGE  =   16'hFC00,   //橙色
            YELLOW  =   16'hFFE0,   //黄色
            GREEN   =   16'h07E0,   //绿色
            CYAN    =   16'h07FF,   //青色
            BLUE    =   16'h001F,   //蓝色
            PURPPLE =   16'hF81F,   //紫色
            BLACK   =   16'h0000,   //黑色
            WHITE   =   16'hFFFF,   //白色
            GRAY    =   16'hD69A;   //灰色

always@(posedge vga_clk or negedge sys_rst_n)
	begin
    if(sys_rst_n == 1'b0)
        pix_data  <= 16'd0;
	else	if(x==1'b0&&y==1'b0&&w==1'b0&&h==1'b0)
		pix_data	<=pix_data0;
	else
		if(pix_x>=x&&(pix_x<=x+w)&&pix_y==y)pix_data<=RED;
		else if((pix_x>=x&&(pix_x<=x+w))&&(pix_y==y+h))pix_data<=RED;
		else if(pix_x==x&&pix_y>=y&&(pix_y<=y+h))pix_data<=RED;
		else if((pix_x==x+w)&&pix_y>=y&&(pix_y<=y+h))pix_data<=RED;
		else
		pix_data<=pix_data0;
	end

endmodule
