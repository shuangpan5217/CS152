class Tree
  attr_accessor :value, :left, :right
  def initialize(value, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end

  def each_node(&block)
    yield @value if self != nil
    if(@left != nil)
      @left.each_node(&block)
    end
    if(@right != nil)
      @right.each_node(&block)
    end
  end

  def method_missing(m, *args, &block)
    path = m.to_s.split(/_/)
    get_value(path)
  end

  def get_value(path)
    if(path[0])
      direction = path.shift
      if(direction == "left")
        if(@left == nil)
          put 'No such Node'
        else
          @left.get_value(path)
        end
      else
        if(@right == nil)
          put 'No such Node'
        else
          @right.get_value(path)
        end
      end
    else
      @value
    end
  end
end

my_tree = Tree.new(42,
                   Tree.new(3,
                            Tree.new(1,
                                     Tree.new(7,
                                              Tree.new(22),
                                              Tree.new(123)),
                                     Tree.new(32))),
                   Tree.new(99,
                            Tree.new(81)))

my_tree.each_node do |v|
  puts v
end

arr = []
my_tree.each_node do |v|
  arr.push v
end
p arr

p "Getting nodes from tree"
p my_tree.left_left
p my_tree.right_left
p my_tree.left_left_right
p my_tree.left_left_left_right