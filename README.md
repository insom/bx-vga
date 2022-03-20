bx-vga
------

Hello FPGA world -- when built with `apio build` and uploaded to a
[TinyFPGA-BX][bx], this Verilog will output a VGA compatible signal on pins
16(HSync), 17(VSync) and 20(Pixel Data).

[bx]: https://store.tinyfpga.com/products/tinyfpga-bx

### Wiring

```
FPGA            VGA

16  ------------  13
17  ------------  14
20  -- 220Ohm --   3
GND ------------   1
GND ------------   2
```
