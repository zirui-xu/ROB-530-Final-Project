# SC-F-LOAM
ROB-530-Final-Project

## Prerequisites (dependencies)
- We mainly depend on ROS, Ceres (for A-LOAM), and GTSAM (for pose-graph optimization). 
    - For the details to install the prerequisites, please follow the [A-LOAM](https://github.com/HKUST-Aerial-Robotics/A-LOAM), [LIO-SAM](https://github.com/TixiaoShan/LIO-SAM), and [F-LOAM](https://github.com/wh200720041/floam) repositiory. 
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
    roslaunch scfloam scfloam_velodyne_HDL_64.launch # Import data after launching it
```

- Output will be saved to `save_directory` in `scfloam_velodyne_HDL_64.launch`. Please modify it to the directory you want. Save utility follows [SC-LIO-SAM's save utility](https://github.com/gisbi-kim/SC-LIO-SAM#applications).
### Some problems you might encounter
- `catkin_make` fail: make it until success (in my case, 3 times) if you install everything well.

## How to import data?
### Raw data way:
Download data from [Kitti website](http://www.cvlibs.net/datasets/kitti/eval_odometry.php) to `YOUR_KITTI_DATASET_DIRECTORY`. 
```
- Download odometry data set (grayscale, 22 GB)
- Download odometry data set (velodyne laser data, 80 GB)
- Download odometry ground truth poses (4 MB)
```

The directory should form like
```
| YOUR_KITTI_DATASET_DIRECTORY 
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

Modify `kitti_helper.launch` to fit your data (e.g., `dataset_folder`).

```
    source ~/catkin_scfloam_ws/devel/setup.bash
    roslaunch scfloam kitti_helper.launch
```
Note: You can also generate rosbag by running the above command. Just change parameters of `kitti_helper.launch` (i.e., set `to_bag` to `true` and `output_bag_file` to `YOUR_ROSBAG_DIRECTORY`).


### Rosbag way: 
Play the wrapped kitti data in `XXX.bag`. [Here](https://drive.google.com/drive/folders/12rBBkP_X75x5OCh5TycSY4e8K34nVIod?usp=sharing) you can download some preprocessed rosbags.
```
    rosbag play YOUR_ROSBAG_DIRECTORY/XXX.bag
```
Note: you should run `roscore` in the other terminal before running the above command.

## Results:
TODO. (Figure and Table)

## How to evaluate?
First after generating corresponding files, you need to open 'convert.m' file and change the name of file for 'reading time and sample ground truth accordingly' to ‘SC-A-LOAM/times.txt’ or ‘SC-A-LOAM/times.txt’ if you want to estimate SC-A-LOAM or SC-F-LOAM.

Then run 'convert.m' file to generate a 'ground_truth.txt' file from the '00/02/05.txt' file of ground truth. This is because:
    1. The frames of original ground truth are not the same as output estimates.
    2. The x, y and z dimensions of the original ground truth are not the same as output estimates.

Second, you can install “evo”, an evaluation tool, from https://github.com/MichaelGrupp/evo or by “pip install evo” or other methods you prefer. Then you can use evo for evaluation according to its instructions. Some sample commands for evaluation are:
    evo_traj kitti SC-A-LOAM\odom_poses.txt SC-A-LOAM\optimized_poses.txt --ref=ground_truth.txt -p --plot_mode=yx
    evo_ape kitti ground_truth.txt SC-A-LOAM\odom_poses.txt -va --plot --plot_mode yx --save_results SC-A-LOAM/odom_poses.zip
    evo_res SC-A-LOAM\odom_poses.zip SC-A-LOAM\optimized_poses.zip -p --save_table SC-A-LOAM/comparison.csv
