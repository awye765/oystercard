require "Oystercard"

describe Oystercard do

  context "when new card" do

  subject(:card){described_class.new}

    it "starts with balance of 0" do
      expect(card.balance).to eq(0)
    end

    it "expected to not be in journey" do
      expect(card).not_to be_in_journey
    end

    it "has no entry station set" do
      expect(card.entry_station).to eq nil
    end

    it "has no journey history saved" do
      expect(card.journeys).to be_empty
    end

  end

  describe "#top_up" do

    subject(:card){described_class.new}

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

    context "when card has sufficient balance" do

      subject(:card){described_class.new}
      let(:station){ double :station }

      it "can touch in" do
        card.top_up(1)
        card.touch_in(station)
        expect(card).to be_in_journey
      end

      it "stores entry station" do
        card.top_up(1)
        card.touch_in(station)
        expect(card.entry_station).to eq station
      end

    end

    context "when card has insufficient balance" do

      subject(:card){described_class.new}
      let(:station){ double :station }

      it "raises error if card balance below minimum fare value" do
        expect{ card.touch_in(station) }.to raise_error "Error: minimum balance less than minimum fare. Top-up!"
      end

    end

  end

  describe "#touch_out" do

    subject(:card){described_class.new}
    let(:entry_station){ double :station }
    let(:exit_station){ double :station }

    context "touching out and min fare deduction" do

      it "can touch out" do
        card.top_up(1)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card).not_to be_in_journey
      end

      it "deducts min fare from balance on touch out" do
        expect{card.touch_out(exit_station)}.to change{card.balance}.by(-1)
      end

    end

    context "processes journey log info" do

      it "stores exit station" do
        card.top_up(1)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.exit_station).to eq exit_station
      end

      it "forgets entry station" do
        card.top_up(1)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.entry_station).to eq nil
      end

      let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

      it "stores a journey" do
        card.top_up(1)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journeys).to include journey
      end

    end

  end

end