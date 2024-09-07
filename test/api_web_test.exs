defmodule SteamApiClientTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  # Teste para a função get_player_summaries
  test "fetches player summaries successfully" do
    steam_id = "76561198377279330"  # Substitua com um Steam ID válido para o teste
    assert {:ok, %{"response" => %{"players" => players}}} = SteamApiClient.get_player_summaries(steam_id)
    assert length(players) > 0
  end

  # Teste para a função get_owned_games
  test "fetches owned games successfully" do
    steam_id = "76561198377279330"  # Substitua com um Steam ID válido para o teste
    assert {:ok, %{"response" => %{"games" => games}}} = SteamApiClient.get_owned_games(steam_id)
    assert length(games) > 0
  end

  # Teste para verificar exibição de player summaries na tela
  test "displays player summaries correctly" do
    output = capture_io(fn ->
      SteamApiCommandLine.main(["player_summaries", "76561198377279330"])  # Substitua com um Steam ID válido
    end)

    assert String.contains?(output, "Nome:")  # Verifica se a saída contém a palavra "Nome"
    assert String.contains?(output, "Foto de perfil:")  # Verifica se a saída contém a palavra "Foto de perfil"
  end

  # Teste para verificar exibição de jogos na tela
  test "displays owned games correctly" do
    output = capture_io(fn ->
      SteamApiCommandLine.main(["owned_games", "76561198377279330"])  # Substitua com um Steam ID válido
    end)

    assert String.contains?(output, "Nome do jogo:")  # Verifica se a saída contém a palavra "Nome do jogo"
    assert String.contains?(output, "Imagem:")  # Verifica se a saída contém a palavra "Imagem"
  end
end
