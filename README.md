# RemindMe

Introducing an RemindMe reminder application for seamlessly orgainizing task and todos.

## Description

My innovative reminder application is designed to efficiently manage and prompt you about your tasks and to-dos by allowing you to schedule them for specific dates of your choosing. With this app, you have the freedom to store and organize your tasks, ensuring that you never miss an important deadline or forget a critical to-do item. It empowers you to stay on top of your commitments by providing timely reminders for each task, offering you the peace of mind and productivity boost that comes from having a reliable task management system that accommodates your personalized scheduling needs.

In addition to its robust task management capabilities, our app goes the extra mile by offering you real-time access to local news and weather updates. By seamlessly integrating this information, you can stay informed about current events and weather conditions in your immediate vicinity. This combination of task management and localized news and weather features provides users with a holistic tool that enhances their daily productivity and keeps them informed about the world around them, all within a single, user-friendly application."

## Features

- Effortlessly schedule, organize, and manage tasks and to-dos for any date.
- Set customizable reminders to ensure you never miss an important deadline or forget essential tasks.
- Stay well-informed with up-to-date, location-specific news.
- Access real-time weather data to make informed decisions about outdoor activities and travel.
- Enjoy uninterrupted access to your scheduled tasks and reminders, even in areas with limited or no internet connectivity.

## Project Structure

#### Architecture:

The app follows the Model-View-Controller (MVC) architecture for structuring the codebase.

#### Database:

Hive is employed as the database to store both offline JSON data and reminders.

#### Calendar Display:

The app utilizes the TableCalendar package to display a calendar for managing and viewing reminders.

#### State Management:

Bloc is chosen as the primary state management solution, helping manage and coordinate the app's various states.

#### Date Formatting:

The intl package is integrated to handle date formatting within the app.

#### Background Task:

The app employs the background_fetch package to execute tasks in the background, enhancing user experience and app functionality.

#### Location Data:

The app utilizes the geolocator and geocoding packages to access and manage location-related data.

#### API Data Handling:

The Dio package is used for efficient handling of API data, facilitating communication with external services.

#### Permission Handling:

The app leverages the permission_handler package to manage and request permissions as needed to access device features and data.

## Instructions

- Firstly, when you install the application which is the drive have provided below the first screen is splash screen.
- Splash screen has some condition that need to be fullfilled to move to another page.
- Location and notification permission are the condition of the splash screen.
- After the condition are fullfilled, it will navigate to home navigation screen where there is bottom navigation.
- Through the bottom navigation, we can navigate to reminder screen (initial page), weather screen and news screen.

### Reminder Screen

- We can add reminder for any future perferred date which will reflect in the calender screen as well as database.
- We can also edit the reminder by clicking on edit button next to reminder info and we can delete reminder by swiping left.
- These reminder are stored in hive database and showed on state change and on start up of application.
- The color indication of today is dark indigo where as selected date color is light indigo color.
- Also, Date which has reminders will show green dot at the bottom as reminder indication.
- Finally, I have setup background fetch for showing reminder notification in app background when the reminder date nearby.

### Weather Screen

- Secondly, we can navigate to weather screen by clicking on cloud icon in the second bottom navigation item.
- Here I have used open source api to fetch the data of weather.
- Initially It will show the weather data of current location which I have fetched by using geolocator and geocoding package.
- Your can all get the weather of perferred location by clicking on circular puls icon at the top left in the appbar.
- It will open a dialog box where you can enter the location name and access the location data of that particular location.
- Also, It will work in offline mode. I have saved the json data in the hive and retreived that data while there is no internet.

### News Screen

- Finally, you can navigate to news screen by clicking on newspaper in on bottom navigation.
- Here I have used open sources newsapi to fetch the news data.
- The news screen shows the list of news which its title, image and published date.
- You can view more detail by clicking on the particular news which will lead to news detail screen.
- The news detail screen data such as link of article and more content.
- Also, It will work in offline mode. I have saved the json data in the hive and retreived that data while there is no internet.
- There is limitation for free account in this api where the content has limited length of words.

## Screenshots

I have attached screenshot in raw folder of the root application.

## Application Download

<a href="https://drive.google.com/file/d/1taXGBSl4YCDbDK2Be957FGzlAreyp24V/view?usp=drive_link"> Download App </a>

## Contact

If you have any questions or suggestions, feel free
to [contact me on LinkedIn](https://www.linkedin.com/in/nirajkaranjeet/).
