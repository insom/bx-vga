// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    output LED,   // User/boot LED next to power LED
    output USBPU, // USB pull-up resistor
    output PIN_13,
    output PIN_14,
    output PIN_16, // HS
    output PIN_17, // VS
    output PIN_20, // Green
);
    assign USBPU = 0;
    reg [25:0] blink_counter;
    wire [31:0] blink_pattern = 32'b101010001110111011100010101;

    always @(posedge CLK) begin
        blink_counter <= blink_counter + 1;
    end
    
    // light up the LED according to the pattern
    assign LED = blink_pattern[blink_counter[25:21]];
    assign PIN_14 = blink_counter[3];

    reg mhz25;

    pll foo(
        .clock_in(CLK),
        .clock_out(mhz25), 
        .locked(PIN_13)
        );

    reg [9:0] x;
    reg [9:0] y;
    reg valid;

    // Thanks Ken Sheriff for these three :-)
    assign PIN_16 = x < (640 + 16) || x >= (640 + 16 + 96);
    assign PIN_17 = y < (480 + 10) || y >= (480 + 10 + 2);
    assign valid = (x < 640) && (y < 480);

    always @(posedge mhz25) begin
      if (x < 799) begin
        x <= x + 1;
      end else begin
        x <= 0;
        if (y <= 525) begin
          y <= y + 1;
        end else begin
          y <= 0;
        end
      end
      // Let's do checkerboards to it
      if (x[4] == 0 ) begin
          PIN_20 <= y[4];
      end else begin
          PIN_20 <= ~y[4];
      end
    end
endmodule
