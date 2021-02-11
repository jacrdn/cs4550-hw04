defmodule Practice.PracticeTest do
  use ExUnit.Case
  import Practice

  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def parse_integer(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def aapply(n1, n2, op) do
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

  def makeonee(c1, c2) do
    [Enum.at(c1, 0), aapply(Enum.at(c1, 1), Enum.at(c2, 1), Enum.at(c2, 0))]
  end

  def get_op(ls, idx) do
    ls |> Enum.at(idx) |> Enum.at(0)
  end

  def consolidate_by_op_accc(idx, nl, ls, op) do
    # if the list is empty we return
    cond do
      idx == -1 ->
        nl
      idx == 0 ->
        [Enum.at(ls, idx) | nl]
      op == get_op(ls, idx) ->
        consolidate_by_op_accc(idx - 2, [ makeonee(Enum.at(ls, idx - 1), Enum.at(ls, idx)) | nl ], ls, op)
      true ->
        consolidate_by_op_accc(idx - 1, [Enum.at(ls, idx) | nl], ls, op)
    end
  end

  def consolidate_by_opp(ls, op) do
    consolidate_by_op_accc(Enum.count(ls) - 1, [], ls, op)
  end

  def conso(ls) do
    ls
    |> consolidate_by_opp("*")
    |> consolidate_by_opp("/")
    |> consolidate_by_opp("-")
    |> consolidate_by_opp("+")

  end

  def equate(ls) do
    ls |> conso() |> Enum.at(0) |> Enum.at(1)

  end

    test "equate" do
      assert equate([["=", "6"], ["-", "2"], ["+", "5"], ["*", "4"], ["/", "2"], ["*", "2"]]) == "9"
      assert equate([["=", "6"], ["-", "2"]]) == "4"
    end

    test "equate2" do
      assert ("str" == "str") == true
      assert ("han" == "han") == true
      assert ("han" == "nah") == false
    end

    test "how enum works" do
      assert Enum.at([["=", "2"], ["+", "3"], ["*", "4"]], 0) == ["=", "2"]
      assert Enum.at(Enum.at([["=", "2"], ["+", "3"], ["*", "4"]], 2), 0) == "*"
      assert Enum.at([["=", "2"], ["+", "3"], ["*", "4"], ["/", "5"], ["*", "6"]], 0) == ["=", "2"]
      assert Enum.at([["=", "2"], ["+", "3"], ["*", "4"], ["/", "5"], ["*", "6"]], 1) == ["+", "3"]
      assert Enum.count([["=", "2"], ["+", "3"], ["*", "4"], ["/", "5"], ["*", "6"]]) - 1 == 4
      assert Enum.count([["=", "2"], ["+", "3"], ["*", "4"]]) == 3
    end

    test "get op" do
      assert get_op([["=", "2"], ["+", "3"], ["*", "4"]], 2) == "*"
    end

    test "conso" do
      assert conso([["=", "6"], ["-", "2"], ["+", "5"], ["*", "4"], ["/", "2"], ["*", "2"]]) == [["=", "9"]]
    end

    test "consolidate other" do
      assert consolidate_by_opp([["=", "2"], ["+", "3"], ["*", "4"]], "*") == [["=", "2"], ["+", "12"]]
    end

    test "consolidate" do
      assert consolidate_by_opp([["=", "2"], ["+", "3"], ["*", "4"], ["/", "5"], ["*", "6"]], "*") == [["=", "2"], ["+", "12"], ["/", "30"]]
    end

  test "double some numbers" do
    assert double(4) == 8
    assert double(3.5) == 7.0
    assert double(21) == 42
    assert double(0) == 0
  end

  test "test make one" do
    assert makeonee(["+", "3"], ["*", "4"]) == ["+", "12"]
    assert makeonee(["/", "3"], ["*", "2"]) == ["/", "6"]
  end

  test "factor some numbers" do
    assert factor(5) == [5]
    assert factor(8) == [2,2,2]
    assert factor(12) == [2,2,3]
    assert factor(226037113) == [3449, 65537]
    assert factor(1575) == [3,3,5,5,7]
  end

  test "evaluate some expressions" do
    assert calc(" 2 + 3 *  4 ") == 14
    assert calc("5") == 5
    assert calc("5 + 1") == 6
    assert calc("5 * 3") == 15
    assert calc("10 / 2") == 5
    assert calc("10 - 2") == 8
    assert calc("5 * 3 + 8") == 23
    assert calc("8 + 5 * 3") == 23
  end

  def ntwos(x, l) do
    if rem(x, 2) != 0 do
      [x, l]
    else
      ntwos(div(x, 2), [2 | l])
    end
  end

  def cfactors(x, i) do
    if rem(x, i) != 0 do
      []
    else
      [i | cfactors(div(x, i), i)]
    end
  end

  def mcomposites(x, i, l, og) do
    if Enum.reduce(l, 1, fn(x, acc) -> x * acc end) < og do # fix 2nd half of if
      mcomposites(x, i + 2, cfactors(x, i) ++ l, og) # this prolly the problem
    else
      l
    end
  end


  def fct(x) do
    nl = Enum.at(ntwos(x, []), 1)
    Enum.sort(mcomposites(x, 3, nl, x))
  end

 test "factor somn" do
    assert ntwos(5, []) == [5, []]
    assert ntwos(15, []) == [15, []]
    assert ntwos(8, []) == [1, [2,2,2]]
    assert ntwos(12, []) == [3, [2,2]]
    assert ntwos(1575, []) == [1575, []]
 end

 test "cfactor some numbers" do
  assert cfactors(1575, 3) == [3,3]
  assert cfactors(1575, 5) == [5,5]
  assert cfactors(1575, 7) == [7]
  assert cfactors(226037113, 3449) == [3449]
  assert cfactors(226037113, 65537) == [65537]
  assert Enum.sort(mcomposites(1575, 3, [], 1575)) == [3,3,5,5,7]
  assert Enum.sort(mcomposites(226037113, 3, [], 226037113)) == [3449, 65537]
end

 test "factor some other stuff" do
  assert fct(5) == [5]
  assert fct(8) == [2,2,2]
  assert fct(2) == [2]
  assert fct(3) == [3]
  assert fct(12) == [2,2,3]
  assert fct(226037113) == [3449, 65537]
  assert fct(1575) == [3,3,5,5,7]
  assert fct(1576) == [2,2,2,197]
 end

  test "palindrome" do
    assert palindrome("kayak") == true
    assert palindrome("pullup") == true
    assert palindrome("pushup") == false
    assert palindrome("a") == true
    assert palindrome("") == true
  end

end
