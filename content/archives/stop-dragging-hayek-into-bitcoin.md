---
title: Stop Dragging Hayek into Bitcoin
date: 2017-11-12
---
*Note: This post discusses the relationship between Hayek's work and cryptocurrencies, and is not financial advice. Opinions are my own. I do not hold a position in Bitcoin or other cryptocurrencies.*

When monetary theory comes up in reference to Bitcoin, the work of Friedrich von Hayek is often invoked. I have read a number of claims that the Nobel laureate's 1976 book, *Denationalisation of Money*,[^refined] lays the theoretical foundation for the cryptocurrencies we see today.

In this post, I will argue that the similarities between Hayek's hypothetical currencies and Bitcoin are merely superficial, and that the technology behind cryptocurrencies is not a substitute for intentional design decisions in Hayek's proposal.

## The Ducat

Hayek's central point in *Denationalisation of Money* is that there is no innate reason for governments to have a monopoly on money. He makes the case that private banks should be able to issue their own currencies, creating a competitive market for the issuance and control of these currencies. The argument goes that demand will be greatest for currencies which are capable of keeping a stable value, and so banks will strive to manage the monetary supply more responsibly than governments do.

Hayek makes his argument through the construction of a hypothetical currency which he calls the **ducat**. The ducat is nominally backed by government currency.[^ducat] More importantly, it is also backed by the issuer's promise (with reputational, but not legal, consequences) to keep its purchasing power approximately stable relative to a commodity index.

This price stability is to be accomplished through the standard means of monetary control: when the price of the ducat *exceeds* the desired purchasing power, more ducats are printed and sold until the price drops to the promised purchasing power. Likewise, when the price of ducats drops *below* the desired purchasing power, the bank buys back notes until it is restored. As there is market pressure to do this well, the currencies picked by the market will be the ones that are functionally commodity-backed, even if none of them are in name.

Note that when the issuing bank sells their ducats, to make good on their promise to maintain a stable value, they can't just pocket the money and forget about it. Instead, they must invest the money responsibly so that they can buy back ducats when the need arises.[^invest] This is essential since a diligent consumer, choosing between currencies, will consider the solvency of the banks who issued them.

## Token of Expectation

Government-issued fiat currencies and Hayek's ducat can each be seen as a token of an expectation that it entitles the bearer to.[^credit] For fiat currencies, that expectation is relief against liabilities towards the government (i.e. taxes).[^taxes] In Adam Smith's words:

> A prince who should enact that a certain proportion of his taxes should be paid in a paper money of a certain kind might thereby give a certain value to this paper money, even though the term of its final discharge and redemption should depend altogether upon the will of the prince.[^smith]

