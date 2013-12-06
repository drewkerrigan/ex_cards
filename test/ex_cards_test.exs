defmodule ExCardsTest do
  use ExUnit.Case

  test "shuffle deck" do
    deck1 = ExCards.deck()
    deck2 = ExCards.deck()
    
    assert(deck1 != deck2)
  end

  test "deal hand" do
    {player, deck} = ExCards.deck
    |> ExCards.deal(2)
    
    {dealer, deck2} = deck
    |> ExCards.deal(2)

    {newplayer, deck3} = deck2
    |> ExCards.hit(player)

    IO.puts "Player after hit"
    IO.inspect newplayer

    IO.puts "Dealer"
    IO.inspect dealer

    IO.puts "Result"
    IO.inspect ExCards.compare(newplayer, dealer)
    assert(true)
  end

  test "compare" do
    assert(:push == ExCards.compare(["A","J"], ["A","J"]))
    assert(:push == ExCards.compare(["2","5"], ["3","4"]))
    assert(:win == ExCards.compare(["A","J"], ["A","K"]))
    assert(:lose == ExCards.compare(["A","Q"], ["A","J"]))
    assert(:lose == ExCards.compare(["2","2"], ["2","3"]))
    assert(:win == ExCards.compare(["3","2"], ["2","2"]))
  end
end
