module Binary_to_BCD(number, mille, hundreds, tens, ones);
   // I/O Signal Definitions
   input  [31:0] number;
	output reg [3:0] mille;
   output reg [3:0] hundreds;
   output reg [3:0] tens;
   output reg [3:0] ones;
   
   // Internal variable for storing bits
   reg [23:0] shift;
   integer i;
   
   always @(number)
   begin
      // Clear previous number and store new number in shift register
      shift[23:8] = 0;
      shift[7:0]  = number;
      
      // Loop eight times
      for (i=0; i<8; i=i+1)
		begin
         if (shift[11:8] >= 5)
            shift[11:8]  = shift[11:8] + 3;
            
         if (shift[15:12] >= 5)
            shift[15:12] = shift[15:12] + 3;
            
         if (shift[19:16] >= 5)
            shift[19:16] = shift[19:16] + 3;
				
			if (shift[23:20] >= 5)
				shift[23:20] = shift[23:20] + 3;
         
         // Shift entire register left once
         shift = shift << 1;
      end
      
      // Push decimal numbers to output
      mille		= shift[23:20];
		hundreds = shift[19:16];
      tens     = shift[15:12];
      ones     = shift[11:8];
   end
 
endmodule
