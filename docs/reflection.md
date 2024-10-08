## Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them
* 3.1 Properties of People: Vision
Our UI was designed with color contrast that meet accessibility standards and the games were visually appealing.

* 3.3 Stateless & stateful widgets
Stateless: showing result page after each game, stateful: score and displaying the game

* 3.4 Accessing sensors (force, GPS, etc.)
We used GPS to track the user’s location for the running game and to calculate the distance they’ve ran.

* 3.6 Drawing with Canvas, e.g. for custom UI widgets/components
We implemented a drawing app that tests the users’ memory to recall patterns of shapes and colors. We allow the user to draw and retrieve the patterns from their memory onto a canvas.

* 3.7 Undo and Redo
We implemented Undo and Redo for our drawing game. The game allows the user to return to previous shapes as well as look reverse the undo. This is implemented so that the user can compare the shapes on screen with their memory.

* 3.8 Secure data persistence
For 3.8 Secure data persistence, our app keeps user’s data in Hive’s secure storage and we display the user’s best record for each game as well as the times played. This was heavily dependent on the Journal App assignment. We also followed the same structure to build encryption for all of the user’s data.

## Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?
For our memory game, our original concept was showing the user a shape, and asking them to draw it from memory. The issue with this concept was that scoring a user's drawing would have been hard to implement, so we pivoted from that to showing the user a sequence of shapes and then asking them to draw the shapes one at a time. Instead of forcing them to draw the shape exactly, we scored them based on whether the shape was the right kind (circle or rectangle) and whether it was the right color. The second design was more feasible because it was within the bounds of what we learned in class: instead of scoring the user by checking how many pixels matched the original drawing was or something like that, we just had to check the user's previous draw action, which would have the data we needed.

For the stats page, most of the design stays the same, but we added in more visuals and data, originally we only wanted to display best records for each game but we also included the number of games played.


## Discuss how doing this project challenged and/or deepened your understanding of these topics.
Steven: This project challenged me to improve my understanding of how to navigate between views, something we only did in the simplest way in the journal assignment. For this project I needed to navigate between multiple views, not just one, and navigate back to the home screen lower in the stack instead of just popping one view.


Ramses: This project challenged me to think more about how to handle user’s data using online resources, it also helped me improve my understanding and skills in how to manage user data in a concise and clear way that is easy for the app to keep track of the changes users have. The data in our app is more complex than the journal app so I needed to do a bit of research on my own and changed my previous code structure to align with what we want for our app.


Benjamin: This project challenged my idea on designing and implementing frontend. I was used to implementing web development features in HTML, but learning flutter in this course allowed me to learn concepts such as semantics and accessibility. I believe I have become more mindful in designing user-centric designs.


Amy: This project deepened my understanding on git commands especially working on the same gitlab repository so I needed to avoid merge conflicts and making sure I am frequently pulling from git. My team resolved this issue by notifying each other whenever we git push. For challenges, I was challenged with coding the home screen, particularly designing the UI look and how buttons could be more accessible with sizing and padding.


Charyl: This project challenged me to understand the intricacies of measuring and handling reaction times accurately. Implementing the random delay and ensuring the game responds promptly to user actions deepened my understanding of state management and real-time processing in Flutter.


## Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app
One area of future work is displaying the user’s stats in a more informative way, like creating a graph that shows their past performances on the y-axis and dates on the x-axis. This way they can get a visual representation of how they’ve improved over time.


Another area of future work is adding Semantics to all of the widgets. There are some widgets with Semantics labels, but the peer audit found that the screen reader failed to read the canvas in the drawing memory game. This accessibility issue could be avoided if we fix this in the future.


## Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.
Course slides, previous homework, Ed Board, flutter documentation

## Thinking about CSE 340 as a whole: What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?

Ramses: The most valuable thing I learned was how to integrate accessibility features to a mobile application. I believe that this is really often overlooked in industry and I have not had a ton of experience in it, but it is definitely one of the most important things to consider when building human-centered products. This will help me beyond this class as I will begin to consider accessibility issues everytime I build things that will interact with humans. 


Steven: The most valuable thing I learned was how to make use of persistent data and encryption. This class was my first exposure to that, and I never thought about it before but it’s an incredibly valuable aspect of most apps that we use in our lives, and we should be capable of implementing it in our future apps.


Benjamin: I think the most valuable thing I learn is designing an interface that is accessible. I learned that color is a huge issue and might affect the experience of someone who is visually-impaired. I would like to use these new mindful design choices in future projects.


Amy: The most valuable thing I learned is understanding my target audience and searching through the Flutter documentation to improve app design and ease-of-use. Since we are evaluated on both backend and frontend, I had to ensure that the UI for my apps are easily navigable to the user. 


Charyl: The most valuable thing I learned in CSE 340 was how to develop applications using Flutter. As someone completely new to Flutter, this course provided a solid foundation in understanding how to create responsive and visually appealing mobile apps. The emphasis on building stateful and stateless widgets, managing state, and integrating accessibility features has equipped me with the skills necessary to develop user-friendly applications. These skills are invaluable for my future projects, as mobile app development is a critical area in the tech industry, and proficiency in Flutter opens up many opportunities.


## If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?
Ramses: I’d tell myself to look for more online resources when running into issues, a lot of the questions I had when working on projects could be solved with a simple google search, flutter provides a lot of documentation and there’s a lot of useful resources available online. The other advice I would give myself is to pay more attention to class examples, a lot of them were similar to the skills we were intended to learn through the projects and understanding them before diving deeper into the projects is really essential in getting a good grasp of the concepts and being able to apply to a more complex application. 


Steven: I’d tell myself to ask for help more often, from classmates and course staff. There were a few times where I got stuck on something and I thought I could figure it out on my own, but I ended up taking a few hours to figure out what the problem was, and it was usually just an “oh duh” moment, not ‘ooohhh okay, what a valuable learning experience”. The other thing is to pay closer attention to our in-class examples. They’re good demos for stuff we’ll need in our homeworks, and I think I would’ve had better starts to all my assignments if I understood the demos better.


Benjamin: I would give myself the advice of starting steady. I noticed a lot of the times I start the project confident, and underestimate the difficulty of the later parts. I would like to tell myself to properly read the instructions and do research instead of rushing the progression.


Amy: My advice for myself is to go to more office hours and start early on assignments so I can come to office hours prepared with questions. Whenever I have questions on an assignment, I missed the timing to go to office hours (and some office hours didn’t work for schedule) so I would go back and tell myself to begin assignments at the start of each week. Another piece of advice is to look back at the course slides for clues on coding the app. I should read the slides multiple times.


Charyl: I would advise myself to start experimenting with Flutter widgets and state management early on, as getting hands-on experience is crucial for mastering these concepts. Another piece of advice would be to actively participate in discussions and ask questions whenever something is unclear, as this would have helped me grasp the material more quickly and avoid confusion later on. Lastly, I would recommend setting aside dedicated time each week for project work to avoid last-minute stress and ensure a steady, thoughtful progression through the assignments.
