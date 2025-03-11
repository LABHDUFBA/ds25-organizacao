# Bibliotecas #----

library(tidyverse)
library(gridExtra)
library(patchwork)
library(scales)

# ////// #

# Definindo variáveis dos tibbles #----

  # Perfis

perfis <- tibble(
  perfil = "",
  link_do_perfil = "",
  antivax = "",
  provax = "",
  conspiracionista = "",
  negacionista = "",
  profissao = "")

  # Posts

posts <- tibble(
  link_de_post = "",
  conteudo_de_post = "",
  antivax = "",
  provax = "",
  conspiracionista = "",
  negacionista = "",
  profissao = "")

# Após algumas discussões, decidimos alterar as variáveis da planilha. 

# Por isso, provax receberá NA's, e outras foram excluídas — como "categoria_profissao_perfil" que, apesar do péssimo nome, dizia se a profissão se refere ao perfil ou alguém que aparece no post selecionado.

# ////// #

# Lendo os arquivos .csv brutos #----

  # A planilha do Google deu alguns erros durante o processo, então algumas informações trocavam de lugar/sumiam, por isso alguns datasets tem mais de um csv

  # Instagram Bruto

instagram_bruto_1 <- read.csv(file = "dados/Listagem social media Antivax - Instagram.csv")

instagram_bruto_2 <- read.csv(file = "dados/Listagem social media Antivax - Instagram 2.csv")

instagram_bruto <- bind_rows(instagram_bruto_1, instagram_bruto_2)

  # Facebook Bruto

facebook_bruto_1 <- read.csv(file = "dados/Listagem social media Antivax - Facebook.csv")

facebook_bruto_2 <- read.csv(file = "dados/Listagem social media Antivax - Facebook 2.csv")

facebook_bruto <- bind_rows(facebook_bruto_1, facebook_bruto_2)

  # TikTok Bruto

tiktok_bruto <- read.csv(file = "dados/Listagem social media Antivax - Tiktok.csv")

  # YouTube Bruto

youtube_bruto_1 <- read.csv(file = "dados/Listagem social media Antivax - Youtube.csv")

youtube_bruto_2 <- read.csv(file = "dados/Listagem social media Antivax - Youtube 2.csv")

youtube_bruto <- bind_rows(youtube_bruto_1, youtube_bruto_2)

  # Kwai Bruto

kwai_bruto_1 <- read.csv(file = "dados/Listagem social media Antivax - Kwai.csv")

kwai_bruto_2 <- read.csv(file = "dados/Listagem social media Antivax - Kwai 2.csv")

kwai_bruto <- bind_rows(kwai_bruto_1, kwai_bruto_2)

# ////// #

# Removendo dados desnecessários #----

rm(list = setdiff(ls(), c("perfis", "posts", "facebook_bruto", "instagram_bruto", "tiktok_bruto", "youtube_bruto", "kwai_bruto")))

# ////// #

# Transformando os dados #----

  # Substituindo nomes das colunas

nomes_brutos <- facebook_bruto %>% names()

nomes_colunas <- nomes_brutos %>%
  str_to_lower() %>%
  str_replace_all(pattern = "\\.", "_") %>%
  stringi::stri_trans_general("ASCII") %>%
  str_squish() %>%
  str_replace_all("_+", "_") %>% # Substitui múltiplos "_" por um só
  str_replace("_$", "") # Tira essa porra do final

rm(nomes_brutos)

nomes_colunas_yt <- nomes_colunas

nomes_colunas_yt <- append(nomes_colunas_yt, "nome_do_usuario", after = 1)

names(facebook_bruto) <- nomes_colunas
names(instagram_bruto) <- nomes_colunas
names(tiktok_bruto) <- nomes_colunas
names(youtube_bruto) <- nomes_colunas_yt
names(kwai_bruto) <- nomes_colunas

  # Corrigindo o formato dos dados

facebook_bruto[,c(3:5, 7, 10:12)] <- lapply(facebook_bruto[, c(3:5, 7, 10:12)], as.logical)

instagram_bruto[,c(3:5, 7, 10:12)] <- lapply(instagram_bruto[, c(3:5, 7, 10:12)], as.logical)

tiktok_bruto[,c(3:5, 7, 10:12)] <- lapply(tiktok_bruto[, c(3:5, 7, 10:12)], as.logical)

youtube_bruto[,c(4:6, 8, 11:13)] <- lapply(youtube_bruto[,c(4:6, 8, 11:13)], as.logical)

kwai_bruto[,c(3:5, 7, 10:12)] <- lapply(kwai_bruto[, c(3:5, 7, 10:12)], as.logical)

  # Regex para links

    # Facebook

      # Link do perfil

