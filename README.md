# R_AvgDiff
R-Implemenation of the "Averaged Difference" Algorithm for Spatial Outlier Detection conceive by Yufeng Kou and Chang-Tien Lu in the scientific paper "Spatial Weighted Outlier Detection". The algorithm is suitable to detect point observation with distinct features
from their surrounding neighbors. The algorithm is demonstrated by the means of agricultural yield data and generally suitable especially for the use in context of Precision Farming applications.

:seedling; Trial project. Primarily implemented to get familiar with the python syntax and the ArcPy interface for ArcGIS.

sp

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
- Calculate the mean position out of the points of one cluster to get more representative cluster locations.
- Add the possibility to fit additional attributes to the corresponding cluster (e.g. by calculating the mean for the points of the same cluster)
