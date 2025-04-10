module CPU16 (
    input  wire        clk,
    input  wire        reset,
    output wire [15:0] debug_leds // LED
);
    // Wires for interconnections
    wire    [15:0]   pc_current;
    wire    [15:0]   pc_next;
    wire             pc_load;
    wire    [15:0]   instr;
    wire    [3:0]    opcode;
    wire    [3:0]    rt;
    wire    [3:0]    rs;
    wire    [3:0]    func;
    wire    [11:0]   addr;        // jump address field
    wire    [15:0]   reg_data1;
    wire    [15:0]   reg_data2;
    wire    [15:0]   imm_ext;
    wire    [15:0]   alu_in2;
    wire    [15:0]   alu_out;
    wire             alu_zero;
    wire    [15:0]   mem_data;    // data memory read output
    wire    [15:0]   write_data;
    // Control signals
    wire             RegWrite, 
                     MemWrite, 
                     MemRead, 
                     ALUSrc, 
                     MemtoReg, 
                     Jump;
    wire    [3:0]    ALUControl;
    wire             branch_taken;
    wire    [15:0]   branch_target;
    wire    [15:0]   jump_target;

    ProgramCounter PC(
        .clk(clk), 
        .reset(reset), 
        .pc_in(pc_next), 
        .load(pc_load), 
        .pc_out(pc_current)
    );
    
    InstructionMemory IM(
        .addr(pc_current), 
        .instr(instr)
    );
    
    RegisterFile RF(
        .clk(clk), .reset(reset),
        .RegWrite(RegWrite),
        .read_reg1(rs), 
        .read_reg2(rt),
        .write_reg(rt), 
        .write_data(write_data),
        .read_data1(reg_data1), 
        .read_data2(reg_data2),
        .debug_out(debug_signal)   // New debug Out
    );
    
    ALU alu(
        .A(reg_data1), .B(alu_in2), .ALUControl(ALUControl), 
        .ALUOut(alu_out), .Zero(alu_zero)
    );
    
    DataMemory DM(
        .clk(clk), .MemWrite(MemWrite), .MemRead(MemRead),
        .addr(alu_out), .write_data(reg_data2), .read_data(mem_data)
    );
    
    SignExt4 signext(.in(instr[3:0]), .out(imm_ext));
    
    ControlUnit CTRL(
        .opcode(opcode), .func(func),
        .RegWrite(RegWrite), .MemWrite(MemWrite), .MemRead(MemRead),
        .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .Jump(Jump),
        .ALUControl(ALUControl)
    );
    
    Mux2 aluSrcMux(.in0(reg_data2), .in1(imm_ext), .select(ALUSrc), .out(alu_in2));
    Mux2 wbMux(.in0(alu_out), .in1(mem_data), .select(MemtoReg), .out(write_data));

    // Decode instruction fields
    assign opcode = instr[15:12];
    assign rt     = instr[11:8];
    assign rs     = instr[7:4];
    assign func   = instr[3:0];
    assign addr   = instr[11:0];

    // Branch condition logic
    assign branch_taken = ((opcode == 4'b0100) && alu_zero)   ||   // beq and Zero=1
                          ((opcode == 4'b0101) && !alu_zero);      // bne and Zero=0

    // Compute branch and jump target addresses
    assign branch_target = pc_current + 16'd2 + { {14{instr[3]}}, instr[3:0], 1'b0 };
    assign jump_target   = pc_current + 16'd2 + { {4{addr[11]}}, addr, 1'b0 };

    // PC control: decide when to load new PC
    assign pc_load = Jump || branch_taken;
    assign pc_next = Jump ? jump_target :
                     branch_taken ? branch_target :
                     16'b0;
    
    reg [15:0] led_value;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led_value <= 16'h0000;
        end else begin
            if (RegWrite)
                led_value <= write_data;
        end
    end

    assign debug_leds = led_value;
endmodule
