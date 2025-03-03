cmake_minimum_required(VERSION 3.0)
project(set_damping_plugin)

find_package(Gazebo REQUIRED)
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  gazebo_ros
)

add_service_files(
  FILES
  SetFloat.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS std_msgs
)


include_directories(${GAZEBO_INCLUDE_DIRS} ${catkin_INCLUDE_DIRS})

add_library(set_damping_plugin SHARED src/dynamic_joint_damping_plugin.cpp)
target_link_libraries(set_damping_plugin ${GAZEBO_LIBRARIES} ${catkin_LIBRARIES})


install(TARGETS set_damping_plugin DESTINATION $ENV{LOCOSIM_DIR}/robot_descriptions/gazebo_plugins/lib)
