defmodule SteamApiClient do
  @api_url "http://api.steampowered.com"
  @api_key "0A1FC04FF8AD927601C6F8B8EB9FE216"  # Substitua pela sua chave da API

  # Função para obter o resumo do jogador
  def get_player_summaries(steam_id) do
    url = "#{@api_url}/ISteamUser/GetPlayerSummaries/v0002/?key=#{@api_key}&steamids=#{steam_id}&format=json"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Failed to fetch data, status code: #{status_code}, response: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  # Função para obter a lista de jogos de um usuário
  def get_owned_games(steam_id) do
    url = "#{@api_url}/IPlayerService/GetOwnedGames/v0001/?key=#{@api_key}&steamid=#{steam_id}&format=json&include_appinfo=1"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Failed to fetch data, status code: #{status_code}, response: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
