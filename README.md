# bughopper

The main idea behind thsis project is to allow people to know about a place or a locality that is unknown to him/her. Through this app, one can know about the mishappenings that may have taken place at a particular location. He/she can also contribute his/her part by reporting an crime or incident if he/she happens to observe. The report will be stored in a database and also corresponding to the incident that has taken place, the nearby police station or hospital can be alerted so that quick action can be put initiated.
    

##The tools and technologies used in this project are:  
    
    Flutter, Firebase and Dart.

## How to Run:
    
To run the project:  

1. Clone the repository and navigate inside its directory.  

            $   git clone https://github.com/hackabit18/bughopper
            $   cd bughopper
            
2. Run the following command while connecting a android device to the computer in debug mode:  

            $   flutter run

* Note: The phone no. in the lib/pages/createReport.dart needs to be added in order to send the report to particular number.

##  About the app:

Feel Safe is a mobile app for getting know of unknown locality. It gives us the collectio of all the mishaps that has occured on that locality for the last few months and gives the user a idea of how safe the place is.
Moreover it has the functionality of reporting crimes and accidents directly from the app with a click of a button. The reporter has to give a brief description of the incident and a report is send to the nearest police station (and hospital if needed).

<img height="480px" src="./assets/readme/FeelSafe.jpeg" style="padding-left:10%">

<br><br>

<img height="480px" src="./assets/readme/homepage.jpg" style="padding-left:25%">  

<br><br>  


### Main features: 

#### 1. Information about a place

A person can know about the mishaps of the locality that is not know to him/her.  

This can be done by 2 ways -

1. Marking the location on the map - 

The app shows the information about the place marked in the map.

<img height="480px" src="./assets/readme/map.jpg" style="padding-left:10%">

<br><br>


2. Current location - 

The app show information about the current locality.


The report generated has the news of the mishaps that occured in last few months and also the reports send by various users about the mishaps.

<img height="480px" src="./assets/readme/news.jpg" style="padding-left:10%">

<img height="480px" src="./assets/readme/reports.jpg" style="padding-left:10%">  

<br><br>


#### 2. Reporting

A person can report about a crime/accident by writing a short description of it.

1. Current Location reporting - 

<img height="480px" src="./assets/readme/report_form.jpg" style="padding-left:10%">  

<br><br>


2. Mark on map - 

<img height="480px" src="./assets/readme/map.jpg" style="padding-left:10%">  

<br><br>

Once the report is submitted, a notification id sent to the police(and hospital if needed).

<img height="480px" src="./assets/readme/report_success.jpg" style="padding-left:10%"> 

## Future Scope:

1. The app currently sends the message to and individual, but with updated database of all the police stations and hospitals it could be more efficient.

2. With more and more people using it, the data of the mishaps would be could be updated to a large extend.

3. Currently the reporter's details are shared with the police to avoid fake reports but that can be improved by making the reporter anonymous (as people donot want to be involved in the process of police investigation).
