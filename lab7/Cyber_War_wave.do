onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Cyber_War_Testbench/CLOCK_50
add wave -noupdate /Cyber_War_Testbench/HEX0
add wave -noupdate /Cyber_War_Testbench/HEX5
add wave -noupdate /Cyber_War_Testbench/LEDR
add wave -noupdate /Cyber_War_Testbench/SW
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
WaveRestoreZoom {0 ps} {1488 ps}
