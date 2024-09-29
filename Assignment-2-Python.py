# The below imports trivia questions from an API, and assesses the users input of the question difficulty and determines whether they can continue.
# To set up own API key, you will need to generate a new URL via 'https://opentdb.com/api_config.php'

# API request
import requests
from pprint import pprint as pp

trivia_questions = "https://opentdb.com/api.php?amount=10"

response = requests.get(trivia_questions)
print(response.status_code)

data = response.json()
pp(data)

# Creating a text file with all the questions within this Trivia
with open('Trivia questions.txt', 'w+') as text_file:
    for question in data["results"]:
        text_file.write(question["question"] + '\n')

#Accessing the necessary data within data to form a Trivia question with other information about it
difficulty = data["results"][0]["difficulty"]
print(difficulty)

question = data["results"][0]["question"]
print(question)

question_type = data["results"][0]["type"]
print(question_type)

Trivia = f"Level: {difficulty}, Question: {question}, Type: {question_type}"
print(Trivia)

# Asking the user what difficulty level they want for the questions and seeing if they can join Trivia using if...else
Desired_difficulty = str(input("Desired difficulty? (Options: Easy, Medium or Hard):"))
can_continue = str(Desired_difficulty) == 'Medium'
if Desired_difficulty != "Medium":
    print("Sorry, you can not join the Trivia today")
elif Desired_difficulty == "Hard":
    print("Sorry, you can not join the Trivia today")
else:
    print("Fantastic!You can carry on with Trivia {}".format(can_continue))

# Another way of asking the user what difficulty level they want for the questions and seeing if they can join Trivia using while loop
Desired_difficulty = str(input("Desired difficulty? (Options: Easy, Medium of Hard):"))
while Desired_difficulty != "Medium":
    print("You are not qualified to take this Trivia")
    Desired_difficulty = input("Desired difficulty? (Options: Easy, Medium or Hard):")
print("Fantastic! You can carry on with Trivia")

for level in Desired_difficulty:
    if Desired_difficulty[:len(level)] == level:
        print(f"You have selected {level} difficulty.")
        break
    else:
        print("Invalid level entered!")

# Importing an additional module I have not used in this assignment yet and using it, installed using PIP. To show the time and date of trivia
import datetime
datetime.datetime.now()
print(datetime.datetime.now())
























