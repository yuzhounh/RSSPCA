# Robust Sparse Smooth Principal Component Analysis for Face Reconstruction and Recognition
Copyright (C) 2023 Jing Wang

RSSPCA finds the first projection vector by solving the following optimization problem:
$$\mathop{\max}_{w}||X^Tw||_1,  s.t. ||w||_2^2=1,  ||w||_1<=c_1,  w^TLw<=c_2,$$
where $c_1$ and $c_2$ are positive constants, $L$ is a Laplacian matrix representing the two-dimensional spatial structure information of images.

# Usage
Run `main.m` to play this demo. 

# Contact information
Jing Wang  
wangjing@xynu.edu.cn
2024-1-29 12:31:24
