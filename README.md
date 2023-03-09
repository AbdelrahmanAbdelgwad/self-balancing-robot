# Overview
A self-balancing robot is a type of robot that can maintain its balance on two wheels. This repository presents the development process of a self-balancing robot using the [OSOYOO Two Wheel Self Balancing Car Kit](https://osoyoo.com/2018/07/18/osoyoo-balancing-car/). The kit includes: an Arduino board, an MPU-6050 sensor, and DC motors. The goal of the project is to design and implement a control algorithm for the robot, and to test its performance under different conditions. The robot was built to have a two-wheeled structure with a platform to carry some payloads. The MPU-6050 sensor was used to measure the tilt angle of the robot and the Arduino board was used to control the motors based on the control algorithm.

# System modeling
The state-space model was developed based on the book [Development of a Self-Balancing Two-Wheeled Robot](http://kth.diva-portal.org/smash/record.jsf?pid=diva2%3A550532&dswid=-7832), using Lagrange equation. A MATLAB code was developed to calculate the state space matrices (A, B, C, D) based on the model derived in the book and the robot parameters (e.g. mass, inertia, etc...). You can find the MATLAB code in control_design/SB_Model.m .
 

# Controller Design
## Controller Desin VI
A VI on LabVIEW was designed to convert the state space model into a transfer function relating the tilt angle and the motor torque. The same LabView VI was used to figure out the system response using the root locus which was used to design a PID controller. The PID controller was chosen as it provides good performance, it's simple and easy to implement, also it's good to handle the robot's stability. You can find the VI in control_design/PID_design_for_project.vi.
## Controller Design Process
Looking at the root locus of the uncompensated system, we immediately find that we need to add a zero to bend the root locus and cause our closed loop poles to be in the stable region. This would make a PD controller very suitable for the job. However, we needed to add the integral gain due to the lack of the pole at the origin. If the integral part was not added, the compensated system would still face a steady state error.

# Control Implementation
The `LabVIEW LINX Toolkit` was used to interface with the Arduino UNO using serial communication. The interface was designed to read both the accelerometer and gyroscope readings from the MPU6050. The tilt angle was estimated using a complementary filter where both readings were taken into consideration.

# Calibration and Fine-tuning
## Sensor Calibration
The MPU-6050 sensor was calibrated to correct for scale offset and shift offset errors. The calibration process was done by measuring the angle in multiple positions to get the offset values of the sensor. In our case, we were tried using a complementary filter which normally solves the problems of gyroscope and accelerometer inaccuracies. However, in our case, the accelerometer readings were so noisy, so they caused the robot to overshoot a lot which causes system failure. Due to this, The most reasonable response we got was using the gyro-scope readings only, but this leads us back to the gyroscope problem. gyroscopes are subject to bias instabilities, in which the initial zero reading of the gyroscope will cause drift over time due to integration of inherent imperfections and noise within the device. This means that it is very dependent on the initial condition.
## PID tuning
Once the sensor was calibrated, the PID controller was fine-tuned to achieve good performance for the robot. During the fine-tuning, the robot was tested under different surfaces and so we noticed that friction has a very large impact on the system response. In some cases, we would even need to tune the PID parame-ters all over again. This is somehow expected since we assumed a coefficient of friction of 0.1 when modeling. So our system is not robust when it comes to changing friction.

# Results and Analysis
The robot was tested under different conditions and the results showed a very good performance, the robot was able to maintain its balance in different conditions and handle small disturbances. The robot showed good stability and the angle measurements from the MPU-6050 sensor were accurate and reliable. The robot was able to handle different payloads. A graph of the angle measurements was plotted over time, and it showed a good response of the controller. However, it was observed that when the surface was slippery, the performance of the controller was affected, and some fine-tuning of the gains was necessary.

# Conclusion
The development of this self-balancing robot showed a good result, it's able to maintain its balance and handle small disturbances. The controller design and fine-tuning process were successful, and the robot showed good performance. However, the robot showed some limitations, like the effect of the surface condition on the performance of the controller. 

## Demo
Check out a demo of the robot in action: [Video Link](https://youtube.com/shorts/erfIMBBUoqQ?feature=share)

# Future Work
- `Full state feedback control`: Use full state feedback control instead of PID control. Full state feedback is a more advanced control technique than PID controller, which could provide more precise control over the robot's movement and allow it to per-form more complex tasks. This approach would need an accurate mathematical model of the system. Also, full state feedback would allow us to regulate the tilt an-gle while also selecting a reference robot linear speed (A Servo System).
- `Kalman Filter` for Sensor Fusion: Generally, using a Kalman filter improves sensor readings and reduce noise and bias errors. This would improve the robot's perfor-mance by providing it with more accurate and stable estimates of the state, which would allow the control algorithm to make more accurate decisions. Also, it would solve its current dependency on the initial angle condition.
- Building the code on the `Arduino Compatible Compiler for LabVIEW` instead of using a firmware library such as LINX, allows for the binary code to be uploaded to the on-board flash memory of the target Arduino board. This would enable the mi-crocontroller on the board to execute the code, in a standalone fashion, without the need for a constant communication link with a host computer once the code is up-loaded. This would make the embedded system more autonomous, and thus more suited for field deployment in portable and practical applications, as it eliminates the need for a PC.
- Improving `Robustness`: Improving the robot's robustness to external factors such as surface conditions or mass changes (due to various payloads). This would make the robot more widely applicable and able to work under different conditions.