facebook_bruto$link_do_perfil <- facebook_bruto$link_do_perfil %>%
  if_else(
    !str_detect(., "profile.php"),  # Se NÃO CONTÉM "profile.php"
    str_replace(., "^([^/]+/[^\n]*/[^\n]*/[^\n]*)/.*$", "\\1"),
    .  # Se CONTÉM "profile.php", mantém como está
  )

    # Instagram

      # Link do perfil

instagram_bruto$link_do_perfil <- instagram_bruto$link_do_perfil %>%
  str_replace_all("/+#?$", "") %>%  # Remove "/" ou "/#" no final
  str_replace_all("[A-Za-z0-9]\\?.*==", "") %>%  # Remove o padrão desejado
  str_replace_all("/\\?hl=pt", "")

instagram_bruto$link_do_post <- instagram_bruto$link_do_post %>%
  str_replace_all("\\?utm.*", "") %>%  # Remove "?utm" e tudo após
  str_replace_all("/+$", "") # Remove a última barra no final, se houver

    # Tiktok

      # Link do perfil

tiktok_bruto$link_do_perfil <- tiktok_bruto$link_do_perfil %>%
  str_replace_all("\\?is_.*", "") %>%
  str_replace_all("\\?_t.*", "")

      # Link do post

tiktok_bruto$link_do_post <- tiktok_bruto$link_do_post %>%
  str_replace_all("\\?is_from_webapp.*", "") %>%
  str_replace_all("\\?_([rt]).*", "") %>%
  str_replace_all("/+$", "")

    # YouTube

      # Link do perfil

youtube_bruto$link_do_perfil <- youtube_bruto$link_do_perfil %>%
  str_replace_all("/featured", "") %>%
  str_replace_all("/video", "") %>%
  str_replace_all("/+$", "")

  # Retirando POSTS repetidos

limpar_dataset <- function(dataset) {

  dataset <- dataset %>%
    mutate(
      perfil = str_squish(perfil),
      link_do_perfil = str_squish(link_do_perfil),
      link_do_post = str_squish(link_do_post)
    ) %>%
    arrange(
      desc(if_else(!is.na(perfil) & perfil != "", 1, 0)),  # Coloca perfis preenchidos primeiro
      desc(if_else(!is.na(conteudo_do_post) & conteudo_do_post != "", 1, 0))  # Coloca perfis vazios com descrição depois
    ) %>%
    distinct(link_do_post, .keep_all = TRUE)  # Elimina links de posts repetidos, mantendo o primeiro

  return(dataset)

}

    # Tibble's gerais de cada rede

facebook <- limpar_dataset(facebook_bruto)
instagram <- limpar_dataset(instagram_bruto)
tiktok <- limpar_dataset(tiktok_bruto)
youtube <- limpar_dataset(youtube_bruto)
kwai <- limpar_dataset(kwai_bruto)

# ////// #

# Separando os tibbles #----

  # Funções

cria_tibble_perfis <- function(dataset, yt) {

  if(yt == F) {

    resultado <- tibble(
      perfil = dataset$perfil,
      link_do_perfil = dataset$link_do_perfil,
      antivax = dataset$perfil_antivax_ou_provax,
      provax = NA,
      conspiracionista = dataset$perfil_conspiracionista,
      negacionista = dataset$perfil_negacionista,
      profissao = dataset$categoria_profissao,
      deletar = dataset$categoria_profissao_do_perfil
    ) %>%
      filter(deletar == TRUE)# %>%     select(-deletar)

  } else {

    resultado <- tibble(
      perfil = dataset$perfil,
      nome_usuario = dataset$nome_do_usuario,
      link_do_perfil = dataset$link_do_perfil,
      antivax = dataset$perfil_antivax_ou_provax,
      provax = NA,
      conspiracionista = dataset$perfil_conspiracionista,
      negacionista = dataset$perfil_negacionista,
      profissao = dataset$categoria_profissao,
      deletar = dataset$categoria_profissao_do_perfil
    ) %>%
      filter(deletar == TRUE) %>%
      select(-deletar)
    }

  return(resultado)

}

cria_tibble_posts <- function(dataset) {

  resultado <- tibble(
    link_de_post = dataset$link_do_post,
    conteudo_de_post = dataset$conteudo_do_post,
    antivax = dataset$post_antivax_ou_provax,
    provax = NA,
    conspiracionista = dataset$post_conspiracionista,
    negacionista = dataset$post_negacionista,
    profissao = dataset$categoria_profissao,
    deletar = dataset$categoria_profissao_do_perfil,
  ) %>%
    filter(deletar == FALSE | is.na(deletar))# %>%     select(-deletar)

  return(resultado)

}

  # Criando Perfis

