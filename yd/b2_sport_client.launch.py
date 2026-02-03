from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='unitree_ros2_example',
            executable='b2_sport_client',
            name='b2_sport_client_node',
            remappings=[
                ('/cmd_vel', '/RosAria/cmd_vel'),
            ]
        )
    ])