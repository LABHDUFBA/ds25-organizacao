## Fluxo de Trabalho no GitHub (Versão Web)

### Acesse o repositório correto

- [Organização](https://github.com/LABHDUFBA/ds25-organizacao)
- [Análise Qualitativa](https://github.com/LABHDUFBA/ds25-analise-quali)
- [Análise Quantitativa](https://github.com/LABHDUFBA/ds25-analise-quanti)
- [ELT](https://github.com/LABHDUFBA/ds25-elt)

---

### Crie uma nova `branch`

- Clique no botão `main`, é nele onde se seleciona a `branch` que está trabalhando;
- Clique em `View all branches`;

![View all branches](imgs/gh01.jpeg)

- Clique em `New branch`, no canto superior direito;
- Escreva o nome da _branch_, de preferência seu nome ou usuário, como: `eric`, `eric-brasil` ou `ericbrasiln` (sem letras maiúsculas, símbolos ou espaços)
- Mantenha `Source` como `main`
- Clique em `Create branch`

![Create branch](imgs/gh02.jpeg)

- Retorne à página inicial do repositório clicando em `Code`.

---

### Acesse sua branch

- Verifique o repositório;
- Clique no botão `main`;
- Selecione `nome-da-branch`.

![Select your branch](imgs/gh03.jpeg)

Para ter certeza que trocou, verifique o nome da branch no canto superior esquerdo.

![Branch name](imgs/gh04.jpeg)

---

### Commits 

Você pode criar ou modificar arquivos. Caso queira criá-los:

- Certifique-se que está em `nome-da-branch `;
- Clique em `Add file`;
- Escolha dentre as opções:

![Commit changes](imgs/gh05.jpeg)

#### *Create new file*

- Nomeie seu arquivo (`Name your file...`) com a **extensão do arquivo**: `exemplo.md`, `index.html`, `ata_reuniao_19_04_1503.txt`, etc...;
- Adicione o conteúdo;
- Clique em `Commit changes`, botão verde no canto superior direito;

![Commit changes](imgs/gh06.jpeg)

- Na caixa aberta, atente-se às duas descrições:
  - `Commit message` é o **título** do seu commit, logo, deve ser sucinto. Por exemplo: 

>`Update arquivo.md`
>
>`Create arquivo.md`
>
>`Delete arquivo.md`

  - `Extended description` é a **descrição** do seu commit, onde detalhará quais alterações foram feitas [^1]. Por exemplo:

[^1]: No `commit`, pode escrever um pequeno texto corrido ou tópicos (bem melhor, visualmente). No `pull request`, escreva suas descrições em **markdown**!

>Atualizei o arquivo da seguinte forma:
>
>- Revisei a descrição das variáveis coletadas
>
>- Atualizei os dados no documento

- Mantenha a opção `Commit directly to the **nome-da-branch** branch`

-  Clique em `Commit changes`

- Retorne ao repositório

- **Verifique, novamente, se está em `nome-da-branch`**

#### *Upload files*

- Arraste ou copie e cole [^2] o arquivo na região `Drag files here to add them to your repository`, ou escolha-os diretamente de um diretório local ( `choose your files`)

[^2]: Copiar e colar: selecione o arquivo que deseja copiar e pressione `Ctrl` + `c`; retorne ao github e cole o arquivo pressionando `Crtl` + `v`

- Em `Commit changes`, temos a mesma ideia anterior: um título e uma descrição

- Mantenha a opção `Commit directly to the **nome-da-branch** branch`

-  Clique em `Commit changes`

#### *Modificar arquivos existentes*

- Certifique-se que está em `nome-da-branch `
- Clique no arquivo que deseja modificar
- Clique no ícone de edição no canto superior direito do arquivo (`edit this file`, um lápis)
- Realize as alterações desejadas
- Clique em `Commit changes`, botão verde no canto superior direito
- Na caixa aberta, atente-se às duas descrições (`Commit message` e `Extended description`)
- Mantenha a opção `Commit directly to the **nome-da-branch** branch`
-  Clique em `Commit changes`

![Commit changes](imgs/gh07.jpeg)

- Retorne ao repositório

Depois disso, garanta que alterou tudo que desejava da forma adequada antes de seguir para o próximo passo.

---

### Criar Pull Request (PR)

- **Verifique, novamente, se está na sua `branch`**

- No painel superior, acesse a aba `Pull requests` do repositório

- Clique em `Compare & pull request`

- Verifique se o PR está na configuração padrão:

>`base: main ← compare: **nome-da-branch** ✔️ Able to merge. These branches can be automatically merged.`

O final da mensagem, `✔️ Able to merge [...]`, é sinal que o Github **não encontrou conflitos** dos arquivos de `nome-da-branch` com a `main`!

- Em `Add a title`, adicione um título para seu PR

- Em `Add a description`, descreva as mudanças que deseja integrar à `main` [^1]

- Clique em `Create pull request`

---

### Solicitar Revisão

Caso não tenha permissão para dar merge — ou queira uma revisão —, eis o passo a passo:

- Dentro do Pull Request, clique na aba `Reviewers`

- Selecione um ou mais revisores para analisar as alterações, de preferência **@ericbrasiln** ou **@leofn**

- Aguarde o feedback e, caso tudo esteja ok, seus commits serão aceitos!

---

### Merge

Caso tenha permissão para fazer o `merge` de seus commits, basta seguir:

- Após criar o Pull Request, clique em `Merge pull request`

- Confirme clicando em `Confirm merge`

- Caso tudo ocorra bem, verá a mensagem `Pull request successfully merged and closed`

---
