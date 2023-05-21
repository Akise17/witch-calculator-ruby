class WitchCalculatorService
  attr_accessor :villagers_killed, :persons

  def initialize(persons)
    @persons = persons
    @villagers_killed = []
  end

  def calculate_average_kills
    return -1 if invalid_data?

    calculate_kills
    calculate_average
  end

  private

  def invalid_data?
    persons.any? do |person|
      next if person[:age_of_death].blank? && person[:year_of_death].blank?

      person[:age_of_death].to_i.negative? || person[:year_of_death].to_i < person[:age_of_death].to_i
    end
  end

  def calculate_kills
    persons.each do |person|
      year_of_birth = person[:year_of_death].to_i - person[:age_of_death].to_i
      villagers_killed_on_birth = calculate_villagers_killed(year_of_birth)
      villagers_killed << villagers_killed_on_birth
    end
  end

  def calculate_villagers_killed(year)
    sqrt5 = Math.sqrt 5
    golden_ratio = (1 + sqrt5) / 2
    result = 0
    (0..year).each do |i|
      fibonacci = ((golden_ratio**i - (1 - golden_ratio)**i) / sqrt5).to_int
      result += fibonacci
    end
    result
  rescue StandardError => e
    'Infinity'
  end

  def calculate_average
    return 'Infinity' if villagers_killed.include? 'Infinity'

    total_villagers_killed = villagers_killed.reduce(:+)
    total_persons = persons.length
    average = total_villagers_killed.to_f / total_persons
    average.round(2)
  end
end
