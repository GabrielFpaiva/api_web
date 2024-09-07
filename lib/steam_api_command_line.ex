defmodule SteamApiCommandLine do
  def main(_args) do
    IO.puts("Iniciando o programa...")  # Adicione esta linha para verificar se o código está sendo executado
    display_menu()
  end

  # Função para exibir o menu
  defp display_menu do
    steam_accounts = [
      %{"id" => "76561198845460850", "name" => "MinhaConta"},
      %{"id" => "76561198377279330", "name" => "ContaNelson"},
      %{"id" => "76561198153209988", "name" => "ContaGilemer"},
      %{"id" => "76561198380481480", "name" => "ContaRebeca"}
    ]

    IO.puts("Selecione uma conta Steam para ver os detalhes:\n")

    steam_accounts
    |> Enum.with_index()
    |> Enum.each(fn {%{"name" => name}, index} ->
      IO.puts("#{index + 1} - #{name}")
    end)

    IO.puts("\nDigite o número da conta para selecionar:")

    case IO.gets("> ") |> String.trim() |> Integer.parse() do
      {selected_index, _} when selected_index in 1..length(steam_accounts) ->
        account = Enum.at(steam_accounts, selected_index - 1)
        display_account_menu(account)

      _ ->
        IO.puts("Seleção inválida, tente novamente.")
        display_menu()
    end
  end

  defp display_account_menu(%{"id" => steam_id, "name" => name}) do
    IO.puts("\nConta selecionada: #{name}")
    IO.puts("1 - Ver Resumo do Jogador")
    IO.puts("2 - Ver Jogos Possuídos")
    IO.puts("3 - Voltar ao Menu Principal")
    IO.puts("\nDigite o número da opção desejada:")

    case IO.gets("> ") |> String.trim() do
      "1" -> fetch_player_summary(steam_id)
      "2" -> fetch_owned_games(steam_id)
      "3" -> display_menu()
      _ ->
        IO.puts("Seleção inválida, tente novamente.")
        display_account_menu(%{"id" => steam_id, "name" => name})
    end
  end

  defp fetch_player_summary(steam_id) do
    case SteamApiClient.get_player_summaries(steam_id) do
      {:ok, data} -> display_player_summary(data)
      {:error, reason} -> IO.puts("Erro: #{reason}")
    end
    display_menu()
  end

  defp fetch_owned_games(steam_id) do
    case SteamApiClient.get_owned_games(steam_id) do
      {:ok, data} -> display_owned_games(data)
      {:error, reason} -> IO.puts("Erro: #{reason}")
    end
    display_menu()
  end

  defp display_player_summary(data) do
    players = data["response"]["players"]

    Enum.each(players, fn player ->
      IO.puts("Nome: #{player["personaname"]}")
      IO.puts("Foto de perfil: #{player["avatarfull"]}\n")
    end)
  end

  defp display_owned_games(data) do
    total_games = data["response"]["game_count"]
    IO.puts("Total de jogos: #{total_games}\n")

    games = data["response"]["games"]
    Enum.each(games, fn game ->
      IO.puts("Nome do jogo: #{game["name"]}")
      IO.puts("Imagem: http://media.steampowered.com/steamcommunity/public/images/apps/#{game["appid"]}/#{game["img_icon_url"]}.jpg\n")
    end)
  end
end
