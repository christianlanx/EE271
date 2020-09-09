onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Victory_testbench/clk
add wave -noupdate /Victory_testbench/reset
add wave -noupdate /Victory_testbench/l_in
add wave -noupdate /Victory_testbench/r_in
add wave -noupdate /Victory_testbench/l_on
add wave -noupdate /Victory_testbench/r_on
add wave -noupdate /Victory_testbench/out
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
WaveRestoreZoom {4085 ps} {5207 ps}
