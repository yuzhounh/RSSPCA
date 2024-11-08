# Robust Sparse Smooth Principal Component Analysis (RSSPCA)

[![License](https://img.shields.io/badge/License-BSD-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

RSSPCA is a novel dimensionality reduction method combining robustness, sparsity and smoothness properties for face reconstruction and recognition tasks. The algorithm solves the following optimization problem:

$$\mathop{\max}_{w}||X^Tw||_1,  s.t. ||w||_2^2=1,  ||w||_1<=c_1,  w^TLw<=c_2$$

where $c_1$ and $c_2$ are positive constants, and $L$ is a Laplacian matrix representing the two-dimensional spatial structure information of images.

The algorithm features robustness for resisting outliers and noise, sparsity for feature selection, and smoothness for preserving spatial relationships. It has been extensively evaluated on six benchmark face databases (AR, FEI, FERET, GT, ORL, and Yale) and compared with state-of-the-art methods including PCA, PCA-L1, RSPCA, and RSMPCA.

To run the demo, execute `main.m` in MATLAB. For large-scale applications, a parallel computing version is available at [RSSPCA_2](https://github.com/yuzhounh/RSSPCA_2). Additional benchmark face databases can be found [here](https://github.com/yuzhounh/Face-databases).

If you use this code, please cite our paper:
```
Paper citation will be added
```

**Contact:** Jing Wang (wangjing@xynu.edu.cn)