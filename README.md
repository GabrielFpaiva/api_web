
# Steam API Client

## Este projeto é um cliente básico da API da Steam, feito em Elixir, que permite ao usuário selecionar contas Steam pré-definidas e visualizar o resumo do jogador ou a lista de jogos possuídos.

### Pré-requisitos

Certifique-se de ter o Elixir instalado em sua máquina. Se você ainda não o tem instalado, siga as instruções neste link: https://elixir-lang.org/install.html.

### Instalação

Siga os passos abaixo para instalar e rodar o projeto:

1. Clone o repositório:
   Clone o projeto para o seu ambiente local:

   git clone <url-do-repositorio>

2. Entre no diretório do projeto:

   cd api_web

3. Instale as dependências:
   Use o comando abaixo para baixar as dependências do projeto:

   mix deps.get

4. Compile o projeto:
   Para garantir que o projeto esteja compilado corretamente, execute o comando:

   mix compile

Executando o Programa

Para rodar o menu interativo, use o seguinte comando:

mix run -e "SteamApiCommandLine.main([])"

Ao rodar o comando acima, o programa exibirá um menu com as seguintes opções:

1. Escolher uma conta Steam pré-definida.
2. Ver o resumo do jogador.
3. Ver os jogos possuídos pelo jogador.
4. Voltar ao menu principal ou sair do programa.

Menu de Opções

1. Resumo do Jogador: Exibe o nome e a foto de perfil da conta Steam selecionada.
2. Jogos Possuídos: Mostra a quantidade de jogos e a lista de jogos possuídos pelo usuário.
3. Voltar ao Menu Principal: Retorna ao menu de seleção de contas.
4. Sair: Encerra o programa.

Observações

O projeto utiliza a biblioteca HTTPoison para fazer requisições HTTP e Jason para manipulação de JSON.

