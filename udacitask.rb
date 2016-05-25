require_relative 'todolist.rb'

# Creates a new todo list
list = TodoList.new("Things to Learn")

# Add four new items
list.add_item "Buy Grocery", due_time: "16:00"
list.add_item "Clean Bike", due_time: "17:00"
list.add_item "Walk Dusty", due_time: "18:00"
list.add_item "Water Plants"

# Print the list
list.print_items

# Delete the first item
list.clear_item "Buy Grocery" # with description

# Print the list
list.print_items

# Delete the second item
list.remove_item 2 # with with item number as in the print list

# Print the list
list.print_items

# Update the completion status of the first item to complete
list.change_status 1 # toggles status

# Print the list
list.print_items

# Update the title of the list

# Print the list