perfis_facebook <- cria_tibble_perfis(facebook, yt = F)
perfis_instagram <- cria_tibble_perfis(instagram, yt = F)
perfis_kwai <- cria_tibble_perfis(kwai, yt = F)
perfis_tiktok <- cria_tibble_perfis(tiktok, yt = F)
perfis_youtube <- cria_tibble_perfis(youtube, yt = T)

  # Criando Posts

posts_facebook <- cria_tibble_posts(facebook)
posts_instagram <- cria_tibble_posts(instagram)
posts_kwai <- cria_tibble_posts(kwai)
posts_tiktok <- cria_tibble_posts(tiktok)
posts_youtube <- cria_tibble_posts(youtube)

# ////// #

# Mapeando profissões e suas categorias #----

# Esse processo sofre com os erros metodológicos do começo da coleta, então boa parte das profissões se referem aos perfis. Por isso realizei o processo usando dos próprios datasets brutos

  # Criando o dataframe de profissões

profissoes <- bind_rows(facebook_bruto[,c(6,7)],
                        instagram_bruto[,c(6,7)],
                        tiktok_bruto[,c(6,7)],
                        youtube_bruto[,c(7,8)]) %>%
  na.omit() %>% # removendo casos cuja profissão não foi preenchida, por alguma razão
  separate_rows(categoria_profissao, sep = ";" # acredito que, *agora*, não interessa saber o "acúmulo" de profissões ou a relação das profissões mais encontradas, então separei todos os casos
  )

  # Padronizando a coluna

profissoes$categoria_profissao <- profissoes$categoria_profissao %>%
  str_squish() %>%
   str_to_lower() %>%
  stringi::stri_trans_general("ASCII")

  # Criando categorizações por "radicais"

cria_categorizacoes <- function(dataset) {

  v_saude <- "medic|terapeut|enfermeir|cirurgi|farmac|neuroci|psiquiatr|psico|dentista|pediatra" # profissões de saúde

  v_saude_prof <- "medic" # profissões de saúde

  v_educacao <- "professor|tutor|educador|pedagogo" # profissões de educação

  v_comunicacao <- "jornalista|escritor|apresentador|comunicador|redator|noticia|publicitari|editor" # profissões de comunicação

  v_politica <- "senador|deputad|candidat|vereador|parlamentar" # profissões políticas

  v_conteudo_digital <- "conteudo|blogueir|influencer|youtuber|streamer|tiktoker|podcaster" # profissões de "conteúdo digital"

  resultado <- dataset %>%
    select(categoria_profissao) %>%
    separate_rows(categoria_profissao, sep = ";") %>% # isso é preciso? acho que não né
    mutate(
      categoria_profissao = categoria_profissao %>%
        str_squish() %>%
        str_to_lower() %>%
        stringi::stri_trans_general("Latin-ASCII")
    ) %>%
    filter(categoria_profissao != "") %>%
    mutate(profissao_reduzida = NA)

  resultado <- resultado %>%

    mutate(

      categoria = case_when( # Cria categorias previamente

        str_detect(categoria_profissao, v_saude) ~ "Saúde", # Todas as profissões encontradas pela expressão serão categorizadas como SAÚDE

        str_detect(categoria_profissao, v_educacao) ~ "Educação", # Todas as profissões encontradas pela expressão serão categorizadas como EDUCAÇÃO

        str_detect(categoria_profissao, v_comunicacao) ~ "Comunicação", # Todas as profissões encontradas pela expressão serão categorizadas como COMUNICAÇÃO

        str_detect(categoria_profissao, v_politica) ~ "Política", # Todas as profissões encontradas pela expressão serão categorizadas como POLÍTICA

        str_detect(categoria_profissao, v_conteudo_digital) ~ "Conteúdo Digital", # Todas as profissões encontradas pela expressão serão categorizadas como CONTEÚDO DIGITAL

        TRUE ~ "Outros" # Profissões diversas
      ),

      profissao_reduzida = case_when( # "Ajuste fino" das categorias

        str_detect(categoria_profissao, v_saude_prof) ~ "medico",
        str_detect(categoria_profissao, v_politica) ~ "politico",
        str_detect(categoria_profissao, v_conteudo_digital) ~ "criador de conteudo",
        TRUE ~ categoria_profissao  # Mantém o nome original caso não seja encontrado um grupo
      )) %>%
    rename(profissao = categoria_profissao) %>%
    relocate(profissao_reduzida, .after = profissao)

  return(resultado)

  }

  # Criando as categorizações

infos_gerais <- cria_categorizacoes(dataset = profissoes)

