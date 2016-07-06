Gem.find_files('docker_janitor/**/*.rb').each do |path|
  require path.gsub(/\.rb$/, '') unless path =~ /bot.*cli/
end
