require 'journey'

describe Journey do
  subject(:journey)  {Journey.new()}
  let(:entry_station) {double :station, zone: 1}
  let(:exit_station) {double :station, zone: 1}

  describe "#initialize" do

    subject(:journey) {Journey.new()}

    context "irrespective of whether entry_station provided" do

      it "journey is set to NOT complete" do
        expect(journey.complete).to eq false
      end

    end

    context "when there is NO entry_station" do

      it "entry_station is nil" do
        expect(journey.current_journey[:entry_station]).to eq nil
      end

    end

    context "when there IS an entry_station" do

      subject(:journey) {Journey.new(entry_station)}

      it "entry_station is saved to current_journey hash" do
        expect(journey.current_journey[:entry_station]).to eq entry_station
      end

    end

  end

  describe "#finish" do

    subject(:journey) { Journey.new }

    # it "saves finish station to current journey hash" do
    #   journey.finish(exit_station)
    #   expect(journey.current_journey[:exit_station]).to eq exit_station
    # end

    it "saves current journey to journey_log array" do
      journey.finish(exit_station)
      expect(journey.journey_log).not_to be_empty
    end

    # it "resets current_journey" do
    #   journey.finish(exit_station)
    #   expect(journey.current_journey).to be_empty
    # end

    it "journey is set to BE complete" do
      journey.finish(exit_station)
      expect(journey.complete).to eq true
    end

  end

  describe "#fare" do

    context "when touch in but no touch out" do
      subject(:journey)  {Journey.new(entry_station)}

      it "charges penalty fare" do
        journey.finish()
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end

    end

    context "when no touch in but touch out" do
      subject(:journey)  {Journey.new()}

      it "charges penalty fare" do
        journey.finish(exit_station)
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end

    end

    context "when touch in and touch out" do
      subject(:journey)  {Journey.new(entry_station)}

      it "charges minimum fare" do
        journey.finish(exit_station)
        expect(journey.fare).to eq Journey::MIN_FARE
      end

    end

  end

end
