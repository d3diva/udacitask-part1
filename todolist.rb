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


      #-------------------- Start Add ---------------------#
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

      # --------------------- End Add ----------------#

      #---------------------Start validations --------------#
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

      def index_exist(index_no)
        @items.length >= index_no - 1
      end
      #---------------------End validations --------------#

      #-------------- Stard Delete ----------------#
      # clears item by description from the list with validations
      def clear_item(delete_item)
        @items.empty?? conf_message(delete_item, "does not exist") : item_delete(delete_item)
      end

      # deletes item from the list if found
      def item_delete(delete_item)
        @items.delete_if {|e| e.description == delete_item.capitalize}
         conf_message(delete_item, "removed")
      end

      # removes by index form the list with validations
      def remove_item(index_no)
        index_exist(index_no)? exist_index_remove_item(index_no) :  conf_message(index_no, "does not exist")
      end

      # deletes item from the list if found
      def exist_index_remove_item(index_no)
        index_no -= 1
        @r_item = @items[index_no].description
        @items.delete_at(index_no)
        conf_message(@r_item, "removed")
      end
      #-------------- End Delete ----------------#


      #-------------- Start change status ---------#
      # Chanage status of item with validations
      def change_status(index_no)
        index_exist(index_no)? index_change_status(index_no) :  conf_message(index_no, "does not exist")
      end

      # Change status
      def index_change_status(index_no)
        index_no -= 1
        items[index_no].update_status
      end
      #-------------- End change status ---------#


      # conferm message of the actions
      def conf_message(idescription, message)
        print_line
        puts "#{idescription} #{message}"
        print_line
      end


      #------------------ Start print  --------------------#
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
      #------------------ End print  --------------------#
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
