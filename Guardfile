guard 'shell' do
  watch (/data\/((?!\.#).*)\.lua$/) do |m|
    `bin/to-gnuplot < "#{m[0]}" > "data/#{m[1]}.dat"`
    `ln -fs "data/#{m[1]}.dat" "data/current.dat"`
  end

  watch ("src/loot.gnuplot") do
    `cp -fL data/current.dat data/previous.dat`
    `gnuplot src/loot.gnuplot`
  end

  watch (/data\/current\.dat$/) do |m|
    `gnuplot src/loot.gnuplot`
  end
end
