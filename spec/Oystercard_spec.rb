require 'oystercard.rb'

describe Oystercard do

	subject(:card) {described_class.new}

  describe "#balance" do
    it {is_expected.to respond_to(:balance)}

    it 'initializes Oystercard with default balance 0' do
    expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it {is_expected.to respond_to(:top_up).with(1).argument }

  	it 'tops up with £10' do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
  	end
  end
end
