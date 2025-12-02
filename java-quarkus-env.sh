#!/usr/bin/env bash

source .conf

# configura diretório padrão - opcional
prepare_dir() {
    read -p "Diretório raiz: " dir
    cd "$dir" || exit 1
    whereiam=$(pwd)
    echo "Local atual: $whereiam"
}

# clonar repositório do github
clone_repo() {
    read -p "Link para o repositório do github: " repo
    git clone "$repo"
    repo_name=$(basename "$repo" .git)
    echo "$repo_name"
}

# config diretories
config_dirs() {
    mkdir -p src/main/java/com/github/tiagolofi
    mkdir -p src/main/resources/META-INF/resources
    mkdir -p src/main/resources/META-INF/branding
}

# gera o pom.xml e o application.properties
create_pom_properties() {
    declare -A CONFIG

    CONFIGS=$(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-files/.conf)

    while IFS='=' read -r key val; do
        [[ -z "$key" || "$key" =~ ^# ]] && continue
        CONFIG["$key"]="$val"
    done < .conf

    POM_TEMPLATE=$(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-files/pom-default-xml)
    PROPS_TEMPLATE=$(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-files/application-properties)
    INDEX_TEMPLATE=$(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-files/index)

    CONFIG["REPO_NAME"]=$1

    for key in "${!CONFIG[@]}"; do
        placeholder="{{${key}}}"
        value="${CONFIG[$key]}"
        POM_TEMPLATE="${POM_TEMPLATE//$placeholder/$value}"
        PROPS_TEMPLATE="${PROPS_TEMPLATE//$placeholder/$value}"
        INDEX_TEMPLATE="${INDEX_TEMPLATE//$placeholder/$value}"
    done

    echo "$POM_TEMPLATE" > pom.xml
    echo "$PROPS_TEMPLATE" > src/main/resources/application.properties
    echo "$INDEX_TEMPLATE" > src/main/resources/META-INF/resources/index.html
}

# configurando o maven
config_maven() {
    mvn wrapper:wrapper
}

gerar_par_chaves() {
    openssl genpkey -algorithm RSA -out private.pem -pkeyopt rsa_keygen_bits:4096
    openssl rsa -pubout -in private.pem -out public.pem
}

add_files() {
    GIT_IGNORE=$(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-files/gitignore)
    echo "$GIT_IGNORE" > .gitignore
    STYLE_CSS=$(curl -s https://raw.githubusercontent.com/tiagolofi/alias/refs/heads/main/java-files/styles)
    echo "$STYLE_CSS" > src/main/resources/META-INF/branding/style.css
    touch .env
    touch CHANGELOG.md
}

heroku_script() {
    echo 'web: java $JAVA_OPTS -jar target/quarkus-app/quarkus-run.jar' > Procfile
}

echo "### ALIAS DE CONFIGURAÇÃO DE PROJETOS JAVA QUARKUS ###"
echo "[INFO] Configurando diretórios..."
prepare_dir
echo "[INFO] Preparando repositório github..."
repo=$(clone_repo)
cd "$repo" 
config_dirs
config_maven
create_pom_properties "$repo"
add_files
heroku_script
gerar_par_chaves