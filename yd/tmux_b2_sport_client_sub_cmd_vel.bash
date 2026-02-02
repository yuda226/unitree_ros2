#!/bin/sh

# modified from https://unix.stackexchange.com/questions/80473/how-do-i-run-a-shell-command-from-tmux-conf

tmux has-session -t tmux_run
if [ $? != 0 ]; then
    # create a new session
    tmux new-session -s tmux_run -n tmux_run -d
    
    # use mouse in Ubuntu /tmux 2.1
    tmux set -g mouse on

    # Highlight active window
    tmux set-window-option -g window-status-current-bg green

    # history limit
    tmux set -g history-limit 10000

    # Set status bar
    tmux set -g status-bg black
    tmux set -g status-fg white 

    tmux setw -g mode-keys vi
    tmux bind-key -t vi-copy 'v' begin-selection
    tmux bind-key -t vi-copy 'y' copy-pipe "xclip -sel clip -i"
    
    tmux send-keys -t tmux_run '' C-m
    tmux select-layout tiled
    
    tmux split-window -h -t tmux_run
    tmux send-keys -t tmux_run 'sleep 1; ros2 run unitree_ros2_example b2_sport_client' C-m
    tmux select-layout tiled
    
    tmux split-window -h -t tmux_run
    tmux send-keys -t tmux_run 'sleep 3; ros2 topic pub /cmd_vel geometry_msgs/msg/TwistStamped "{header: {stamp: {sec: 0, nanosec: 0}, frame_id: 'base_link'}, twist: {linear: {x: 0.223, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 0.9}}}" -r 10'
    tmux select-layout tiled

    tmux split-window -h -t tmux_run
    tmux send-keys -t tmux_run ' sleep 3; ros2 topic pub /cmd_vel geometry_msgs/msg/Twist "{linear: {x: 0.223, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 0.9}}" -r 10'
    tmux select-layout tiled
fi
tmux attach -t tmux_run

