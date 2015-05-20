string = "user[address][street]"
arr = []

def parse(key)
  arr = [[]]
  until arr.all? { |el| el.is_a?(String) }
    key.each do |el|
      if el.is_a?(Array)
        parse(el)
      else
        arr << el
      end
    end
  end
end

p parse(string)
