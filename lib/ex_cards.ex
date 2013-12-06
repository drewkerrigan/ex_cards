defmodule ExCards do
  ## Public API

  def deck() do
    cards = lc r inlist ranks(), s inlist suites(), do: {r,s}
    shuffle(cards)
  end

  ### hit(Deck, Hand) -> {NewHand, NewDeck}
  # Deck = proplist() - original deck
  # Hand = list() of card values (i.e. ["3","J"])
  # NewHand = list() of card values (i.e. ["3","J"])
  # NewDeck = proplist() - remainder of deck
  def hit(deck, hand) do
    {card, newdeck} = deck |> deal(1)
    {hand ++ card, newdeck}
  end

  ### deal(Deck, Count) -> {Cards, NewDeck}
  # Deck = proplist() - original deck
  # Count = integer()
  # Cards = list() of card values (i.e. ["3","J"])
  # NewDeck = proplist() - remainder of deck
  def deal([{card, _}|rest]) do
      {card, rest}
  end
  def deal(deck, num) do
    deal(deck, num, [])
  end
  def deal(rest, 0, cards) do
    {cards, rest}
  end
  def deal(deck, num, cards) do
    {card, rest} = deal(deck)
    deal(rest, num-1, cards ++ [card])
  end


  def total(aces_low,has_ace) when has_ace, do: {aces_low,aces_low+10}
  def total(total,_), do: total
  def total(ranks) do
    total = :lists.sum(lc rank inlist ranks, do: value(rank))
    is_ace = fn(x) -> x == "A" end
    has_ace = :lists.any(is_ace,ranks)
    total(total,has_ace)
  end

  def is_bust({lo,_}), do: is_bust(lo)
  def is_bust(total), do: total > 21

  def is_blackjack(["J","A"]), do: true
  def is_blackjack(["A","J"]), do: true
  def is_blackjack(_), do: false

  def compare(player,dealer) do
    player_total = best(total(player))
    dealer_total = best(total(dealer))

    cond do
      player_total == nil -> :lose
      dealer_total == nil -> :win
      player_total  >  dealer_total -> :win
      player_total == dealer_total ->
        case {is_blackjack(player),is_blackjack(dealer)} do
          {true,false} -> :win
          {false,true} -> :lose
          _ -> :push
        end
      true ->
        :lose
    end
  end

  ## Private Functions

  defp ranks(), do: ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
  defp suites(), do: [:club,:spade,:heart,:diamond]

  defp shuffle(deck) do
    {a1, a2, a3} = :erlang.now()
    :random.seed(a1, a2, a3)
    gt = fn({b,_},{a,_}) -> a > b end
    cards = lc card inlist deck, do: {:random.uniform(),card}
    lc {_,card} inlist :lists.sort(gt,cards), do: card
  end

  defp best({lo,hi}) do
    bust = is_bust(hi)
    if not bust, do: hi, else: best(lo)
  end
  defp best(total) do
    bust = is_bust(total)
    if not bust, do: total
  end

  defp value(rank) do
    values = :lists.zip(ranks(),[1,2,3,4,5,6,7,8,9,10,10,10,10])
    :lists.sum(lc {text,score} inlist values, text == rank, do: score)
  end
end
