# ExCards

A simple card library in Elixir. Currently only implements blackjack scoring.

### Build

```
mix
```

### Test

```
mix test
```

### Include in your mix project

mix.exs

```
...
  defp deps do
    [{ :ex_cards, github: "drewkerrigan/ex_cards", tag: ">= 0.0.1" }]
  end
...
```

### Example Usage

Test functionality in iex

```
iex -S mix
```

Build a shuffled deck

```
iex(1)> deck = Blackjack.deck()
[{"5", :club}, {"9", :heart}, {"3", :spade}, {"9", :club}, {"A", :heart},
 {"A", :club}, {"7", :diamond}, {"A", :diamond}, {"J", :heart}, {"8", :heart},
 {"K", :club}, {"3", :diamond}, {"10", :heart}, {"10", :club}, {"6", :diamond},
 {"A", :spade}, {"K", :diamond}, {"6", :club}, {"8", :spade}, {"8", :diamond},
 {"7", :heart}, {"7", :spade}, {"K", :spade}, {"2", :heart}, {"9", :spade},
 {"10", :diamond}, {"7", :club}, {"Q", :heart}, {"5", :diamond},
 {"4", :diamond}, {"4", :club}, {"2", :spade}, {"3", :club}, {"2", :diamond},
 {"Q", :club}, {"9", :diamond}, {"2", :club}, {"K", :heart}, {"10", :spade},
 {"5", :heart}, {"J", :spade}, {"J", :club}, {"Q", :diamond}, {"4", :heart},
 {"5", :spade}, {"6", :spade}, {"J", :diamond}, {"4", :spade}, {"8", :club},
 {"3", :heart}, ...]
```

Deal 2 cards to a player

```
iex(2)> {player, deck} = Blackjack.deck |> Blackjack.deal(2)    
{["10", "4"],
 [{"Q", :club}, {"Q", :heart}, {"A", :club}, {"7", :diamond}, {"7", :heart},
  {"6", :heart}, {"10", :spade}, {"J", :club}, {"8", :club}, {"Q", :diamond},
  {"9", :heart}, {"10", :heart}, {"3", :heart}, {"A", :diamond}, {"4", :spade},
  {"9", :diamond}, {"J", :diamond}, {"4", :club}, {"K", :spade}, {"7", :spade},
  {"3", :club}, {"6", :diamond}, {"K", :diamond}, {"5", :spade}, {"3", :spade},
  {"2", :spade}, {"8", :heart}, {"J", :spade}, {"A", :heart}, {"8", :spade},
  {"A", :spade}, {"10", :club}, {"9", :spade}, {"7", :club}, {"Q", :spade},
  {"6", :spade}, {"K", :club}, {"K", :heart}, {"2", :heart}, {"5", :club},
  {"2", :club}, {"5", :heart}, {"9", :club}, {"4", :heart}, {"5", :diamond},
  {"J", :heart}, {"6", :club}, {"2", :diamond}, {"3", :diamond},
  {"8", :diamond}]}

iex(3)> player
["10", "4"]
```

Deal 2 cards to the dealer

```
iex(4)> {dealer, deck2} = deck |> Blackjack.deal(2)
{["Q", "Q"],
 [{"A", :club}, {"7", :diamond}, {"7", :heart}, {"6", :heart}, {"10", :spade},
  {"J", :club}, {"8", :club}, {"Q", :diamond}, {"9", :heart}, {"10", :heart},
  {"3", :heart}, {"A", :diamond}, {"4", :spade}, {"9", :diamond},
  {"J", :diamond}, {"4", :club}, {"K", :spade}, {"7", :spade}, {"3", :club},
  {"6", :diamond}, {"K", :diamond}, {"5", :spade}, {"3", :spade}, {"2", :spade},
  {"8", :heart}, {"J", :spade}, {"A", :heart}, {"8", :spade}, {"A", :spade},
  {"10", :club}, {"9", :spade}, {"7", :club}, {"Q", :spade}, {"6", :spade},
  {"K", :club}, {"K", :heart}, {"2", :heart}, {"5", :club}, {"2", :club},
  {"5", :heart}, {"9", :club}, {"4", :heart}, {"5", :diamond}, {"J", :heart},
  {"6", :club}, {"2", :diamond}, {"3", :diamond}, {"8", :diamond}]}

iex(5)> dealer
["Q", "Q"]
```

Player hits

```
iex(6)> {newplayer, deck3} = deck2 |> Blackjack.hit(player)
{["10", "4", "A"],
 [{"7", :diamond}, {"7", :heart}, {"6", :heart}, {"10", :spade}, {"J", :club},
  {"8", :club}, {"Q", :diamond}, {"9", :heart}, {"10", :heart}, {"3", :heart},
  {"A", :diamond}, {"4", :spade}, {"9", :diamond}, {"J", :diamond},
  {"4", :club}, {"K", :spade}, {"7", :spade}, {"3", :club}, {"6", :diamond},
  {"K", :diamond}, {"5", :spade}, {"3", :spade}, {"2", :spade}, {"8", :heart},
  {"J", :spade}, {"A", :heart}, {"8", :spade}, {"A", :spade}, {"10", :club},
  {"9", :spade}, {"7", :club}, {"Q", :spade}, {"6", :spade}, {"K", :club},
  {"K", :heart}, {"2", :heart}, {"5", :club}, {"2", :club}, {"5", :heart},
  {"9", :club}, {"4", :heart}, {"5", :diamond}, {"J", :heart}, {"6", :club},
  {"2", :diamond}, {"3", :diamond}, {"8", :diamond}]}

iex(7)> newplayer
["10", "4", "A"]
```

Player had an ace, so total can be 15 or 25

```
iex(8)> Blackjack.total(newplayer)
{15, 25}
```

Automatically show the best hand, splitting is currently unsupported

```
iex(9)> Blackjack.total(newplayer) |> Blackjack.best
15
```

Show dealer total

```
iex(10)> Blackjack.total(dealer)
20
```

Compare the player with the dealer, player `:lose`s

```
iex(11)> Blackjack.compare(newplayer, dealer)
:lose
```
