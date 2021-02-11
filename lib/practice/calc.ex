defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def parse_integer(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def applyy(n1, n2, op) do
    no1 = parse_integer(n1)
    no2 = parse_integer(n2)
    cond do
      op == "+" ->
        to_string(no1 + no2)
      op == "-" ->
        to_string(no1 - no2)
      op == "*" ->
        to_string(no1 * no2)
      op == "/" ->
        to_string(no1 / no2)
    end
  end

  def makeone(c1, c2) do
    [Enum.at(c1, 0), applyy(Enum.at(c1, 1), Enum.at(c2, 1), Enum.at(c2, 0))]
  end

  def chunkify(ls) do
    [["=", hd(ls)] | Enum.chunk_every(tl(ls), 2)]
  end

  def get_op(ls, idx) do
    ls |> Enum.at(idx) |> Enum.at(0)
  end

  def consolidate_by_op_acc(idx, nl, ls, op) do
    # if the list is empty we return
    cond do
      idx == -1 ->
        nl
      idx == 0 ->
        [Enum.at(ls, idx) | nl]
      op == get_op(ls, idx) ->
        consolidate_by_op_acc(idx - 2, [ makeone(Enum.at(ls, idx - 1), Enum.at(ls, idx)) | nl ], ls, op)
      true ->
        consolidate_by_op_acc(idx - 1, [Enum.at(ls, idx) | nl], ls, op)
    end
    # if the operator is the desired one take it and the last one apply and recur
    # else (cons  and recur)
    #
  end



  def consolidate_by_op(ls, op) do
    consolidate_by_op_acc(Enum.count(ls) - 1, [], ls, op)

  end


#  def consolidate_ops(ls) do



  # def equate(ls) do
  #   if Enum.count(ls) == 1:
  #     ls |> hd |>

  # with chunks [[2] [+ 3] [* 4]]
  # run multiplication first
  # access that index and apply it with this number directly before -> 12
  # carry over [+ 12]


  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # expr
    expr
    |> String.split() # split into list
    |> Enum.filter(fn x -> x != " " end) # remove excess spaces
    # ["2", "+", "3", "*", "4"]
    |> chunkify()
    |> consolidate_by_op("*")
    |> consolidate_by_op("/")
    |> consolidate_by_op("-")
    |> consolidate_by_op("+")
    |> Enum.at(0)
    |> Enum.at(1)
    |> parse_integer()



    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
