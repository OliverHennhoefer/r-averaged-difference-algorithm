# R_AvgDiff
R-Implemenation of the "Averaged Difference"-Algorithm for Spatial Outlier Detection conceived by _Yufeng Kou_ and _Chang-Tien Lu_ in the scientific paper "Spatial Weighted Outlier Detection"<sup>1</sup> from 2006. The algorithm is suitable for detection of point observations with distinct features from their surrounding neighbors.<br/>
The algorithm is demonstrated by the means of agricultural yield data and generally suitable especially for the use in context of Precision Farming.<br/>

Related Institutions and Projects:
:round_pushpin: disy Informationssysteme GmbH. https://www.disy.net/de/ 
:seedling: iFAROS. https://www.ifaros-ictagri.com/ <br/>
:books: Universität Hohenheim: shorturl.at/ehtCJ

## Dependencies:<br/>
:wrench: __sp__-package, for geometry types<br/>
:wrench: __data.table__-package, as faster alternative for _base::data.frame_<br/>
:wrench: __FNN__-package, for k-nearest-neighbor search algorithm<br/>

## Parameters:<br/>
- Input: _SpatialDataPointsDataFrame_, georeferenced point data with attribute(s)<br/>
- Input: _k_, number of neighbours taken into account (as in _k-Nearest-Neighbor_)<br/>
- Output: _data.table_, containing index and the corresponding _averaged difference_ in decreasing order<br/><br/>

The function output must then be used to acutally delete potential outliers in the original dataframe as shown in the script (below function). The number of top outliers must be defined by the user. For the example shown, 1.200 points (of ~ 8.000 points) were deleted. The nearest neighbors considered (_k_) was arbitrarily set to 355. Chosen parameter values should orient on the absolute amount of data points and the "severity" of the visible measurement errors.<br/>
Execution time for shown example: ~1.5 sec.

## Result:<br/>
![before](before.png)<br/>
![after](after.png)<br/>

## Future Improvements:<br/>
- Implementation of a stand-alone package already uncluding dependencies.<br/><br/>

<sup>1</sup> http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.101.9899&rep=rep1&type=pdf
