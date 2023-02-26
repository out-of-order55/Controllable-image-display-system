module  frame_gen
(
    input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
	input	wire			key_flag	,
	
	output	reg				frame		//一帧的信号

);
//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//parameter define
//1280*720
parameter H_SYNC    =   12'd40  ,   //行同步
          H_BACK    =   12'd220 ,   //行时序后沿
          H_LEFT    =   12'd0   ,   //行时序左边框
          H_VALID   =   12'd1280,   //行有效数据
          H_RIGHT   =   12'd0   ,   //行时序右边框
          H_FRONT   =   12'd110 ,   //行时序前沿
          H_TOTAL   =   12'd1650;   //行扫描周期
parameter V_SYNC    =   12'd5   ,   //场同步
          V_BACK    =   12'd20  ,   //场时序后沿
          V_TOP     =   12'd0   ,   //场时序上边框
          V_VALID   =   12'd720 ,   //场有效数据
          V_BOTTOM  =   12'd0   ,   //场时序下边框
          V_FRONT   =   12'd5   ,   //场时序前沿
          V_TOTAL   =   12'd750 ;   //场扫描周期

//reg   define
reg     [11:0]   cnt_h           ;   //行同步信号计数器
reg     [11:0]   cnt_v           ;   //场同步信号计数器


//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//cnt_h:行同步信号计数器
always@(posedge vga_clk or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_h   <=  12'd0   ;
    else    if(cnt_h == H_TOTAL - 1'd1)
        cnt_h   <=  12'd0   ;
    else
        cnt_h   <=  cnt_h + 1'd1   ;

//hsync:行同步信号
assign  hsync = (cnt_h  <=  H_SYNC - 1'd1) ? 1'b1 : 1'b0  ;

//cnt_v:场同步信号计数器
always@(posedge vga_clk or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_v   <=  12'd0 ;
    else    if((cnt_v == V_TOTAL - 1'd1) &&  (cnt_h == H_TOTAL-1'd1))
        cnt_v   <=  12'd0 ;
    else    if(cnt_h == H_TOTAL - 1'd1)
        cnt_v   <=  cnt_v + 1'd1 ;
    else
        cnt_v   <=  cnt_v ;

//vsync:场同步信号
assign  vsync = (cnt_v  <=  V_SYNC - 1'd1) ? 1'b1 : 1'b0  ;

//rgb_valid:VGA有效显示区域
assign  rgb_valid = (((cnt_h >= H_SYNC + H_BACK + H_LEFT)
                    && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID))
                    &&((cnt_v >= V_SYNC + V_BACK + V_TOP)
                    && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID)))
                    ? 1'b1 : 1'b0;

//pix_data_req:像素点色彩信息请求信号,超前rgb_valid信号一个时钟周期
assign  pix_data_req = (((cnt_h >= H_SYNC + H_BACK + H_LEFT - 1'b1)
                    && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID - 1'b1))
                    &&((cnt_v >= V_SYNC + V_BACK + V_TOP)
                    && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID)))
                    ? 1'b1 : 1'b0;
				
//对帧开始信号和帧截至信号赋值
assign	frame_begin=(cnt_h==1'b1&&cnt_v==1'b0)?1'b1:1'b0;
assign	frame_end=(cnt_h==H_TOTAL-1&&cnt_v==V_TOTAL-1)?1'b1:1'b0;

//帧信号
always@(*)
	if(sys_rst_n == 1'b0)
		frame<=1'b0;
	else	if(key_flag==1'b1&&cnt_v==1'b0&&cnt_h==1'b0)
		frame<=1'b1;
	else	if(cnt_v==V_TOTAL-1'b1)
		frame<=1'b0;
	else
		frame<=frame;
	




endmodule
