class GildedRose
  attr_reader :name, :days_remaining, :quality

  MAX_QUALITY = 50

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if !aged_brie? and !backstage?
      if @quality > 0
        if !sulfura?
          @quality -= 1
        end
      end
    else
      if !max_quality_reached?
        @quality += 1
        if backstage?
          if @days_remaining < 11
            if !max_quality_reached?
              @quality += 1
            end
          end
          if @days_remaining < 6
            if !max_quality_reached?
              @quality += 1
            end
          end
        end
      end
    end

    if !sulfura?
      @days_remaining -= 1
    end

    if @days_remaining < 0
      if !aged_brie?
        if !backstage?
          if @quality > 0
            if !sulfura?
              @quality -= 1
            end
          end
        else
          @quality = 0
        end
      else
        if !max_quality_reached?
          @quality += 1
        end
      end
    end
  end

  private

  def sulfura? = @name == "Sulfuras, Hand of Ragnaros"
  def aged_brie? = @name == "Aged Brie"
  def backstage? = @name == "Backstage passes to a TAFKAL80ETC concert"

  def max_quality_reached? = @quality == MAX_QUALITY
end
