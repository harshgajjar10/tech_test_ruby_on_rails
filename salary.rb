class Salary
  attr_accessor :monthly_salary, :cumulative_sum_of_salary

  def initialize(monthly_salary, cumulative_sum_of_salary)
    @monthly_salary = monthly_salary
    @cumulative_sum_of_salary = cumulative_sum_of_salary
  end

  def self.salary_validation
    puts "\nEnter Monthly Salary :"
    salary = gets.chomp.to_i
    if salary > 0
      salary 
    else
      puts "\n----- Error : Enter Valid input for Monthly Salary -----\n 'Monthly salary' must be integer \n"
      salary_validation
    end
  end

  def self.cumulative_sum_validation
    puts "\nEnter Cumulative Sum of Salary :"
    cumulative_sum = gets.chomp.to_i
    if cumulative_sum > 0
      cumulative_sum 
    else
      puts "\n----- Error : Enter Valid input for Cumulative Sum of salary -----\n 'Cumulative sum of salary' must be integer and greater than to 'Monthly Salary'.\n"
      cumulative_sum_validation
    end
  end

  def get_number_of_month
    if cumulative_sum_of_salary > monthly_salary && cumulative_sum_of_salary > monthly_salary && cumulative_sum_of_salary % monthly_salary == 0
      puts "\nThe number of the Month : #{cumulative_sum_of_salary / monthly_salary % 12}"
      iteration
    else
      puts "\n-----Error : Cumulative sum of salary or Per Month Salary is not Valid, Please Enter Valid inputs-----\n"
      Salary.new(Salary.salary_validation, Salary.cumulative_sum_validation).get_number_of_month
    end
  end

  def iteration
    puts "\nIf You want to check more than enter ('Y' or 'y') or ('Any key' + 'Enter' for exit)"
    answer = gets.chomp.upcase
    Salary.new(Salary.salary_validation, Salary.cumulative_sum_validation).get_number_of_month if answer == 'Y' 
  end
end

Salary.new(Salary.salary_validation, Salary.cumulative_sum_validation).get_number_of_month
