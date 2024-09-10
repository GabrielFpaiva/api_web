defmodule SteamApiClientTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "fetches player summaries successfully with valid Steam ID" do
    steam_id = "76561198377279330"
    result = SteamApiClient.get_player_summaries(steam_id)

    IO.inspect(result, label: "Player summaries result")  # Inspeção da resposta

    assert {:ok, %{"response" => %{"players" => players}}} = result
    assert length(players) > 0
  end

  test "fetches owned games successfully with valid Steam ID" do
    steam_id = "76561198377279330"
    result = SteamApiClient.get_owned_games(steam_id)

    IO.inspect(result, label: "Owned games result")  # Inspeção da resposta

    assert {:ok, %{"response" => %{"games" => games}}} = result
    assert length(games) > 0
  end

  test "displays player summaries when passing Steam ID as argument" do
    output = capture_io(fn ->
      SteamApiCommandLine.main(["76561198377279330"])
    end)

    IO.inspect(output, label: "Player summaries output")  # Inspeção da saída

    assert String.contains?(output, "Nome:")
    assert String.contains?(output, "Foto de perfil:")
  end

  test "displays owned games when passing Steam ID as argument" do
    output = capture_io(fn ->
      SteamApiCommandLine.main(["76561198377279330"])
    end)

    IO.inspect(output, label: "Owned games output")  # Inspeção da saída

    assert String.contains?(output, "Nome do jogo:")
    assert String.contains?(output, "Imagem:")
  end
end
