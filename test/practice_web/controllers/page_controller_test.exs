defmodule PracticeWeb.PageControllerTest do
  use PracticeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Factor"
  end

  test "double 5", %{conn: conn} do
    conn = post conn, "/double", %{"x" => "5"}
    assert html_response(conn, 200) =~ "10"
  end

  test "calc 3 * 5 - 10 / 2", %{conn: conn} do
    conn = post conn, "/calc", %{"expr" => "3 * 5 - 10 / 2"}
    assert html_response(conn, 200) =~ "10"
  end

  test "factor 512", %{conn: conn} do
    conn = post conn, "/factor", %{"x" => "512"}
    assert html_response(conn, 200) =~ "[2, 2, 2, 2, 2, 2, 2, 2, 2]"
  end

  test "palindrome kayak", %{conn: conn} do
    conn = post conn, "/palindrome", %{"word" => "kayak"}
    assert html_response(conn, 200) =~ "true"
  end

  test "palindrome hannah", %{conn: conn} do
    conn = post conn, "/palindrome", %{"word" => "hannah"}
    assert html_response(conn, 200) =~ "true"
  end

  test "palindrome somn", %{conn: conn} do
    conn = post conn, "/palindrome", %{"word" => "somn"}
    assert html_response(conn, 200) =~ "false"
  end

end
