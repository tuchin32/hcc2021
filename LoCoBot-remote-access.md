# LoCoBot Network Setup and Remote Access 

###### tags : `SIS2021`

# Hardware and Software Setup

## LoCoBot

The LoCoBot is a low-cost mobile manipulator suitable for both navigation and manipulation from Carnegie Mellon University(CMU) and designed to run Facebook AI's PyRobot. PyRobot is an open source, lightweight, high-level interface on top of the robot operating system (ROS).

> The default LoCoBot is built on as following 
- Yujin Robot Kobuki Base (YMR-K01-W1)
- Intel NUC NUC8i3BEH core i3 Mini PC
- WidowX 200 Mobile Manipulator
- Intel® RealSense™ Depth Camera D435
![](https://i.imgur.com/3pOKess.jpg) \
Fig.1 LoCoBot basic setup


The LoCoBot's NUC is no GPU, so we added Xavier-NX to execute perception algorithms or deep learning model, and also used switch let NUC, Xavier-NX and laptop can connect each other.

> For the sis2021 course required
- Xavier-Nx
- Switch
![](https://i.imgur.com/vndu35K.jpg) \
Fig.2 Addition setup

## Network setup

Xavier-NX and NUC are connected to switch by RJ45 so that can connect each other and connect wifi to use Internet.  The LoCoBot and Xavier-NX password are **locobot** and **111111**, respectively.

![](https://i.imgur.com/K7OEK8j.png) \
Fig.3 LoCoBot network setup


> LoCoBot wired fix ip

- Xavier-NX is 10.42.0.3
- NUC is 10.42.0.2

> LoCoBot's hostname

| LoCoBot  | Jetson hostname   | NUC hostname   |
|:--------:|:-----------------:|:--------------:|
| 1        | xavier-nx01       | locobot        |
| 2        | xavier-nx02       | locobot        |
| 3        | xavier-nx03       | locobot        |
| 4        | xavier-nx04       | locobot        |
| 5        | xavier-nx05       | locobot        |
| 6        | xavier-nx06       | locobot        |
| 7        | xavier-nx07       | locobot        |
| 8        | xavier-nx08       | locobot        |
| 9        | xavier-nx09       | locobot        |
| 10       | xavier-nx10       | locobot        |

## SSH 

SSH (Secure Shell), can directly connect the remote server execute our commands on the local machine, and use below command.
```
 $ ssh remote_hostname@remote_ip
```

If you don't input this command every time, the **sshpass** package and **alias** can achieve this idea. The sshpass can use ssh to execute command so that can directly connect the remote server with one command.
```
 $ sudo apt-get install sshpass
 $ sshpass -p password ssh remote_hostname@remote_ip [command]
```

Although sshpass is convenient approach, the command is so long. The alias can simplify it. You can customize frequently used and long commands as aliases, which will save a lot of time in execution.
*Edit bashrc.*
```
 $ vim ~/.bashrc
```
*Add command on the below.*
```
 alias simplified_name="command"
```
*Source bashrc to refresh it.*
```
 $ source ~/.bashrc
```
*Finally, you can input simplified_name to execute command.*
```
 $ simplified_name
```

## ROS connection

In order to connect two or above machines under ros connection, the master must to be established on host, and the other machines which want to control need to connect the host.

> For LoCoBot
- Host set on the NUC, and it ip is 10.42.0.2

*On the host, you need to run this command.*
```
 $ export ROS_MASTER_URI=http://10.42.0.2:11311
 $ export ROS_IP=10.42.0.2
```

You can write this commands into script, and source it. We already written this script, you just source this environment.
```
$ source ~/sis2021/environment.sh
```

> For other machine
- Slave set on the laptop or Xavier-NX, and it ip is slave_ip

*On the slave, you need to run this command.*
```
 $ export ROS_MASTER_URI=http://10.42.02:11311
 $ export ROS_IP=slave_ip
```

## laptop setup
The laptop can plug in switch to connect by wired, and connect wifi to use Internet, you can see the figure 4.

![](https://i.imgur.com/XLhtMfw.png) \
Fig.4 Network setup


### Network setting
Your laptop fix wired ip is 10.42.0.X, X is arbitrary number, but **1, 2 and 3 are used**. The fix wired ip setting can refer manual and command setting. 

1. Manual setting

Click setting --> network --> edit wired network --> IPV4 \
Change IPV4 method --> manual \
Address --> 10.42.0.X \
Netmask --> 24 \
Related setting can see the figure 5.

![](https://i.imgur.com/AoGPMWZ.png) \
Fig.5 Manual network setting


2. Command setting

*Edit network.*
```
 $ nmcli connection add con-name wired_name type ethernet ifname 
eth0 autoconnect yes ip4 10.42.0.X/24 ipv4.method manual
```
*Connection this network.*
```
 $ nmcli connection up wired_name
```

3. Check

*After setting, checked by ping.*
```
laptop $ ping 10.42.0.2
laptop $ ping 10.42.0.3
```

*Connect wifi and check Internet.*
```
 $ nmcli device wifi connect SSID-Name password wireless-password
 $ ping 8.8.8.8
```

### SSH
*SSH to LoCoBot and Xavier-NX[Num].*
```
 $ ssh locobot@10.42.0.2
 $ ssh Xavier-NX[Num]@10.42.0.3
```

### ROS connection
*Setting environment variable to connect ROS.*
```
 $ export ROS_IP=l0.42.0.X
 $ export ROS_MASTER_URI=http://10.42.0.2:11311
```

### Remote connection (VNC)

If want to use VNC, the VNC server and VNC viewer need to install on robot and laptop respectively, but if use noVNC, the VNC viewer is no need to install.

#### VNC viewer on linux

You must install VNC viewer on your laptop, and connect VNC server to remote your robot. Take ubnutu 18.04 for example, the other os like Windows or macOS, please refer this website [VNC viewer download](https://www.realvnc.com/en/connect/download/viewer/linux/).

*Install VNC viewer.*
```
laptop $ wget https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.20.529-Linux-x86.deb
laptop $ sudo dpkg -i VNC-Viewer-6.20.529-Linux-x86.deb
```
*If your laptop cannot install, please fix missing and broken packages, and install again.*
```
laptop $ sudo apt --fix-broken install
```

#### How to use VNC viewer 

*Open VNC viewer.*
```
laptop $ vncviewer
```

You will see this window.

![](https://i.imgur.com/b5PmO4P.png) \
Fig.6 Vnc viewer window

select File --> new connection or press Ctrl+n

![](https://i.imgur.com/yX5LcSN.png) \
Fig.7 Vnc viewer setting

Fill VNC Server and Name, and then click it to connect VNC server, if you see this picture. Now you can remote the robot!
![](https://i.imgur.com/FQBAczx.jpg) \
Fig.8 Remote desktop

#### VNC viewer on Mac

Enter vnc://remote_ip location in Safari to use your Mac as a VNC Viewer.

### byobu
This tool is very useful for managing your terminal, whether it is local or remote, it can be accessed by anyone.

*Install.*
```
 $ sudo apt-get install byobu
```

*Open terminal, and type.*
```
 $ byobu
```

*Then you can start use byobu.*

The common commands are as following

* `F2` create a new window
* `F3` and `F4` switch window
* `shift`+`F2` create a horizontal terminal
* `ctrl`+`F2` create a vertical terminal` 
* `ctrl`+`D` delete current window
* `shift`+ arrow key change window 

### How to connect 
We will introduce three methods to access LoCoBot, make sure you already finished above setting.

>  X11_Forward

First, edit your ssh_config on the laptop, and ssh into LoCoBot, open camera and type rviz on your laptop, then you will see rviz on your laptop.

*Edit ssh config.*
```
 laptop $ sudo vim /etc/ssh/ssh_config
```

*Modifiy ForwardX11 to yes and uncomment.* \
![](https://i.imgur.com/zIYR24G.png) \
Fig.9 ssh_config setting

*SSH into LoCoBot.*
```
 laptop $ ssh locobot@10.42.0.2 
```

*Open D435.*
```
 locobot $ roslaunch realsense2_camera rs_rgbd.launch
```

*Open Rviz.*
```
 laptop $ rivz
```

> VNC

First, ssh into LoCoBot, open vnc server and wait vnc viewer to connect it, then you will see remote desktop on your laptop.

*SSH into LoCoBot*
```
 laptop $ ssh locobot@10.42.0.2 
```

*For LoCoBot.*
```
 locobot $ source ~/sis2021/vnc/vnc_start.sh
```

Use vnc viewer to connect it. 
 
> noVNC

First, ssh into LoCoBot, open vnc server and novnc, then you can use browser to connect it.

*SSH into LoCoBot or Xavier-NX.*
```
 laptop $ ssh locobot@10.42.0.2 
```

*For LoCoBot.*
```
 locobot $ source ~/sis2021/vnc/vnc_start.sh
```

*Open another terminal.*
```
 locobot $ source ~/sis2021/vnc/novnc_start.sh
```

open the browser URL input ==http://remote_IP:6080/vnc.html== 
you will see login interface, click connect and input password, then you will can remote the robot. 

![](https://i.imgur.com/fIlkleG.png) \
Fig.10 noVNC window

![](https://i.imgur.com/Ev8BpqQ.jpg) \
Fig.11 Remote desktop
