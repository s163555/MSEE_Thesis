# PWM with generic dead band and duty cycle resolution


```python
from pynq import Overlay
ol=Overlay("pwm_ultrasound_pulser.bit")

from pynq import MMIO
RANGE = 8 # Number of bytes; 8/4 = 2x 32-bit locations which is all we need for this example

duty_address = ol.ip_dict['axi_gpio_duty']['phys_addr']
duty_register = MMIO(duty_address, RANGE)
# Write 0x00 to the tri-state register at offset 0x4 to configure the IO as outputs.
duty_register.write(0x4, 0x0) # Write 0x0 to location 0x4; Set tri-state to output

band_address = ol.ip_dict['axi_gpio_band']['phys_addr']
band_register = MMIO(band_address, RANGE)
# Write 0x00 to the tri-state register at offset 0x4 to configure the IO as outputs.
band_register.write(0x4, 0x0) # Write 0x0 to location 0x4; Set tri-state to output

flags_address = ol.ip_dict['axi_gpio_flags']['phys_addr']
flags_register = MMIO(flags_address, RANGE)
# Write 0x00 to the tri-state register at offset 0x4 to configure the IO as outputs.
flags_register.write(0x4, 0x0) # Write 0x0 to location 0x4; Set tri-state to output

start_delay_address = ol.ip_dict['axi_gpio_start_delay']['phys_addr']
start_delay_register = MMIO(start_delay_address, RANGE)
# Write 0x00 to the tri-state register at offset 0x4 to configure the IO as outputs.
start_delay_register.write(0x4, 0x0) # Write 0x0 to location 0x4; Set tri-state to output

train_length_address = ol.ip_dict['axi_gpio_train_length']['phys_addr']
train_length_register = MMIO(train_length_address, RANGE)
# Write 0x00 to the tri-state register at offset 0x4 to configure the IO as outputs.
train_length_register.write(0x4, 0x0) # Write 0x0 to location 0x4; Set tri-state to output

gate_delay_address = ol.ip_dict['axi_gpio_gate_delay']['phys_addr']
gate_delay_register = MMIO(gate_delay_address, RANGE)
# Write 0x00 to the tri-state register at offset 0x4 to configure the IO as outputs.
gate_delay_register.write(0x4, 0x0) # Write 0x0 to location 0x4; Set tri-state to output


def duty(duty):
    duty_register.write(0x00, duty)

def band(band):
    band_register.write(0x00, band)

def dutypct(duty):
    duty_register.write(0x00, round((0x1F*2)/(100/duty)))

def fire():
    flags_register.write(0x00, 1) # bit 0
    flags_register.write(0x00, 0)

def prime():
    flags_register.write(0x00, 2) # bit 1
    flags_register.write(0x00, 0)

def startdelay(startdelay):
    start_delay_register.write(0x0, startdelay);

def trainlength(trainlength):
    train_length_register.write(0x0, trainlength);

def gatedelay(gatedelay):
    gate_delay_register.write(0x0, gatedelay);
```

```python
duty(0x1F)
```


```python
dutypct(50)
```


```python
band(4)
```


```python
startdelay(20)
```


```python
trainlength(127)
```


```python
gatedelay(20)
```


```python
prime()
```


```python
fire()
```


```python
band(0)
startdelay(20)
trainlength(96)
gatedelay(20)
prime()
fire()
```


```python
band(2)
startdelay(20)
trainlength(98)
gatedelay(20)
prime()
fire()
```


```python
band(2)
startdelay(40)
trainlength(291)
prime()
fire()
```


```python
band(5)
startdelay(200)
trainlength(580)
gatedelay(200)
prime()
fire()
```


```python
band(10)
startdelay(1000)
trainlength(294)
gatedelay(500)
try:
    while True:
        prime()
        fire()
except KeyboardInterrupt:
    pass
```


```python

```
