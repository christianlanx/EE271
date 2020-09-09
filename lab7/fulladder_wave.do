onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullladder_testbench/A
add wave -noupdate /fullladder_testbench/B
add wave -noupdate /fullladder_testbench/c_in
add wave -noupdate /fullladder_testbench/out
add wave -noupdate /fullladder_testbench/c_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 199
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
WaveRestoreZoom {0 ps} {92 ps}
