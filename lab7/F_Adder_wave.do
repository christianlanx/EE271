onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /F_Adder_testbench/A
add wave -noupdate /F_Adder_testbench/B
add wave -noupdate /F_Adder_testbench/c_in
add wave -noupdate /F_Adder_testbench/out
add wave -noupdate /F_Adder_testbench/c_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {1 ns}