infos_facebook <- cria_categorizacoes(dataset = facebook)

infos_instagram <- cria_categorizacoes(dataset = instagram)

infos_tiktok <- cria_categorizacoes(dataset = tiktok)

infos_kwai <- cria_categorizacoes(dataset = kwai)

infos_youtube <- cria_categorizacoes(dataset = youtube)


# ////// #

# Removendo dados desnecessários #----

rm(list = setdiff(ls(), c(
  "facebook", "instagram", "tiktok", "youtube", "kwai",
  "limpar_dataset", "profissoes",
  "perfis_facebook", "perfis_instagram", "perfis_kwai", "perfis_tiktok", "perfis_youtube",
  "posts_facebook", "posts_instagram", "posts_kwai", "posts_tiktok", "posts_youtube"
)))

# ////// #

# Visualização #----

graficos_redes <- function(dataset) {

  # Distribuição das Profissões

  grafico_profissoes <- dataset %>%
    group_by(profissao_reduzida) %>%
    count() %>%
    arrange(desc(n)) %>%
    head(10) %>%
    ggplot(aes(x = reorder(profissao_reduzida, n), y = n)) +  # Agora X é categórico e Y é numérico
    geom_bar(aes(fill = profissao_reduzida), show.legend = FALSE, stat = "identity") +
    geom_text(aes(label = number_format(decimal.mark = ",", big.mark = ".")(n)),
              vjust = -0.5, size = 4, color = "black") +  # Posiciona os rótulos acima das barras
    scale_y_continuous(expand = expansion(c(0, 0.08)), labels = number_format(decimal.mark = ",", big.mark = ".")) +
    labs(y = "Contagem de termos", x = NULL, title = "Top 10 Profissões") +
    theme_bw() +
    theme(panel.grid.minor = element_line(linetype = "dashed"),
          panel.grid.major = element_line(linetype = "dashed"),
          plot.title = element_text(hjust = 0.5),
          axis.title.y = element_text(vjust = 5),
          axis.text.x = element_text(angle = 30, hjust = 1, size = 8),  # Gira os rótulos do eixo X
          axis.ticks = element_blank(),
          panel.background = element_blank())

  # # # # # # # # # # # # # # # # # # # # # # # #
  # # # # # # # # # # # # # # # # # # # # # # # #

  # Distribuição das Categorias

  grafico_categorias <- dataset %>%
    group_by(categoria) %>%
    count() %>%
    arrange(desc(n)) %>%
    ggplot(aes(x = reorder(categoria, n), y = n)) +  # Agora X é categórico e Y é numérico
    geom_bar(aes(fill = categoria), show.legend = FALSE, stat = "identity") +
    geom_text(aes(label = number_format(decimal.mark = ",", big.mark = ".")(n)),
              vjust = -0.5, size = 4, color = "black") +  # Posiciona os rótulos acima das barras
    scale_y_continuous(expand = expansion(c(0, 0.08)), labels = number_format(decimal.mark = ",", big.mark = ".")) +
    labs(y = NULL, x = NULL, title = "Distribuição das Categorias") +
    theme_bw() +
    theme(panel.grid.minor = element_line(linetype = "dashed"),
          panel.grid.major = element_line(linetype = "dashed"),
          plot.title = element_text(hjust = 0.5),
          axis.text.x = element_text(angle = 30, hjust = 1),  # Gira os rótulos do eixo X
          axis.ticks = element_blank(),
          panel.background = element_blank())

  # Retornar os gráficos em uma lista

  return(list(profissoes = grafico_profissoes, categorias = grafico_categorias))

  }

exibir_graficos <- function(dataset, nome_rede) {

  # Criar um layout com título acima dos gráficos

  titulo <- ggplot() +
    ggtitle(nome_rede) +
    theme_void() +  # Remove eixos e fundo
    theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))

  # Gerar os gráficos

  graficos <- graficos_redes(dataset)

  # Ajustar o layout para reduzir espaço em branco

  titulo / (graficos$profissoes + graficos$categorias) +
    plot_layout(heights = c(0.1, 1))  # Define proporção de espaço do título
}

  # Exemplos

    # Facebook

grafico_instagram <- exibir_graficos(infos_facebook, "Facebook")

ggsave(filename = "listagem_instagram.png", plot = grafico_facebook,
       device = "png", width = 10, height = 5, units = "in", dpi = 320)

    # Instagram

grafico_instagram <- exibir_graficos(infos_instagram, "Instagram")

ggsave(filename = "listagem_instagram.png", plot = grafico_instagram,
       device = "png", width = 10, height = 5, units = "in", dpi = 320)
