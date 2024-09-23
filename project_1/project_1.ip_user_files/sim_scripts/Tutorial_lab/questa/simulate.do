onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Tutorial_lab_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {Tutorial_lab.udo}

run -all

quit -force
