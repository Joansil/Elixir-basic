defmodule BillsTest do
  use ExUnit.Case
  doctest Bills

  test "create bills" do
    bills = Bills.createbill(["Agua"], [5])
    assert bills  == [%Bills.Bill{fatura: "Agua", vencimento: 5}]
  end

  test "order array of bills" do
    bills = Bills.createbill(["Luz", "Agua"], [5])
    refute Bills.orderbill(bills)  == [
      %Bills.Bill{fatura: "Luz", vencimento: 5},
      %Bills.Bill{fatura: "Agua", vencimento: 5}
    ]
  end

  test "verify if a bill exit" do
    bills = Bills.createbill(["Telefone", "Luz"], [5,15])
    assert Bills.existbill(bills, %Bills.Bill{fatura: "Telefone", vencimento: 15}) == true
  end

end
