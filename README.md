# final_project 
# URL of our shiny app: https://gloriagou947.shinyapps.io/final_project/

## ggmap citation:
D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal, 5(1), 144-161. URL http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
Corresponding BibTeX entry:
  @Article{,
    author = {David Kahle and Hadley Wickham},
    title = {ggmap: Spatial Visualization with ggplot2},
    journal = {The R Journal},
    year = {2013},
    volume = {5},
    number = {1},
    pages = {144–161},
    url =
      {http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf},
  }
## We also followed the example from http://www.sharpsightlabs.com/mapping-seattle-crime/


Project Description
This is a written, non-technical description of your project.  Depending on the specifics of your project, you should outline the answers to these (and perhaps other) questions:
●	What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.

We will be working with Seattle Police Department 911 Incident Response, the URL is in the parentheses below. The data was collected by Seattle Police department after the incidents are considered safe to close out.  We accessed the data through seattle.gov, which is a website that contains all the data collected by SPD. It is a dataset of all officers dispatched to 911 calls from 2001 to present, and the data is still updating every 4 hours. (https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp)

●	Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.

	The target audience is Seattle residents and those who are concerned about Seattle’s safety. 

●	What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.

  The general goal of working with this dataset is to give Seattle residents a better idea about Seattle’s safety. From our data, the audience can see where the most dangerous regions are. They can learn where the safest places are. They can also learn about what kind of crime happens the most frequently and during what time of the day, crimes happen the most frequently. 

Technical Description
This section of your proposal is an opportunity to think through the specific analytical steps you'll need to complete throughout the project.

●	What will be the format of your final product (Shiny app, HTML page or slideshow compiled with KnitR, etc.)?
	
	The format of our final product will be in HTML page. (changed to shiny based on Jordan's suggestion)

●	How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?

	We will be reading in our data in a static .csv format. 

●	What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?
 	
 	we plan to reformat our dataset including changing column names, create new columns involving other columns so that it would be easier to analyze and visualize data.

●	What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)

	We will be using plotly, ggplot2 (for making good-looking graphics), htmlwidgets (for building interactive visualizations). We are considering using ggvis for interactive, web-based graphics, but not 100 percent sure for now. 

●	What questions, if any, will you be answering with statistical analysis/machine learning?
	
	With our statistical analysis, we can answer questions like visually showing the specific locations that are dangerous or safe. We can also answer questions like what time of the day is fairly safe or dangerous. 

●	What major challenges do you anticipate? 

	We are trying to beautify the web app by using some new packages that we have not used before. The major challenge might be applying unfamiliar R codes to our shiny web app. 

