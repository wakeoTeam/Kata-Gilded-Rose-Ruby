class GildedRose
  attr_reader :name, :days_remaining, :quality

  MAX_QUALITY = 50
  MIN_QUALITY = 0
  SELL_DATE = 0
  LONG_BEFORE_SELL_DATE_THRESHOLD = 11
  MEDIUM_CLOSE_TO_SELL_DATE_THRESHOLD = 6

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if !aged_brie? and !backstage?
      if !min_quality_reached?
        if !sulfura?
          @quality -= 1
        end
      end
    else
      if !max_quality_reached?
        @quality += 1
        if backstage?
          if @days_remaining < LONG_BEFORE_SELL_DATE_THRESHOLD
            if !max_quality_reached?
              @quality += 1
            end
          end
          if @days_remaining < MEDIUM_CLOSE_TO_SELL_DATE_THRESHOLD
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

    if after_sell_date?
      if !aged_brie?
        if !backstage?
          if !min_quality_reached?
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
  def min_quality_reached? = @quality == MIN_QUALITY
  def after_sell_date? = @days_remaining < SELL_DATE
end
