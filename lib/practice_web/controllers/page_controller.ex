defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Float.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    l = Practice.Factor.factor(x)
    l1 = Enum.map(l, fn x -> to_string(x) end)
    redu = Enum.reduce(l1, "[", fn s, acc -> (acc <> s <> ", ") end)
    y = String.slice(redu, 0..(String.length(redu) - 3)) <> "]"
    render conn, "factor.html", x: x, y: y
  end

  def palindrome(conn, %{"word" => word}) do
    w = Practice.palindrome(word)
    y = "#{w}"
    render conn, "palindrome.html", word: word, y: y
  end
end
