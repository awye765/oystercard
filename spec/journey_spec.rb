require 'journey'

describe Journey do

  describe "new journey" do

    context "when there is NO touch-in" do

      subject(:journey){described_class.new}

      let(:station){ double :station }

      describe "#initialize" do

        it "entry station is nil" do
           journey()
           expect(journey.entry_station).to eq nil
        end

      describe "#finish" do

        it "it records exit station on touch out" do
          subject(:journey){described_class.new}
          journey.finish(station)
          expect(subject.exit_station).to eq station
        end

      end

    end

    context "when there IS touch-in" do

      subject(:journey){described_class.new(station)}

      let(:station){ double :station }

      describe "#initialize" do

        it "records entry station on touch in" do
          expect(journey.entry_station).to eq station
        end

      end

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
