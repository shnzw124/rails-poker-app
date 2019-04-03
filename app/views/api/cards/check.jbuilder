json.result @cards do |card|
  if card.hand
    json.(card, :card_set, :hand, :best)
  else
    next
  end
end

json.error @cards do |card|
  if card.hand == nil
    json.(card, :card_set, :msg)
  else
    next
  end
end
