# alias

Este repositório reúne um conjunto organizado de aliases, funções de shell e scripts utilitários para tornar o uso do terminal mais produtivo, rápido e padronizado. O objetivo é centralizar atalhos, comandos repetitivos e ferramentas pessoais em um único local, facilitando manutenção, versionamento e reutilização em diferentes máquinas.

# .bash_aliases

```sh
# fuzzy finder
alias fz="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/fuzzy.sh)"

# fuzzy finder in specific directory
alias fc="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/fuzzy-with-context.sh)"

# ripgrep + fzf
alias fr="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/ripgrep-fzf.sh)"

# utils
alias back="bash <(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/back-to-home.sh)"

# configurar ambiente python para libs
alias pye="bash <curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/python-lib-env.sh)"

# configurar ambiente java quarkus
alias jvq="bash <curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-quarkus-env.sh)"

# iniciar quarkus
alias start="bash <curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/start-java-quarkus.sh)"
```