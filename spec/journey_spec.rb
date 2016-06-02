require 'journey'

describe Journey do
  subject(:journey) {described_class.new()}
  let(:entry_station) {double :station, zone: 1}
  let(:exit_station) {double :station, zone: 1}

  describe "#initialize" do

    context "when there is NO entry_station" do

      it "entry_station is nil" do
        expect(journey.current_journey[entry_station]).to eq nil
      end

    end

    context "when there IS an entry_station" do

      it "entry_station is saved to current_journey hash" do
        journey = Journey.new(entry_station)
        expect(journey.current_journey[entry_station]).to eq entry_station
      end

    end


  end

  describe "#finish" do

    subject(:journey) { described_class.new }

    it "saves finish station to current journey hash" do

    end

    it "saves journey to journey_log" do

    end

    it "resets current_journey" do

    end

  end

  describe "#fare" do

  end

  describe "#complete" do

  end

end
