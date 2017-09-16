FactoryGirl.define do
  factory :boardgame do
    sequence(:title) {|n| 'Test Game #{n}' }
    genre 'LCG'
    publisher 'Fantasy Flight'
    player_count '2'
    duration '45'
    msrp '39.95'
    user
  end
end