By contrast, the expectation represented by the ducat is that the bank will buy it back for a price near the commodity value it is pegged to, if nobody else will (this is a corollary to the bank's promise of a stable value). Rather than bank on the "will of the prince", the holder of a ducat puts his trust in the issuing bank.

Both the fiat currencies and ducat obtain their value from the expectations attached to them. Their usefulness in exchange is a side-effect of the transferability of these expectations.

## Bitcoin

Now let's turn to Bitcoin. A core feature of Bitcoin is that it has no central issuer. Bitcoins are created by a process called **mining**, in which computers compete to solve a math problem that involves making an enormous number of guesses.[^nonce] The computer that finds a valid solution first gets a reward of newly-minted bitcoins.

Unlike the issuer of Hayek's ducats, when the miner of a bitcoin sells that bitcoin for dollars, there is no expectation that the proceeds will be re-invested to manage the price of the currency. In fact, most of the value of that coin has already been spent on energy costs in generating the coin.[^energy]

Like the ducat, Bitcoin is touted as a solution to sins attributed to government money. Both remove the government as the counterparty to the expectation that the money represents. But where Hayek moves the burden of the expectation to a bank, Bitcoin dispenses entirely with the notion that the currency is a token of expectation. This deviation from Hayek is not just an implementation detail, it's a completely different theory of money.

## Useful Money

Proponents of Bitcoin argue that money's value comes not from representing any expectation, but from its usefulness in transactions. Markets need a form of currency to function, so in a free market people will prefer to entrust a currency which can be transacted electronically and cannot be arbitrarily inflated by a government. This would give Bitcoin, the most broadly-accepted cryptocurrency that fits these criteria, great value.

Under this theory it is not the expectation attached to money that drives its usefulness in transaction, but its usefulness in transaction that creates its value. Future generations are assumed to be willing to work or trade goods for bitcoins, in the expectation that their own future generations are willing to do so, and so on. In this view, a bitcoin acts as a token of an eternal debt that is never cashed in, but traded to posterity. The value that the coins represent is borrowed from infinity, in the same way that [Hilbert's Grand Hotel](https://en.wikipedia.org/wiki/Hilbert%27s_paradox_of_the_Grand_Hotel) can always find another room.

Backers of this theory often point out that gold has worked this way for millennia. They're not wrong,[^gold] but skeptics point out that gold is a tangible material that goes back to the Earth's formation, while bitcoin is tied to the social convention of which genesis block we attach value to.[^network] If this does in fact work, it will be a fun twist-ending to the long tradition of alchemy: we have finally turned tin into gold, not by physically creating gold, but by turning it into [ASIC](https://en.wikipedia.org/wiki/Application-specific_integrated_circuit) miners and convincing each other that its output should be valued as a gold-like commodity.

## tl;dr

I don't expect this post to change anyone's opinions on bitcoin, and I have tried to present the case for Bitcoin fairly. I'm in no more of a position to say that bitcoins are overvalued than I am to say that a decaying shark is not worth [eight million dollars](https://en.wikipedia.org/wiki/The_Physical_Impossibility_of_Death_in_the_Mind_of_Someone_Living): value is what *someone* is willing to pay, not what *I'm* willing to pay.

Instead, I hope what you take away from this is that Hayek's blueprint for denationalized currencies is not realized by today's mainstream cryptocurrencies[^mainstream]. Though Hayek's work and Bitcoin are both motivated by the same problems with fiat currencies, the alternatives they take are not just different, but based on a fundamentally different understanding of what money is.

[^refined]: And its 1978 revision, *Denationalisation of Money: The Argument Refined*. Where the two differ, this post refers to the revised version.

[^ducat]: "The only legal obligation I would assume would be to redeem these notes and deposits on demand with, at the option of the holder, either 5 Swiss francs or 5 D-marks or 2 dollars per ducat." (*Denationalisation of Money: The Argument Refined*)

[^invest]: "The issuing bank [...] would not wish to incur an obligation to maintain by redemption a value of its currency higher than that at which it had issued it. [The] bank would presumably be driven to buy interest-bearing securities [...]" (*Denationalisation of Money: The Argument Refined*)

[^credit]: This *expectation* view of money is my attempt to distill the least controversial elements of *What is Money* and *The Credit Theory of Money* by A Mitchell Innes (1913 & 1914 respectively.) The subject is also covered by David Graeber in *Debt: The First 5,000 Years* (2011).

[^taxes]: Bitcoin draws a disproportionate number of people who don't believe in the moral legitimacy of the government's ability to collect tax. That argument is beyond the scope of this post, because it doesn't change the economics of how fiat works in a world where tax does exist.

[^smith]: *An Inquiry Into the Nature and Causes of the Wealth of Nations*, Adam Smith, 1776

[^nonce]: Specifically, the problem is to find a [nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce) that produces a block which [hashes](https://en.wikipedia.org/wiki/Cryptographic_hash_function) into a string of bytes with a minimum number of leading zeros. This is all part of a clever system that keeps the transaction ledger secure; see *[Bitcoin: A Peer-to-Peer Electronic Cash System](https://bitcoin.org/bitcoin.pdf)*

[^energy]: The mining market is in equilibrium when the average cost of mining a block in the cheapest market equals the expected market value of rewards from that block. The dominant cost factor is energy; other onging costs include hardware depreciation and physical space.

[^gold]: Gold also has value from its use in jewelry but this demand does not explain its value.

[^network]: Sometimes [Metcalfe's law](https://en.wikipedia.org/wiki/Metcalfe%27s_law) is invoked to argue that network effects will make it increasingly difficult to unseat bitcoin. I would argue that this is offset by the potential profitability of being an early adopter of a rival cryptocurrency.

[^mainstream]: By *mainstream* I mean decentralized proof-of-work cryptocurrencies in the spirit of Bitcoin. A few coins claim to be commodity backed or otherwise more true to Hayek, but I'm not in a position to determine whether or not they actually hold the reserves they claim or are scams.