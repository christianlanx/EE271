onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /NormalLight_testbench/clk
add wave -noupdate /NormalLight_testbench/reset
add wave -noupdate /NormalLight_testbench/is_center
add wave -noupdate /NormalLight_testbench/l_in
add wave -noupdate /NormalLight_testbench/r_in
add wave -noupdate /NormalLight_testbench/l_on
add wave -noupdate /NormalLight_testbench/r_on
add wave -noupdate /NormalLight_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 371
configure wave -valuecolwidth 38
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2900 ps} {3771 ps}
