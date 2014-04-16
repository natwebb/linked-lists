class LinkedListItem
  attr_reader :next_list_item
  attr_accessor :payload

  include Comparable

  def initialize(payload)
    @payload = payload
  end

  def last?
    @next_list_item.nil?
  end

  def next_list_item=(val)
    raise ArgumentError if self.object_id == val.object_id
    @next_list_item = val
  end

  def <=>(other)
    payload1 = self.payload
    payload2 = other.payload

    precedence = [Fixnum, String, Symbol]
    index1 = precedence.index(payload1.class)
    index2 = precedence.index(payload2.class)
    class_equality = (index1 <=> index2)

    return class_equality unless class_equality == 0

    payload1 <=> payload2
  end

  def ===(other)
    self.object_id == other.object_id
  end
end
