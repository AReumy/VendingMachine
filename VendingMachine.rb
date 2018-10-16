require_relative 'DrinkInfo'

class VendingMachine
  def initialize
    #　投入する金額
    @input_money = 0

    #　投入した総金額
    @current_money = 0

    #　払い戻す金額
    @change = 0

    #　売り上げ
    @sales = 0

    #　ドリンクのオブジェクトをセーブする配列
    @drink_info = []

    #　ドリンクのオブジェクトを配列にセーブ
    @drink_info.push(Drink.new('コーラ', 120, 5))
    @drink_info.push(Drink.new('レッドブル', 200, 5))
    @drink_info.push(Drink.new('水', 100, 5))
  end

  #　ユーザーがお金を販売機に投入
  def input_money

    #　-1を入力したら、購入終了
    while @input_money != -1

      #　ユーザーがお金を投入
      puts '金額を投入してください。(購入終了　→　-1)'
      @input_money = gets.chomp.to_i

      #　条件　＜１円、５円、１０００円以外の札は投入できない。＞
      #　条件に合わない場合は、それをそのまま釣り銭としてユーザに出力する。
      if @input_money != -1 and @input_money != 0
        if @input_money <= 1000 and @input_money != 1 and @input_money != 5
          @current_money += @input_money
          self.get_drink_info

          #　現在の金額、釣り銭を出力
          puts '現在金額：' + @current_money.to_s
        else
          @change += @input_money
          self.refund
          break
        end
      end

      #　現在の金額が100円以上の場合、購入を進行
      if @input_money!= -1 and @current_money >= 100
        self.purchase
      end

      #　0を入力したら、払い戻しを進行
      if @input_money == -1
        self.refund
        break
      end

    end

  end

  #　ユーザーにドリンク情報リストを出力
  def get_drink_info

    @drink_info_length =  @drink_info.length - 1

    #　ドリンク情報を出力
    for index in 0..@drink_info_length
      puts @drink_info[index].get_id.to_s + '　→　' +  @drink_info[index].get_name + '  ¥' +  @drink_info[index].get_price.to_s +
               '  残り数：  ' + @drink_info[index].get_quantity.to_s
    end

  end

  #　ユーザーがドリンクを購入
  def purchase

    while true

      #　購入しようとするドリンクのIDを入力
      puts '購入しようとする商品の番号を入力してください。(払い戻す　→　-1)'
      @input_id = gets.chomp.to_i

      #　-1を入力したら、購入を終了
      if(@input_id == -1)
        break
      end

      @index = @input_id - 1

      begin

        #　現在投入した金額より高いドリンクを選んだ場合、このメッセージを出力
        if @current_money < @drink_info[@index].get_price
          puts '現在金額が不足です。'
        else

          #　ドリンクの数量と売り上げをアップデート
          current_quantity = @drink_info[@index].update_quantity

          #　ドリンクの在庫が不足する場合メッセージ出力
          #　商品の在庫がない時には金額が引きされず、売り上げが上がらない。
          if current_quantity == false
            puts '商品の在庫がないです。'
          else
            @current_money -= @drink_info[@index].get_price
            @sales += @drink_info[@index].get_price
          end

          #　売り上げと現在金額を出力
          puts '売り上げ：' + @sales.to_s
          puts '現在金額：' + @current_money.to_s

        end
        #　現在のドリンク情報リストを出力
        self.get_drink_info

      rescue
        # 存在しないIDを入力したら、このメッセージを出力
        puts '存在しない商品番号です。'
      end

    end

  end

  # ユーザーに釣り銭を出力
  def refund

    # 釣り銭に現在の金額を加える
    @change += @current_money

    # 釣り銭を出力
    puts '釣り銭：' + @change.to_s
  end

end

vendingMachine = VendingMachine.new
vendingMachine.get_drink_info
vendingMachine.input_money