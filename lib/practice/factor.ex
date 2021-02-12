defmodule Practice.Factor do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def parse_integer(text) do
    {num, _} = Integer.parse(text)
    num
  end

# factors out all the twos of a given number
  def ntwos(x, l) do
    if rem(x, 2) != 0 do
      [x, l]
    else
      ntwos(div(x, 2), [2 | l])
    end
  end

# factors out all the odd numbers
  def cfactors(x, i) do
    if rem(x, i) != 0 do
      []
    else
      [i | cfactors(div(x, i), i)]
    end
  end

# factors the composites to be broken down
  def mcomposites(x, i, l, og) do
    if Enum.reduce(l, 1, fn(x, acc) -> x * acc end) < og do 
      mcomposites(x, i + 2, cfactors(x, i) ++ l, og) 
    else
      l
    end
  end



  def factor(x) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # expr
    nl = Enum.at(ntwos(x, []), 1)
    Enum.sort(mcomposites(x, 3, nl, x))
  end

  def factor_s(x) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # expr
    x |> factor() |> to_string()
  end
end
