#!/usr/bin/env bash

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

# configurar ambiente virtual do python
config_python() {
    python3 -m venv env
    source env/bin/activate
    touch .env
    mkdir tests
    pip install setuptools python-dotenv pytest
    pip freeze > "requirements.txt"
}

# script de build da lib python
build_script() {
    build_script="python -m pip install --upgrade pip
python -m pip install --upgrade build
python -m build"

    echo "$build_script" > build.sh

    chmod +x build.sh
}

# script do project.toml 
project_script() {
    setuptools_info=$(pip show setuptools)

    version=$(echo "$setuptools_info" | grep -oP '^Version:\s*\K.*')

    project=$(cat <<EOF
[build-system]
requires = ["setuptools >= $version"]
build-backend = "setuptools.build_meta"

[project]
name = "$1"
version = "0.0.1"
authors = [
  { name="Tiago Matos", email="tiagolofi@example.com" },
]
description = ""
readme = "README.md"
requires-python = ">=3.8"
classifiers = [
    "Programming Language :: Python :: 3",
    "Operating System :: OS Independent",
]
dependencies = [
  "python-dotenv"
]
license = "Apache-2.0"
license-files = ["LICEN[CS]E*"]

[project.urls]
Homepage = "https://github.com/tiagolofi/$1"
Issues = "https://github.com/tiagolofi/$1/issues"
    
EOF
)

    echo "$project" > pyproject.toml

}

# script do setup.py
setup_script() {
    setup=$(cat <<EOF
from setuptools import setup, find_packages

setup(
    name="$1",
    version="0.0.1",
    description="",
    author="tiagolofi",
    author_email="tiagolofi@example.com",
    url="https://github.com/tiagolofi/$1",
    packages=find_packages(),
    python_requires=">=3.9",
    install_requires=[
        "python-dotenv", "pytest"
    ],
    extras_require={
    },
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
    ],
)
EOF
)

    echo "$setup" > setup.py
}

echo "### ALIAS DE CONFIGURAÇÃO DE PROJETOS PYTHON - LIBS ###"
echo "[INFO] Configurando diretórios..."
prepare_dir
echo "[INFO] Preparando repositório github..."
repo=$(clone_repo)
cd "$repo"
echo "[INFO] Preparando ambiente virtual do Python..."
config_python
echo "[INFO] Preparando scripts auxiliares..."
project_script "$repo"
build_script
setup_script "$repo"
echo "[INFO] Ambiente construído com sucesso!"