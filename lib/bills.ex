defmodule Bills do
 @moduledoc """
    In this module, we have some functions about bills
  """
  @doc """
    When this function receive `bills`, return an array of bills
      ## Sample
      iex> Bills.createbill(["Agua", "Telefone", "Luz"], [5,15])
      [
        %Bills.Bill{fatura: "Agua", vencimento: 5},
        %Bills.Bill{fatura: "Agua", vencimento: 15},
        %Bills.Bill{fatura: "Telefone", vencimento: 5},
        %Bills.Bill{fatura: "Telefone", vencimento: 15},
        %Bills.Bill{fatura: "Luz", vencimento: 5},
        %Bills.Bill{fatura: "Luz", vencimento: 15}
      ]
  """
  def createbill(bills, amount) do
    for bill <- bills, day <- amount do
      %Bills.Bill{fatura: bill, vencimento: day}
    end
  end

  @doc """
    When this function recieve informations to create a bill, we have to order and save in a file.
      ## Sample
      iex> Bills.paybills(["Agua", "Telefone", "Luz"], [5,15], 2, "contas outubro")
      :ok
  """
  def paybills(bills, amount, howmany, namearch) do
    createbill(bills, amount)
    |> orderbill
    |> billforpay(howmany)
    |> savebills(namearch)
  end


  def billforpay(bills, howmany) do
    Enum.split(bills, howmany)
  end

  @doc """
    When recieve the `bills` and `name of archive`, returns a `ok`
      ## Sample
      iex> bills = Bills.createbill(["Agua", "Telefone", "Luz"], [5,15])
      iex> Bills.savebills(bills, "conta novembro")
      :ok
  """
  def savebills(bills, namearch) do
    binary = :erlang.term_to_binary(bills)
    File.write!(namearch, binary)
  end

  def loadbills(namearchive) do

    case File.read(namearchive) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _erro} -> "O arquivo não existe!"
    end

  end

  @doc """
    When this funtion receive `bills`, return an orderly array of bills
      ## Sample
      iex> bills = Bills.createbill(["Agua", "Telefone", "Luz"], [5,15])
      iex> Bills.orderbill(bills)
      [
        %Bills.Bill{fatura: "Agua", vencimento: 5},
        %Bills.Bill{fatura: "Agua", vencimento: 15},
        %Bills.Bill{fatura: "Luz", vencimento: 5},
        %Bills.Bill{fatura: "Luz", vencimento: 15},
        %Bills.Bill{fatura: "Telefone", vencimento: 5},
        %Bills.Bill{fatura: "Telefone", vencimento: 15}
      ]
  """
  def orderbill(bills) do
    Enum.sort(bills)
  end

  @doc """
    When this funtion receive `bills` and a bill element, return if a bill exist
      ## Sample
      iex> bills = Bills.createbill(["Agua", "Telefone", "Luz"], [5,15])
      iex> Bills.existbill(bills, %Bills.Bill{fatura: "Telefone", vencimento: 15})
      true
  """
  def existbill(bills, bill) do
    Enum.member?(bills, bill)
  end

end
