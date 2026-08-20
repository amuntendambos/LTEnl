# LTEnl
We present a Matlab-based functional enviroment, LTEnl that simulates risk-based largest tolerable earthquakes (LTE) as a base for red-light thresholds for use in defining traffic light protocols. This is a collection of codes applied in a study about defining risk-based, consistent traffic light systems for subsurface operations in the Netherlands [Muntendam-Bos & Schultz, 2026].  See also, prior works in developing this approach (as well as their GitHub repositories).

These files are a collection of matlab programs and scripts: 
	
	scriptAdjustBLANK.m	- adjust the existing blank file from Schultz et al. (2022) containing specific 
				        	information for the Netherlands for the purpose of the analysis of the 					  
                        	subsurface operations contained in this study;
	scriptRISK.m 	     - creates the data structure containing the risk scenarios;
	scriptMAP.m		     - derives the mean or median LTE values based on pre-defined tolerances for the 
				            risk acceptance criteria;
	scriptMAPspecial.m	- maps the equivalent risks of the number of households exposed given the 
				                mean/median LTE derived based on a chosen risk acceptance metric;
	testRISKscenarios.m	- computes the impact for selected Dutch M>=3.0 earthquakes;
	plotRESULTS.m		    - provides most of the figures contained in the paper and supplement (Figure 1 
				                and Figure 2 and Figure S9 have not been created with matlab).

All blank.mat-files derived for this study using the above scripts are part of this repository. Note that licensed databases are missing from this work enviroment. This will require the user to find their own datasources to adapt the approach.

References: 
            
            A.G. Muntendam-Bos & R. Schultz. (2026)
	          Risk-based tolerable magnitudes for induced seismicity at subsurface operations in the Netherlands
	          Netherlands Journal of Geosciences (under review)

	          R. Schultz, A. Muntendam‐Bos, W. Zhou, G.C. Beroza, & W.L. Ellsworth. (2022)
            Induced seismicity red-light thresholds for enhanced geothermal prospects in the Netherlands
            Geothermics, 106, 102580.
            doi: 10.1016/j.geothermics.2022.102580.
            
            R. Schultz, G.C. Beroza, & W.L. Ellsworth. (2021)
            A risk-based approach for managing hydraulic fracturing-induced seismicity
            Science, 372(6541), 504-507.
            doi: 10.1126/science.abg5451.
            
            R. Schultz, G.C. Beroza, & W.L. Ellsworth. (2021)
            A strategy for choosing red-light thresholds to manage hydraulic fracturing induced seismicity in North America
            Journal of Geophysical Research: Solid Earth, 126(12), e2021JB022340.
            doi: 10.1029/2021JB022340.
            
            R. Schultz, G.C. Beroza, & W.L. Ellsworth, & J. Baker. (2020)
            Risk‐Informed Recommendations for Managing Hydraulic Fracturing–Induced Seismicity via Traffic Light Protocols
            Bulletin of the Seismological Society of America, 110(5), 2411-2422.
            doi: 10.1785/0120200016.


This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details: http://www.gnu.org/licenses/

