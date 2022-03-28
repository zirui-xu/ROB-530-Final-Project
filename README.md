# SC-F-LOAM
ROB-530-Final-Project

## Prerequisites (dependencies)
- We mainly depend on ROS, Ceres (for A-LOAM), and GTSAM (for pose-graph optimization). 
    - For the details to install the prerequisites, please follow the [A-LOAM](https://github.com/HKUST-Aerial-Robotics/A-LOAM) and [LIO-SAM](https://github.com/TixiaoShan/LIO-SAM) repositiory. 
- The below examples are done under ROS melodic (ubuntu 18) and GTSAM version 4.x.

## How to use? 
- First, install the abovementioned dependencies, and follow below lines. 
```
    mkdir -p ~/catkin_scfloam_ws/src
    cd ~/catkin_scfloam_ws/src
    git clone https://github.com/zirui-xu/ROB-530-Final-Project.git
    cd ../
    catkin_make
    source ~/catkin_scfloam_ws/devel/setup.bash
    roslaunch scfloam scfloam_velodyne_HDL_64.launch # You should import data before launching this
```

### Some problems you might encounter
- `catkin_make` fail: make it until success (in my case, 3 times)

## How to import data?
### General way:
Download data from [Kitti website](http://www.cvlibs.net/datasets/kitti/eval_odometry.php) to `YOU_KITTI_DATASET_DIRECTORY`. 

Modify `kitti_dataset_helper.launch` to fit your data (e.g., `dataset_folder`).

```
    source ~/catkin_scfloam_ws/devel/setup.bash
    roslaunch scfloam kitti_dataset_helper.launch
```
The directory should form like
```
| YOU_KITTI_DATASET_DIRECTORY 
    |-- results
        |-- 00.txt
        |-- 01.txt
        |-- ...
    |-- sequences 
        |-- 00
            |-- calib.txt
            |-- times.txt
            |-- image_0
                |-- 000000.png
                |-- 000001.png
                |-- ...
            |-- image_1
                |-- 000000.png
                |-- 000001.png
                |-- ...
            |-- velodyne
                |-- 000000.bin
                |-- 000001.bin
                |-- ...
        |-- 01
        |-- ...
```
### Rosbag way: 
Play the wrapped kitti data in `XXX.bag`. [Here](https://drive.google.com/drive/folders/12rBBkP_X75x5OCh5TycSY4e8K34nVIod?usp=sharing) you can download some preprocessed rosbags.
```
    rosbag play XXX.bag
```
Note: you should run `roscore` in the other terminal before running the above command.

