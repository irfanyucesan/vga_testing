`timescale 1ns / 1ps

module vgaimage(
input clk,
output vsync,
output hsync,
output reg red,
output reg green,
output reg blue);
    
wire [9:0] CounterX;
wire [8:0] CounterY;
wire ActiveArea;

vhsync syncgen
(
	.clk(clk),
	.hsync(hsync),
	.vsync(vsync),
	.ActiveArea(ActiveArea),
	.CounterX(CounterX),
	.CounterY(CounterY)
);

always @(posedge clk) begin

    if((ActiveArea) &&(CounterY<100)) begin // 100 pixel kalýn beyaz blok
        {blue,green,red}<=3'b111;
    end
    else if((ActiveArea) &&(CounterY>380)) begin // 100 pixel kalýn siyah blok
        {blue,green,red}<=3'b000;
    end
    else if ((ActiveArea) &&(CounterX<80)) begin // 3 bit renk inputu toplam 8 renk 640/8
        {blue,green,red}<= 3'b000;
    end
    else if ((ActiveArea) && (CounterX<160)) begin
        {blue,green,red}<= 3'b001;
    end
    else if ((ActiveArea) &&(CounterX<240)) begin
        {blue,green,red}<= 3'b010;
    end
    else if ((ActiveArea) &&(CounterX<320)) begin
        {blue,green,red}<= 3'b011;
    end
    else if ((ActiveArea) &&(CounterX<400)) begin
        {blue,green,red}<= 3'b100;
    end
    else if ((ActiveArea) &&(CounterX<480)) begin
        {blue,green,red}<= 3'b101;
    end
    else if ((ActiveArea) &&(CounterX<560)) begin
        {blue,green,red}<= 3'b110;
    end
    else if ((ActiveArea) &&(CounterX<640)) begin
        {blue,green,red}<= 3'b111;
    end
    else begin
        {blue,green,red}<=3'b000;
    end
end
endmodule