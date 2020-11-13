defmodule BillsTest do
  use ExUnit.Case
  doctest Bills

  test "create bills" do
    bills = Bills.createbill(["Agua", "Telefone", "Luz"])
    assert bills  == ["Agua", "Telefone", "Luz"]
  end

  test "order array of bills" do
    bills = Bills.createbill(["Agua", "Telefone", "Luz"])
    refute Bills.orderbill(bills)  == ["Agua", "Telefone", "Luz"]
  end

  test "verify if a bill exit" do
    assert Bills.existbill(Bills.createbill(["Agua", "Telefone", "Luz"]), "Telefone") == true
  end

end
