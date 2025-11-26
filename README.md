# alias

Este repositório reúne um conjunto organizado de aliases, funções de shell e scripts utilitários para tornar o uso do terminal mais produtivo, rápido e padronizado. O objetivo é centralizar atalhos, comandos repetitivos e ferramentas pessoais em um único local, facilitando manutenção, versionamento e reutilização em diferentes máquinas.

# .bash_aliases

```sh
# fuzzy finder
alias fz="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/fuzzy.sh)"
alias fc="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/fuzzy-with-context.sh)"
alias fr="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/ripgrep-fzf.sh)"
alias back="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/back-to-home.sh)"
```