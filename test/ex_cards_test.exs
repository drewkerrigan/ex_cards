defmodule ExCardsTest do
  use ExUnit.Case

  test "shuffle deck" do
    deck1 = Blackjack.deck()
    deck2 = Blackjack.deck()

    assert(deck1 != deck2)
  end

  test "deal hand" do
    {player, deck} = Blackjack.deck
    |> Blackjack.deal(2)

    {dealer, deck2} = deck
    |> Blackjack.deal(2)

    {newplayer, deck3} = deck2
    |> Blackjack.hit(player)

    IO.puts "Player after hit"
    IO.inspect newplayer

    IO.puts "Dealer"
    IO.inspect dealer

    IO.puts "Result"
    IO.inspect Blackjack.compare(newplayer, dealer)
    assert(true)
  end

  test "compare" do
    assert(:push == Blackjack.compare(["A","J"], ["A","J"]))
    assert(:push == Blackjack.compare(["2","5"], ["3","4"]))
    assert(:win == Blackjack.compare(["A","J"], ["A","K"]))
    assert(:lose == Blackjack.compare(["A","Q"], ["A","J"]))
    assert(:lose == Blackjack.compare(["2","2"], ["2","3"]))
    assert(:win == Blackjack.compare(["3","2"], ["2","2"]))
  end
end
