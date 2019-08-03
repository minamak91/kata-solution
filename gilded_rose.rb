class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1

      if item.name == 'Aged Brie'
        item.quality += 1 if item.quality < 50
        next
      end

      if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_quality(item)
        next
      end

      next if item.quality.zero? || item.name == 'Sulfuras, Hand of Ragnaros'

      decrease_quality(item)
    end
  end

  def update_backstage_quality(item)
    quantity_increased = 1

    if item.sell_in <= 10
      quantity_increased = 2
    end

    if item.sell_in <= 5
      quantity_increased = 3
    end

    item.quality += quantity_increased
    item.quality = 50 if item.quality > 50
  end

  def decrease_quality(item)
    quantity_decreased = item.name == 'Conjured Mana Cake' ? 2 : 1
    item.quality -= quantity_decreased
    if item.sell_in < 0
      item.quality -= quantity_decreased
    end

    item.quality = 0 if item.quality < 0
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
