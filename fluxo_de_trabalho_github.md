## Fluxo de Trabalho no GitHub (Versão Web)

### Acesse o repositório correto

- [Organização](https://github.com/LABHDUFBA/ds25-organizacao)

- [Equipe Quali](https://github.com/LABHDUFBA/ds25-analise-quali)

- [ELT](https://github.com/LABHDUFBA/ds25-elt/)

---

### Crie uma nova `branch`

- Clique no botão `main`, é nele onde se seleciona a `branch` que está trabalhando (também pode estar escrito como `master`)

- Clique em `View all branches`

- Clique em `New branch`, no canto superior direito

- Escreva o nome da branch, de preferência seu nome ou usuário, como: `eric`, `eric_brasil` ou `ericbrasiln` (sem letras maiúsculas, símbolos ou espaços)

- Mantenha `Source` como `main`

- Clique em `Create branch`

- Retorne ao repositório

Depois que a branch foi criada, **basta repetir o processo**, ignorando este tópico.

---

### Acesse sua branch

- Verifique o repositório

- Clique no botão `main` (ou `master`)

- Selecione `sua_branch`

Para ter certeza que trocou, verifique o mesmo botão `main` e observe se o nome de sua branch estará no lugar.

---

### Commits 

Você pode criar ou modificar arquivos. Caso queira criá-los:

- Certifique-se que está em `sua_branch `

- Clique em `Add file`

- Escolha dentre as opções:

#### *Create new file*

- Nomeie seu arquivo (`Name your file...`) com a **extensão do arquivo**: `exemplo.md`, `index.html`, `ata_reuniao_19_04_1503.txt` *etc...*

- Adicione o conteúdo

- Clique em `Commit changes`, botão verde no canto superior direito

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

- Mantenha a opção `Commit directly to the **sua_branch** branch`

-  Clique em `Commit changes`

- Retorne ao repositório

- **Verifique, novamente, se está em `sua_branch`**

#### *Upload files*

- Arraste ou copie e cole [^2] o arquivo na região `Drag files here to add them to your repository`, ou escolha-os diretamente de um diretório local ( `choose your files`)

[^2]: Copiar e colar: selecione o arquivo que deseja copiar e pressione `Ctrl` + `c`; retorne ao github e cole o arquivo pressionando `Crtl` + `v`

- Em `Commit changes`, temos a mesma ideia anterior: um título e uma descrição

- Mantenha a opção `Commit directly to the **sua_branch** branch`

-  Clique em `Commit changes`

#### *Modificar arquivos existentes*

- Certifique-se que está em `sua_branch `

- Clique no arquivo que deseja modificar

- Clique no ícone de edição no canto superior direito do arquivo (`edit this file`, um lápis)

- Realize as alterações desejadas

- Clique em `Commit changes`, botão verde no canto superior direito

- Na caixa aberta, atente-se às duas descrições (`Commit message` e `Extended description`)

- Mantenha a opção `Commit directly to the **sua_branch** branch`

-  Clique em `Commit changes`

- Retorne ao repositório

Depois disso, garanta que alterou tudo que desejava da forma adequada antes de seguir para o próximo passo.

---

### Criar Pull Request (PR)

- **Verifique, novamente, se está na sua `branch`**

- No painel superior, acesse a aba `Pull requests` do repositório

- Clique em `Compare & pull request`

- Verifique se o PR está na configuração padrão:

>`base: main ← compare: **sua_branch** ✔️ Able to merge. These branches can be automatically merged.`

O final da mensagem, `✔️ Able to merge [...]`, é sinal que o Github **não encontrou conflitos** dos arquivos de `sua_branch` com a `main`!

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
