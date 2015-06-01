json.(pokemon, :name, :attack, :defense, :poke_type, :moves, :image_url, :id)
display_toys ||= false
if display_toys
  json.toys do
    json.array!(pokemon.toys) do |toy|
      json.partial!("toys/toy", toy: toy)
    end
  end
end
