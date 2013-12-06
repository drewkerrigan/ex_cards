defmodule ExCards do

  defmacro __using__(_opts) do
    quote do
      def deck() do
        cards = lc r inlist ranks(), s inlist suites(), do: {r,s}
        shuffle(cards)
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

      def ranks(), do: ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
      def suites(), do: [:club,:spade,:heart,:diamond]

      def shuffle(deck) do
        {a1, a2, a3} = :erlang.now()
        :random.seed(a1, a2, a3)
        gt = fn({b,_},{a,_}) -> a > b end
        cards = lc card inlist deck, do: {:random.uniform(),card}
        lc {_,card} inlist :lists.sort(gt,cards), do: card
      end
    end
  end
end
