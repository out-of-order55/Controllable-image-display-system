module	uart_pro
(
	input	wire	sys_rst_n		,
	input	wire	sys_clk			,
	input	wire[7:0]	pi_data	,
	input	wire	pi_flag			,
	
	output	reg	[9:0]	x,
	output	reg	[9:0]	y,
	output	reg	[9:0]	w,
	output	reg	[9:0]	h
	
);
parameter   IDLE        =   4'b0000,    //初始状态
			X			=	4'b0001,//x坐标状态
			Y			=	4'b0010,//y坐标状态
			W			=	4'b0100,//宽度状态
			H			=	4'b1000,//高度状态
			END			=	4'b1001;

reg	[9:0]	data_pro[11:0]	;//将ASCII变为数字			
reg	[3:0]	cnt_data	;// 对pi_flag计数
reg	[3:0]	state			;
reg	[12:0]	baut_cnt	;
reg	[3:0]	cnt_dly		;
reg			flag		;
reg	[7:0]		pi_data_reg	;
// reg	[9:0]	data	;
// reg	[9:0]	data1	;
// reg	[9:0]	data2	;
// reg	[9:0]	data3	;
// reg	[9:0]	data4	;
// reg	[9:0]	data5	;
// reg	[9:0]	data6	;
// reg	[9:0]	data7	;
// reg	[9:0]	data8	;
// reg	[9:0]	data9	;
// reg	[9:0]	data10	;
// reg	[9:0]	data11	;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		pi_data_reg<=1'd0;
	else
		pi_data_reg<=pi_data;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		cnt_data<=1'b0;
	else	if(state==END)
		cnt_data<=1'b0;
	else	if(pi_flag==1'b1)
		cnt_data<=cnt_data+1'b1;
		
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		baut_cnt<=1'b0;
	else	if(baut_cnt==13'd5207)
		baut_cnt<=1'b0;
	else	if(state==H&&cnt_data==4'd12)
		baut_cnt<=baut_cnt+1'b1;
		
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		cnt_dly<=1'b0;
	else	if(state==END)
		cnt_dly<=cnt_dly+1'b1;
		
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		flag<=1'b0;
	else	if(cnt_dly==1'b0&&state==END)
		flag<=1'b1;
	else
		flag<=1'b0;
		
//还需要添加一个end状态,用来计算乘法和加法
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		state<=IDLE;
	else	case(state)
		IDLE:
			if(pi_flag==1'b1&&cnt_data==4'd0)
				state<=X;
			else
				state<=state;
		X:
			if(pi_flag==1'b1&&cnt_data==4'd3)
				state<=Y;
			else
				state<=state;
		Y:
			if(pi_flag==1'b1&&cnt_data==4'd6)
				state<=W;
			else
				state<=state;
		W:
			if(pi_flag==1'b1&&cnt_data==4'd9)
				state<=H;
			else
				state<=state;
		H:
			if(baut_cnt==13'd5207&&cnt_data==4'd12)
				state<=END;
			else
				state<=state;
		END:
			if(cnt_dly==4'd15)
				state<=IDLE;
			else
				state<=state;
				
		default:state<=IDLE;
		endcase

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		begin
		data_pro[0]<=1'b0;
		data_pro[1]<=1'b0;
		data_pro[2]<=1'b0;
		data_pro[3]<=1'b0;
		data_pro[4]<=1'b0;
		data_pro[5]<=1'b0;
		data_pro[6]<=1'b0;
		data_pro[7]<=1'b0;
		data_pro[8]<=1'b0;
		data_pro[9]<=1'b0;
		data_pro[10]<=1'b0;
		data_pro[11]<=1'b0;
			// data<=1'b0;
			// data1<=1'b0;
			// data2<=1'b0;
			// data3<=1'b0;
			// data4<=1'b0;
			// data5<=1'b0;
			// data6<=1'b0;
			// data7<=1'b0;
			// data8<=1'b0;
			// data9<=1'b0;
			// data10<=1'b0;
			// data11<=1'b0;
		end
	else	case(state)
		IDLE:
			begin
			data_pro[0]<=1'b0;
			data_pro[1]<=1'b0;
			data_pro[2]<=1'b0;
			data_pro[3]<=1'b0;
			data_pro[4]<=1'b0;
			data_pro[5]<=1'b0;
			data_pro[6]<=1'b0;
			data_pro[7]<=1'b0;
			data_pro[8]<=1'b0;
			data_pro[9]<=1'b0;
			data_pro[10]<=1'b0;
			data_pro[11]<=1'b0;
			// data<=1'b0;
			// data1<=1'b0;
			// data2<=1'b0;
			// data3<=1'b0;
			// data4<=1'b0;
			// data5<=1'b0;
			// data6<=1'b0;
			// data7<=1'b0;
			// data8<=1'b0;
			// data9<=1'b0;
			// data10<=1'b0;
			// data11<=1'b0;
			end
		X:
			if(cnt_data==4'd1)	
				data_pro[0]<=pi_data_reg-10'd48;	
				// data<=pi_data_reg-10'd48;

			else	if(cnt_data==4'd2)
				
				data_pro[1]<=pi_data_reg-10'd48;
				// data1<=pi_data_reg-10'd48;
				
			else	if(cnt_data==4'd3)
				data_pro[3]<=pi_data_reg-10'd48;
				// data2<=pi_data_reg-10'd48;
		Y:
			if(cnt_data==4'd4)	
				data_pro[3]<=pi_data_reg-10'd48;	

			else	if(cnt_data==4'd5)
				
				data_pro[4]<=pi_data_reg-10'd48;
				
			else	if(cnt_data==4'd6)
				data_pro[5]<=pi_data_reg-10'd48;
		W:
			if(cnt_data==4'd7)	
				data_pro[6]<=pi_data_reg-10'd48;	

			else	if(cnt_data==4'd8)
				
				data_pro[7]<=pi_data_reg-10'd48;
				
			else	if(cnt_data==4'd9)
				data_pro[8]<=pi_data_reg-10'd48;
		H:
			if(cnt_data==4'd10)	
				data_pro[9]<=pi_data_reg-10'd48;	

			else	if(cnt_data==4'd11)
				
				data_pro[10]<=pi_data_reg-10'd48;
				
			else	if(cnt_data==4'd12)
				data_pro[11]<=pi_data_reg-10'd48;
		END://乘法处理与加法计算
			if(flag==1'b1)
			begin
			// data<=data*100;
			// data1<=data1*10;
			data_pro[0]<=data_pro[0]*100;
			data_pro[1]<=data_pro[1]*10;
			data_pro[3]<=data_pro[3]*100;
			data_pro[4]<=data_pro[4]*10;
			data_pro[6]<=data_pro[6]*100;
			data_pro[7]<=data_pro[7]*10;
			data_pro[9]<=data_pro[9]*100;
			data_pro[10]<=data_pro[10]*10;
			end
			else
			begin
			data_pro[0]<=data_pro[0];
			data_pro[1]<=data_pro[1];
			data_pro[3]<=data_pro[3];
			data_pro[4]<=data_pro[4];
			data_pro[6]<=data_pro[6];
			data_pro[7]<=data_pro[7];
			data_pro[9]<=data_pro[9];
			data_pro[10]<=data_pro[10];
			end
		
		default:
			begin
			data_pro[0]<=1'b0;
			data_pro[1]<=1'b0;
			data_pro[2]<=1'b0;
			data_pro[3]<=1'b0;
			data_pro[4]<=1'b0;
			data_pro[5]<=1'b0;
			data_pro[6]<=1'b0;
			data_pro[7]<=1'b0;
			data_pro[8]<=1'b0;
			data_pro[9]<=1'b0;
			data_pro[10]<=1'b0;
			data_pro[11]<=1'b0;
			end
		endcase
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
		begin
		x<=1'b0;
		y<=1'b0;
		w<=1'b0;
		h<=1'b0;
		end
	else	if(cnt_dly==4'd15)
		begin
		x<=data_pro[0]+data_pro[1]+data_pro[2];
		y<=data_pro[3]+data_pro[4]+data_pro[5];
		w<=data_pro[6]+data_pro[7]+data_pro[8];
		h<=data_pro[9]+data_pro[10]+data_pro[11];
		end
    //可能是给数据处理预留的周期太少l
		
endmodule