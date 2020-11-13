defmodule Bills do
 @moduledoc """
    In this module, we have some functions about bills
  """
  @doc """
    When this function receive `bills`, return an array of bills
      ## Sample
      iex> Bills.createbill(["Agua", "Telefone", "Luz"], [5,5,15])
      ["Agua", "Telefone", "Luz"]
  """
  def createbill(bills, amount) do
    for day <- amount, bill <- bills do
      "Fatura: #{bill} vence dia: #{day}"
    end
  end

  def paybills(bills, amount, howmany) do
    createbill(bills, amount)
    |> orderbill
    |> billforpay(howmany)
  end

  def billforpay(bills, howmany) do
    Enum.split(bills, howmany)
  end

  def savebills(namearch, bills) do
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
      iex> Bills.orderbill(Bills.createbill(["Agua", "Telefone", "Luz"]))
      ["Agua", "Luz", "Telefone"]
  """
  def orderbill(bills) do
    Enum.sort(bills)
  end

  @doc """
    When this funtion receive `bills` and a bill element, return if a bill exist
      ## Sample
      iex> Bills.existbill(Bills.createbill(["Agua", "Telefone", "Luz"]), "Telefone")
      true
  """
  def existbill(bills, bill) do
    Enum.member?(bills, bill)
  end

end
