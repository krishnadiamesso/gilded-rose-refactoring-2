class GildedRose

  def initialize(items)
    @items = items
  end


  MAXIMUM_QUALITY = 50
  MINIMUM_QUALITY = 0

  def update_quality
    @items.each do |item|

      case item.name
      when 'Aged Brie'
        update_aged_brie(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_passes(item)
      else
        update_normal_item(item)
      end
    end
  end

  private

  def update_aged_brie(item)
    quality_increase(item)
    decrease_sell_in(item)
    quality_increase(item) if item.sell_in.negative?
  end

  def update_backstage_passes(item)
    quality_increase(item)
    quality_increase(item) if item.sell_in < 11
    quality_increase(item) if item.sell_in < 6
    decrease_sell_in(item)
    quality_zero(item) if item.sell_in.negative?
  end

  def update_normal_item(item)
    quality_degrade(item)
    decrease_sell_in(item)
    quality_degrade(item) if item.sell_in.negative?
  end

  def quality_increase(item)
    item.quality += 1 if item.quality < MAXIMUM_QUALITY
  end

  def quality_degrade(item)
    item.quality -= 1 if item.quality.positive? && item.name != 'Sulfuras, Hand of Ragnaros'
  end

  def decrease_sell_in(item)
    item.sell_in -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
  end

  def quality_zero(item)
    item.quality = 0
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
