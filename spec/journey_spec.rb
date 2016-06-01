require 'journey'

describe Journey do

  subject(:journey){described_class.new}

  let(:station){ double :station }

  describe
    it "has no entry station set" do
      expect(card.entry_station).to eq nil
    end

  describe "#start" do

    it "records entry station on touch in" do
      journey.start(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "#finish" do

    it "it records exit station on touch out" do
      journey.finish(station)
      expect(subject.exit_station).to eq station
    end

  end

end


  # context "when card has sufficient balance" do

  #   subject(:journey){described_class.new}

  #   let(:station){ double :station }

  #     it "starts a journey on touch in" do
  #       card.top_up(1)
  #       card.touch_in(station)
  #       expect(card.entry_station).to be station
  #     end

  #     it "saves the entry station" do
  #       card.top_up(1)
  #       card.touch_in(station)
  #       expect(card.entry_station).to eq station
  #     end

  #   end

  # end
