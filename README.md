# R_AvgDiff
R-Implemenation of the "Averaged Difference" Algorithm for Spatial Outlier Detection conceive by Yufeng Kou and Chang-Tien Lu in the scientific paper "Spatial Weighted Outlier Detection". The algorithm is suitable to detect point observation with distinct features
from their surrounding neighbors. The algorithm is demonstrated by the means of agricultural yield data and generally suitable especially for the use in context of Precision Farming applications.

:seedling: iFAROS. This algorithm was implemented in the course of iFAROS project. https://www.ifaros-ictagri.com/ <br/>
:bullettrain_side: Calculation for ~8000 points (see __Results__) in less than 2 seconds.<br/>

## Dependencies:<br/>
:wrench: _sp_-package, for geometry types<br/>
:wrench: _data.table_-package, as faster alternative for _base::data.frame_<br/>
:wrench: _FNN_-package, for k-nearest-neighbor search algorithm<br/>

## Parameters:<br/>
- Input: SpatialDataPointsDataFrame, georeferenced point data with attribute<br/>
- Input: k, number of neighbours taken into account (as in _k-Nearest-Neighbor_)<br/>
- Output: data.table, containing index and the corresponding _averaged difference_<br/>


## Result:<br/>
![#1589f0](https://placehold.it/15/1589f0/000000?text=+) Original point data </br>
![#f03c15](https://placehold.it/15/f03c15/000000?text=+) Result for a (cluster-)radius of 500 meters </br>
![#fffa00](https://placehold.it/15/fffa00/000000?text=+) Result for a (cluster-)radius of 1000 meters </br>

![alt text](https://github.com/OliverHennhoefer/ArcPy_Supercluster/blob/master/supercluster_result.PNG)
*Note: Since the algorithm randomly chooses points for clustering, the results vary for every application of 'supercluster'*

## Future Improvements:<br/>
- Implementation of a stand-alone package already unclusing dependencies.
