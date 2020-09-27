# Averaged Difference Algorithm
R-Implemenation of the "Averaged Difference"-Algorithm for Spatial Outlier Detection conceived by _Yufeng Kou_ and _Chang-Tien Lu_ in the scientific paper "Spatial Weighted Outlier Detection"<sup>1</sup> from 2006. The algorithm is suitable for detection of point observations with distinct features from their surrounding neighbors.<br/>
The algorithm is demonstrated by the means of agricultural yield data and generally suitable especially for the use in context of Precision Farming.<br/>

:round_pushpin: disy Informationssysteme GmbH. https://www.disy.net/de/ <br/>
:seedling: iFAROS. https://www.ifaros-ictagri.com/ <br/>

## Dependencies:<br/>
:wrench: __sp__-package, for geometry types<br/>
:wrench: __data.table__-package, as faster alternative for _base::data.frame_<br/>
:wrench: __FNN__-package, for k-nearest-neighbor search algorithm<br/>

## Parameters:<br/>
- Input: _SpatialDataPointsDataFrame_, georeferenced point data with attribute(s)<br/>
- Input: _k_, number of neighbours taken into account (as in _k-Nearest-Neighbor_)<br/>
- Output: _data.table_, containing index and the corresponding _averaged difference_ in decreasing order<br/><br/>

The function returns a list (data.table) with points indices and the _averaged difference_ of the respective point. The data.table allows for the deletion of the top _n_ outliers by their indices. The actual number of outliers to be deleted can be freely chosen by the user.<br/>
For the example shown, 1.200 points (of ~ 8.000 points) were deleted. The nearest neighbors considered (_k_) was (arbitrarily) set to 355. Chosen parameter values should orient on the absolute amount of data points and the "severity" of the visible measurement errors. Global outliers can be obtained for larger neighborhoods, while smaller neighborhoods are especially suitable to identify local outliers on a smaller spatial scale.<br/>

Execution time for 8.000 point observations: ~3 sec.

## Demonstration:<br/>
<!---  ![original_observations](img/original.png)<br/> --->
<!---  ![cleansed_observations](img/processed.png)<br/> --->

<p float="left">
  <img src="https://github.com/OliverHennhoefer/r-averaged-difference-algorithm/blob/master/img/original.png" width="500">
  <img src="https://github.com/OliverHennhoefer/r-averaged-difference-algorithm/blob/master/img/processed.png" width="500">
</p><br/>

<sup>1</sup> http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.101.9899&rep=rep1&type=pdf
