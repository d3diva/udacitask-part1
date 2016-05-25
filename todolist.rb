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

      # Prints header
      def print_header
        "#{"Sl."} #{"Description".ljust(20)} #{"Created time".ljust(10)}  #{"Due by".ljust(10)} #{"Status"}"
      end

      # Prints title
      def print_title
        "#{''.ljust(20)} #{title}"
      end

      # Prints Prepared date
      def print_date
        "#{''.ljust(15)} Prepared Date: #{@tdate}"
      end

      # Prints report to file
      def report_print_items
        $report_file.puts print_line
        $report_file.puts print_date
        $report_file.puts print_title
        $report_file.puts print_line
        $report_file.puts print_header
        $report_file.puts print_line
        items.each_with_index do |item, index_no|
          $report_file.puts item.print_item_details(index_no)
        end
        $report_file.puts print_line
      end

      # Out put list to terminal
      def print_items
        puts print_line
        puts print_date
        puts print_title
        puts print_line
        puts print_header
        puts print_line
        items.each_with_index do |item, index_no|
          puts item.print_item_details(index_no)
        end
        puts print_line
      end

      def print_line
           "-" * 60
      end
end

class Item
    # methods and stuff go here
    attr_accessor :description, :completed_status, :created_time, :due_time

    # Initialize item with a description and marked as
    # not complete
    def initialize(item_description)
       @description = item_description
       @completed_status = false
       @created_time = Time.now.strftime("%H:%M")
       @due_time = (Time.now + 18000).strftime("%H:%M")
    end

    # prints items details
    def print_item_details(index_no)
      "#{index_no +1} #{@description.ljust(25)} #{@created_time.ljust(10)} #{@due_time.ljust(12)} #{task_complete?? "\u2611" : "\u2610"}"
    end

    # verify status
    def task_complete?
      @completed_status
    end



end
