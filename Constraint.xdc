## Clock from BTN0 (T17)
set_property PACKAGE_PIN T17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

## Reset button
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## LED Mapping
set_property PACKAGE_PIN U16 [get_ports {debug_leds[0]}]
set_property PACKAGE_PIN E19 [get_ports {debug_leds[1]}]
set_property PACKAGE_PIN U19 [get_ports {debug_leds[2]}]
set_property PACKAGE_PIN V19 [get_ports {debug_leds[3]}]
set_property PACKAGE_PIN W18 [get_ports {debug_leds[4]}]
set_property PACKAGE_PIN U15 [get_ports {debug_leds[5]}]
set_property PACKAGE_PIN U14 [get_ports {debug_leds[6]}]
set_property PACKAGE_PIN V14 [get_ports {debug_leds[7]}]
set_property PACKAGE_PIN V13 [get_ports {debug_leds[8]}]
set_property PACKAGE_PIN V3  [get_ports {debug_leds[9]}]
set_property PACKAGE_PIN W3  [get_ports {debug_leds[10]}]
set_property PACKAGE_PIN U3  [get_ports {debug_leds[11]}]
set_property PACKAGE_PIN P3  [get_ports {debug_leds[12]}]
set_property PACKAGE_PIN N3  [get_ports {debug_leds[13]}]
set_property PACKAGE_PIN P1  [get_ports {debug_leds[14]}]
set_property PACKAGE_PIN L1  [get_ports {debug_leds[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {debug_leds[*]}]
