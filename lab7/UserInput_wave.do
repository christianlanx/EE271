onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UserInput_testbench/clk
add wave -noupdate /UserInput_testbench/reset
add wave -noupdate -expand /UserInput_testbench/buttons
add wave -noupdate -expand /UserInput_testbench/out
add wave -noupdate /UserInput_testbench/dut/ps
add wave -noupdate /UserInput_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {432 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
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
WaveRestoreZoom {1336 ps} {2824 ps}
