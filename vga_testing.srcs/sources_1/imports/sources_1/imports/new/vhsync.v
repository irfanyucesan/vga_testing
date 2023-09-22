module vhsync(
input  clk,
output hsync,
output vsync,
output reg ActiveArea,
output reg [9:0] CounterX,
output reg [8:0] CounterY);

//////////////////////////////////////////////////
clk_wiz_0 instance_name
(
    // Clock out ports
    .CLK_24MHZ(CLK_24MHZ),     // output CLK_24MHZ
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);
//////////////////////////////////////////////////

reg	vga_HS, vga_VS;

always @(posedge CLK_24MHZ)begin
	CounterX <= CounterX + 1;
    if(CounterX==800)begin 
        CounterX <= 0;
        CounterY <= CounterY + 1;
        if(CounterY==525)begin
            CounterY<=0;
        end
    end
end

always @(posedge CLK_24MHZ)
begin
	vga_HS <= ((CounterX > (640+16)) && (CounterX<(640+16+96)));
	vga_VS <= ((CounterY > (480+10)) && (CounterY<(480+10+2))); 
	ActiveArea <= (CounterX<640) && (CounterY<480);
end

assign hsync = ~vga_HS;
assign vsync = ~vga_VS;

endmodule