def create_hash(keys, values)
    keys.inject(Hash.new()){|hash, key| hash[key]=values[keys.index(key)]; hash}
end