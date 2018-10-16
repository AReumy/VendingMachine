class Drink
  # ドリンクのID
  @@id = 1

  def initialize (name, price, quantity)
    # ドリンクのID
    @id = @@id

    # ドリンクの名前
    @name = name

    # ドリンクの値段
    @price = price

    # ドリンクの数
    @quantity = quantity

    # ドリンクのID増加
    @@id += 1
  end

  # ドリンクのIDを返却
  def get_id
    return @id
  end

  # ドリンクの名前を返却
  def get_name
    return @name
  end

  # ドリンクの値段を返却
  def get_price
    return @price
  end

  # ドリンクの数量を返却
  def get_quantity
    return @quantity
  end

  # ドリンクの数量をアップデートしてから、その結果を返却
  def update_quantity

    if @quantity == 0
      return false
    else
      @quantity -= 1
      return true
    end
    
  end

end