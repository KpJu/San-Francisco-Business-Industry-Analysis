*Project was done by R, and code is saved as rmd (R Markdown) files.*

### Code1 ###
This code is trying to identify the pockets in San Francisco with a high concentration of business.

To look at the concentration of active businesses in San Francisco, we need to identify the active business and filter out those with actual business locations outside of San Francisco. In this case, businesses without a business end date are considered active business. 

Variable “City” in the dataset has multiple input representing San Francisco, to better extract businesses in required city and for the ease of plotting, library “zipcode” was used and matched zipcodes with actual city names/longitude/latitude. 

With a simple table output, zipcode 94110, 94103, 94107 and 94109 have the most active businesses in San Francisco. Most active businesses concentrate in northeast area, such as financial district, and some mid area such as mission district and Bernal Heights. To see it more clearly, a less granular map was created as well using the joined zipcode dataset, which tells the same story that the active businesses tend to be more concentrate in areas that are more financially active and with more population.

![](https://github.com/KpJu/San-Francisco-Business-Industry-Analysis/blob/master/Output/Plot1.PNG)
![](https://github.com/KpJu/San-Francisco-Business-Industry-Analysis/blob/master/Output/Plot2.PNG)

### Code2 ###
This code follows from Code1, and take a deeper look at industry trend during time.

To promote growth in less popular industries in San Francisco, the county is offering a tax break for new businesses in these categories to encourage them set up shop in San Francisco. The analysis to identify the NAICS code and description of businesses that would benefit from this scheme, the data should be based on the active business dataset as well. After looking at the sorted table of NAICS Code and its corresponding description in the dataset, it is found that not all description is populated for NAICS code. Therefore the csv file of NAICS Code dictionary, which is created from data dictionary, was pulled in the match the description with NAICS, and the counts of these NAICS were generated as shown in Table 1. Utilities (2200-2299), Insurance (5240-5249) and Certain Services (8100-8399) are the least popular three business among active businesses in San Francisco.

