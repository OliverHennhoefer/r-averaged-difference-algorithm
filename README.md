# R_AvgDiff
R-Implemenation of the "Averaged Difference" Algorithm for Spatial Outlier Detection conceive by Yufeng Kou and Chang-Tien Lu in the scientific paper "Spatial Weighted Outlier Detection". The algorithm is suitable to detect point observation with distinct features
from their surrounding neighbors. The algorithm is demonstrated by the means of agricultural yield data and generally suitable especially for the use in context of Precision Farming applications.

:seedling: iFAROS. This algorithm was implemented in the course of iFAROS project. https://www.ifaros-ictagri.com/ <br/>
:bullettrain_side: High Performance. Calculation for ~8000 points (see __Results__) in less than 2 seconds.<br/>

## Dependencies:<br/>
:wrench: __sp__-package, for geometry types<br/>
:wrench: __data.table__-package, as faster alternative for _base::data.frame_<br/>
:wrench: __FNN__-package, for k-nearest-neighbor search algorithm<br/>

## Parameters:<br/>
- Input: _SpatialDataPointsDataFrame_, georeferenced point data with attribute<br/>
- Input: _k_, number of neighbours taken into account (as in _k-Nearest-Neighbor_)<br/>
- Output: _data.table_, containing index and the corresponding _averaged difference_<br/>


## Result:<br/>
![alt text](https://github.com/OliverHennhoefer/R_AvgDiff/blob/master/before.png)
![alt text](https://github.com/OliverHennhoefer/R_AvgDiff/blob/master/after.png)
*Note: Since the algorithm randomly chooses points for clustering, the results vary for every application of 'supercluster'*

## Future Improvements:<br/>
- Implementation of a stand-alone package already unclusing dependencies.
