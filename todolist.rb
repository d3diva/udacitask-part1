class TodoList
    # methods and stuff go here
    attr_accessor :title, :items

    # Initialize todo list with a title and no items
    def initialize(list_title)
      @title = list_title
      @items = Array.new # Starts empty! No Items yet!
      @tdate = Time.now.strftime("%m/%d/%Y") # Todays' Date
    end
      $report_file = File.new("newlist.txt", "w+") #new file with wright permission

      # adds new item with time due as options
      def add_item(new_item, options = {})
        new_item = Item.new(new_item.capitalize)
        # add due time if given
        if options[:due_time]
          new_item.due_time = options[:due_time]
        end
        # See if item already exists else push item and conferm with message
        @items.empty?? add_new_item(new_item) : item_exist(new_item)? conf_message(new_item.description, "Already Exists") : add_new_item(new_item)
      end

      # adds it to the array of Items
      def add_new_item(new_item)
          @items.push(new_item)
      end

      # see if item with description exist
      def is_item_with_description_exist(new_item)
          item_found = @items.find{|item| item.description == new_item }
          return !item_found.nil?
      end

      # see if item exist for both new and rename
      def item_exist(new_item)
        if new_item =~ /[A-Za-z]/
          is_item_with_description_exist(new_item)
        elsif new_item.is_a?(Item)
          is_item_with_description_exist(new_item.description)
        end
      end

      # conferm message of the actions
      def conf_message(idescription, message)
        print_line
        puts "#{idescription} #{message}"
        print_line
      end
end

class Item
    # methods and stuff go here
end
