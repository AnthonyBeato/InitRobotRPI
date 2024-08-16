#
# 1. Configuración de Locale
#

locale  # check for UTF-8

sudo apt update -y && sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings


#
# 2. Instalación de ROS Humble
#

sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

sudo apt update -y && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update -y
sudo apt upgrade -y

sudo apt install ros-humble-ros-base -y


#
# 3. Instalación de Herramientas ROS y Configuración del Entorno de Trabajo
#

sudo apt install ros-dev-tools -y

mkdir robot_ws && cd robot_ws && mkdir src
colcon build

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "source ~/robot_ws/install/setup.bash" >> ~/.bashrc
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc


#
# 4. Instalación de Paquetes Adicionales
#

sudo apt-get install -y \
  nano \
  vim \
  python3-pip \
  python3-serial \
  ros-humble-rosbridge-server \
  python3-colcon-common-extensions \
  ros-humble-ros2-control \
  ros-humble-ros2-controllers \
  ros-humble-hardware-interface \
  ros-humble-joint-state-broadcaster \
  ros-humble-diff-drive-controller \
  ros-humble-ros2controlcli \
  ros-humble-rviz2 \
  ros-humble-robot-state-publisher \
  ros-humble-ament-cmake \
  ros-humble-rclcpp \
  ros-humble-rclcpp-lifecycle \
  ros-humble-xacro \
  libserial-dev \


#
# 5. Configuración del Espacio de Trabajo y Clonación de Repositorios
#

cd ~/robot_ws/src

git clone https://github.com/AnthonyBeato/diffdrive_msp432.git 
cd ..
colcon build
source ~/.bashrc