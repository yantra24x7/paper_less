class Shift
  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_time, type: String
  field :end_time, type: String
  field :total_hour, type: String
  field :shift_no, type: String
  field :start_day, type: String
  field :end_day, type: String
  field :break_time, type: Integer
  field :total_time, type: Integer
  field :actual_hour, type: Integer
  field :module, type: String
 

  validates :start_time, :end_time, :total_hour, :shift_no, :start_day, :end_day, :break_time, :module, presence: true


 def self.current_shift
    shift = []
    shifts = Shift.all
    shifts.map do |ll|
     case
      when ll.start_day == '1' && ll.end_day == '1'
        duration = ll.start_time.to_time..ll.end_time.to_time
        if duration.include?(Time.now)
          shift = ll
        end
      when ll.start_day == '1' && ll.end_day == '2'
        if Time.now.strftime("%p") == "AM"
          duration = ll.start_time.to_time-1.day..ll.end_time.to_time
         else
          duration = ll.start_time.to_time..ll.end_time.to_time+1.day
         end
        if duration.include?(Time.now)
          shift = ll
        end
      else
        duration = ll.start_time.to_time..ll.end_time.to_time
        if duration.include?(Time.now)
          shift = ll
        end
      end
    end
    return shift
  end

end
