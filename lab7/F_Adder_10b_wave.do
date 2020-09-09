onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /F_Adder_10b_testbench/A
add wave -noupdate -radix unsigned /F_Adder_10b_testbench/B
add wave -noupdate /F_Adder_10b_testbench/c_in
add wave -noupdate -radix unsigned -childformat {{{/F_Adder_10b_testbench/out[9]} -radix unsigned} {{/F_Adder_10b_testbench/out[8]} -radix unsigned} {{/F_Adder_10b_testbench/out[7]} -radix unsigned} {{/F_Adder_10b_testbench/out[6]} -radix unsigned} {{/F_Adder_10b_testbench/out[5]} -radix unsigned} {{/F_Adder_10b_testbench/out[4]} -radix unsigned} {{/F_Adder_10b_testbench/out[3]} -radix unsigned} {{/F_Adder_10b_testbench/out[2]} -radix unsigned} {{/F_Adder_10b_testbench/out[1]} -radix unsigned} {{/F_Adder_10b_testbench/out[0]} -radix unsigned}} -subitemconfig {{/F_Adder_10b_testbench/out[9]} {-radix unsigned} {/F_Adder_10b_testbench/out[8]} {-radix unsigned} {/F_Adder_10b_testbench/out[7]} {-radix unsigned} {/F_Adder_10b_testbench/out[6]} {-radix unsigned} {/F_Adder_10b_testbench/out[5]} {-radix unsigned} {/F_Adder_10b_testbench/out[4]} {-radix unsigned} {/F_Adder_10b_testbench/out[3]} {-radix unsigned} {/F_Adder_10b_testbench/out[2]} {-radix unsigned} {/F_Adder_10b_testbench/out[1]} {-radix unsigned} {/F_Adder_10b_testbench/out[0]} {-radix unsigned}} /F_Adder_10b_testbench/out
add wave -noupdate /F_Adder_10b_testbench/c_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20969801 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {20969801 ps} {20970730 ps}
