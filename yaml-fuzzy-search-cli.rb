require 'pry'
require 'yaml'
require 'io/console'

def get_yaml_as_hash(filename)
  YAML.load_file(filename)
end

def flat_hash(h,f=[],g={})
  return g.update({ f=>h }) unless h.is_a? Hash
  h.each { |k,r| flat_hash(r,f+[k],g) }
  g
end

def translation_mapping(hash)
  new_hash = {}
  f_hash = flat_hash(hash)
  f_hash.keys.each do |key|
    value = f_hash[key]
    new_hash[key.map(&:to_s).join('.')] = value
  end
  new_hash
end

data = get_yaml_as_hash('test.yml')
key_list = translation_mapping(data)


while(true) do
  char = STDIN.getch
  printf("\r#{char}")
end

binding.pry

