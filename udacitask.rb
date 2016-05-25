require_relative 'todolist.rb'

# Creates a new todo list
list = TodoList.new("Things to Learn")

# Add four new items
list.add_item "Buy Grocery", due_time: "16:00"
list.add_item "Clean Bike", due_time: "17:00"
list.add_item "Walk Dusty", due_time: "18:00"
list.add_item "Water Plants"

# Print the list

# Delete the first item

# Print the list

# Delete the second item

# Print the list

# Update the completion status of the first item to complete

# Print the list

# Update the title of the list

# Print the list
