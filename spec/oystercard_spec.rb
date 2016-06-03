require "Oystercard"

describe Oystercard do

  subject(:card) {described_class.new}
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }
  let(:journey){ double :journey}

  describe "#initialize" do

    context "when new card" do

      it "starts with balance of 0" do
        expect(card.balance).to eq(0)
      end

    end

  end

  describe "#top_up" do

    it "can increase balance by specified amount" do
      expect{card.top_up(1)}.to change{card.balance}.by(+1)
    end

    it "doesnt allow to exceed max balance" do
      max_balance = Oystercard::MAX_BALANCE
      card.top_up(max_balance)
      expect{card.top_up(1)}.to raise_error "Maximum balance of #{max_balance} reached!"
    end

  end

  describe "#touch_in" do

    context "when card has insufficient balance" do

      it "raises error if card balance below minimum fare value" do
        expect{ card.touch_in(entry_station) }.to raise_error "Error: minimum balance less than minimum fare. Top-up!"
      end

      it "creates new journey object" do
        card.top_up(10)
        card.touch_in(entry_station)
        expect(card.current_journey).to respond_to :fare
      end



    end

  end

  describe "#touch_out" do

      it "deducts min fare from balance on touch out" do
        expect{card.touch_out(exit_station)}.to change{card.balance}.by(-1)
      end
  end

end
