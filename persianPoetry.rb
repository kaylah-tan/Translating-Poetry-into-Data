require 'csv'
data_filepath = '/Users/kaylahtan/Desktop/translations.csv'
data = CSV.parse(File.read(data_filepath), headers: true, converters: :numeric)

# Coded by Darin Wilson from Sonic Pi examples
# The piece consists of three long loops, each of which
# plays one of two randomly selected pitches. Each note
# has different attack, release and sleep values, so that
# they move in and out of phase with each other. This can
# play for quite awhile without repeating itself.
# Ensure you are pressing 'stop' after listening, otherwise this
# will loop on forever.
use_synth :hollow
with_fx :reverb, mix: 0.7 do
  
  live_loop :note1 do
    play choose([:D4,:E4]), attack: 6, release: 6
    sleep 1
  end
  
  live_loop :note2 do
    play choose([:Fs4,:G4]), attack: 4, release: 5
    sleep 1
  end
  
  live_loop :note3 do
    play choose([:A4, :Cs5]), attack: 5, release: 5
    sleep 1
  end
end

columns = data.headers
min_value = data[columns].min
max_value = data[columns].max

columns.each do |column|
  in_thread do
    data[column].each do |value|
      # Plays a synth or sample based on the numeric value from my translationa dataset
      case value
      when 0
        use_synth :pretty_bell
      when 1..2
        use_synth :dark_ambience
      when 3
        use_synth :growl
      when 4
        use_synth :kalimba
      when 5
        use_synth :gnoise
      when 6
        use_synth :cnoise
      when 7
        use_synth :zawa
      when 8
        use_synth :winwood_lead
      when 9
        use_synth :organ_tonewheel
      when 10
        sample :ambi_choir
      when 13
        sample :vinyl_hiss
      when 14
        sample :ambi_lunar_land
      when 15
        sample :guit_e_slide
      when 16
        sample :ambi_glass_rub
      when 17
        sample :vinyl_backspin
      when 18
        sample :vinyl_rewind
      when 19
        sample :ambi_swoosh
      when 20
        sample :ambi_drone
      else
        
      end
      
      # Play a note where the pitch is scaled to the dataset values
      play value, attack: 0.2, decay: 0.5, release: 2, amp: 5
      sleep 1.5
    end
  end
end
