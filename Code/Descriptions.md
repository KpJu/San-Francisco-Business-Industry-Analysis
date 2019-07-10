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
![](https://github.com/KpJu/San-Francisco-Business-Industry-Analysis/blob/master/Output/Table.png)

Overall, almost all industries in San Francisco have increased during the recent years, especially after 2008. As illustrated in the figure below (for better visualization, only the top ten industries are listed, and the data is cut off at year 1985), Real Estate and Rental and Leasing Services (purple line) suffered a decrease after the financial crisis in 2007/2008, yet slowly recovered after that and remarkable jumps are observed from 2013 and peaks in 2014, after which the housing market starts to be saturating and begins to level off. Similarly, Transportation and Warehousing (pink line) experiences a noticeable jump between 2006 and 2007, and is affected by the housing market crash and observed a downturn after 2008. However, with the rise of electronic cars and driver-less cars, leading by Tesla, Transportation industry has been flourish and peaks in 2016, the number of transportation and warehousing industry business is even much higher than Real Estate industry business. Another industry worth mentioning is Professional, Scientific, and Technical Services. Unlike Real Estate industry, scientific services industry has always been increasing rapidly regardless of the financial crisis, and peaked in 2016 as well. The peak in Scientific, and Technical Services actually helps drive up the Transportation industry as illustrated.
![](https://github.com/KpJu/San-Francisco-Business-Industry-Analysis/blob/master/Output/Plot3.png)

Finally, let's take a look at the industries that have more ended businesses. The Figure below is just a simple count of the closing businesses in the top 10 industries. From the graph, transportation (Blue line) and Scientific industries (pink line) still have the highest number. However, given the total amount of active business in San Francisco in these two industries, the proportion of closing business is very small. Whereas Food Services (Green line) and Retail Trade (purple-pink line) industries have more closing businesses. Traditional businesses have been slowing down while new industries become more and more popular. 
![](https://github.com/KpJu/San-Francisco-Business-Industry-Analysis/blob/master/Output/Plot4.png)
