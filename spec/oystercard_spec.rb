require "Oystercard"

describe Oystercard do

  subject(:card) {described_class.new}
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }

  describe "#initialize" do

    context "when new card" do

      it "starts with balance of 0" do
        expect(card.balance).to eq(0)
      end

      it "expected to have no stored journeys" do
        expect(card.journey_log).to be_empty
      end

      it "has no journey history saved" do
        expect(card.journey_log).to be_empty
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

    end

  end

  describe "#touch_out" do

      it "deducts min fare from balance on touch out" do
        expect{card.touch_out(exit_station)}.to change{card.balance}.by(-1)
      end

    context "processes journey log info" do

      let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

      it "stores a journey" do
        card.top_up(1)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journey_log).to include journey
      end

    end

  end

end
