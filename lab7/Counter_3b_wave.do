onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Counter_3b_testbench/clk
add wave -noupdate /Counter_3b_testbench/reset
add wave -noupdate /Counter_3b_testbench/in
add wave -noupdate -radix unsigned /Counter_3b_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {900 ps} {1900 ps}
