defmodule Practice.Palindrome do

  def flipandstuff(low) do
        c = length(low)
        chunks = Enum.chunk_every(low, div(c, 2))
        rt = Enum.at(chunks, 0)
        lt = Enum.at(chunks, 1)
        lt_rev = Enum.reverse(lt)
        j1 = Enum.join(rt, "")
        j2 = Enum.join(lt_rev, "")
        (j1 == j2)
  end

  def palindrome(word) do
    w = String.codepoints(word)
    cond do
      String.length(word) == 0 or String.length(word) == 1 ->
        true
      rem(String.length(word), 2) == 0 ->
        flipandstuff(w)
      rem(String.length(word), 2) == 1 ->
        c = length(w)
        nl = List.delete_at(w, (div(c - 1, 2)))
        flipandstuff(nl)
    end
  end
end
