Jinwoo Baek's code review project for TW. (First ruby project)

Mars Rovers
=======

To execute, please type in the following line in a console with the current directory set to the project directory.

    ruby Deployer.rb

To change the input, please change the content of the input.txt file.

To execute tests, please type in the following line in a console with the current directory set to the project directory.

    ruby TestExecuter.rb

Design Decisions
--------------

The Deployer gets instructions from NASA on the specific instructions for each rovers in text format. The Deployer then parses the text file using the Parser. The Parser checks the format, and the logic of the input while converting the data into an array of rover-instruction pair and maximum coordinate. The format and logic check by the parser allows a predictable flow of execution after this point.

When the Parser return the parsed data to the Deployer, the Deployer initiates a setup for the rovers, and plateau. The instructions are separated and organized in a hash to be given for when the rovers are deployed into the plateau. Then, the rovers are deployed into its designated plateau.

When the rovers are deployed and situated in their starting co-ordinate and heading, the Deployer sends a message with its instruction to each rover sequentially to execute their instruction set. The execution is done by the rovers interacting with the plateau that they are residing in. The individual grids within the plateau supplies the state so that the rovers can determine if they can navigate into a new grid.

Finally, when all the rovers are done with their execution, they report to the Deployer with their final location and heading. The Deployer then formats the data using the Outputformatter. The formatted text file is sent to NASA.

Assumptions
-----------

- Rovers will override instructions for self-preservation.
- Rovers can observe both the existence and non-existence of the plateau.
- It is possible for NASA to make errors.

Things to Improve Upon
--------------------

- Improve the algorithm in the extract_rover_and_instruction_set of Parser.rb. This algorithm checks if the new rover's starting co-ordinate interferes with a previously added rover's starting co-ordinate. I would improve the linear search to a tree search for when there is a larger number of rovers.

- I would refactor the Parser.rb file to separate the format checking algorithm and the logic checking algorithm.

- To deal with when NASA designates a large plateau, I have designed the code so that the an improvement can be implemented into the flow of the program by adding a conditional statement into a single method in Deployer.rb. This can be done when I create a subclass of Plateau. This would be done to prevent a memory-issue caused by the current GridPlateau's method of creating an array of arrays populated with Grid objects. The new Plateau class would override the existing methods and substitute the functionality of the grid approach by keeping track of only the occupied co-ordinates on the Plateau.