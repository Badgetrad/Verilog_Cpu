import sys
import shrike
from machine import Pin, SPI
import time

# --- Pin Routing ---
SPI_ID = 0
SCK_PIN = 2
MOSI_PIN = 3
MISO_PIN = 0
CS_PIN = 1

# --- Reset (active low: reset asserted when pin = 0) ---
reset_pin = Pin(14, Pin.OUT, value=1)

def reset_cpu():
    reset_pin.value(0)      # assert reset
    time.sleep_ms(100)
    reset_pin.value(1)      # release reset
    time.sleep_ms(100)

# --- SPI Setup ---
cs = Pin(CS_PIN, Pin.OUT, value=1)
spi = SPI(
    SPI_ID,
    baudrate=1_000_000,
    polarity=0,
    phase=0,
    bits=8,
    firstbit=SPI.MSB,
    sck=Pin(SCK_PIN),
    mosi=Pin(MOSI_PIN),
    miso=Pin(MISO_PIN)
)

def spi_exchange(tx_byte):
    tx = bytes([tx_byte])
    rx = bytearray(1)
    cs.value(0)
    spi.write_readinto(tx, rx)
    cs.value(1)
    time.sleep_ms(2)  
    return rx[0]

def send_program(program):
    for byte in program:
        resp = spi_exchange(byte)
        print(f"Sent 0x{byte:02X}, Received 0x{resp:02X}")


print(f"Starting SPI on {sys.platform}")
reset_cpu()

while True:
    resp = spi_exchange(0x00)  # dummy byte to clock data out over MISO
    print(f"R1 = {resp} (0x{resp:02X})")
    time.sleep(1)