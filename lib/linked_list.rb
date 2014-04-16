class LinkedList
  attr_reader :size

  def initialize(*seeds)
    @size = 0
    seeds.each do |item|
      add_item(item)
    end
  end

  def add_item(payload)
    if @size == 0
      @first_item = LinkedListItem.new(payload)
    else
      current_item = @first_item
      until current_item.last?
        current_item = current_item.next_list_item
      end
      current_item.next_list_item = LinkedListItem.new(payload)
    end
    @size +=1
  end

  def get(n)
    get_item(n).payload
  end
  alias [] get

  def []=(n, val)
    get_item(n).payload = val
  end

  def remove(n)
    raise IndexError if n < 0 || n > (@size - 1)
    if n == 0
      @first_item = @first_item.next_list_item
    else
      item = get_item(n-1)
      new_next_item = item.next_list_item.next_list_item
      item.next_list_item = new_next_item
    end
    @size -= 1
  end

  def indexOf(arg)
    current_item = @first_item
    index = 0
    while index < @size
      break index if current_item.payload == arg
      current_item = current_item.next_list_item
      index += 1
    end
  end

  def last
    if @size == 0
      nil
    else
      get(@size-1)
    end
  end

  def to_s
    string = "|"
    current_item = @first_item
    @size.times do
      string << " " + current_item.payload.to_s
      string << "," unless current_item.last?
      current_item = current_item.next_list_item
    end
    string << " |"
    string
  end

  def sorted?
    if @size < 2
      true
    else
      item = @first_item
      count = @size - 1
      count.times do
        return false if item > item.next_list_item
        item = item.next_list_item
      end
      true
    end
  end

  def swap_with_next(n)
    raise IndexError if n < 0 || n >= (@size - 1)

    if n == 0
      first = @first_item
      second = first.next_list_item

      first.next_list_item = second.next_list_item
      second.next_list_item = first
      @first_item = second
    else
      current_item = @first_item
      count = n - 1
      count.times do
        current_item = current_item.next_list_item
      end
      previous = current_item
      first = previous.next_list_item
      second = first.next_list_item

      previous.next_list_item = second
      first.next_list_item = second.next_list_item
      second.next_list_item = first
    end
  end

  def sort
    if @size < 2
      self
    else
      count = @size - 1
      item = @first_item
      index = 0

      while true
        swap = false
        count.times do
          if item > item.next_list_item
            swap_with_next(index)
            swap = true
          else
            item = item.next_list_item
          end
          index += 1
        end

        break unless swap
        index = 0
        item = @first_item
      end

    end
    self
  end

  private

  def get_item(n)
    raise IndexError if n < 0 || n >= @size
    current_item = @first_item
    n.times do
      current_item = current_item.next_list_item
    end
    current_item
  end
end
