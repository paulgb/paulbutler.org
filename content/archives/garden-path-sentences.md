---
title: Garden Path Sentences
date: 2007-06-27
---
I recently came across an interesting post on the Powerset Blog recently about <a href="http://blog.powerset.com/2007/6/18/search-engines-leaking-oil-for-holes">garden path sentences</a>. Garden path sentences are sentences that lead you down the wrong path through a string of words with multiple meanings. For example,

<blockquote>The complex houses married and single students and their families
</blockquote>

In this case, most readers would probably think <em>complex</em> was an adjective that modified the plural noun <em>houses</em>. The post ended with a challenge – how easy would it be to create a program to automatically generate these sentences. Since school is out and I have some free time, I tried it myself. I found a decent <a href="http://www.ibiblio.org/webster/">free xml dictionary</a>, and wrote a Ruby script to parse the important bits (the type of word and alternate forms) into an SQL database. I cross-checked all the words against a word frequency table to make sure there were no obscure words. I then wrote a Python script to put the words together into a (hopefully meaningful, but not often) sentence. <em>April 2009 Update: I removed the live demo as part of a server move</em>.

![His concrete spheres foster complexities](/images/gardenpath.png)

As you can see, the sentences that it comes up with are far from meaningful. However, in most cases you can at least see how a reader could be taken down the wrong path (at least in the cases where there is a right path). In the above example, concrete could be an adjective or a noun, and spheres could be a noun or a verb (to form a sphere). Foster could be an adjective or a noun depending on the context, but I couldn’t see the reader seeing it as an adjective here. Certainly the sentence generator leaves a lot to be desired (especially considering that this was one of the better sentences), but I got about as far with it as I expected to. I think it could be improved further with a few modifications:

<ul>
<li>Words in the database are already cross-checked to make sure they aren’t obscure, but often a word will be common as a noun and uncommon as a verb, or vice versa. I didn’t have a dataset that allowed me to determine if this was the case for a particular word.</li>
<li>The valency of verbs is ignored. All verbs are assumed to be transitive, even though valency information is available in the database.</li>
<li>I underestimated the difficulty of having a computer generate a meaningful sentence. It is difficult to determine what verbs are compatible with what nouns, I guess you would need to parse a large amount of English text (perhaps some of <a href="http://www.gutenberg.org/wiki/Main_Page">Project Gutenberg</a> – I think Wikipedia would not be varied enough but I could be wrong).</li>
</ul>

I noticed later that <a href="http://blog.dkbza.org/2007/06/powerset-and-garden-path.html">Ero Carrera</a> had taken a similar approach to what I did, but with his linguistics experience he better anticipated the problems I ran into. He has some good ideas, and his post is an interesting read.

