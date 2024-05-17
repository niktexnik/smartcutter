class ConstantsDictionary
  def self.from_array(array)
    hash = array.index_with(&:to_s)
    new(hash)
  end

  attr_reader :hash

  def initialize(hash)
    @hash = hash

    @hash.each do |key, value|
      define_singleton_method(key) do
        value
      end
    end
  end

  def to_h
    @hash
  end

  def all
    values
  end

  delegate :values, to: :to_h

  delegate :keys, to: :to_h
end
