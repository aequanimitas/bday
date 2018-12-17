defmodule BdayTest do
  use ExUnit.Case
  use PropCheck

  def field do
    oneof([unquoted_text(), quotable_text()])
  end

  def unquoted_text() do
    let chars <- list(elements(textdata())) do
      to_string(chars)
    end
  end

  def quotable_text do
    let chars <- list(elements('\r\n",' ++ textdata())) do
      to_string(chars)
    end
  end

  def textdata, do: uppercase() ++ lowercase() ++ numbers() ++ symbols()
  defp uppercase, do: 65..90 |> Enum.to_list
  defp lowercase, do: 97..122 |> Enum.to_list
  defp numbers, do: 48..57 |> Enum.to_list
  defp symbols do
    Enum.to_list(32..43) ++
    Enum.to_list(45..47) ++
    Enum.to_list(58..64) ++
    Enum.to_list(91..96) ++
    Enum.to_list(123..126)
  end
end
